function rosenblattAlgorithm ()
    %datele: exemplele + etichetele
    X = [0 0 0 0.5 0.5 0.5 1 1;0 0.5 1 0 0.5 1 0 0.5];
    T = [1 1 1 1 -1 -1 -1 -1];
    %[W, b] = algorithmRosenblattOnline(X, T, 10);
    %disp(['Weights: ' num2str(W), ', Bias: '  num2str(b)])
    %genereazaPuncteDeplasareFataDePrimaBisectoare
    
    m = [10 50 100 250 500];
    deplasare = [0.5 0.3 0.1 0.01 -0.1 -0.3];

    for i = 1:length(m)
        for j = 1:length(deplasare)

            X = 2*rand(2,m(i)) - 1;
            T = double(-X(1,:) + X(2,:) > 0);

            eticheta1 = find(T == 1);
            etichetaMinus1 = find(T == 0);
            T(etichetaMinus1) = -1;
            X(2,eticheta1) = X(2,eticheta1) + deplasare(j);
            X(2,etichetaMinus1) = X(2,etichetaMinus1) - deplasare(j);

            figure((i - 1)*length(deplasare) + j)
            % subplot(length(m),length(deplasare),(i - 1)*length(deplasare) + j)
            plot(X(1,eticheta1),X(2,eticheta1),'or');
            hold on
            plot(X(1,etichetaMinus1),X(2,etichetaMinus1),'*b');

            eroare = 1;
            epoca= 0;
            net = newp([-2 2; -2 2],1,'hardlims');
            net.trainParam.epochs = 1;
            net.trainParam.showWindow = 0;
            while (eroare > 0) && (epoca < 50)
                epoca = epoca + 1;
                net = train(net,X,T); 
                eroare = sum(T ~= sim(net, X));        
            end
            plotpc(net.IW{1},net.b{1})
            title(['Epoca ' num2str(epoca)]);
        end
    end
end

function [W, b] = algorithmRosenblattOnline(X, T, maxNoEpochs)
    %  maxNoEpochs training set S with example matrix X, 
    % array T of classes with values 1 or -1 it returns the weights 
    % array, bias and misclassing error for each epoch
    net = newp([-1 1;-1 +1],1,'hardlims');
    net.inputWeights{1}.initFcn = 'rands';
    net.biases{1}.initFcn = 'rands';
    net.trainParam.epochs = 1;
    net.trainParam.showWindow = 0;
    net = init(net);
    eroare = 1;
    epoca = 0;
    
    %errorArray = zeros (1, length(X));
    while (eroare > 0) && (epoca < maxNoEpochs)
        epoca = epoca + 1;
        net = train(net,X,T);
        figure(1)
        eticheta1 = find(T == 1);
        etichetaMinus1 = find(T == -1);
        plot(X(1,eticheta1),X(2,eticheta1),'or');
        hold on
        plot(X(1,etichetaMinus1),X(2,etichetaMinus1),'*b');
        plotpc(net.IW{1},net.b{1})
        title(['Epoca ' num2str(epoca)]);
        axis([-2 2 -2 2]);
        pause(1);
        hold off
        eroare = sum(T ~= sim(net, X));
    end
    W = net.IW{1,1};
    b = net.b{1};
end

function genereazaPuncteDeplasareFataDePrimaBisectoare() 
    m = 50; % numarul de exemple din multimea de antrenare
    X = 2*rand(2,m) - 1;
    % Pentru ca punctele aflate deasupra primei bisectoare sa aiba clasa 1 
    % (adica sa se afle in semiplanul pozitiv fata de prima bisectoare) se
    % considera ecuatia dreptei de forma -x + y = 0
    T = double(-X(1,:) + X(2,:) > 0);
    close all
    deplasare = 0.3;
    eticheta1 = find(T == 1);
    etichetaMinus1 = find(T == 0);
    T(etichetaMinus1) = -1;
    X(2,eticheta1) = X(2,eticheta1) + deplasare;
    X(2,etichetaMinus1) = X(2,etichetaMinus1) - deplasare;
    plot(X(1,eticheta1),X(2,eticheta1),'or');
    hold on
    plot(X(1,etichetaMinus1),X(2,etichetaMinus1),'*b');
end
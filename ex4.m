points = [[0 0];
          [0 1];
          [1 0];
          [1 1]]';
      
net = perceptron;
net = configure(net, [0; 0], 0);

%or
net.IW{1} = [1 1];
net.b{1} = -1;

disp(sim(net, points));

%and
net.IW{1} = [1 1];
net.b{1} = -2;

disp(sim(net, points));
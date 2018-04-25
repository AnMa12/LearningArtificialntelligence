trainingSet = 2 * rand(3, 10) - 1;

net = perceptron;
net = configure(net, [0; 0; 0], 0);
net.IW{1} = [0 1 0];
net.b{1} = 0;

view(net);

y = sim(net, trainingSet);
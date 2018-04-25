points = 2 * rand(2, 1000) - 1;

net = perceptron;
net = configure(net, [0; 0], 0);
net.IW{1} = [1 -1];
net.b{1} = 0;

labels = sim(net, points);
classes = ["b*" "r*"];

for i = 1 : 1 : 1000
    plot(points(1, i), points(2, i), classes(labels(i) + 1));
    hold on;
end

hold off;

nodes n1, n2, n3, n4;
edges e1, e2, e3, e4;
n1 = Source(PullAny, Passive);
n2 = Pool(0, PullAny, Automatic);
n3 = Pool(0, PullAny, Automatic);
n4 = Pool(0, PullAny, Automatic);

e1 = Edge(n1, n2, 70, 2);
e2 = Edge(n1, n3, 30, 1);
e3 = Edge(n2, n4, 80, 2);
e4 = Edge(n3, n4, 20, 1);

one_step;
one_step;
one_step;
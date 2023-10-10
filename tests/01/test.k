nodes n1, n2, n3, n4, n5;
edges e1, e2, e3, e4, e5;
n1 = Source(PushAny, Automatic);
n2 = Pool(0, PullAny, Passive);
n3 = Pool(0, PullAny, Passive);
n4 = Pool(0, PullAny, Automatic);
n5 = Pool(0, PullAny, Passive);

e1 = Edge(n1, n2, 60, 1);
e2 = Edge(n1, n3, 40, 1);
e3 = Edge(n2, n4, 100, 3);
e4 = Edge(n3, n4, 100, 1);
e5 = Edge(n4, n5, 100, 1);

one_step;
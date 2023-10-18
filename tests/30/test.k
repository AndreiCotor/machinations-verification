nodes n1, n2, n3, n4, n5, n6, n7;
edges e1, e2, e3, e4, e5, e6, e7;
n1 = Source(PullAny, Automatic);
n3 = Pool(0, PullAny, Passive);
n4 = Pool(0, PullAny, Passive);
n5 = Pool(0, PullAny, Automatic);
n6 = Pool(0, PushAny, Passive);
n7 = Pool(0, Automatic, Passive);

e1 = Edge(n1, n3, 40, 1);
e2 = Edge(n1, n4, 60, 1);
e3 = Edge(n3, n5, 30, 2);
e4 = Edge(n4, n5, 70, 2);
e5 = Edge(n5, n7, 100, 1);
e6 = Edge(n6, n7, 50, 1);

one_step;
one_step;
one_step;
one_step;
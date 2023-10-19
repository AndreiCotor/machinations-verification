nodes n1, n2, n3, n4, n5, n6, n7;
edges e1, e2, e3, e4, e5, e6;

n1 = Source(PushAny, Passive);
n2 = Source(PullAny, Passive);
n3 = Source(PullAny, Passive);
n4 = Pool(0, PushAny, Passive);
n5 = Pool(0, PullAny, Passive);
n6 = Pool(0, PullAny, Passive);
n7 = Pool(0, PushAny, Passive);

e1 = Edge(n1, n4, 50, 1);
e2 = Edge(n2, n5, 50, 1);
e3 = Edge(n3, n6, 50, 1);
e4 = Edge(n4, n5, 50, 1);
e5 = Edge(n5, n7, 50, 1);
e6 = Edge(n6, n7, 50, 1);

one_step;
one_step;
one_step;
one_step;
one_step;
one_step;
one_step;

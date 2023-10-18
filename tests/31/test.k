nodes n1, n2, n3, n4, n5, n6, n7, n8, n9, n10;
edges e1, e2, e3, e4, e5, e6;
cond_edges ce1, ce2;
n1 = Source(PushAny, Automatic);
n2 = Pool(0, PushAll, Automatic);
n3 = Drain(PushAny, Passive);

n4 = Source(PushAny, Automatic);
n5 = Pool(0, PushAll, Automatic);
n6 = Drain(PushAny, Passive);

n7 = Source(PushAny, Passive);
n8 = Pool(0, PushAny, Passive);
n9 = Pool(0, PushAny, Passive);
n10 = Pool(0, PushAny, Passive);

e1 = Edge(n1, n2, 90, 25);
e2 = Edge(n2, n3, 100, 200);
e3 = Edge(n4, n5, 85, 40);
e4 = Edge(n5, n6, 100, 350);
e5 = Edge(n7, n8, 100, 1);
e6 = Edge(n8, n9, 100, 1);

ce1 = CondEdge(n2, n7, >199);
ce2 = CondEdge(n5, n7, >349);

one_step;
one_step;
one_step;
one_step;
one_step;
one_step;
one_step;
one_step;
one_step;
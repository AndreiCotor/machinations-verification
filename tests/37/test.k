nodes n1, n2, n3, n4;
edges e1, e2, e3;
cond_edges ce1, ce2;

n1 = Source(PushAny, Passive);
n2 = Pool(10, PushAny, Automatic);
n3 = Pool(5, PushAny, Automatic);
n4 = Drain(PushAny, Automatic);

e1 = Edge(n1, n2, 100, 1);
e2 = Edge(n2, n3, 50, 1);
e3 = Edge(n3, n4, 100, 1);

ce1 = CondEdge(n2, n1, <5);
ce2 = CondEdge(n3, n2, >=3);

one_step;
one_step;
one_step;
one_step;
one_step;
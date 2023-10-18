nodes n1, n2, n3;
edges e1, e2;
cond_edges ce1;
n1 = Source(PushAny, Automatic);
n2 = Pool(0, PushAll, Automatic);
n3 = Drain(PushAny, Passive);

e2 = Edge(n2, n3, 100, 300);

ce1 = CondEdge(n2, n1, >50);

one_step;
one_step;
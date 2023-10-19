nodes n1, n2, n3;
edges e1, e2;
cond_edges ce1;

n1 = Source(PushAny, Passive);
n2 = Pool(100, PushAny, Passive);
n3 = Pool(100, PushAny, Passive);

e1 = Edge(n1, n2, 50, 1);
e2 = Edge(n3, n2, 50, 1); 


one_step;
one_step;
one_step;
one_step;
one_step;

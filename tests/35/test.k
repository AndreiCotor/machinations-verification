nodes n1, n2, n3, n4, n5;
edges e1, e2, e3, e4;

n1 = Source(PushAny, Automatic);
n2 = Pool(0, PushAll, Automatic);
n3 = Drain(PushAny, Passive);
n4 = Source(PushAny, Automatic);
n5 = Pool(0, PushAll, Automatic);


e1 = Edge(n1, n2, 100, 30);
e2 = Edge(n2, n3, 100, 300);
e3 = Edge(n4, n5, 100, 1);
e4 = Edge(n5, n2, 100, 50);


one_step;
one_step;
one_step;
one_step;
one_step;
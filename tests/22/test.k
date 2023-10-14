nodes n1, n2, n3, n4, n5, n6;
        edges e1, e2, e3, e4, e5;
        cond_edges ce1;
        n1 = Source(PushAny, Automatic);
        n2 = Pool(0, PullAny, Automatic);
        n3 = Pool(0, PullAny, Automatic);
        n4 = Pool(0, PullAny, Passive);
        n5 = Source(PullAny, Passive);
        n6 = Pool(0, PushAll, Passive);

        e1 = Edge(n1, n2, 100, 1);
        e2 = Edge(n1, n3, 100, 1);
        e3 = Edge(n2, n4, 100, 1);
        e4 = Edge(n3, n4, 100, 1);
        e5 = Edge(n5, n6, 100, 100);

        ce1 = CondEdge(n4, n5, >0);

        one_step;
        one_step;
        one_step;
        one_step;
        one_step;
        one_step;
        one_step;
        one_step;
        one_step;
        one_step;
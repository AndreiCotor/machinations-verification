nodes n1, n2, n3;
        edges e1, e2;
        cond_edges ce1, ce2;
        n1 = Source(PushAny, Passive);
        n2 = Pool(277, PushAny, Passive);
        n3 = Drain(PushAny, Passive);

        e1 = Edge(n1, n2, 100, 1);
        e2 = Edge(n2, n3, 100, 1);

        ce1 = CondEdge(n2, n1, <274);
        ce2 = CondEdge(n2, n2, >273);

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
nodes n1, n2, n3;
        edges e1, e2;
        cond_edges ce1;
        n1 = Source(PushAny, Automatic);
        n2 = Pool(10, PushAny, Automatic);
        n3 = Drain(PullAny, Automatic);

        e1 = Edge(n1, n2, 100, 1);
        e2 = Edge(n2, n3, 100, 1);

        ce1 = CondEdge(n2, n1, <5);

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
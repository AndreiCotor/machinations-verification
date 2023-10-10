        nodes n1, n2, n3;
        edges e1, e2;
        n1 = Source(PushAny, Automatic);
        n2 = Pool(0, PullAny, Passive);
        n3 = Drain(PullAny, Automatic);

        e1 = Edge(n1, n2, 100, 2);
        e2 = Edge(n2, n3, 100, 1);

        one_step;
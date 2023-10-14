nodes n1, n2, n3, n4;
        edges e1, e2, e3;
        n1 = Source(PushAll, Automatic);
        n2 = Pool(0, PushAny, Automatic);
        n3 = Pool(0, PushAny, Automatic);
        n4 = Pool(0, PullAny, Automatic);

        e1 = Edge(n1, n2, 150, 1);
        e2 = Edge(n1, n3, 30, 1);
        e3 = Edge(n1, n4, 20, 1);

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
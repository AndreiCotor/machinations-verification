        nodes n1, n2, n3, n4, n5;
        edges e1, e2, e3, e4;
        n1 = Pool(14, PushAny, Automatic);
        n2 = Pool(0, PushAny, Passive);
        n3 = Pool(0, PushAny, Passive);
        n4 = Pool(0, PushAny, Passive);
        n5 = Pool(0, PushAny, Passive);

        e1 = Edge(n1, n2, 150, 1);
        e2 = Edge(n1, n3, 50, 1);
        e3 = Edge(n1, n4, 33, 1);
        e4 = Edge(n1, n5, 25, 1);

        one_step;
        one_step;
        one_step;
        one_step;
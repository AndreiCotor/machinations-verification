nodes n1, n2, n3;
        edges e1, e2;
        n1 = Pool(14, PushAny, Automatic);
        n2 = Pool(0, PushAny, Passive);
        n3 = Pool(0, PushAny, Passive);

        e1 = Edge(n1, n2, 0, 1);
        e2 = Edge(n1, n3, 25, 1);

        one_step;
        one_step;
        one_step;
        one_step;
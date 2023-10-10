        nodes n1, n2;
        edges e1, e2;
        n1 = Pool(60, PushAny, Automatic);
        n2 = Pool(0, PushAll, Automatic);

        e1 = Edge(n1, n2, 100, 1);
        e2 = Edge(n2, n1, 100, 60);

        one_step;
        one_step;
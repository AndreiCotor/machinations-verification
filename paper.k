module PAPER-SYNTAX
     imports DOMAINS-SYNTAX
     imports INT-SYNTAX
     imports FLOAT-SYNTAX
    //syntax Resource ::= Int
    //syntax Capacity ::= Int
    //syntax Step ::= Int 
    //syntax Activation ::= "Passive" | "Automatic" | "Interactive"
    //syntax Action ::= "Pull-Any" | "Pull-All" | "Push-Any" | "Push-All"
    //syntax Node ::= "Source" 
    //        | "Pool" "(" Action "," Resource "," Capacity ")" 
    //        | "Drain" "(" Action ")" 
    //        | "Converter"
    //        | "Gate" "(" Action ")"
    //syntax Vertex ::= "(" Id "," Node "," Activation "," Step ")"
    //syntax Formula ::= "All" | "Exp"
    //syntax Cond ::= BoolExp
    //syntax Cond ::= Bool
    //syntax Connection ::= "Trigger" | "RConn" "(" Exp ")" | "CConn" "(" Cond ")"
    //syntax Edge ::= "(" Id "," Connection "," Id "," Int "," Step ")"
    //syntax Graph ::= "(" List{Vertex} "," List{Edge} ")" 

     syntax NoResources ::= Int
     syntax Step ::= Int 
     syntax IsActive ::= Bool
     syntax GlobalState ::= Step
     syntax Type ::= "Pool" | "Source" | "Drain" | "Converter" 
     syntax NodeState ::= NoResources "," Step "," Action "," Activation "," IsActive "," Type
     syntax Flow ::= Int
     syntax EdgeState ::= Id "," Id "," Flow "," Int "," Int "," IsActive
     syntax CondEdgeState ::= Id "," Id "," CondExp 
     syntax Id ::= "none"
     syntax Id ::= "all"
     syntax Action ::= "PullAny" | "PushAny" | "PushAll" | "PullAll"
     syntax Activation ::= "Passive" | "Automatic"
     syntax CondExp ::= "<" Int | ">" Int

     syntax Stmt ::= Id "=" "Pool" "(" NoResources "," Action "," Activation ")" ";"
                  | Id "=" "Source" "(" Action "," Activation ")" ";"
                  | Id "=" "Drain" "(" Action "," Activation ")" ";"
                  | Id "=" "Edge" "(" Id "," Id "," Int "," Int ")" ";"
                  | Id "=" "CondEdge" "(" Id "," Id "," CondExp ")" ";"
                  | "one_step;"
               //   | "simulate" "(" Nodes ")" ";"
               //   | "one_node" "(" Id ")" ";"
               //   | "add_one" "(" ExitNodes ")" ";"
                  | "select_edge" "(" Nodes ")" ";"
                  | "select_edge_for_node" "(" Id "," Int "," Edges ")" ";"
                  | "check_edge" "(" Action "," Id ")" ";"
                  | "compatible_actions" "(" Action "," Action ")" ";"
                  | "active" "(" Nodes ")" ";"
                  | "check_cond" "(" CondEdges ")" ";"
                  | "toggle_active" "(" Id "," Int "," CondExp ")" ";"
                  | "request_edges" "(" Edges ")" ";"
                  | "request_ex" "(" Id ")" ";"
                  | "request_en" "(" Id ")" ";"
                  | "adapt_nodes" "(" Nodes ")" ";"
                  | "adapt" "(" Id ")" ";"
                  | "adapt_flow" "(" Edges "," Int ")" ";"
                  | "update_edges" "(" Edges ")" ";"
                  | "update" "(" Id "," Int ")" ";"
                  | "nodes" Nodes ";"
                  | "edges" Edges ";"
                  | "cond_edges" CondEdges ";"
                  | "check_all_nodes_fulfilled" "(" Nodes ")" ";"
                  | "check_fulfilled_edge" "(" Id "," Edges ")" ";"
                  | "set_flow_to_0" "(" Edges ")" ";"
                  > Stmt Stmt                     [left]

     syntax Pgm ::= Stmt
     syntax Edges ::= List{Id, ","}
     syntax CondEdges ::= List{Id, ","}
     syntax Nodes ::= List{Id, ","}
endmodule

module PAPER
     imports PAPER-SYNTAX
     imports DOMAINS
     imports FLOAT-SYNTAX

     configuration 
                <T>
                    <k> $PGM:Pgm </k>
                    <global-state> 0 </global-state>
                    <exit> .Map </exit>
                    <entrance> .Map </entrance>
                    <node-states> .Map </node-states>
                    <edge-states> .Map </edge-states>
                    <cond-edge-states> .Map </cond-edge-states>
                    <nodes> .Nodes </nodes>
                    <edges> .Edges </edges>
                    <cond-edges> .CondEdges </cond-edges>
                </T>
     //Stmt
     rule <k> X:Id = Pool(I:NoResources, A:Action, Ac:Activation); => . ...</k> 
               <node-states>... X |-> (_ => (I, 0, A, Ac, false, Pool):NodeState) ...</node-states> 
     
     rule <k> X:Id = Source(A:Action, Ac:Activation); => . ...</k> 
               <node-states>... X |-> (_ => (1000, 0, A, Ac, false, Source):NodeState) ...</node-states> 

     rule <k> X:Id = Drain(A:Action, Ac:Activation); => . ...</k> 
               <node-states>... X |-> (_ => (0, 0, A, Ac, false, Drain):NodeState) ...</node-states> 

     rule <k> X:Id = Edge(Ex:Id, En:Id, Prob:Int, Cap:Int); => check_edge(Ac, En); ...</k> 
               <edge-states>... X |-> (_ => (Ex, En, 0, Prob, Cap, false):EdgeState) ...</edge-states>
               <entrance>... En |-> (Ee:Edges => (X, Ee):Edges) ...</entrance>
               <exit>... Ex |-> (Eex:Edges => (X, Eex):Edges) ...</exit>
               <node-states>... Ex |-> (_, _, Ac:Action, _, _, Pool):NodeState ...</node-states>
     requires (Prob >Int 0) andBool (Prob <=Int 100) 

     rule <k> X:Id = Edge(Ex:Id, En:Id, Prob:Int, Cap:Int); => check_edge(Ac, En); ...</k> 
               <edge-states>... X |-> (_ => (Ex, En, 0, Prob, Cap, false):EdgeState) ...</edge-states>
               <entrance>... En |-> (Ee:Edges => (X, Ee):Edges) ...</entrance>
               <exit>... Ex |-> (Eex:Edges => (X, Eex):Edges) ...</exit>
               <node-states>... Ex |-> (_, _, Ac:Action, _, _, Source):NodeState ...</node-states>
     requires (Prob >Int 0) andBool (Prob <=Int 100) 

     rule <k> X:Id = Edge(Ex:Id, En:Id, Prob:Int, Cap:Int); => check_edge(Ac, En); ...</k> 
               <edge-states>... X |-> (_ => (Ex, En, 0, Prob, Cap, false):EdgeState) ...</edge-states>
               <entrance>... En |-> (Ee:Edges => (X, Ee):Edges) ...</entrance>
               <exit>... Ex |-> (Eex:Edges => (X, Eex):Edges) ...</exit>
               <node-states>... Ex |-> (_, _, Ac:Action, _, _, Converter):NodeState ...</node-states>
     requires (Prob >Int 0) andBool (Prob <=Int 100) 

     rule <k> check_edge(Ac:Action, En:Id); => compatible_actions(Ac, Acen); ...</k>
          <node-states>... En |-> (_, _, Acen, _, _, Pool) ...</node-states>
     rule <k> check_edge(Ac:Action, En:Id); => compatible_actions(Ac, Acen); ...</k>
          <node-states>... En |-> (_, _, Acen, _, _, Drain) ...</node-states>
     rule <k> check_edge(Ac:Action, En:Id); => compatible_actions(Ac, Acen); ...</k>
          <node-states>... En |-> (_, _, Acen, _, _, Converter) ...</node-states>

     rule <k> compatible_actions(PullAll, PullAll); => . ...</k>
     rule <k> compatible_actions(PullAll, PullAny); => . ...</k>
     rule <k> compatible_actions(PullAny, PullAll); => . ...</k>
     rule <k> compatible_actions(PullAny, PullAny); => . ...</k>
     rule <k> compatible_actions(PushAll, PushAll); => . ...</k>
     rule <k> compatible_actions(PushAll, PushAny); => . ...</k>
     rule <k> compatible_actions(PushAny, PushAll); => . ...</k>
     rule <k> compatible_actions(PushAny, PushAny); => . ...</k>


     rule <k> X:Id = CondEdge(Ex:Id, En:Id, C:CondExp); => . ...</k> 
               <cond-edge-states>... X |-> (_ => (Ex, En, C):CondEdgeState) ...</cond-edge-states>
               <node-states>... En |-> (_, _, _, Passive, _, _) ...</node-states>                         // ??????

     rule S1:Stmt S2:Stmt => S1 ~> S2 [structural]
     rule <k>one_step; => active(N); check_cond(CE); select_edge(N); request_edges(E); adapt_nodes(N); check_all_nodes_fulfilled(N); update_edges(E); ...</k> 
          <edges> E </edges>
          <nodes> N </nodes>
          <cond-edges> CE </cond-edges>
          <global-state> S => S +Int 1 </global-state>
     
     // 1st step: reset the node's active states
     rule <k> active(.Nodes); => . ...</k>
     rule <k> active(Nd:Id, Nds:Nodes); => active(Nds); ...</k>
          <node-states>... Nd |-> ((NR:NoResources, S:Step, A:Action, Automatic, _:IsActive, T) => (NR, S, A, Automatic, true, T)) ...</node-states>
     rule <k> active(Nd:Id, Nds:Nodes); => active(Nds); ...</k>
          <node-states>... Nd |-> ((NR:NoResources, S:Step, A:Action, Passive, _:IsActive, T) => (NR, S, A, Passive, false, T)) ...</node-states>
     
     // 2nd step: take the conditional edges and make the nodes active for the respected conditions
     rule <k> check_cond(.CondEdges); => . ...</k>
     rule <k> check_cond(CE:Id, CEs:CondEdges); => toggle_active(En, Nr, C); check_cond(CEs); ...</k>
          <cond-edge-states>... CE |-> (Ex, En, C):CondEdgeState ...</cond-edge-states>
          <node-states>... Ex |-> (Nr, _, _, _, _, _):NodeState ...</node-states>

     rule <k> toggle_active(En:Id, Nr:Int, (< V:Int):CondExp); =>. ...</k>
          <node-states>... En |-> ((N, S, A, Ac, _, T):NodeState => (N, S, A, Ac, true, T):NodeState) ...</node-states>
     requires Nr <Int V

     rule <k> toggle_active(En:Id, Nr:Int, (< V:Int):CondExp); =>. ...</k>
          <node-states>... En |-> ((N, S, A, Ac, Ia, T):NodeState => (N, S, A, Ac, Ia, T):NodeState) ...</node-states>
     requires Nr >=Int V

     rule <k> toggle_active(En:Id, Nr:Int, (> V:Int):CondExp); =>. ...</k>
          <node-states>... En |-> ((N, S, A, Ac, _, T):NodeState => (N, S, A, Ac, true, T):NodeState) ...</node-states>
     requires Nr >Int V
     
     rule <k> toggle_active(En:Id, Nr:Int, (> V:Int):CondExp); =>. ...</k>
          <node-states>... En |-> ((N, S, A, Ac, Ia, T):NodeState => (N, S, A, Ac, Ia, T):NodeState) ...</node-states>
     requires Nr <=Int V

     // 3rd step: select edges 
     rule <k> select_edge(.Nodes); => . ...</k> 
     rule <k> select_edge(Nd:Id, Nds:Nodes); => select_edge_for_node(Nd, randInt(100) %Int 101, E); select_edge(Nds); ...</k>
          <node-states>... Nd |-> ((_, _, PushAny, _, true, _):NodeState) ...</node-states> 
          <exit>... Nd |-> (E:Edges) ...</exit>

     rule <k> select_edge(Nd:Id, Nds:Nodes); => select_edge_for_node(Nd, randInt(100) %Int 101, E); select_edge(Nds); ...</k>
          <node-states>... Nd |-> ((_, _, PushAll, _, true, _):NodeState) ...</node-states> 
          <exit>... Nd |-> (E:Edges) ...</exit>

     rule <k> select_edge(Nd:Id, Nds:Nodes); => select_edge_for_node(Nd, randInt(100) %Int 101, E); select_edge(Nds); ...</k>
          <node-states>... Nd |-> ((_, _, PullAny, _, true, _):NodeState) ...</node-states>
          <entrance>... Nd |-> (E:Edges) ...</entrance>

     rule <k> select_edge(Nd:Id, Nds:Nodes); => select_edge_for_node(Nd, randInt(100) %Int 101, E); select_edge(Nds); ...</k>
          <node-states>... Nd |-> ((_, _, PullAll, _, true, _):NodeState) ...</node-states>
          <entrance>... Nd |-> (E:Edges) ...</entrance>

     rule <k> select_edge(Nd:Id, Nds:Nodes); => select_edge(Nds); ...</k>
          <node-states>... Nd |-> ((_, _, _, _, false, _):NodeState) ...</node-states>


     // not selected case - ok to set false here since only one node can influence an edge
     rule <k> select_edge_for_node(Nd:Id, Rnd:Int, Ed:Id, Edg:Edges); => select_edge_for_node(Nd:Id, randInt(100) %Int 101, Edg:Edges); ...</k>
          <edge-states>... Ed |-> ((Ex, En, Fl, Prob, Cap, _):EdgeState => (Ex, En, Fl, Prob, Cap, false):EdgeState) ...</edge-states>
     requires Rnd >Int Prob

     // selected case
     rule <k> select_edge_for_node(Nd:Id, Rnd:Int, Ed:Id, Edg:Edges); => select_edge_for_node(Nd:Id, randInt(100) %Int 101, Edg:Edges); ...</k>
          <edge-states>... Ed |-> ((Ex, En, Fl, Prob, Cap, _):EdgeState => (Ex, En, Fl, Prob, Cap, true):EdgeState) ...</edge-states>
     requires Rnd <=Int Prob

     rule <k> select_edge_for_node(_, _, .Edges); => . ...</k>

     // 4th step: request
     rule <k> request_edges(.Edges); => . ...</k>
     rule <k> request_edges(Eg:Id, Egs:Edges); => request_ex(Eg); request_edges(Egs); ...</k>

     rule <k> request_ex(Eg:Id); =>. ...</k>
          <edge-states>... Eg |-> ((Ex:Id, En:Id, V:Int, P:Int, Cap:Int, true):EdgeState => (Ex, En, V +Int Cap, P, Cap, true):EdgeState) ...</edge-states> 
     [priority(50)]

     rule <k> request_ex(_); =>. ...</k>
     [priority(51)]

     // 5th step: adapt flows from edges so we don't transfer more resources than there are
     rule <k> adapt_nodes(.Nodes); => . ...</k>
     rule <k> adapt_nodes(Nd:Id, Nds:Nodes); => adapt(Nd); adapt_nodes(Nds); ...</k>

     rule <k> adapt(Nd:Id); => adapt_flow(Ex, R); ...</k>
         <exit>... Nd |-> Ex ...</exit>
         <global-state> S:Int </global-state>
         <node-states>... Nd |-> (R:Int, _, A:Action, Ac:Activation, IA:IsActive, T:Type => R, S, A, Ac, IA, T)  ...</node-states>

     rule <k> adapt_flow(.Edges, _); =>. ...</k>
     rule <k> adapt_flow(Eg:Id, Egs:Edges, R:Int); => adapt_flow(Egs, R -Int minInt(F:Int, R:Int)); ...</k>
          <edge-states>... Eg |-> ((Ex:Id, En:Id, F:Int, P:Int, Cap:Int, A:Bool):EdgeState => (Ex, En, minInt(F:Int, R:Int), P, Cap, A):EdgeState) ...</edge-states>

     // 6th step: check for PushAll and PullAll nodes if all of their adjencent capacities can be fulfilled (i.e. flow = capacity for every edge)
     rule <k> check_all_nodes_fulfilled(.Nodes); =>. ... </k>
     rule <k> check_all_nodes_fulfilled(Nd:Id, Nds:Nodes); => check_fulfilled_edge(Nd, Edgs); check_all_nodes_fulfilled(Nds); ...</k>
          <node-states>... Nd |-> (_, _, PushAll, _, _, _):NodeState ...</node-states>
          <exit>... Nd |-> Edgs:Edges ...</exit>

     rule <k> check_all_nodes_fulfilled(Nd:Id, Nds:Nodes); => check_fulfilled_edge(Nd, Edgs); check_all_nodes_fulfilled(Nds); ...</k>
          <node-states>... Nd |-> (_, _, PullAll, _, _, _):NodeState ...</node-states>
          <entrance>... Nd |-> Edgs:Edges ...</entrance>

     rule <k> check_all_nodes_fulfilled(Nd:Id, Nds:Nodes); => check_all_nodes_fulfilled(Nds); ...</k>
          <node-states>... Nd |-> (_, _, PushAny, _, _, _):NodeState ...</node-states>

     rule <k> check_all_nodes_fulfilled(Nd:Id, Nds:Nodes); => check_all_nodes_fulfilled(Nds); ...</k>
          <node-states>... Nd |-> (_, _, PullAny, _, _, _):NodeState ...</node-states>

     rule <k>check_fulfilled_edge(_:Id, .Edges); => . ...</k>
     rule <k>check_fulfilled_edge(Nd:Id, Edg:Id, Edgs:Edges); => check_fulfilled_edge(Nd, Edgs); ...</k>
          <edge-states>... Edg |-> (_, _, F:Int, _, Cap:Int, Sel:Bool):EdgeState ...</edge-states>
     requires (F ==Int Cap) orBool (notBool Sel)

     rule <k>check_fulfilled_edge(Nd:Id, Edg:Id, _:Edges); => set_flow_to_0(EdgsNd); ...</k>
          <edge-states>... Edg |-> (_, _, F:Int, _, Cap:Int, Sel:Bool):EdgeState ...</edge-states>
          <node-states>... Nd |-> (_, _, PushAll, _, _, _):NodeState ...</node-states>
          <exit>... Nd |-> EdgsNd:Edges ...</exit>
     requires (F <Int Cap) andBool Sel

     rule <k>check_fulfilled_edge(Nd:Id, Edg:Id, _:Edges); => set_flow_to_0(EdgsNd); ...</k>
          <edge-states>... Edg |-> (_, _, F:Int, _, Cap:Int, Sel:Bool):EdgeState ...</edge-states>
          <node-states>... Nd |-> (_, _, PushAny, _, _, _):NodeState ...</node-states>
          <entrance>... Nd |-> EdgsNd:Edges ...</entrance>
     requires (F <Int Cap ) andBool Sel

     rule <k> set_flow_to_0(.Edges); => . ... </k>
     rule <k> set_flow_to_0(Edg:Id, Edgs:Edges); => set_flow_to_0(Edgs); ... </k>
          <edge-states>... Edg |-> ((Ex:Id, En:Id, _, P:Int, Cap:Int, Sel:Bool):EdgeState => (Ex, En, 0, P, Cap, Sel):EdgeState) ...</edge-states>

     // 7th step: update the nodes' capacities & reset edges
     rule <k> update_edges(.Edges); => . ...</k>
     rule <k> update_edges(Eg:Id, Egs:Edges); => update(Ex, 0 -Int F); update(En, F); update_edges(Egs); ...</k>
          <edge-states>... Eg |-> ((Ex:Id, En:Id, F:Int, P:Int, Cap:Int, _:Bool):EdgeState => (Ex, En, 0, P, Cap, false):EdgeState) ...</edge-states>

     rule <k> update(Nd:Id, V:Int); => . ...</k>
          <node-states>... Nd |-> ((NR:Int, S:Step, A:Action, Ac:Activation, IA:IsActive, T:Type) => (NR +Int V, S, A, Ac, IA, T)) ...</node-states>

     /*
     // take the neighbours of Nd and call add_one on their list
     // update the step for the current node
     rule <k> one_node(Nd:Id); => add_one(Ex); ...</k>
         <exit>... Nd |-> Ex ...</exit>
         <global-state> S:Int </global-state>
         <node-states>... Nd |-> (R:Int, _ => R, S)  ...</node-states>

     rule <k> add_one(.ExitNodes); =>. ...</k>
     rule <k> add_one(Nd:Id, Nds:ExitNodes); => add_one(Nds); ...</k>
         <node-states>... Nd |-> (P:Int, S:Int => P +Int 1, S)  ...</node-states>   
     */
     //Pgm -> declararile
     rule <k> nodes X:Id, Xs:Nodes; => nodes Xs; ...</k> 
         <node-states> V:Map (.Map => X|->0, 0, PushAny, Passive, false, Pool) </node-states>
         <entrance> _:Map (.Map => X|->.Edges) </entrance>
         <exit> _:Map (.Map => X|->.Edges) </exit>
         <nodes> N:Nodes => X, N </nodes>
         requires notBool (X in keys(V))

     rule <k> edges X:Id, Xs:Edges => Xs; ...</k> 
          <edge-states> E:Map (.Map => X|->(none, none, 0, 0, 1, false):EdgeState) </edge-states>
          <edges> Ed:Edges => X, Ed </edges>
          requires notBool (X in keys(E))

     rule <k> cond_edges X:Id, Xs:CondEdges => Xs; ...</k> 
          <cond-edge-states> E:Map (.Map => X|->(none, none, (< 0):CondExp):CondEdgeState) </cond-edge-states>
          <cond-edges> Ed:CondEdges => X, Ed </cond-edges>
          requires notBool (X in keys(E))

     rule <k>nodes .Nodes; =>. ...</k> [structural]
     rule <k>edges .Edges; =>. ...</k> [structural]
     rule <k>cond_edges .CondEdges; =>. ...</k> [structural]


     // verification example
     syntax Id ::= "n1"     [token]
              | "n2"   [token]
              | "n3"   [token]
              | "n4"   [token]
              | "n5"   [token]
              | "n6"   [token]
              | "n7"   [token]
              | "n8"   [token]
              | "e1"   [token]
              | "e2"   [token]
              | "e3"   [token]
              | "e4"   [token]
              | "e5"   [token]
              | "e6"   [token]
              | "ce1"   [token]
              | "ce2"   [token]
     syntax Pgm ::= "prog" [macro]
     rule prog => 
     /*   nodes n1, n2, n3, n4;
        edges e1, e2, e3;
        cond_edges ce1;
        n1 = Source(Passive);
        n2 = Pool(0, PushAny, Automatic);
        n3 = Drain(PushAny, Automatic);
        n4 = Pool(0, PushAny, Automatic);
        e1 = Edge(n1, n2, 100, 2);
        e2 = Edge(n2, n3, 100, 1);
        e3 = Edge(n2, n4, 50, 1);
        ce1 = CondEdge(n4, n1, < 2);
        one_step;
        one_step;
        one_step;
        one_step;*/

        nodes n1, n2, n3, n4;
        edges e1, e2, e3;
        n1 = Source(PushAll, Automatic);
        n2 = Pool(0, PushAny, Automatic);
        n3 = Pool(0, PushAny, Automatic);
        n4 = Pool(0, PushAny, Automatic);

        e1 = Edge(n1, n2, 50, 1);
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
endmodule
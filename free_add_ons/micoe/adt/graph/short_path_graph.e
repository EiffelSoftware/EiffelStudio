indexing

description: "These graphs support various algorithms involving%
             % shortest paths: minimal spanning tree, single source%
             % shortest paths.";
keywords: "shortest paths", "minimal spanning tree", "single source"
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"

class SHORT_PATH_GRAPH [G]

inherit
    GRAPH [G]
        redefine
            anchor
        end

creation
    make

feature -- Access

    negative_wt : BOOLEAN
        -- does `current' have edges with
        -- negative weight?
    negative_wt_cycle : BOOLEAN
        -- does `current' have a negative
        -- weight cycle?

-----------------------------------------------------------
feature -- Minimal spanning tree

    minimal_weight : DOUBLE
        -- Weight of MST.

    build_minimal_spanning_tree (r : G) is
        -- Build a minimal spanning tree for the graph `current'
        -- with root at the vertex having `item' = `r'.
        -- On termination the root of the MST is in `roots'.

        require
            all_positive : not negative_wt

        local
            pq : PRIORTQ [G, DOUBLE]
            it : ITERATOR
            u  : like anchor
            v  : like anchor
            ei : ITERATOR
            w  : DOUBLE

        do
            find_vertex (r)
            if found then
                create pq.make

                from
                    it := iterator
                until
                    it.finished
                loop
                    u ?= item (it)
                    u.set_distance (infinite_dist)
                    pq.add (u)
                    it.forth
                end -- loop

                from
                    found_vertex.set_distance (0.0) 
                until
                    pq.empty
                loop
                    u ?= pq.item 
                    pq.remove 
 
                    from
                        ei := u.edge_iterator
                    until
                        ei.finished
                    loop    
                        v ?= u.successor (ei)
                        w := u.weight (ei)
                        if v.is_in_queue (pq) and then
                           w < v.distance         then
                            v.set_distance (w)
                            v.set_parent (u)
                        end

                        ei.forth  
                    end
                end -- loop

                v := clone (found_vertex)
                v.delete_all_edges
                roots.make (false)
                roots.append (v)
                build_tree_recursively (found_vertex, v)
                minimal_weight := 0.0
                from
                    it := iterator
                until
                    it.finished
                loop
                    minimal_weight := minimal_weight + item (it).distance
                    it.forth
                end -- loop
            end -- if found then ...
        end
-----------------------------------------------------------
feature -- Single source shortest paths

    short_path_valid : BOOLEAN
            -- did build_shortest_paths succeed?

    build_shortest_paths (x : G) is
        -- Traverses the graph setting the `parent'
        -- attributes of the vertices so that they point along
        -- the shortest path from the root `r', having `item'
        -- = `x'. An appropriate algorithm is chosen depending on whether
        -- 1) `current' is a DAG,
        -- 2) `current' has no negative weight edges or
        -- 3) neither of these holds.
        -- On termination `roots' contains just one vertex `v' whose
        -- item is `x'; `v' is the root of a spanning tree
        -- The path from `v' to any vertex `u' in the tree is
        -- isomorphic to the shortest path in `current' from the
        -- single source to the vertex with item `u.item'.

        local
            v : like anchor

        do
            short_path_valid := false
            find_vertex (x)

            if found then
                if acyclic then
                    dag_shortest_paths (found_vertex)
                elseif not negative_wt then
                    dijkstra_shortest_paths (found_vertex)
                else
                    bellman_ford_shortest_paths (found_vertex)
                end

                short_path_valid := (not negative_wt_cycle)
            end

            if short_path_valid then
                v := clone (found_vertex)
                v.delete_all_edges
                roots.make (false)
                roots.append (v)
                build_tree_recursively (found_vertex, v)
            end
        end
-----------------------------------------------------------
feature { NONE }

    anchor        : SHORT_PATH_VERTEX [G]

-----------------------------------------------------------

    dag_shortest_paths (s : SHORT_PATH_VERTEX [G]) is

        require
           its_a_dag : acyclic

        local
            it : ITERATOR

        do
            it := topological_iterator
            initialize_single_source (s) 
            relax_all (it)
        end
-----------------------------------------------------------

    initialize_single_source (s : SHORT_PATH_VERTEX [G]) is

        local
            u  : SHORT_PATH_VERTEX [G] 
            it : ITERATOR
 
        do
            from 
                it := iterator
            until
                it.finished
            loop
                u ?= item (it)
                u.set_distance (infinite_dist)
                it.forth
            end

            s.set_distance (0.0)
        end 
-----------------------------------------------------------

    relax_all (it : ITERATOR) is

        local
            u, v : SHORT_PATH_VERTEX [G] 
            w    : DOUBLE
            ei   : ITERATOR

        do
            from
                -- empty statement
            until
                it.finished
            loop
                u ?= item (it) 
                it.forth 
 
                from
                    ei := u.edge_iterator
                until
                    ei.finished
                loop
                    v := u.successor (ei)
                    w := u.weight (ei)

                    if u.distance + w < v.distance then
                        v.set_distance (u.distance + w)
                        v.set_parent (u)
                    end

                    ei.forth
                end
            end
        end
-----------------------------------------------------------

    dijkstra_shortest_paths (s : SHORT_PATH_VERTEX [G]) is

        local
            pq : PRIORTQ [G, DOUBLE]
            u  : SHORT_PATH_VERTEX [G] 
            it : ITERATOR

        do
            initialize_single_source (s) 
            create pq.make

            from
                it := iterator
            until
                it.finished
            loop
                u ?= item (it)
                pq.add (u)
                it.forth
            end

            relax_queue (pq)
        end
-----------------------------------------------------------

    relax_queue (pq : PRIORTQ [G, DOUBLE]) is

        local
            u  : SHORT_PATH_VERTEX [G] 
            v  : SHORT_PATH_VERTEX [G] 
            ei : ITERATOR
            wt : DOUBLE

        do
            from
                -- empty statement
            until
                pq.empty
            loop
                u ?= pq.item 
                pq.remove 
 
                from
                    ei := u.edge_iterator
                until
                    ei.finished
                loop
                    v  := u.successor (ei)
                    wt := u.weight (ei)
                    if u.distance + wt < v.distance then
                        v.set_distance (u.distance + wt)
                        v.set_parent (u)
                    end

                    ei.forth
                end
            end
        end
-----------------------------------------------------------

    bellman_ford_shortest_paths (s : SHORT_PATH_VERTEX [G]) is

        local
            n, i : INTEGER

        do
            initialize_single_source (s) 

            from
                i := 1
                n := vertices.count
            until
                i >= n
            loop
                relax_all (iterator)
                i := i + 1
            end

            test_negative_wt_cycle
        end
-----------------------------------------------------------

    test_negative_wt_cycle is

        local
            it : ITERATOR
            ei : ITERATOR
            u  : SHORT_PATH_VERTEX [G] 
            v  : SHORT_PATH_VERTEX [G]
            w  : DOUBLE

        do
            negative_wt_cycle := false

            from
                it := iterator
            until
                it.finished
            loop
                u ?= item (it)

                from
                    ei := u.edge_iterator
                until
                    ei.finished
                loop
                    v := u.successor (ei)
                    w := u.weight (ei)

                    if u.distance + w < v.distance then
                        negative_wt_cycle := true
                        ei.stop
                    else
                        ei.forth
                    end
                end

                if negative_wt_cycle then
                    it.stop
                else
                    it.forth 
                end
            end
        end

end -- class SHORT_PATH_GRAPH

------------------------------------------------------------------------
--                                                                    --
--  MICO/E --- a free CORBA implementation                            --
--  Copyright (C) 1999 by Robert Switzer                              --
--                                                                    --
--  This library is free software; you can redistribute it and/or     --
--  modify it under the terms of the GNU Library General Public       --
--  License as published by the Free Software Foundation; either      --
--  version 2 of the License, or (at your option) any later version.  --
--                                                                    --
--  This library is distributed in the hope that it will be useful,   --
--  but WITHOUT ANY WARRANTY; without even the implied warranty of    --
--  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU --
--  Library General Public License for more details.                  --
--                                                                    --
--  You should have received a copy of the GNU Library General Public --
--  License along with this library; if not, write to the Free        --
--  Software Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.--
--                                                                    --
--  Send comments and/or bug reports to:                              --
--                 micoe@math.uni-goettingen.de                       --
--                                                                    --
------------------------------------------------------------------------

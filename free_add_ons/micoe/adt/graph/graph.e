indexing

description: "This class kills three birds with one stone:%
             % undirected graphs, digraphs and weighted graphs.%
             % Unweighted graphs are implemented by giving all%
             % edges the weight 1.0. The class supports various%
             % standard graph algorithms such as: breadth first%
             % search, depth first search and topological ordering.";
keywords: "digraph", "weighted graph", "breadth first", "depth first",
          "topological ordering"
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"

class GRAPH [G]

inherit
    VERTEX_COLORS
        undefine
            copy, is_equal
        end;
    ES_TRAVERSABLE
        redefine
            iterator, first, next, inside, copy, is_equal
        end

creation
    make

feature -- Access

    roots           : INDEXED_LIST [like anchor]
        -- The roots of the trees in a depth first forest.
    directed : BOOLEAN
        -- Is `current' a digraph?
    bfs_traversal_finished : BOOLEAN
        -- Has a complete breadth first search been made?
    dfs_traversal_finished : BOOLEAN
        -- Has a complete depth first search been made?

feature -- Initialization

    make (dir : BOOLEAN) is
        -- Initialize a newly created graph. If `dir' is true
        -- it will be a digraph.

        do
            directed := dir
            create roots.make (false)
            create vertices.make (false)
            bfs_traversal_finished := false
            dfs_traversal_finished := false
        end
----------------------
feature -- Mutation

    add_vertex (x : G) is
        -- Add a vertex with item `x' if there is not yet such a vertex;
        -- otherwise do nothing.

        local
            v : like anchor

        do
            if internal_find (x) = 0 then
                create v.make (x)
                vertices.append (v)
            end
        end 
----------------------

    add_edge (x1, x2 : G; wt : DOUBLE) is
        -- Add an edge from vertex with item `x1' to vertex with
        -- item  `x2'; if either of these vertices does not yet
        -- exist add it. The new edge gets the weight `wt'.

        local
            v1, v2 : like anchor
            n      : INTEGER

        do
            n := internal_find (x1)

            if n = 0 then
                create v1.make (x1)
                vertices.append (v1)
            else
                v1 := vertices.at (n)
            end

            n := internal_find (x2)

            if n = 0 then
                create v2.make (x2)
                vertices.append (v2)
            else
                v2 := vertices.at (n)
            end

            v1.add_edge (v2, wt, directed)

            infinite_dist := infinite_dist + wt
        end
----------------------

feature -- Traversal

    depth_first_iterator : ITERATOR is
        -- An iterator prepared to traverse `current' in
        -- depth first order. `result' lays the ground
        -- work for `build_dfs_forest' in the process of
        -- doing its traversal.

        require
            no_iterator_active : not iterator_active

        local
            root : like anchor

        do
            root := vertices.at (1)
            create roots.make (false)
            dfs_traversal_finished := false
            create {DEPTH_FIRST_ITERATOR [G]} result.make (current)
            init_first (result)
        end
----------------------

    build_dfs_forest is
        -- Replace each vertex `u' in `roots' with a clone
        -- that is the root of a tree isomorphic to the
        -- DFS tree rooted `u'.

        require
            dfs_traversal_finished : dfs_traversal_finished

        local
            u, v : like anchor
            i, n : INTEGER

        do
            from
                i := roots.low_index
                n := roots.high_index
            until
                i > n
            loop
                u := roots.at (i)
                v := clone (u)
                v.delete_all_edges
                roots.replace (v, i)
                build_tree_recursively (u, v)
                i := i + 1
            end
        end
----------------------

    breadth_first_iterator (start : G) : ITERATOR is
        -- An iterator prepared to traverse `current' in
        -- breadth first order starting at the vertex
        -- with `item' = `start'. `result' lays the ground
        -- work for `build_bfs_tree' in the process of
        -- executing its traversal.

        require
            no_iterator_active : not iterator_active

        do
            create roots.make (false)
            add_root (start)
            bfs_traversal_finished := false
            create {BREADTH_FIRST_ITERATOR [G]} result.make (current)
            init_first (result)
        end
----------------------

    build_bfs_tree is
        -- For the one vertex `u' in `roots' replace `u'
        -- with a clone that is the root of a tree isomorphic
        -- to the BFS tree rooted at `u'.

        require
            bfs_traversal_finished : bfs_traversal_finished

        local
            u, v : like anchor

        do
            check
                exactly_one_root : roots.count = 1
            end
            u := roots.at (roots.low_index)
            v := clone (u)
            v.delete_all_edges
            roots.replace (v, roots.low_index)
            build_tree_recursively (u, v)
        end
----------------------

    topological_iterator : ITERATOR is
        -- An iterator prepared to traverse `current' in
        -- topological order (if possible; see the precondition).

        require
            no_iterator_active : not iterator_active
            is_a_dag           : directed and then acyclic

        do
           create {TOPOLOGICAL_ITERATOR [G]} result.make (current)
           init_first (result)
        end
----------------------

    iterator : ITERATOR is
        -- Iterator guaranteed to traverse ALL vertices of `current'.

        do
            create {VERTEX_ITERATOR [G]} result.make (current)
            init_first (result)
        end
----------------------

    item (it : ITERATOR) : like anchor is
        -- The vertex `it' is standing on.

        local
            git : GRAPH_ITERATOR [G]

        do
            git    ?= it
            result := git.gi_item
        end
----------------------
feature -- Searching

    found        : BOOLEAN     -- Was find_vertex successful?
    found_vertex : like anchor -- The vertex found by find_vertex;
                               -- valid only if `found' is true.


    find_vertex (x : G) is
        -- Search for a vertex with `item' = `x'.
        -- Set `found' and `found_vertex' accordingly.

        local
            n : INTEGER

        do
            n := internal_find (x)
            found := (n /= 0)

            if found then
                found_vertex := vertices.at (n)
            end

        ensure
            right_vertex : found implies equal (x, found_vertex.item)
        end
----------------------
feature -- Status

    acyclic : BOOLEAN is
        -- Is `current' acyclic?

        local
            dfi : ITERATOR

        do
            from
                result := true
                dfi    := depth_first_iterator
            until
                dfi.finished
            loop
                if has_back_edge (item (dfi)) then
                    result := false
                    dfi.stop
                 else
                    dfi.forth
                 end
            end
        end
----------------------

    is_a_tree : BOOLEAN is

        local
            it : ITERATOR
            ei : ITERATOR
            nv : INTEGER
            ne : INTEGER
            u  : like anchor

        do
            from
                it := iterator
            until
                it.finished
            loop
                u := item (it)
                from
                    ei := u.edge_iterator
                until
                    ei.finished
                loop
                    ne := ne + 1
                    ei.forth
                end

                nv := nv + 1
                it.forth
            end

            if not directed then
                ne := ne // 2
            end

            result := (nv = ne + 1 and then acyclic)
        end
----------------------

    vertex_count : INTEGER is

        do
            result := vertices.count
        end
----------------------

    iterator_active : BOOLEAN is
        -- Is some iterator traversing `current'?

        do
            result := (n_iter > 0)
        end
----------------------

    vertex_vector : ARRAY[G] is
        -- Build an array, whose elements are the `items' of
        -- the vertices.

        local
            i : INTEGER

        do
            from
                create result.make (1, vertices.count)
                i := 1
            until
                i > vertices.count
            loop
                result.put (vertices.at (i).item, i)
                i := i + 1
            end
        end
----------------------
feature { GRAPH }

    add_root (x : G) is
        -- Roots play a role if the graph is a forest.

        local
            v : like anchor
            n : INTEGER

        do
            n := internal_find (x)

            if n = 0 then
                create v.make (x)
                vertices.append (v)
            else
                v := vertices.at (n)
            end

            roots.append (v)
        end
----------------------
feature { ITERATOR }

    first (it : ITERATOR) is

        local
            git : GRAPH_ITERATOR [G]

        do
            git ?= it
            git.gi_first
        end
----------------------

    next (it : ITERATOR) is

        local
            git : GRAPH_ITERATOR [G]

        do
            git ?= it
            git.gi_next
        end
----------------------

    inside (it : ITERATOR) : BOOLEAN is

        local
            git : GRAPH_ITERATOR [G]

        do
            git    ?= it
            result := git.gi_inside
        end
----------------------

    set_bfs_traversal_finished is

        do
            bfs_traversal_finished := true
        end
----------------------

    set_dfs_traversal_finished is

        do
            dfs_traversal_finished := true
        end
----------------------
feature { GRAPH_ITERATOR }

    color_all_vertices_white is

        local
            i : INTEGER
            v : like anchor

        do
            from
                i := vertices.low_index
            until
                i > vertices.high_index
            loop
               v := vertices.at (i)
               v.set_color (White)
               v.set_d (Infinity)
               i := i + 1
            end
            last_white := vertices.low_index
        end
----------------------

feature { GRAPH_ITERATOR, GRAPH }

    vertices      : INDEXED_LIST [like anchor] 
    infinite_dist : DOUBLE 
        -- Sum of the absolute values of all
        -- edge weights in the graph; successively
        -- computed by `add_edge'. This needed by
        -- short path algorithms.
----------------------

    find_white_vertex : BOOLEAN is
        -- Look for a vertex that is still white; make it a root
        -- if one is found and return true. If the white vertex
        -- found by this functoion is not recolored by some other
        -- routine, then successive calls will always "find" the
        -- same vertex; so (in a real sense) this function has
        -- no side effects.

        do
            from
                if last_white < vertices.low_index then
                    last_white := vertices.low_index
                end
            until
                last_white > vertices.high_index or else
                vertices.at (last_white).color = White
            loop
                last_white := last_white + 1
            end

            if last_white <= vertices.high_index then
                roots.append (vertices.at (last_white))
                result := true
            end
        end
----------------------

    valid_white_vertex : BOOLEAN is

        do
            result := (last_white >= vertices.low_index and then
                       last_white <= vertices.high_index)
        end
----------------------

    found_white_vertex : like anchor is

        require
            white_vertex_found : valid_white_vertex

        do
            result := vertices.at (last_white)
        end
----------------------
feature -- Copying

    copy (other : like current) is

        local
            i   : INTEGER
            n   : INTEGER
            it  : ITERATOR
            v1  : like anchor
            v2  : like anchor
            wt  : DOUBLE

        do
            directed := other.directed
            create vertices.make (false)
            from
                i := other.vertices.low_index
                n := other.vertices.high_index
            until
                i > n
            loop
                from
                    v1 := other.vertices.at (i)
                    it := v1.edge_iterator
                until
                    it.finished
                loop
                    v2 := v1.successor (it)
                    wt := v1.weight (it)
                    add_edge (v1.item, v2.item, wt)
                    it.forth
                end
                i := i + 1
            end
        end
----------------------
feature -- Equality Test

    is_equal (other : like current) : BOOLEAN is

        local
            i, n  : INTEGER
            it1   : ITERATOR
            it2   : ITERATOR
            v1    : like anchor
            v2    : like anchor

        do
            result := (directed = other.directed and then
                       vertices.count = other.vertices.count)
            if result then
                from
                    i := 1
                    n := vertices.count
                until
                    not result or else i > n
                loop
                    v1     := vertices.at (i)
                    v2     := other.vertices.at (i)
                    result := (v1.out_degree = v2.out_degree)
                    if result then
                        from
                            it1 := v1.edge_iterator
                            it2 := v2.edge_iterator
                        until
                            it1.finished
                        loop
                            result := (equal (v1.successor (it1).item,
                                              v2.successor (it2).item)
                                       and then v1.weight (it1) = v2.weight (it2))
                            if not result then
                                it1.stop
                                it2.stop
                            end
                        end -- loop
                    end -- if result then ...
                    i := i + 1
                end
            end
        end
----------------------
feature { NONE }

    infinity : INTEGER is -1
                -- A value that no genuine depth can be.

    last_white  : INTEGER
    anchor      : VERTEX [G]

----------------------

    internal_find (x : G) : INTEGER is

        do
            from
                result := vertices.low_index
            until
                result > vertices.high_index or else
                equal (x, vertices.at (result).item) 
            loop
                result := result + 1
            end

            if result > vertices.high_index then
                result := 0
            end  

        ensure
            right_vertex : result /=0 implies
                           equal (x, vertices.at (result).item)
        end
----------------------

    has_back_edge (v : like anchor) : BOOLEAN is

        local
             it : ITERATOR

        do
            from
                it := v.edge_iterator
            until
                it.finished
            loop
                if v.successor (it).color = Grey then
                    result := true
                    it.stop
                else
                    it.forth
                end
            end
        end
----------------------

    build_tree_recursively (u, v : like anchor) is
        -- `u' is a vertex of `current' and `v' is a
        -- clone of `u' and simultaneously a leaf of the
        -- tree being built. We investigate the edges leaving
        -- `u'; if any of them has a target whose parent
        -- is `u', we add a copy of this edge to `v ' and
        -- then recurse on the targets. This procedure is
        -- used by `build_bfs_tree', `build_dfs_forest' as
        -- well as various shortest path routines.

        local
            u1 : like anchor
            v1 : like anchor
            it : ITERATOR
            wt : DOUBLE

        do
            from
                it := u.edge_iterator
            until
                it.finished
            loop
                u1 := u.successor (it)
                wt := u.weight (it)
                if u1.parent = u and then
                   u1 /= u.parent    then
                        -- watch out for "inverse edges" ...
                    v1 := clone (u1)
                    v1.delete_all_edges
                    v.add_edge (v1, wt, true)
                    v1.set_parent (v)
                    build_tree_recursively (u1, v1)
                end
                it.forth
            end
        end

end -- class GRAPH

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


indexing

description: "A depth first iterator can traverse a graph in depth%
             % first order";
keywords: "depth first", "traversal"
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"

class DEPTH_FIRST_ITERATOR [G]

inherit
    VERTEX_COLORS;
    GRAPH_ITERATOR [G]
        redefine
            make
        end

creation
    make

feature -- Initialization

    make (g : GRAPH [G]) is

        do
            precursor (g)
            time := 0
            create v_stack.make
            create i_stack.make
        end
----------------------
feature { GRAPH }

    gi_item : VERTEX [G] is

        do
            result := v_stack.item
        end
----------------------

    gi_inside : BOOLEAN is

        local
            g : GRAPH [G]

        do
            g ?= partner
            result := (not v_stack.empty or else g.find_white_vertex)
            if not result then
                g.set_dfs_traversal_finished
            end
        end
---------------------------------

    gi_first is

        local
            u : VERTEX [G]
            i : ITERATOR
            g : GRAPH[G]

        do
            g ?= partner
            g.color_all_vertices_white
            if g.find_white_vertex then -- start a new tree
                u := g.found_white_vertex
                i := u.edge_iterator
                u.set_parent (void)
                look_for_white_successor (u, i)
                if i.finished then
                    finish (u, i) -- puts them on stacks
                else
                    descend (u, i) -- proceed into graph; this
                                   -- also puts them on stacks
                end
            end -- if g.find_white_vertex then ...
        end
----------------------

    gi_next is

        local
            u, v  : VERTEX [G]
            i, i1 : ITERATOR
            g     : GRAPH[G]

        do
            g ?= partner
            -- pop the top elements; these
            -- were returned by `gi_item'
            v_stack.remove
            i_stack.remove
            if not v_stack.empty then
                u := v_stack.item
                i := i_stack.item
                look_for_white_successor (u, i)
                if i.finished then
                    -- We've  gone as far as possible
                    finish_without_push (u) -- it's still on stack
                else -- found a white successor
                    v  := u.successor (i)
                    i1 := v.edge_iterator
                    v.set_parent (u)
                    descend (v, i1) -- proceed into graph; this also
                                    -- puts them on stacks
                end -- if i.finished then ...
            elseif g.find_white_vertex then -- start a new tree
                u := g.found_white_vertex
                i := u.edge_iterator
                u.set_parent (void)
                look_for_white_successor (u, i)
                if i.finished then
                    discover (u, i) -- puts them on stacks
                    finish_without_push (u)
                else
                    descend (u, i) -- proceed into graph; this also
                                   -- puts them on stacks
                end
            end -- if not v_stack.empty then ...
        end
---------------------------------
feature { NONE }

    time    : INTEGER
    v_stack : STACK [VERTEX [G]]
        -- The essential invariant of this data structure is:
        -- 1. The vertex at the bottom is entered in partner.roots
        -- 2. The vertex at the top is finished in the sense that
        --    a. It has no white successors
        --    b. It is black
        --    c. f > d
        -- 3. All vertices on the stack except the one at the top
        --    are grey and they represent a path through `partner'
        --    joining the bottom vertex to the top one
        -- 4. The parent of each vertex on the stack is the vertex
        --    just below it
    i_stack : STACK [ITERATOR]

----------------------

    descend (u : VERTEX [G]; i : ITERATOR) is
        -- Go as far into the graph as possible
        -- leaving the path followed on the stacks.
        -- When you can't go any further leave the
        -- last vertex in a finished state at the
        -- top of `v_stack' ... and of course its
        -- finished edge_iterator at the top of
        -- `i_stack' to preserve the class invariant.

        local
            v  : like u
            i1 : like i

        do
            discover (u, i) -- pushes on stacks
            look_for_white_successor (u, i)
            if i.finished then
                finish_without_push (u)
            else
                v  := u.successor (i)
                i1 := v.edge_iterator
                v.set_parent (u)
                descend (v, i1) -- this discovers `v'
            end
        end
----------------------

    look_for_white_successor (x : VERTEX [G]; it : ITERATOR) is
            -- Traverse `x' with `it' until either it.finished
            -- or else it is standing on a white successor of `x'.

        do
            from
                -- nothing
            until
                it.finished
                or else
                x.successor (it).color = White
            loop
                it.forth
            end

        ensure
            white_found : it.finished or else
                          x.successor (it).color = White
        end
----------------------

    discover (u : VERTEX [G]; i : ITERATOR) is

        do
            u.set_color (Grey)
            time := time + 1
            u.set_d (time)
            v_stack.add (u)
            i_stack.add (i)            
        end
----------------------

    finish (u : VERTEX [G]; i : ITERATOR) is

        do
            check
                i_finished : i.finished
            end
            u.set_color (Black)
            time := time + 1
            u.set_f (time)
            v_stack.add (u)
            i_stack.add (i)
        end
----------------------

    finish_without_push (u : VERTEX [G]) is

        do
            check
                on_stack : u = v_stack.item
            end
            u.set_color (Black)
            time := time + 1
            u.set_f (time)
        end

invariant
    same_height  : v_stack.count = i_stack.count
    top_finished : i_stack.empty or else i_stack.item.finished
    top_black    : v_stack.empty or else v_stack.item.color = Black

end -- class DEPTH_FIRST_ITERATOR

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

indexing

description: "Vertices for the class GRAPH.";
keywords: "graph"
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"

class VERTEX [G]

creation
    make

feature -- Data

    item     : G
        -- The "information" this vertex carries
    color    : INTEGER
        -- Needed by various graph algorithms.
    d        : INTEGER
        -- depth (breadth first search)
        -- resp. discovery time (depth first search)
    f        : INTEGER
        -- finish time (depth first search)
    parent   : VERTEX [G]
        -- In a depth first forest `current' was
        -- discovered from `parent' but `parent' can
        -- also be used by shortest path algorithms.

feature -- Initialization

    make (x : G) is
        -- Make `x' the "information" carried by `current'.

        do
            create successors.make (false)
            item := x
        end
----------------------
feature -- Access

    out_degree : INTEGER is
        -- How many edges leave `current'? For undirected
        -- graphs the name of this feature is to be taken
        -- with a grain of salt.

        do
            result := successors.count
        end
----------------------
feature -- Mutation

    set_parent (p : like parent) is

        do
            parent := p
        end
----------------------

    set_color (c : INTEGER) is

        do
            color := c
        end
----------------------

    set_item (x : G) is

        do
           item := x
        end
----------------------

    set_d (dval : INTEGER) is

        do
            d := dval
        end
----------------------

    set_f (fval : INTEGER) is

        do
            f := fval
        end
----------------------

    add_edge (v : VERTEX [G]; wt : DOUBLE; directed : BOOLEAN) is
        -- Add an edge departing from `current' and ending in `v'
        -- with weight `wt'. If `directed' = false, add an edge from
        -- `v' back to `current'.

        local
            e : like edge_anchor

        do
            create e.make (v, wt)
            successors.append (e)

            if not directed then
                v.add_edge (current, wt, true)
            end
        end
----------------------
feature { GRAPH }

    delete_all_edges is

        do
            create successors.make (false)
        end
----------------------
feature -- Traversal

    edge_iterator : ITERATOR is
        -- An iterator prepared to traverse all edges
        -- leaving `current'.

        do
            result := successors.iterator
        end
----------------------

    successor (it : ITERATOR) : like current is
        -- The vertex at the other end of the edge
        -- that `it' is standing on.

        do
            result := successors.item (it).target
        end
----------------------

    weight (it : ITERATOR) : DOUBLE is
        -- The weight of the edge
        -- that `it' is standing on.


        do
            result := successors.item (it).weight
        end
----------------------

    edge (it : ITERATOR) : like edge_anchor is
        -- The edge that `it' is standing on.

        do
            result := successors.item (it)
        end
----------------------
feature { NONE }

    edge_anchor : EDGE [G]
    successors  : INDEXED_LIST [like edge_anchor]

end -- class VERTEX

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

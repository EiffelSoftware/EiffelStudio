indexing

description: "A breadth first iterator can traverse a graph in breadth%
             % first order";
keywords: "breadth first", "traversal"
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"

class BREADTH_FIRST_ITERATOR [G]

inherit
    VERTEX_COLORS;
    GRAPH_ITERATOR [G]

creation
    make

feature { GRAPH }

    gi_item : VERTEX [G] is

        do
            result := waiting.item
        end
---------------------------------

    gi_first is

        local
            g  : GRAPH [G]
            u  : VERTEX [G]

        do
            create waiting.make
            g ?= partner
            g.color_all_vertices_white
                -- Also sets `d' to `infinity'.
            u := g.roots.at (1)
            u.set_d (0)
            waiting.add (u)
        end
---------------------------------

    gi_next is

        local
            u,v  : VERTEX [G]
            it   : ITERATOR

        do
            u := waiting.item 
            waiting.remove 

            from
                it := u.edge_iterator
            until
                it.finished
            loop
                v := u.successor (it)
                if v.color = White then
                    v.set_color (Grey)
                    v.set_parent (u)
                    v.set_d (u.d + 1)
                    waiting.add (v)
                end
                it.forth
            end

            u.set_color (Black)
        end
---------------------------------

    gi_inside : BOOLEAN is

        local
            g : GRAPH [G]
        do
            result := (not waiting.empty)
            if not result then
                g ?= partner
                g.set_bfs_traversal_finished
            end
        end
---------------------------------

feature { NONE }

    waiting  : QUEUE [VERTEX [G]] 

end -- class BREADTH_FIRST_ITERATOR

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

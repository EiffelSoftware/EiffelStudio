indexing

description: "These are the iterators that visit _all_ vertices of a graph%
             % in no particular order.";
keywords: "graph", "traversal"
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"

class VERTEX_ITERATOR [ G ]

inherit
    GRAPH_ITERATOR [G]
        redefine
            gi_first, gi_next, gi_inside, gi_item
        end

creation
    make

feature { GRAPH }

    gi_first is

        do
            cursor := 1
        end
---------------------------------------------------

    gi_next is

        do
             cursor := cursor + 1
        end
---------------------------------------------------

    gi_inside : BOOLEAN is

        local
            g : GRAPH [G]

        do
            g      ?= partner
            result := (cursor <= g.vertex_count)
        end
---------------------------------------------------

    gi_item : VERTEX [G] is

        local
            g : GRAPH [G]

        do
            g      ?= partner
            result := g.vertices.at (cursor)
        end
---------------------------------------------------

feature { NONE }

    cursor : INTEGER

end -- class VERTEX_ITERATOR

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

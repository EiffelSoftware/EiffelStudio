indexing

description: "These iterators visit the vertices of a graph in topological order%
             % provided the graph is a DAG.";
keywords: "graph", "traversal", "DAG"
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"

class TOPOLOGICAL_ITERATOR [G]

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

            create vertices.make
        end
----------------------

feature { GRAPH }

    gi_item : VERTEX [G] is

        do
            result := vertices.item
        end
----------------------

    gi_first is

        local
            g  : GRAPH [G]
            it : ITERATOR

        do
            g ?= partner

            from
                it := g.depth_first_iterator
           until
               it.finished
           loop
               vertices.add (g.item (it))
               it.forth
           end
        end
----------------------

    gi_next is

        do
            vertices.remove
        end
----------------------

    gi_inside : BOOLEAN is

        do
           result := (not vertices.empty)
        end
----------------------
feature { NONE }

    vertices : STACK [VERTEX [G]]

end -- class TOPOLOGICAL_ITERATOR

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

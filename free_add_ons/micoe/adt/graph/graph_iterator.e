
indexing

description: "This abstraction permits us to use all graph iterators in a uniform manner.";
keywords: "graph", "traversal"

deferred class GRAPH_ITERATOR [G]

inherit
    ITERATOR
        export { NONE }
            first, inside
        end

feature { GRAPH }

    gi_item : VERTEX [G] is
        -- Vertex `current' is standing on.

        deferred
        end
---------------------------------

    gi_first is
        -- Go to "first" vertex of the partner graph.
        -- The various descendants define "first" differently.

        deferred
        end
---------------------------------

    gi_next is
        -- Go to "next" vertex of the partner graph.
        -- The various descendants define "next" differently.

        deferred
        end
---------------------------------

    gi_inside : BOOLEAN is
        -- Has `current' visited all vertices of its
        -- partner graph?

        deferred
        end

end -- class GRAPH_ITERATOR

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

indexing

description: "Vertices occurring in short path graphs.";
keywords: "shortest paths", "minimal spanning tree", "single source"
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"

class SHORT_PATH_VERTEX [G]

inherit
    VERTEX [G]
        redefine
            parent, edge_anchor
        end;
    Q_ELEMENT [G, DOUBLE]
        rename
            make     as q_make,
            item     as unused_item,
            set_item as unused_set_item
        redefine
            priority
        end

creation
    make

feature -- Access

    distance : DOUBLE  -- needed in shortest path algorithms.
    parent   : SHORT_PATH_VERTEX [G] -- used to build trees

    priority : DOUBLE is
        -- Used in priority queues.

        do
            result := -distance
        end
-----------------------------------------------
feature -- Mutation

    set_distance (dist : DOUBLE) is

        require
            reduction : distance = 0.0 or else dist <= distance

        do
            distance := dist
            if queue /= void then
                queue.raise_priority (current)
            end
        end
-----------------------------------------------
feature { NONE }

    edge_anchor : SHORT_PATH_EDGE [G]

end -- class SHORT_PATH_VERTEX

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

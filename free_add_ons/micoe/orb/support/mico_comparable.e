indexing

description: "Defines a total order via a function `compare'.";
keywords: "Still to be entered";
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"

deferred class MICO_COMPARABLE

inherit
    COMPARABLE
        redefine
            infix "<", copy, is_equal
        end

feature -- Comparison

    compare (other : MICO_COMPARABLE) : INTEGER is
        -- This routine defines the behavior of infix "<"
        -- and `is_equal'.
        -- It should rerturn
        --   -1 if `current' < `other'
        --    1 if `current' > `other'
        --    0 in all other cases.

        require
            nonvoid_arg : other /= void

        deferred
        end
----------------------

    infix "<" (other : like current) : BOOLEAN is

        do
            result := (compare (other) < 0)
        end
----------------------
feature -- Copying

    copy (other : like current) is
        -- This makes it possible to adapt copying to local needs.

        do
            local_copy (other)
        end
----------------------
feature -- Equality Test

    is_equal (other : like current) : BOOLEAN is

        do
           result := same_type (other) and then (compare (other) = 0)
        end
----------------------
feature { NONE } -- Implementation

    local_copy (other : like current) is

        do
            standard_copy (other)
                -- This seems to be what most MICO classes want.
        end

end -- class MICO_COMPARABLE

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

indexing

description: "A data element with exactly 8 bits.";
keywords: "Still to be entered";
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"

class OCTET
    -- An unsigned data item with exactly 8 bits.

creation
    make, make_truncate

feature -- Initialization

    make (n : INTEGER) is

        require
            has_eight_bits : 0 <= n and then n <= 255

        do
            value := n
        end
--------------------------------------

    make_truncate (n : INTEGER) is
        -- `n' may be too big to fit into a byte.
        -- We cut it down to size.

        do
            value := int2octet (n)
        end
--------------------------------------
feature -- Access

    value : INTEGER

--------------------------------------
feature -- Mutation

    set_value (n : INTEGER) is

        require
            has_eight_bits : 0 <= n and then n <= 255

        do
            value := n
        end
--------------------------------------
feature { NONE } -- Implementation

    int2octet (n : INTEGER) : INTEGER is

        external "C"
        alias "MICO_int2octet"

        ensure
            has_eight_bits : 0 <= result and then result <= 255
        end

invariant
    has_eight_bits : 0 <= value and then value <= 255

end -- class OCTET

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

indexing

description: "Still to be entered";
keywords: "Still to be entered";
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"

class GIOP_SIMPLE_PROFILE

inherit
    IOR_PROFILE
        redefine
            copy, compare
        end

creation
    make

feature -- Initialization

    make is

        do
            objkey := void
        end
----------------------
feature -- Encoding

    encode (ec : DATA_ENCODER) is

        do
        end
----------------------

    encode_id : INTEGER is

        do
            result := 10000
        end
----------------------
feature -- Access

    addr : ADDRESS is

        do
            check
                never_called : false
            end
        end
----------------------

    id : INTEGER is

        do
            result := 10000
        end
----------------------

    get_objectkey (l : INTEGER_REF) : ARRAY [INTEGER] is

        do
            if objkey = void then
                l.set_item (0)
                create result.make (1, 0)
            else
                l.set_item (objkey.count)
                result := objkey
            end
        end
----------------------

    reachable : BOOLEAN is

        do
            result := true
        end
----------------------
feature -- Mutation

    set_objectkey (key : ARRAY [INTEGER]; cnt : INTEGER) is

        local
            i, j : INTEGER

        do
            from
                create objkey.make (1, cnt)
                i := 1
                j := key.lower
            until
                i > cnt
            loop
                objkey.put (key.item (j), i)
                i := i + 1
                j := j + 1
            end
        end
----------------------
feature -- Miscellaneous

    print_it is

        do
            io.put_string ("giop-simple-profile")
        end
----------------------
feature -- Copying

    copy (other : like current) is

        do
            objkey := clone (other.objkey)
        end
----------------------
feature -- Comparison

    compare (other : like current) : INTEGER is
        -- I'm not sure this is a reasonable solution.
        -- At least after a copy `compare' answers 0,
        -- which is what we need in that case.

        do
            if id = other.id then
                result := keycompare (objkey, other.objkey)
            else
                result := id - other.id
                    -- be sure they aren't regarded as equal ...
            end
        end
----------------------
feature { GIOP_SIMPLE_PROFILE } -- Implementation

    objkey : ARRAY [INTEGER]

end -- class GIOP_SIMPLE_PROFILE

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

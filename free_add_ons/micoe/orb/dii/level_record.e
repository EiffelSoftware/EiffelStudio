indexing

description: "Still to be entered";
keywords: "Still to be entered";
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"

class LEVEL_RECORD
    -- not defined by OMG but needed by MICO.

inherit
    TYPECODE_CHECKER_CONSTANTS

creation
    make, make2, make5

feature -- Initialization


    make is

        do
            make2 (Level_none, void)
        end
-------------------------------------------

    make2 (l : INTEGER; t : CORBA_TYPECODE) is

        do
            make5 (l, t, 0, 1, 0)
        end
-------------------------------------------

    make5 (l : INTEGER; t : CORBA_TYPECODE; nn, ii, xx : INTEGER) is

        do
            my_level := l
            type     := t
            n        := nn
            i        := ii
            x        := xx
        end
-------------------------------------------
feature -- Access

    level : INTEGER is
        -- IDL type described by this record;
        -- possible values defined in TYPECODE_CHECKER_CONSTANTS:
        -- Level_struct, Level_union, etc.

       do
           result := my_level
       end
-------------------------------------------

    tc : CORBA_TYPECODE is
        -- Type of next higher level ... the parent
        -- so to speak.

        do
            result := type
        end
-------------------------------------------

    i : INTEGER
        -- Index in member vector.
    n : INTEGER
        -- Length of member vector.
    x : INTEGER
        -- Also index in member vector (used for unions).

-------------------------------------------
feature -- Mutation

    set_i (ii : INTEGER) is

        do
            i := ii
        end
-------------------------------------------

    set_n (nn : INTEGER) is

        do
            n := nn
        end
-------------------------------------------

    set_x (xx : INTEGER) is

        do
            x := xx
        end
-------------------------------------------
feature { LEVEL_RECORD } -- Implementation

    my_level : INTEGER
        -- Type described by this record;
        -- possible values defined in TYPECODE_CHECKER_CONSTANTS:
        -- Level_struct, Level_union, etc.
    type     : CORBA_TYPECODE
        -- Type of next higher level ... the parent
        -- so to speak

end -- class LEVEL_RECORD

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

indexing

description: "Still to be entered";
keywords: "Still to be entered";
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"

class ROOT

inherit
    INTERCEPTOR_STATICS
        undefine
            copy, is_equal
        end;
    HASHABLE
        undefine
            copy, is_equal
        redefine
            hash_code
        end
    COMPARABLE
        redefine
            infix "<"
        end

feature

    Lowest_priority  : INTEGER is 0
    Highest_priority : INTEGER is

        external "C"
        alias "MICO_highest_priority"

        end
--------------------------------------

    repoid : STRING is

        do
            result := "IDL:omg.org/Interceptor/Root:1.0"
        end
--------------------------------------

    get_prio : INTEGER is

        do
            result := prio
        end
--------------------------------------

    activate (p : INTEGER) is

        require
            valid_priority : p = Lowest_priority or else
                             p = Highest_priority

        do
            prio      := p
            is_active := true
        end
--------------------------------------

    deactivate is

        do
            is_active := false
        end
--------------------------------------

    get_is_active : BOOLEAN is

        do
            result := is_active
        end
--------------------------------------
feature -- Comparison

    infix "<" (other : like current) : BOOLEAN is

        do
             result := (prio < other.prio)
        end
--------------------------------------
feature -- Hashing

    hash_code : INTEGER is

        do
            result := prio.hash_code
            -- XXX this is probably not such a good idea,
            -- since there are only two possible priorities.
        end
--------------------------------------
feature { ROOT }-- Implementation

    prio      : INTEGER -- either Lowest_priority or Highest_Priority
    is_active : BOOLEAN

invariant
    valid_priority : prio = Lowest_priority or else
                     prio = Highest_priority

end -- class ROOT

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

indexing

description: "Still to be entered";
keywords: "Still to be entered";
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"

class STATIC_ANY

inherit
    ANY
        redefine
            copy, is_equal
        end

creation
   make1, make2

feature -- Initialization

    make1 (sinfo : STATIC_TYPE_INFO) is

        require
            nonvoid_info : sinfo /= void

        do
            make2 (sinfo, void)
        end
----------------------

    make2 (sinfo : STATIC_TYPE_INFO; a : ANY) is

        require
            nonvoid_info : sinfo /= void

        do
            info := sinfo
            val  := a
        end
----------------------
feature -- Access

    flags : FLAGS is

        do
            result := my_flags
        end
----------------------

    type : STATIC_TYPE_INFO is

        do
            result := info
        end
----------------------

    value : ANY is

        do
            result := val
        end
----------------------

    retn : ANY is

        do
            result := val
            val    := void
        end
----------------------

    set_flags (f : FLAGS) is

        do
            my_flags := f
        end
----------------------
feature -- Mutation

    set_value0 is

        local
            stcv : STC_VOID

        do
            create stcv
            set_value2 (stcv, void)
        end
----------------------

    set_value1 (sinfo : STATIC_TYPE_INFO) is

        do
            set_value2 (sinfo, void)
        end
----------------------

    set_value2 (sinfo : STATIC_TYPE_INFO; a : ANY) is

        do
            info := sinfo
            val  := a  
        end
----------------------
feature -- Marshalling and Demarshalling

    marshal (ec : DATA_ENCODER) is

        do
            check
                nonvoid_info : info /= void
            end

            if val = void then
                val := info.create_object
            end
            info.marshal (ec, val)
        end
----------------------

    demarshal (dc : DATA_DECODER) : BOOLEAN is

        do
            check
                nonvoid_info : info /= void
            end

            val    := info.demarshal (dc)
            result := (val /= void)
        end
----------------------
feature -- Copying

    copy (other : like current) is

        do
            info := other.info
            val  := clone (other.val)
        end
----------------------
feature -- Equality Test

    is_equal (other : like current) : BOOLEAN is

        do
            result := (info = other.info
                       and then
                       equal (val, other.val))
        end
----------------------
feature { STATIC_ANY } -- Implementation

    info     : STATIC_TYPE_INFO
    val      : ANY -- Yes, I really mean an Eiffel ANY.
    my_flags : FLAGS -- I'm betting this attribute is a zombie ...


invariant
    nonvoid_info : info /= void

end -- class STATIC_ANY

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

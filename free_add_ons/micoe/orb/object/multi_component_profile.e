indexing

description: "Still to be entered";
keywords: "Still to be entered";
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"

class MULTI_COMPONENT_PROFILE

inherit
    IOR_STATICS
        undefine
            copy, is_equal
        end;
    IOR_PROFILE
        redefine
            copy, components
        end

creation
    make, make2

feature -- Initialization

    make (mc : MULTI_COMPONENT) is

        do
            make2 (mc, Tag_multiple_components)
        end
------------------------------------------------

    make2 (mc : MULTI_COMPONENT; pid : INTEGER) is

        do
             my_mc := mc
             tagid := pid
        end
------------------------------------------------
feature -- Access

    addr : ADDRESS is

        do
        end
------------------------------------------------

    id : INTEGER is

        do
            result := tagid
        end
------------------------------------------------

    get_objectkey (l : INTEGER_REF) : ARRAY [INTEGER] is

        do
            l.set_item (1)
            create result.make (1, 1)
            result.put (0, 1)
        end
------------------------------------------------

    reachable : BOOLEAN is

        do
            result := false
        end
------------------------------------------------

    components : MULTI_COMPONENT is

        do
            result := my_mc
        end
------------------------------------------------
feature -- Mutation

    set_objectkey (key : ARRAY [INTEGER]; cnt : INTEGER) is

        do
            -- Just ignore it.
        end
------------------------------------------------
feature -- Copying

    copy (other : like current) is

        do
            my_mc := clone (other.my_mc)
            tagid := other.tagid
        end
------------------------------------------------
feature -- Comparison

    compare (other : like current) : INTEGER is

        do
            if id /= other.id then
                result := (id - other.id)
            else
                result := my_mc.compare (other.my_mc)
            end
        end
------------------------------------------------
feature -- Encoding

    encode (ec : DATA_ENCODER) is

        do
            my_mc.encode (ec)
        end
------------------------------------------------

    encode_id : INTEGER is

        do
            result := tagid
        end
------------------------------------------------
feature -- Miscellaneous

    print_it is

        do
             my_mc.print_it
        end
------------------------------------------------
feature { MULTI_COMPONENT_PROFILE } -- Implementation

    my_mc : MULTI_COMPONENT
    tagid : INTEGER

end -- class MULTI_COMPONENT_PROFILE

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

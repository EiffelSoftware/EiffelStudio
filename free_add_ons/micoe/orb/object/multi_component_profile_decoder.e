indexing

description: "Still to be entered";
keywords: "Still to be entered";
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"

class MULTI_COMPONENT_PROFILE_DECODER

inherit
    IOR_STATICS
        undefine
            copy, is_equal
        end;
    IOR_PROFILE_DECODER

creation
    make, make1

feature -- Initialization

    make is

        do
            make1 (Tag_multiple_components)
        end
------------------------------------------------------

    make1 (id : INTEGER) is

        do
            tagid := id
            register_prof_decoder (current)
        end
------------------------------------------------------
feature -- Access

    has_id (id : INTEGER) : BOOLEAN is

        do
            result := (id = tagid)
        end
------------------------------------------------------
feature -- Decoding

    decode (dc : DATA_DECODER; id : INTEGER) : IOR_PROFILE is

        local
            mc : MULTI_COMPONENT

        do
            create mc.make
            mc.decode (dc)
            create {MULTI_COMPONENT_PROFILE} result.make2 (mc, id)        
        end
------------------------------------------------------
feature { MULTI_COMPONENT_PROFILE_DECODER } -- IMPLEMENTATION

    tagid : INTEGER

end -- class MULTI_COMPONENT_PROFILE_DECODER

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

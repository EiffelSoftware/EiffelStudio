indexing

description: "Still to be entered";
keywords: "Still to be entered";
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"

class LOCAL_PROFILE_DECODER

inherit
    IOR_STATICS;
    IOR_PROFILE_DECODER

creation
    make

feature -- Initialization

    make is

        do
            tagid := Tag_local
        end
------------------------------------------------
feature -- Access

    has_id (id : INTEGER) : BOOLEAN is

        do
            result := (id = Tag_local)
        end
------------------------------------------------
feature -- Decoding

    decode (dc : DATA_DECODER; id : INTEGER) : IOR_PROFILE is

        local
            pid  : INTEGER_REF
            len  : INTEGER
            host : STRING
            dum  : BOOLEAN

        do
            dum  := dc.struct_begin
            host := dc.get_string_raw
            create pid
            dc.get_long (pid)
            len := dc.seq_begin
            create {LOCAL_PROFILE} result.make5 (dc.get_buffer.data, len,
                                                 tagid, host, pid.item)
            dc.get_buffer.rseek_rel (len)
            dc.seq_end
            dum := dc.struct_end
        end
------------------------------------------------
feature { NONE } -- Implementation

    tagid : INTEGER

end -- class LOCAL_PROFILE_DECODER

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

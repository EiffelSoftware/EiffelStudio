indexing

description: "Still to be entered";
keywords: "Still to be entered";
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"

class UIOP_PROFILE_DECODER

inherit
    IOR_STATICS;
    IOR_PROFILE_DECODER

creation
    make, make1

feature -- Initialization

    make is

        do
            make1 (Tag_unix_iop)
        end
------------------------------------------------

    make1 (pid : INTEGER) is

        do
            tagid := pid
            register_prof_decoder (current)
        end
------------------------------------------------
feature -- Access

    has_id (id : INTEGER) : BOOLEAN is

        do
            result := (id = Tag_unix_iop)
        end
------------------------------------------------
feature -- Decoding

    decode (dc : DATA_DECODER; id : INTEGER) : IOR_PROFILE is

        local
            major, minor : OCTET
            objkey       : ARRAY [INTEGER]
            len          : INTEGER
            comps        : MULTI_COMPONENT
            host         : STRING
            filename     : STRING
            ua           : UNIX_ADDRESS
            sa           : SSL_ADDRESS
            ip           : IOR_PROFILE
            dum          : BOOLEAN

        do
            dum := dc.struct_begin
            dum := dc.struct_begin
            major := dc.get_octet
            minor := dc.get_octet
            check
                right_version : major.value = 1
                                and then
                                minor.value <= 1
            end            
            dum := dc.struct_end
            host     := dc.get_string_raw
            filename := dc.get_string_raw
            len := dc.seq_begin
            objkey := dc.get_buffer.data1 (len)
            dc.get_buffer.rseek_rel (len)
            dc.seq_end

            if major.value > 1 or else minor.value > 0 then
                create comps.make
                comps.decode (dc)
            end

            create ua.make_with_filename (filename)
            create {UIOP_PROFILE} result.make7 (objkey, ua, comps,
                                                major, minor, tagid, host)

            if comps /= void                           and then
               comps.component (Tag_ssl_sec_trans) /= void then
                create sa.make (clone (result.addr))
                ip := result
                create {SSL_PROFILE} result.make (ip, sa)
            end
            dum := dc.struct_end
        end
------------------------------------------------
feature { NONE } -- Implementation

    tagid : INTEGER

end -- class UIOP_PROFILE_DECODER

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

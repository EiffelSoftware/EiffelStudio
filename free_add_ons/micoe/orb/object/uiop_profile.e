indexing

description: "An IOR profile to be used when unix domain transport %
             %is employed.";
keywords: "Still to be entered";
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"

class UIOP_PROFILE

inherit
    IOR_STATICS
        undefine
            copy, is_equal
        end;
    ADDRESS_STATICS
        undefine
            copy, is_equal
        end;
    IOR_PROFILE
        redefine
            copy
        end

creation
    make, make4, make5, make6, make7

feature

    make (keys : ARRAY [INTEGER]; ua : UNIX_ADDRESS;
          mc : MULTI_COMPONENT) is

        local
            major : OCTET
            minor : OCTET

        do
            create major.make (1)
            create minor.make (0)
            make7 (keys, ua, mc, major, minor, Tag_unix_iop, void)
        end
---------------------------------------------------

    make4 (keys : ARRAY [INTEGER]; ua : UNIX_ADDRESS;
           mc : MULTI_COMPONENT; major : OCTET) is

        local
            minor : OCTET

        do
            create minor.make (0)
            make7 (keys, ua, mc, major, minor, Tag_unix_iop, void)
        end
---------------------------------------------------

    make5 (keys : ARRAY [INTEGER]; ua : UNIX_ADDRESS;
           mc : MULTI_COMPONENT; major, minor : OCTET) is

        do
            make7 (keys, ua, mc, major, minor, Tag_unix_iop, void)
        end
---------------------------------------------------

    make6 (keys : ARRAY [INTEGER]; ua : UNIX_ADDRESS;
           mc : MULTI_COMPONENT; major, minor : OCTET; pid : INTEGER) is

        do
            make7 (keys, ua, mc, major, minor, pid, void)
        end
---------------------------------------------------

    make7 (keys : ARRAY [INTEGER]; ua : UNIX_ADDRESS;
           mc : MULTI_COMPONENT; major, minor : OCTET;
           pid : INTEGER; a_host : STRING) is

        do
            major_ver := major
            minor_ver := minor
            if major.value = 1 and then
               minor.value = 0 and then
               mc /= void      and then
               mc.size > 0         then
               minor_ver.set_value (1)
            end
            tagid := pid
            if a_host /= void then
                host := a_host
            else
                host := hostname
            end
            myaddr := ua
            comps  := mc
            objkey := keys
        end
---------------------------------------------------
feature -- Access

    addr : ADDRESS is

        do
            result := myaddr
        end
---------------------------------------------------

    length : INTEGER is

        do
            if objkey /= void then
                result := objkey.count
            end
        end
---------------------------------------------------

    id : INTEGER is

        do
            result := tagid
        end
---------------------------------------------------

    get_objectkey (l : INTEGER_REF) : ARRAY [INTEGER] is

        do
            l.set_item (length)
            result := objkey
        end
---------------------------------------------------

    reachable : BOOLEAN is

        do
            result := samehosts (host, hostname)
        end
---------------------------------------------------
feature -- Encoding and Decoding

    encode_id : INTEGER is

        do
            result := tagid
        end
---------------------------------------------------

    encode (ec : DATA_ENCODER) is

        do
            ec.struct_begin
            ec.struct_begin
            ec.put_octet (major_ver)
            ec.put_octet (minor_ver)
            ec.struct_end
            ec.put_string_raw (host)
            ec.put_string_raw (myaddr.get_filename)
            ec.seq_begin (length)
            ec.put_octets (objkey)
            ec.seq_end
            if major_ver.value > 1 or else minor_ver.value > 0 then
                comps.encode (ec)
            end
            ec.struct_end
        end
---------------------------------------------------
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
---------------------------------------------------
feature -- Copying

    copy (other : like current) is

        do
            major_ver := clone (other.major_ver)
            minor_ver := clone (other.minor_ver)
            comps  := clone (other.comps)
            tagid  := other.tagid
            host   := clone (other.host)
            myaddr := clone (other.myaddr)
            objkey := clone (other.objkey)
        end
---------------------------------------------------
feature -- Comparison

    compare (other : like current) : INTEGER is

        local
            kcmp, hcmp, acmp : INTEGER

        do
            if id = other.id then
                kcmp := keycompare (objkey, other.objkey)
                if myaddr /= void and then other.myaddr /= void then
                    acmp := myaddr.compare (other.myaddr)
                end
                if host < other.host then
                    hcmp := -1
                elseif host > other.host then
                    hcmp := 1
                end

                if tagid /= other.tagid then
                    result := (tagid - other.tagid)
                elseif length /= other.length then
                    result := (length - other.length)
                elseif kcmp /= 0 then
                    result := kcmp
                elseif major_ver.value /= other.major_ver.value then
                    result := major_ver.value - other.major_ver.value
                elseif minor_ver.value /= other.minor_ver.value then
                    result := minor_ver.value - other.minor_ver.value
                elseif hcmp /= 0 then
                    result := hcmp
                elseif acmp /= 0 then
                    result := acmp
                elseif comps /= void and then other.comps /= void then
                    result := comps.compare (other.comps)
                end -- if tagid /= other.tagid then ...
            else
                result := id - other.id
                    -- make sure they are not treated as equal ...
            end -- if id = other.id then ...
        end
---------------------------------------------------
feature -- Miscellaneous

    print_it is

        do
            io.put_string ("UIOP Profile%N")
            io.put_string ("    Address:  ")
            io.put_string (myaddr.stringify)
            io.new_line
        end
---------------------------------------------------
feature { UIOP_PROFILE } -- Implementation

    objkey    : ARRAY [INTEGER]
    comps     : MULTI_COMPONENT
    myaddr    : UNIX_ADDRESS
    major_ver : OCTET
    minor_ver : OCTET
    tagid     : INTEGER
    host      : STRING

end -- class UIOP_PROFILE

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

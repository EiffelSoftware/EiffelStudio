indexing

description: "Still to be entered";
keywords: "Still to be entered";
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"

class IIOP_PROFILE

inherit
    IOR_STATICS
        undefine
            copy, is_equal
        end;
    IOR_PROFILE
        redefine
            copy
        end

creation
    make, make3, make4, make5, make6

feature

    make (key : ARRAY [INTEGER]; ia : INET_ADDRESS) is

        local
            mc  : MULTI_COMPONENT
            major : OCTET
            minor : OCTET

        do
            create mc.make
            create major.make (1)
            create minor.make (0)
            make6 (key, ia, mc, major, minor, Tag_internet_iop)
        end
---------------------------------------------------

    make3 (key : ARRAY [INTEGER]; ia : INET_ADDRESS;
           mc : MULTI_COMPONENT) is

        local
            major : OCTET
            minor : OCTET

        do
            create major.make (1)
            create minor.make (0)
            make6 (key, ia, mc, major, minor, Tag_internet_iop)
        end
---------------------------------------------------

    make4 (key : ARRAY [INTEGER]; ia : INET_ADDRESS;
           mc : MULTI_COMPONENT; major : OCTET) is

        local
            minor : OCTET

        do
            create minor.make (0)
            make6 (key, ia, mc, major, minor, Tag_internet_iop)
        end
---------------------------------------------------

    make5 (key : ARRAY [INTEGER]; ia : INET_ADDRESS;
           mc : MULTI_COMPONENT; major, minor : OCTET) is

        do
            make6 (key, ia, mc, major, minor, Tag_internet_iop)
        end
---------------------------------------------------

    make6 (key : ARRAY [INTEGER]; ia : INET_ADDRESS;
           mc : MULTI_COMPONENT; major, minor : OCTET; pid : INTEGER) is

        do
            major_ver := major
            minor_ver := minor
            if major.value = 1 and then
               minor.value = 0 and then
               mc /= void      and then
               mc.size >0          then
                minor_ver.set_value (1)
            end
            tagid  := pid
            comps  := mc
            objkey := key
            myaddr := ia
        end
---------------------------------------------------
feature -- Access

    addr : ADDRESS is

        do
            result := myaddr
        end
---------------------------------------------------

    id : INTEGER is

        do
            result := tagid
        end
---------------------------------------------------

    get_objectkey (l : INTEGER_REF) : ARRAY [INTEGER] is

        do
            l.set_item (objkey.count)
            result := objkey
        end
---------------------------------------------------

    reachable : BOOLEAN is

        do
            result := true
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

            ec.put_string_raw (myaddr.get_host)
            ec.put_ushort (myaddr.get_port)
           
            ec.seq_begin (objkey.count)
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
            tagid     := other.tagid
            myaddr    := clone (other.myaddr)
            comps     := clone (other.comps)
            objkey    := clone (other.objkey)
        end
---------------------------------------------------
feature -- Comparison

    compare (other : like current) : INTEGER is

        local
            kcmp : INTEGER
            acmp : INTEGER

        do
            if id /= other.id then
                result := id - other.id
                    -- make sure they aren't treated as equal ...
            else -- id = other.id
                kcmp := keycompare (objkey, other.objkey)
                acmp := myaddr.compare (other.myaddr)
                if objkey.count /= other.objkey.count then
                    result := (objkey.count - other.objkey.count)
                elseif kcmp /= 0 then
                    result := kcmp
                elseif major_ver.value /= other.major_ver.value then
                    result := (major_ver.value - other.major_ver.value)
                elseif minor_ver.value /= other.minor_ver.value then
                    result := (minor_ver.value - other.minor_ver.value)
                elseif acmp /= 0 then
                    result := acmp
                elseif comps /= void then
                    result := comps.compare (other.comps)    
                end -- if objkey.count /= other.objkey.count then ...
            end -- if id /= other.id then ...
        end
---------------------------------------------------
feature -- Miscellaneous

    print_it is

        do
            io.put_string ("IIOP Profile%N")
            io.put_string ("    Version:  ")
            io.putint (major_ver.value)
            io.putchar ('.')
            io.putint (minor_ver.value)
            io.new_line
            io.put_string ("    Address:  ")
            io.put_string (myaddr.stringify)
            io.new_line
            comps.print_it
        end
---------------------------------------------------
feature { IIOP_PROFILE } -- Implementation

    objkey    : ARRAY [INTEGER]
    comps     : MULTI_COMPONENT
    myaddr    : INET_ADDRESS
    major_ver : OCTET
    minor_ver : OCTET
    tagid     : INTEGER
    host      : STRING

end -- class IIOP_PROFILE

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

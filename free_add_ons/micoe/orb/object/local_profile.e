indexing

description: "Still to be entered";
keywords: "Still to be entered";
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"

class LOCAL_PROFILE

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
    make, make2, make3, make4, make5

feature

    make (keys : ARRAY [INTEGER]) is

        do
            make5 (keys, keys.count, Tag_local, void, -1)
        end
----------------------

    make2 (keys : ARRAY [INTEGER]; len : INTEGER) is

        do
            make5 (keys, len, Tag_local, void, -1)
        end
----------------------

    make3 (keys : ARRAY [INTEGER];
           len, an_id : INTEGER) is

        do
            make5 (keys, len, an_id, void, -1)
        end
----------------------

    make4 (keys : ARRAY [INTEGER];
           len, an_id : INTEGER;
           a_host : STRING) is

        do
            make5 (keys, len, an_id, a_host, -1)
        end
----------------------

    make5 (keys   : ARRAY [INTEGER];
           len    : INTEGER;
           an_id  : INTEGER;
           a_host : STRING
           a_pid  : INTEGER) is

        do
            tagid  := an_id
            if a_host /= void then
                host := a_host
            else
                host := hostname
            end
            if a_pid >= 0 then
                pid := a_pid
            else
                pid := getpid
            end
            objkey := keys
        end
----------------------
feature -- Access

    addr : ADDRESS is

        do
            result := myaddr
        end
----------------------

    length : INTEGER is

        do
            if objkey /= void then
                result := objkey.count
            end
        end
----------------------

    id : INTEGER is

        do
            result := tagid
        end
----------------------

    get_objectkey (l : INTEGER_REF) : ARRAY [INTEGER] is

        do
            l.set_item (length)
            result := objkey
        end
----------------------

    reachable : BOOLEAN is

        do
            result := (samehosts (host, hostname) and then (pid = getpid))
        end
----------------------
feature -- Encoding and Decoding

    encode_id : INTEGER is

        do
            result := tagid
        end
----------------------

    encode (ec : DATA_ENCODER) is

        local
            keys    : ARRAY [OCTET]

        do
            ec.struct_begin
            ec.put_string_raw (host)
            ec.put_long (tagid)
            ec.seq_begin (length)
            ec.put_octets (objkey)
            ec.seq_end
            ec.struct_end
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
feature -- Copying

    copy (other : like current) is

        do
            pid    := other.pid
            host   := other.host
            myaddr := other.myaddr
            tagid  := other.tagid
            objkey := clone (other.objkey)
        end
----------------------
feature -- Comparison

    compare (other : like current) : INTEGER is

        local
            kcmp : INTEGER

        do
            if id = other.id then
                kcmp := keycompare (objkey, other.objkey)
                if pid /= other.pid then
                    result := pid - other.pid
                elseif kcmp /= 0 then
                    result := kcmp
                elseif tagid /= other.tagid then
                    result := (tagid - other.tagid)
                elseif host < other.host then
                    result := -1
                elseif host > other.host then
                    result := 1
                else
                    if myaddr /= void then
                        if other.myaddr /= void then
                            result := myaddr.compare (other.myaddr)
                        else -- myaddr /= void and other.myaddr = void
                            result := 1
                        end
                    elseif other.myaddr /= void then
                        result := -1
                    end
                end -- if pid /= other.pid then ...
            else -- id /= other.id
                result := id - other.id
                    -- make sure they are not treated as equal ...
            end
        end
----------------------
feature -- Miscellaneous

    print_it is

        do
        end
----------------------
feature { LOCAL_PROFILE } -- Implementation

    objkey : ARRAY [INTEGER]
    myaddr : LOCAL_ADDRESS
    host   : STRING
    tagid  : INTEGER
    pid    : INTEGER
----------------------

    getpid : INTEGER is

        external "C"
        alias    "MICO_getpid"

        end

end -- class LOCAL_PROFILE

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

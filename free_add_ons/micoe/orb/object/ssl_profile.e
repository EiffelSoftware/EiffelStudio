indexing

description: "Still to be entered";
keywords: "Still to be entered";
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"

class SSL_PROFILE

inherit
    IOR_STATICS
        undefine
            copy, is_equal
        end;
    IOR_PROFILE
        redefine
            copy, is_equal
        end

creation
    make, make2, make3

feature -- Initialization

    make (ip : IOR_PROFILE; sa : SSL_ADDRESS) is

        do
        end
----------------------

    make2 (ior : IOR_PROFILE; ia : SSL_ADDRESS) is

        local
            mc   : MULTI_COMPONENT
            sslc : SSL_COMPONENT
            port : INTEGER
            ina  : INET_ADDRESS

        do
            myaddr := ia
            myprof := ior
            -- use port from SSLComponent instead of port from
            -- IIOP profile ...
            if equal (myaddr.content.proto, "inet") then
                check
                    is_internet_iop : ior.id = Tag_internet_iop
                end
                mc   := ior.components
                sslc ?= mc.component (Tag_ssl_sec_trans)
                check
                    nonvoid_component : sslc /= void
                end
                port := sslc.port
                ina  ?= myaddr.content
                ina.set_port (port)
            end
        end
----------------------

    make3 (o : ARRAY [INTEGER]; ia : SSL_ADDRESS; mc : MULTI_COMPONENT) is

        local
            sslc : SSL_COMPONENT
            mc2  : MULTI_COMPONENT
            ina  : INET_ADDRESS
            port : INTEGER

        do
            myaddr := ia

            -- copy port from IIOP profile to SSLComponent
            if equal (myaddr.content.proto, "inet") then
                ina  ?= myaddr.content
                port := ina.get_port
            end
            mc2 := clone (mc)
            create sslc.make1 (port)
            mc2.add_component (sslc) 
            myprof := ia.make_ior_profile (o, mc2)
        end
----------------------
feature -- Access

    addr : ADDRESS is

        do
            result := myaddr
        end
----------------------

    id : INTEGER is

        do
            result := tag_to_ssltag (myprof.id)
        end
----------------------

    get_objectkey (l : INTEGER_REF) : ARRAY [INTEGER] is

        do
            result := myprof.get_objectkey (l)
        end
----------------------

    reachable : BOOLEAN is

        do
            result := myprof.reachable
        end
----------------------
feature -- Encoding and Decoding

    encode_id : INTEGER is

        do
            result := myprof.id
        end
----------------------

    encode (ec : DATA_ENCODER) is

        do
            myprof.encode (ec)
        end
----------------------
feature -- Mutation

    set_objectkey (key : ARRAY [INTEGER]; cnt : INTEGER) is

        do
            myprof.set_objectkey (key, cnt)
        end
----------------------
feature -- Copying

    copy (other : like current) is

        do
            myaddr := other.myaddr
            myprof := other.myprof
        end
----------------------
feature -- Equality test

        is_equal (other : like current) : BOOLEAN is

            do
                result := equal (myaddr, other.myaddr) and then
                          equal (myprof, other.myprof)
            end
----------------------
feature -- Comparison

    compare (other : like current) : INTEGER is

        local
            sp : SSL_PROFILE

        do
            if id /= other.id then
                result := id - other.id
            else -- id = other.id
                sp ?= other
                if sp /= void then
                    result := myaddr.compare (sp.myaddr)
                    if result = 0 then
                        result := myprof.compare (sp.myprof)
                    end
                end
            end
        end
----------------------
feature -- Miscellaneous

    print_it is

        do
        end
----------------------
feature { SSL_PROFILE } -- Implementation

    objkey : ARRAY [OCTET]
    myaddr : SSL_ADDRESS
    myprof : IOR_PROFILE
----------------------

    tag_to_ssltag (tag : INTEGER) : INTEGER is
        -- This is the only feature that has to be changed
        -- to add support for SSL over a new low level transport.

        do
            inspect tag

            when Tag_internet_iop then
                result := Tag_ssl_internet_iop

            when Tag_unix_iop then
                 result := Tag_ssl_unix_iop

            end
        end

end -- class SSL_PROFILE
    
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

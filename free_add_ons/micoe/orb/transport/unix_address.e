indexing

description: "A concrete address in the unix domain family";
keywords: "GIOP framework", "address", "unix domain";
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"

class UNIX_ADDRESS

inherit
    ADDRESS

creation
    make, make_with_filename

feature

    make (una : SOCKADDR_UN) is

        do
            filename := una.get_path
        end
-------------------------------------

    make_with_filename (n : STRING) is

        local
            p : POINTER

        do
            if n /= void then
                filename := n
            else
                filename := ""
                p        := ext_tempnam
                check
                    got_tempnam : p /= Default_pointer
                end
                filename.from_c (p)
            end
        end
-------------------------------------
feature -- Access

    stringify : STRING is

        do
            result := proto
            result.extend (':')
            result.append (filename)
        end
-------------------------------------

    proto : STRING is

        do
            result := "unix"
        end
-------------------------------------

    make_transport : TRANSPORT is

        do
            create {UNIX_TRANSPORT} result.make
        end
-------------------------------------

    make_transport_server : TRANSPORT_SERVER is

        do
            create {UNIX_TRANSPORT_SERVER} result.make
        end
-------------------------------------

    make_ior_profile (keys : ARRAY [INTEGER];
                      mc : MULTI_COMPONENT) : IOR_PROFILE is

        do
            create {UIOP_PROFILE} result.make (keys, current, mc)
        end
-------------------------------------

    is_local : BOOLEAN is

        do
            result := false
        end
-------------------------------------

    get_filename : STRING is

        do
            result := filename
        end
-------------------------------------

    get_sockaddr : SOCKADDR_UN is

        local
            f : INTEGER
        do
            f := Af_unix
            create result.make (filename, f)
        end
-------------------------------------
feature -- Mutation

    set_filename (n : STRING) is

        do
            filename := n
        end
-------------------------------------

    set_sockaddr (sun : SOCKADDR_UN) is

        do
            filename := sun.get_path
        end
-------------------------------------
feature -- Comparison

    compare (other : like current) : INTEGER is

        do
            if proto < other.proto then
                result := -1
            elseif proto > other.proto then
                result := 1
            end

            if result = 0 then
                if filename < other.filename then
                    result := -1
                elseif filename > other.filename then
                    result := 1
                end
            end
        end
-------------------------------------
feature -- Hashing

    hash_code : INTEGER is

        do
            result := filename.hash_code
        end
-------------------------------------
feature { UNIX_ADDRESS } -- Implementation

    filename : STRING

-------------------------------------

    Af_unix : INTEGER is

        external "C"
        alias "ADDR_Af_unix"

        end
-------------------------------------

    ext_tempnam : POINTER is

        external "C"
        alias "MICO_tempnam"

        end

invariant
    nonvoid_filename : filename /= void

end -- class UNIX_ADDRESS

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

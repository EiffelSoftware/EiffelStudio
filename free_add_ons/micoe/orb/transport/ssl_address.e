indexing

description: "Abstraction of a socket address for the Secure Socket Layer";
keywords: "address", "socket", "secure";
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"

class SSL_ADDRESS

inherit
    ADDRESS

creation
    make

feature -- Initialization

    make (a : ADDRESS) is

        require
            nonvoid_arg : a /= void

        do
            my_addr := a
        end
----------------------
feature -- Access

    stringify : STRING is

        do
            result := "ssl:"
            result.append (my_addr.stringify)
        end
----------------------

    proto : STRING is

        do
            result := "ssl"
        end
----------------------

    make_transport : TRANSPORT is

        do
            create {SSL_TRANSPORT} result.make1 (current)
        end
----------------------

    make_transport_server : TRANSPORT_SERVER is

        do
            create {SSL_TRANSPORT_SERVER} result.ssl_make (current)
        end
----------------------

    make_ior_profile (a : ARRAY [INTEGER];
                      mc : MULTI_COMPONENT) : IOR_PROFILE is

        do
            create {SSL_PROFILE} result.make3 (a, current, mc)
        end
----------------------

    is_local : BOOLEAN is

        do
            result := my_addr.is_local
        end
----------------------

    content : ADDRESS is

        do
            result := my_addr
        end
----------------------

    set_content (a : ADDRESS) is

        require
            nonvoid_arg : a /= void

        do
            my_addr := a
        end
----------------------
feature -- Comparison

    compare (other : like current) : INTEGER is

        local
            he : SSL_ADDRESS

        do
            he     ?= other
            result := my_addr.compare (he.my_addr)
        end
----------------------
feature -- Hashing

    hash_code : INTEGER is

        do
            result := my_addr.hash_code
        end
----------------------
feature {SSL_ADDRESS } -- Implementation

    my_addr : ADDRESS

invariant
        nonvoid_content : my_addr /= void

end -- class SSL_ADDRESS

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

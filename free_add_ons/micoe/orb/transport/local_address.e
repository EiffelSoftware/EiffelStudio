indexing

description: "An address to be used when client and server are collocated.";
keywords: "address", "collocation";
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"

class LOCAL_ADDRESS

inherit
    ADDRESS

creation
    make


feature -- Initialization

    make is

        do
        end
----------------------

    stringify : STRING is

        do
            result := "local"
        end
----------------------

    proto : STRING is

        do
            result := "local"
        end
----------------------

    make_ior_profile (key : ARRAY [INTEGER];
                      mc : MULTI_COMPONENT) : IOR_PROFILE is

        do
            create {LOCAL_PROFILE} result.make (key)
        end
----------------------

    is_local : BOOLEAN is

        do
            result := true
        end
----------------------

    make_transport : TRANSPORT is

        do
            check
                never_called : false
            end
        end
----------------------

    make_transport_server : TRANSPORT_SERVER is

        do
            check
                never_called : false
            end
        end
----------------------
feature -- Copying

    trivial_clone : like current is
        -- This is _not_ my idea of a clone, but that's
        -- what the C++ code says. Be sure to use this
        -- routine whenever the C++ code says clone for a local address.

        do
            create result.make
        end
----------------------
feature -- Comparison

    compare (other : like current) : INTEGER is

        local
            cmpl : BOOLEAN
            cmpg : BOOLEAN

        do
            cmpl := (proto < other.proto)
            cmpg := (other.proto < proto)
            if cmpl then
                result := -1
            elseif cmpg then
                result := 1
            end
        end
----------------------
feature -- Hashing

    hash_code : INTEGER is

        do
            result := proto.hash_code
                -- XXX This isn't a good idea, since
                -- all instances will have the same
                -- hashcode.
        end

end -- class LOCAL_ADDRESS

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

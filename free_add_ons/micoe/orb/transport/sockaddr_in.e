indexing

description: "Abstraction of a socket address in the IP family";
keywords: "address", "socket", "TCP/IP";
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"

class SOCKADDR_IN

creation
    make

feature

    make (f, p : INTEGER; a : POINTER) is

        do
            family := f
            port   := p -- don't do htons here; that's done when
                        -- binding resp. connecting ...
            addr   := a
        end
---------------------------------------------
feature -- Access

    get_family : INTEGER is

        do
            result := family
        end
---------------------------------------------

     get_port : INTEGER is

        do
            result := port -- don't do ntohs here ...
        end
---------------------------------------------

    get_addr : POINTER is

        do
            result := addr
        end
---------------------------------------------
feature -- Mutation

    set_sin_family (sinf : INTEGER) is

        do
            family := sinf
        end
---------------------------------------------

    set_sin_port (sinp : INTEGER) is

        do
            port := sinp
        end
---------------------------------------------

    set_sin_addr (sina : POINTER) is

        do
            addr := sina
        end
---------------------------------------------
feature { SOCKADDR_IN } -- Implementation

    family : INTEGER
        -- Address family AF_INET, etc.
    port : INTEGER
        -- Port number.
    addr : POINTER 
        -- Pointer to a C data structure
        -- describing the IP address. It's
        -- best not to treat this as an integer
        -- since on 32-bit machines it's an
        -- unsigned long, which Eiffel can't
        -- handle.


end -- class SOCKADDR_IN

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

indexing

description: "Abstraction of a socket address in the unix domain family.";
keywords: "address", "socket", "unix domain";
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"

class SOCKADDR_UN

creation
    make

feature -- Initialization

    make (p : STRING; f : INTEGER) is

        do
            family := f
            path   := p
        end

feature -- Access

    get_family : INTEGER is

        do
            result := family
        end
-------------------------------------

    get_path : STRING is

        do
            result := path
        end
-------------------------------------
feature -- Mutastion

    set_family (f : INTEGER) is

        do
            family := f
        end
-------------------------------------

    set_path (p : STRING) is

        do
            path := p
        end
-------------------------------------
feature { SOCKADDR_UN } -- Implementation

    family : INTEGER
        -- It better be AF_UNIX
    path   : STRING

end -- class SOCKADDR_UN

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

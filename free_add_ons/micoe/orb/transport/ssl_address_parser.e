indexing

description: "A concrete address parser capable of converting a string %
             %into an SSL address";
keywords: "address", "socket", "secure";
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"

class SSL_ADDRESS_PARSER

inherit
    ADDRESS_PARSER

creation
    make

feature -- Initialization

    make is

        do
            register_parser (current)
        end
----------------------
feature -- Destruction

        delete is

            do
                unregister_parser (current)
            end
----------------------
feature -- Parsing

    has_proto (s : STRING) : BOOLEAN is

        do
            result := equal (s, "ssl")
        end
----------------------

    parse (s : STRING) : ADDRESS is

        local
            a : ADDRESS

        do
            a := address_parse (s)

            if a /= void then
                create {SSL_ADDRESS} result.make (a)
            end
        end

end -- class SSL_ADDRESS_PARSER

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

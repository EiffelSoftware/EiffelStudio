indexing

description: "Parses production for <member>(71[2.3])";
keywords: "member";
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"

class MEMBER_PARSER

inherit
    CONCRETE_SYNTAX_PARSER
        redefine
            parse, value
        end

feature

    value : MEMBER

    parse (scan : SCANNER) is

        local
            tsp : TYPE_SPEC_PARSER
            dp  : DECLARATOR_PARSER
            tok : INTEGER

        do
            create value.make
            create tsp
            tsp.parse (scan)
            value.set_type_spec (tsp.value)

            if scan.token /= Identifier then
                error (<<"Expecting an identifier">>)
            end            

            from
                create dp
                dp.parse (scan)
                value.add_component (dp.value)
                tok := scan.token
            until
                tok /= Comma
            loop
                scan.advance -- Eat the ','
                dp.parse (scan)
                value.add_component (dp.value)
                tok := scan.token
            end

            if scan.token /= Semicolon then
                error (<<"Expecting ';'">>)
            else
                scan.advance -- Eat the ';'
            end
        end

end -- class MEMBER_PARSER

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

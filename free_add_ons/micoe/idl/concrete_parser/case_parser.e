indexing

description: "Parses production for <case>(75[2.3])";
keywords: "case";
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"

class CASE_PARSER

inherit
    CONCRETE_SYNTAX_PARSER
        redefine
            parse, value
        end

feature

    value : CASE

    parse (scan : SCANNER) is

        local
            tok : INTEGER
            clp : CASE_LABEL_PARSER
            esp : ELEMENT_SPEC_PARSER

        do
            from
                create value.make
                create clp
                tok := scan.token
            until
                tok /= Case_token and then tok /= Default_token
            loop
                clp.parse (scan)
                value.add_component (clp.value)
                tok := scan.token
            end

            create esp
            esp.parse (scan)
            value.set_element_spec (esp.value)

            if scan.token /= Semicolon then
                error (<<"Expecting ';'">>)
            else
                scan.advance -- Eat the ';'
            end
        end

end -- class CASE_PARSER

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

indexing

description: "Parses production for <union_type>(72[2.3])";
keywords: "union_type";
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"

class UNION_TYPE_PARSER

inherit
    EXTENDED_SYNTAX_PARSER
        redefine
            parse, value
        end

feature

    value : UNION_TYPE

    parse (scan : SCANNER) is

        local
            stsp : SWITCH_TYPE_SPEC_PARSER
            cp   : CASE_PARSER
            tok  : INTEGER

        do
            scan.advance -- Eat the "union"

            if scan.token /= Identifier then
                error (<<"Expecting an identifier">>)
            else
                create value.make (symbol_table.register_type (scan.lexeme))
                scan.advance --Eat the identifier
            end

            if scan.token /= Switch_token then
                error (<<"Expecting %"switch%"">>)
            else
                scan.advance -- Eat the "switch"
            end

            if scan.token /= Left_paren then
                error (<<"Expecting '('">>)
            else
                scan.advance -- Eat the '('
            end

            create stsp
            stsp.parse (scan)
            value.set_switch_type_spec (stsp.value)

            if scan.token /= Right_paren then
                error (<<"Expecting ')'">>)
            else
                scan.advance -- Eat the ')'
            end

            if scan.token /= Left_brace then
                error (<<"Expecting '{'">>)
            else
                 scan.advance -- Eat the '{'
            end

            from
                create cp
                cp.parse (scan)
                value.add_component (cp.value)
                tok := scan.token
            until
                tok /= Case_token and then tok /= Default_token
            loop
                cp.parse (scan)
                value.add_component (cp.value)
                tok := scan.token
            end

            if scan.token /= Right_brace then
                error (<<"Expecting '}'">>)
            else
                 scan.advance -- Eat the '}'
            end
        end

end -- class UNION_TYPE_PARSER

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

indexing

description: "Parses production for <primary_expr>(38[2.3])";
keywords: "primary_expr";
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"

class PRIMARY_EXPR_PARSER

inherit
    CONCRETE_SYNTAX_PARSER
        redefine
            parse, value
        end

feature

    value : CONST_EXP

    parse (scan : SCANNER) is

        local
           snp : SCOPED_NAME_PARSER
           cep : CONST_EXP_PARSER
           lit : LITERAL

        do
            inspect scan.token

            when Doublecolon, Identifier then
                create snp
                snp.parse (scan)
                value := snp.value

            when Integer_literal then
                create {INTEGER_LITERAL} lit.make (scan.integer_value)
                value := lit
                scan.advance -- Eat the integer literal

            when String_literal then
                create {STRING_LITERAL} lit.make (scan.string_value)
                value := lit      
                scan.advance -- Eat the string literal

            when Wide_string_literal then
                -- Not yet implemented

            when Real_literal then
                create {REAL_LITERAL} lit.make (scan.real_value)
                value := lit
                scan.advance -- Eat the real literal

            when Character_literal then
                create {CHARACTER_LITERAL} lit.make (scan.character_value)
                value := lit
                scan.advance -- Eat the character literal

            when Wide_character_literal then
                create {WIDE_CHARACTER_LITERAL} lit.make (scan.integer_value)
                value := lit
                scan.advance -- Eat the wide character literal

            when Boolean_literal then
                create {BOOLEAN_LITERAL} lit.make (scan.boolean_value)
                value := lit
                scan.advance -- Eat the boolean literal

            when Left_paren then
                scan.advance -- Eat the '('
                create cep
                cep.parse (scan)
                value := cep.value
                if scan.token /= Right_paren then
                    error (<<"Expecting a ')'">>)
                else
                    scan.advance -- Eat the ')'
                end
            end
        end

end -- class PRIMARY_EXPR_PARSER

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

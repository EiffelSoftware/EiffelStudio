indexing

description: "Parses production for <raises_expr>(93[2.3])";
keywords: "raises_expr";
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"

class RAISES_EXPR_PARSER

inherit
    EXTENDED_SYNTAX_PARSER
        redefine
            parse, value
        end

feature

    value : RAISES_EXPR

    parse (scan : SCANNER) is

        local
            tok  : INTEGER
            snp  : SCOPED_NAME_PARSER
            sn   : SCOPED_NAME
            simp : STRING

        do
            create value.make

            scan.advance -- Eat the "raises"

            if scan.token /= Left_paren then
                error (<<"Expecting '('">>)
            else
                scan.advance -- Eat the '('
            end

            from
                create snp
                snp.parse (scan)
                sn   := snp.value
                simp := sn.last_name_component
                if symbol_table.type_is_visible (simp) then
                    value.add_component (
                        symbol_table.simple_name_to_full_type (simp))
                elseif symbol_table.fulltype_is_visible (sn) then
                    value.add_component (sn)
                else
                    error (<<"A type ", sn.to_string,
                             " is not visible from scope ",
                             symbol_table.current_scope.to_string>>)
                end
                tok := scan.token
            until
                tok /= Comma
            loop
                scan.advance -- Eat the ','
                snp.parse (scan)
                sn   := snp.value
                simp := sn.last_name_component
                if symbol_table.type_is_visible (simp) then
                    value.add_component (
                        symbol_table.simple_name_to_full_type (simp))
                elseif symbol_table.fulltype_is_visible (sn) then
                    value.add_component (sn)
                else
                    error (<<"A type ", sn.to_string,
                             " is not visible from scope ",
                             symbol_table.current_scope.to_string>>)
                end
                tok := scan.token
            end

            if scan.token /= Right_paren then
                if tok = Doublecolon or else tok = Identifier then
                    error (<<"Expecting ','">>)
                else
                    error (<<"Expecting ')'">>)
                end
            else
                scan.advance -- Eat the ')'
            end
        end

end -- class RAISES_EXPR_PARSER

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

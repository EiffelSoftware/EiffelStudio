indexing

description: "Parses production for <except_dcl>(86[2.3])";
keywords: "except_dcl";
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"

class EXCEPT_DCL_PARSER

inherit
    EXTENDED_SYNTAX_PARSER
        redefine
            parse, value
        end

feature

    value : EXCEPT_DCL

    parse (scan : SCANNER) is

        local
             mp  : MEMBER_PARSER
             sn  : SCOPED_NAME
             tok : INTEGER

        do
            scan.advance -- Eat the "exception"

            if scan.token /= Identifier then
                error (<<"Expecting an identifier">>)
            else
                if not symbol_table.simpletype_is_visible (scan.lexeme) then
                    sn := symbol_table.register_type (scan.lexeme)
                    create value.make (sn)
                else
                    error (<<"A type ", scan.lexeme,
                             " already exists in scope ",
                             symbol_table.current_scope.to_string>>)
                end
                scan.advance -- Eat the identifier
            end

            if scan.token /= Left_brace then
                error (<<"Expecting '{'">>)
            else
                scan.advance -- Eat the '{'
            end

            from
                 create mp
                 tok := scan.token
            until
                 tok = Right_brace
            loop
                 mp.parse (scan)
                 value.add_component (mp.value)
                 tok := scan.token
            end

            scan.advance -- Eat the '}'
        end

end -- class EXCEPT_DCL_PARSER

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

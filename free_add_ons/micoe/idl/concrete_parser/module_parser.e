indexing

description: "Parses production for <module>(3[2.3])";
keywords: "module";
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"

class MODULE_PARSER

inherit
    EXTENDED_SYNTAX_PARSER
        redefine
            parse, value
        end

feature

    value   : MODULE
    its_new : BOOLEAN

    parse (scan : SCANNER) is

        local
            dp  : DEFINITION_PARSER
            tok : INTEGER
            nm  : STRING
            sn  : SCOPED_NAME

        do
            scan.advance -- Eat the "module"

            if scan.token /= Identifier then
                error (<<"Expecting an identifier">>)
            else
                nm := clone (scan.lexeme)
                symbol_table.descend (nm)
                    -- Begin a new scope.
                sn := symbol_table.current_scope.duplicate
                scan.advance -- Eat the identifier
            end

            if scan.token /= Left_brace then
                error (<<"Expecting '{'">>)
            else
                scan.advance -- Eat the '{'
            end

            symbol_table.lookup_module (sn)
            if symbol_table.found_module /= void then
                value   := symbol_table.found_module
                its_new := false
            else
                create value.make (sn)
                its_new := true
            end

            from
                 create dp
                 dp.parse (scan)
                 value.add_component (dp.value)
                 tok := scan.token
            until
                 tok = Right_brace
            loop
                 dp.parse (scan)
                 value.add_component (dp.value)
                 tok := scan.token
            end

            scan.advance -- Eat the '}'

            symbol_table.register_module (value)
            symbol_table.ascend
                -- Return to the previous scope.
        end

end -- class MODULE_PARSER

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

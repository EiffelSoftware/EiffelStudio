indexing

description: "Parses production for <enum_tpe>(78[2.3])";
keywords: "enum_type";
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"

class ENUM_TYPE_PARSER

inherit
    EXTENDED_SYNTAX_PARSER
        redefine
            parse, value
        end

feature

    value : ENUM_TYPE

    parse (scan : SCANNER) is

        local
            tok : INTEGER

        do
            scan.advance -- Eat the "enum"

            if scan.token /= Identifier then
                error (<<"Expecting an identifier">>)
            else
                create value.make (symbol_table.register_type (scan.lexeme))
                scan.advance -- Eat the identifier
            end

            if scan.token /= Left_brace then
                error (<<"Expecting '{'">>)
            else
                scan.advance -- Eat the '{'
            end

            from
                if scan.token /= Identifier then
                    error (<<"Expecting an identifier">>)
                else
                    value.add_enumerator (scan.lexeme)
                    scan.advance -- Eat the identifier
                end
                tok := scan.token
            until
                tok /= Comma
            loop
                scan.advance -- Eat the ','
                if scan.token /= Identifier then
                    error (<<"Expecting an identifier">>)
                else
                    value.add_enumerator (scan.lexeme)
                    scan.advance -- Eat the identifier
                end
                tok := scan.token
            end

            if scan.token /= Right_brace then
                error (<<"Expecting '}'">>)
            else
                scan.advance -- Eat the '}'
            end
        end

end -- class ENUM_TYPE_PARSER

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

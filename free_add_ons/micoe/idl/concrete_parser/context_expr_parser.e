indexing

description: "Parses production for <context_expr>(94[2.3])";
keywords: "context_expr";
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"

class CONTEXT_EXPR_PARSER

inherit
    CONCRETE_SYNTAX_PARSER
        redefine
            parse, value
        end

feature

    value : CONTEXT_EXPR

    parse (scan : SCANNER) is

        local
            tok : INTEGER
            sl  : STRING_LITERAL

        do
            scan.advance -- Eat the "context"

            if scan.token /= Left_paren then
                error (<<"Expecting '('">>)
            else
                scan.advance -- Eat the '('
            end

            from
                create value.make
                create sl.make (scan.lexeme)
                value.add_component (sl)
                scan.advance -- Eat the string literal
                tok := scan.token
            until
                tok /= Comma
            loop
                scan.advance -- Eat the ','
                create sl.make (scan.lexeme)
                value.add_component (sl)
                scan.advance -- Eat the string literal
                tok := scan.token
            end

            if scan.token /= Right_paren then
                error (<<"Expecting ')'">>)
            else
                scan.advance -- Eat the ')'
            end
        end

end -- class CONTEXT_EXPR_PARSER

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

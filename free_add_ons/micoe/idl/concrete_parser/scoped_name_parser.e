indexing

description: "Parses production for <scoped_name>(12[2.3])";
keywords: "scoped_name";
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"

class SCOPED_NAME_PARSER

inherit
    THE_TABLE;
    CONCRETE_SYNTAX_PARSER
        redefine
            parse, value
        end

feature { CONCRETE_SYNTAX_PARSER }

    value : SCOPED_NAME

    parse (scan : SCANNER) is

        local
            tok : INTEGER

        do
            create value.make
            from
                if scan.token = DoubleColon then
                    value.set_initial_doublecolon
                    scan.advance -- Eat the '::
                    tok := scan.token
                end

                if scan.token = Identifier then
                    value.add_name_component (scan.lexeme)
                    scan.advance -- Eat the Identifier
                    tok := scan.token
                end
            until
                tok /= Doublecolon
            loop
                scan.advance -- Eat the '::'
                value.add_name_component (scan.lexeme)
                scan.advance -- Eat the Identifier
                tok := scan.token
            end
            if value.name_component_count = 0 then
                error (<<"A scoped name has no components",
                         " (perhaps this is a keyword)">>)
            end
        end

end -- SCOPED_NAME_PARSER

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

indexing

description: "Parses production for <init_dcl>(23[2.3])";
keywords: "interface";
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"

class INIT_DCL_PARSER

inherit
    EXTENDED_SYNTAX_PARSER
        redefine
            parse, value
        end

feature

    value : INIT_DCL

    parse (scan : SCANNER) is

        local
            name : SCOPED_NAME
            ipdp : INIT_PARAM_DCL_PARSER
            tok  : INTEGER

        do
            if scan.token /= Identifier then
                error (<<"Expecting an identifier">>)
            end

            name := symbol_table.current_scope.duplicate
            name.add_name_component (scan.lexeme)
            scan.advance -- Eat the identifier

            if scan.token /= Left_paren then
                error (<<"Expecting `('">>)
            else
                scan.advance -- Eat the `('
            end

            create value.make (name)

            from
                create ipdp
                ipdp.parse (scan)
                value.add_component (ipdp.value)
                tok := scan.token
            until
                tok /= Comma
            loop
                scan.advance -- Eat the ','
                ipdp.parse (scan)
                value.add_component (ipdp.value)
                tok := scan.token
            end

            if scan.token /= Right_paren then
                error (<<"Expecting `)'">>)
            else
                scan.advance -- Eat the `)'
            end
        end


end -- class INIT_DCL_PARSER

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

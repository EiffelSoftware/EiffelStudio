indexing

description: "Parses production for <or_expr>(30[2.3])";
keywords: "or_expr";
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"

class OR_EXPR_PARSER

inherit
    CONCRETE_SYNTAX_PARSER
        redefine
            parse, value
        end

feature

    value : CONST_EXP

    parse (scan : SCANNER) is

        local
            xep : XOR_EXPR_PARSER
            tok : INTEGER

        do
            from
                create {OR_EXPR} value.make
                create xep
                xep.parse (scan)
                value.add_component (xep.value)
                tok := scan.token
            until
                tok /= Orop_token
            loop
                scan.advance -- Eat the '|'
                xep.parse (scan)
                value.add_component (xep.value)
                value.add_operator ('|')
                tok := scan.token
            end

            if value.component_count = 1 then -- a small optimization
                value := value.component_at (1)
            end
        end

end -- class OR_EXPR_PARSER

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

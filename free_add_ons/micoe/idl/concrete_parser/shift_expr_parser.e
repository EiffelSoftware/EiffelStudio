indexing

description: "Parses production for <shift_expr>(33[2.3])";
keywords: "shift_expr";
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"

class SHIFT_EXPR_PARSER

inherit
    CONCRETE_SYNTAX_PARSER
        redefine
            parse, value
        end

feature

    value : CONST_EXP

    parse (scan : SCANNER) is

        local
            aep : ADD_EXPR_PARSER
            tok : INTEGER

        do
            from
                create {SHIFT_EXPR} value.make
                create aep
                aep.parse (scan)
                value.add_component (aep.value)
                tok := scan.token
            until
                tok /= Shleft_token and then
                tok /= Shright_token
            loop
                if tok = Shleft_token then
                    value.add_operator ('l')
                else
                    value.add_operator ('r')
                end
                scan.advance -- Eat the '<<' or '>>'
                aep.parse (scan)
                value.add_component (aep.value)
                tok := scan.token
            end

            if value.component_count = 1 then -- a small optimization
                value := value.component_at (1)
            end
        end

end -- class SHIFT_EXPR_PARSER

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

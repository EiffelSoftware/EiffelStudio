indexing

description: "Parses production for <unary_expr>(36[2.3])";
keywords: "unary_expr";
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"

class UNARY_EXPR_PARSER

inherit
    CONCRETE_SYNTAX_PARSER
        redefine
            parse, value
        end

feature

    value : CONST_EXP

    parse (scan : SCANNER) is

        local
            pep : PRIMARY_EXPR_PARSER

        do
            create pep
            if scan.token = Minus_token then
                create {UNARY_EXPR} value.make
                value.add_operator ('-')
                scan.advance -- Eat the '-'
                pep.parse (scan)
                value.add_component (pep.value)
            elseif scan.token = Plus_token then
                create {UNARY_EXPR} value.make
                value.add_operator ('+')
                scan.advance -- Eat the '+'
                pep.parse (scan)
                value.add_component (pep.value)
            elseif scan.token = Not_token then
                create {UNARY_EXPR} value.make
                value.add_operator ('~')
                scan.advance -- Eat the '~'
                pep.parse (scan)
                value.add_component (pep.value)
            else
                pep.parse (scan)
                value := pep.value
            end
        end

end -- class UNARY_EXPR_PARSER

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

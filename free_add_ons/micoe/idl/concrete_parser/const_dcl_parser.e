indexing

description: "Parses production for <const_dcl>(27[2.3])";
keywords: "const_dcl";
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"

class CONST_DCL_PARSER

inherit
    EXTENDED_SYNTAX_PARSER
        redefine
            parse, value
        end

feature

    value : CONST_DCL

    parse (scan : SCANNER) is

        local
            ctp : CONST_TYPE_PARSER
            cep : CONST_EXP_PARSER

        do
            create value
            scan.advance -- Eat the "const"

            create ctp
            ctp.parse (scan)
            value.set_const_type (ctp.value)

            if scan.token /= Identifier then
                error (<<"Expecting an identifier">>)
            else
                value.set_name (build_scoped_name (scan.lexeme))
                scan.advance -- Eat the identifier
            end

            if scan.token /= Equal_token then
                Error (<<"Expecting '='">>)
            else
                scan.advance -- Eat the '='
            end

            create cep
            cep.parse (scan)
            value.set_const_exp (cep.value)
            value.const_exp.set_size (size (value.const_type))
        end
----------------------
feature { NONE }

    size (ct : CONST_TYPE) : INTEGER is

        local
            it : INTEGER_TYPE
            ft : FLOATING_PT_TYPE

        do
            it ?= ct
            ft ?= ct

            if it /= void then
                if it.short then
                    result := 16
                elseif it.longlong then
                    result := 64
                else -- it's long
                    result := 32
                end
            elseif ft /= void then
                if ft.is_double then
                    if ft.long then
                        result := 128 -- XXX ??
                    else
                        result := 64
                    end
                else -- it's float
                    result := 32
                end
            end
        end

end -- class CONST_DCL_PARSER

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

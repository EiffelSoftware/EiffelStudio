indexing

description: "Parses production <type_dcl>(42[2.3])";
keywords: "type_dcl";
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"

class  TYPE_DCL_PARSER

inherit
    EXTENDED_SYNTAX_PARSER
        redefine
            parse, value
        end

feature

    value : TYPE_DCL

    parse (scan : SCANNER) is

        local
            tdp : TYPEDEF_TYPE_PARSER
            stp : STRUCT_TYPE_PARSER
            utp : UNION_TYPE_PARSER
            etp : ENUM_TYPE_PARSER
            nt  : NATIVE_TYPE
            sn  : SCOPED_NAME
            sd  : SIMPLE_DECLARATOR

        do
            inspect scan.token

            when Typedef_token then
                create tdp
                tdp.parse (scan)
                value := tdp.value

            when Struct_token then
                create stp
                stp.parse (scan)
                value := stp.value

            when Union_token then
                create utp
                utp.parse (scan)
                value := utp.value

            when Enum_token then
                create etp
                etp.parse (scan)
                value := etp.value

            when Native_token then
                scan.advance -- Eat the "native"
                if scan.token /= Identifier then
                    error (<<"Expecting a simple declarator">>)
                else
                    if not symbol_table.type_is_visible (scan.lexeme) then
                        sn := symbol_table.register_type (scan.lexeme)
                        create sd.make (scan.lexeme, sn)
                    else
                        error (<<"A type ", scan.lexeme,
                                 " already exists in scope ",
                                 symbol_table.current_scope.to_string>>)
                    end
                    scan.advance -- Eat the identifier
                end
                create nt.make (sd)
                value := nt
            else
                error (<<"Expecting typedef, struct, union, enum or %
                         %else native">>)
            end
        end

end -- class TYPE_DCL_PARSER


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

indexing

description: "Parses production for <param_dcl>(91[2.3])";
keywords: "param_dcl";
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"

class PARAM_DCL_PARSER

inherit
    CONCRETE_SYNTAX_PARSER
        redefine
            parse, value
        end

feature

    value : PARAM_DCL

    parse (scan : SCANNER) is

        local
            tok  : INTEGER
            ptsp : PARAM_TYPE_SPEC_PARSER

        do
            create value
            tok := scan.token

            if tok /= In_token    and then
               tok /= Out_token   and then
               tok /= Inout_token then
                 error (<<"Expecting %"in%", %"out%" or %"inout%"">>)
             else
                 value.set_param_attribute (scan.lexeme)
                 scan.advance -- Eat the param_attribute
             end

             tok := scan.token

             if tok /= Unsigned_token    and then
                tok /= Long_token        and then
                tok /= Any_token         and then
                tok /= Boolean_token     and then
                tok /= Char_token        and then
                tok /= Double_token      and then
                tok /= Float_token       and then
                tok /= Short_token       and then
                tok /= String_token      and then
                tok /= Wchar_token       and then
                tok /= Octet_token       and then
                tok /= Doublecolon       and then
                tok /= Wstring_token     and then
                tok /= Fixed_token       and then
                tok /= Object_token      and then
                tok /= Identifier        then
                 error (<<"Expecting a parameter typespec">>)
             else
                 create ptsp
                 ptsp.parse (scan)
                 value.set_param_type_spec (ptsp.value)
             end

             if scan.token /= Identifier then
                 error (<<"Expecting an identifier">>)
             else
                 value.set_declarator (scan.lexeme)
                 scan.advance -- Eat the identifier
             end
        end

end -- class PARAM_DCL_PARSER

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

indexing

description: "Special scanner for IDL";
keywords: "scanner";
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"

class IDL_SCANNER

inherit
    SCANNER
        redefine
            build_dfa, recompute_token
        end;
    PROJECT_TOKENS

creation
    make


feature { NONE }

    build_dfa is

        do
            skip_space := true

            create start.make (1, 1)
            build_space_dfa
            build_identifier_dfa
            build_numeric_dfa
            build_multicharacter_dfa (
                <<'(', ')', '[', ']', '{', '}', ',', '=', ';', '#', '.'>>,
                <<Left_paren, Right_paren, Left_brack, Right_brack,
                  Left_brace, Right_brace, Comma, Equal_token,
                  Semicolon, Crosshatch, Dot_token>>)
            build_string_literal_dfa ('\')
            build_character_literal_dfa ('\')

            -- Handle the rest of the operators
            -- NOTE: Minus_token is handled by the numeric DFA and
            -- Div_token is handled by the comment DFA.
             
            build_multicharacter_dfa (
               <<'|', '&', '^', '+', '*', '%%', '~'>>,
               <<Orop_token, Andop_token, Xorop_token, Plus_token,
                 Mult_token, Mod_token, Not_token>>)
            build_double_character_dfa (':', Colon, Doublecolon)
            build_double_character_dfa ('<', Left_angle, Shleft_token)
            build_double_character_dfa ('>', Right_angle, Shright_token)
 
            -- Handle both kinds of comments

            build_comment_dfa
        end
----------------------

    hatch_token  : INTEGER
    skip_advance : BOOLEAN

    recompute_token is
        -- This has to be a bit tricky to take care of the
        -- preprocessor directives like #include, #version
        -- and #pragma since we have a look ahead of only 1.

        local
            ident  : STRING

        do
            if skip_advance then -- don't recurse
                token        := hatch_token
                skip_advance := false
            else -- we're not recursing
                standard_recompute_token

                if token = Crosshatch  and then
                   look_ahead = Identifier then
                    ident := clone (next_lexeme)
                    ident.to_lower
                    if equal (ident, "pragma") then
                        hatch_token := Pragma_token
                    elseif equal (ident, "include") then
                        hatch_token := Include_token
                    elseif equal (ident, "version") then
                        hatch_token := Version_token
                    else
                        hatch_token := Error_token -- unknown directive
                    end
                    skip_advance := true -- prevent recursion while
                    advance              -- recomputing `look_ahead'
                end -- if token = Crosshatch ...
            end -- if skip_advance then ...
        end
----------------------

    keywords : DICTIONARY [INTEGER, STRING] is

        once
            create result.make
            result.put (Interface_token, "interface")
            result.put (Struct_token, "struct")
            result.put (Union_token, "union")
            result.put (Typedef_token, "typedef")
            result.put (Module_token, "module")
            result.put (Sequence_token, "sequence")
            result.put (Array_token, "array")
            result.put (In_token, "in")
            result.put (Out_token, "out")
            result.put (Inout_token, "inout")
            result.put (Int_token, "int")
            result.put (Octet_token, "octet")
            result.put (Boolean_token, "boolean")
            result.put (Char_token, "char")
            result.put (Wchar_token, "wchar")
            result.put (Float_token, "float")
            result.put (Double_token, "double")
            result.put (String_token, "string")
            result.put (Wstring_token, "wstring")
            result.put (Exception_token, "exception")
            result.put (Void_token, "void")
            result.put (Unsigned_token, "unsigned")
            result.put (Fixed_token, "fixed")
            result.put (Const_token, "const")
            result.put (Any_token, "any")
            result.put (Object_token, "Object")
            result.put (Enum_token, "enum")
            result.put (Case_token, "case")
            result.put (Default_token, "default")
            result.put (Raises_token, "raises")
            result.put (Context_token, "context")
            result.put (Oneway_token, "oneway")
            result.put (Readonly_token, "readonly")
            result.put (Attribute_token, "attribute")
            result.put (Switch_token, "switch")
            result.put (Long_token, "long")
            result.put (Short_token, "short")
            result.put (Boolean_literal, "TRUE")
            result.put (Boolean_literal, "FALSE")
            result.put (Native_token, "native")
            result.put (Abstract_token, "abstract")
            result.put (Custom_token, "custom")
            result.put (Factory_token, "factory")
            result.put (Private_token, "private")
            result.put (Public_token,  "public")
            result.put (Supports_token, "supports")
            result.put (Truncatable_token, "truncatable")
            result.put (Valuebase_token,  "valuebase")
            result.put (Valuetype_token, "valuetype")
        end
----------------------

    build_comment_dfa is

        local
            
            sc1 : SINGLE_CHAR_STATE
            sc2 : SINGLE_CHAR_STATE
            sc3 : SINGLE_CHAR_STATE
            ms  : MULTI_STATE
            as1 : ACCEPTING_STATE
            as2 : ACCEPTING_STATE

        do
            nr_dfa := nr_dfa + 1
            if nr_dfa > start.count then
                start.resize (1, nr_dfa)
            end
            create as1.make (true, Div_token)
            create as2.make (false, Space)
            create sc3.make ('/', as2, void)
            create sc1.make ('*', sc3, void)
            sc1.set_no_state (sc1)
            sc3.set_no_state (sc1)
            create sc2.make ('%N', as2, void)
            sc2.set_no_state (sc2)
            create ms.make (<<'/', '*'>>, <<sc2, sc1>>, as1)
            create sc1.make ('/', ms, fail)
            start.put (sc1, nr_dfa)
        end

end -- class IDL_SCANNER

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

indexing

description: "Parses production for <value>(13[2.3])";
keywords: "interface";
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"

class VALUE_PARSER

inherit
    EXTENDED_SYNTAX_PARSER
        redefine
            parse, value
        end

feature

    value : VALUE
----------------------

    set_abstract is

        do
            is_abstract := true
        end
----------------------

    parse (scan : SCANNER) is

        local
            tok : INTEGER
            tdp : TYPE_DCL_PARSER
            cdp : CONST_DCL_PARSER
            edp : EXCEPT_DCL_PARSER
            adp : ATTR_DCL_PARSER
            odp : OP_DCL_PARSER
            idp : INIT_DCL_PARSER
            smp : STATE_MEMBER_PARSER
            inm : STRING

        do
            scan.advance -- Eat the "valuedef"

            if scan.token /= Identifier and then
               scan.token /= Object_token   then
                -- `Object_token' had to be added to handle PIDL ...
                error (<<"Expecting an identifier">>)
            end

            create value.make (symbol_table.register_type (scan.lexeme))
            symbol_table.register_value (value.name, is_abstract)

            if is_abstract then
                value.set_abstract
            end

            inm := scan.lexeme -- it may have to be removed if this
                               -- turns out to be a forward declaration.
            scan.advance -- Eat the name

            if scan.token = Colon then
                 scan.advance -- Eat the ':'
                 if scan.token = Supports_token then
                    scan.advance -- Eat the "supports"
                    collect_parents (scan, true)
                 else
                     collect_parents (scan, false)
                 end
            end

            if scan.token = Semicolon then
                value.set_forward_declaration
                symbol_table.remove_name (inm)
            elseif scan.token = Left_brace then
                -- It's a <value_dcl>
                symbol_table.descend (inm) -- start a new scope

                scan.advance -- Eat the '{'

                from
                    tok := scan.token
                until
                    tok = Right_brace
                loop
                    inspect tok

                    when Typedef_token, Enum_token,
                         Struct_token, Union_token, Native_token then
                        create tdp
                        tdp.parse (scan)
                        value.add_component (tdp.value)

                    when Const_token then
                        create cdp
                        cdp.parse (scan)
                        value.add_component (cdp.value)

                    when Exception_token then
                        create edp
                        edp.parse (scan)
                        value.add_component (edp.value)

                    when Readonly_token, Attribute_token then
                        create adp
                        adp.parse (scan)
                        value.add_component (adp.value)

                    when Factory_token then
                        scan.advance -- Eat the "factory"
                        create idp
                        idp.parse (scan)
                        value.add_component (idp.value)

                    when Private_token, Public_token then
                        create smp
                        smp.parse (scan)
                        value.add_component (smp.value)

                    else -- it had better be an op_dcl ...
                        create odp
                        odp.parse (scan)
                        value.add_component (odp.value)
                    end -- inspect
                    if scan.token /= Semicolon then
                        error (<<"Expecting a ';'">>)
                    else
                        scan.advance -- Eat the ';'
                    end
                    tok := scan.token
                end -- loop

                -- If we get here it's got to be a '}'
                scan.advance -- Eat the '}'
                symbol_table.ascend -- leave scope of interface
            else -- It's a <value_box>
                value.set_box
            end -- if scan.token = Semicolon then ...
        end
----------------------
feature { NONE }

    is_abstract : BOOLEAN
----------------------

    collect_parents (scan : SCANNER; supports : BOOLEAN) is

        local
            tok : INTEGER

        do
            if scan.token = Truncatable_token then
                value.set_truncatable
                scan.advance -- Eat the "truncatable"
            end
            from
                collect_one_parent (scan, supports)
                tok := scan.token
            until
                tok /= Comma
            loop
                scan.advance -- Eat the ','
                collect_one_parent (scan, supports)
                tok := scan.token
            end
            if tok = Supports_token then
                scan.advance -- Eat the "supports"
                -- collect the parents that are supported
                collect_parents (scan, true)
            end
        end
----------------------

    collect_one_parent (scan : SCANNER; supports : BOOLEAN) is

        local
            sn  : SCOPED_NAME
            snp : SCOPED_NAME_PARSER
            nm  : STRING

        do
            create snp
            snp.parse (scan)
            sn := snp.value
            nm := sn.last_name_component
            check_previous_declaration (nm)
            sn := symbol_table.simple_name_to_full_type (nm)
            if value.already_has_parent (sn) then
                error (<<"A valuetype may not inherit more ",
                         "than once from the same direct base">>)
            end
            if supports then
                if not symbol_table.is_an_interface (sn) then
                    error (<<"A valuetype can only support interfaces">>)
                end
            else
                if not symbol_table.is_a_value (sn) then
                    error (<<"A valuetype may only inherit from ",
                             "another valuetype">>)
                end
                if is_abstract                         and then
                   not symbol_table.value_is_abstract (sn) then
                    error (<<"An abstract valuetype may only inherit ",
                             "from another abstract valuetype">>)
                end
            end
            value.add_parent (sn)
        end
----------------------

    check_previous_declaration (nm : STRING) is

        do
            if not symbol_table.type_is_visible (nm) then
               if symbol_table.name_is_known_insensitive (nm) and then
                  not symbol_table.real_name_match (nm)           then
                   error (<<"The name ", nm, " is misspelled; %
                            %previous spelling : ",
                            symbol_table.previous_spelling (nm)>>)
                else
                    error (<<"The name ", nm, " has not yet been declared">>)
                end
            end
        end

end -- class VALUE_PARSER

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

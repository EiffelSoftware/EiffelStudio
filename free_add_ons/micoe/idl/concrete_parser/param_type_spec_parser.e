indexing

description: "Parses production for <param_type_spec>(95[2.3])";
keywords: "param_type_spec";
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"

class PARAM_TYPE_SPEC_PARSER

inherit
    EXTENDED_SYNTAX_PARSER
        redefine
            parse, value
        end

feature

    value : PARAM_TYPE_SPEC

    parse (scan : SCANNER) is

        local
            tok      : INTEGER
            btsp     : BASE_TYPE_SPEC_PARSER
            stp      : STRING_TYPE_PARSER
            fptp     : FIXED_PT_TYPE_PARSER
            wstp     : WIDE_STRING_TYPE_PARSER
            snp      : SCOPED_NAME_PARSER
            simple   : STRING

        do
            inspect scan.token

            when String_token then
                create stp
                stp.parse (scan)
                value := stp.value

            when Doublecolon, Identifier, Object_token then
                -- `Object_token' added to handle PIDL ...
                create snp
                snp.parse (scan)
                simple := snp.value.last_name_component
                if symbol_table.type_is_visible (simple) then
                    value := symbol_table.simple_name_to_full_type (simple)
                elseif not symbol_table.fulltype_is_visible (snp.value) then
                    error (<<"A type ", snp.value.to_string,
                             " is not visible from scope ",
                             symbol_table.current_scope.to_string>>)
                else
                    value := snp.value
                end

            when Fixed_token then
                create fptp
                fptp.parse (scan)
                value := fptp.value

            when Wstring_token then
                create wstp
                wstp.parse (scan)
                value := wstp.value

            else -- it had better be a base_type_spec
                create btsp
                btsp.parse (scan)
                value := btsp.value
            end
        end

end -- class PARAM_TYPE_SPEC_PARSER

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

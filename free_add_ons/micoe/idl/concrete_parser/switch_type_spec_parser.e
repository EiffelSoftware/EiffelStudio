indexing

description: "Parses production for <switch_type_spec>(73[2.3])";
keywords: "switch_type_spec";
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"

class SWITCH_TYPE_SPEC_PARSER

inherit
    EXTENDED_SYNTAX_PARSER
        redefine
            parse, value
        end

feature

    value : SWITCH_TYPE_SPEC

    parse (scan : SCANNER) is

        local
            long     : BOOLEAN
            unsigned : BOOLEAN
            snp      : SCOPED_NAME_PARSER
            it       : INTEGER_TYPE
            etp      : ENUM_TYPE_PARSER
            simp     : STRING
            sn       : SCOPED_NAME

        do
            if scan.token = Unsigned_token then
                unsigned := true
                scan.advance -- Eat the "unsigned"
            end

            if scan.token = Long_token then
                long := true

                if scan.look_ahead /= Long_token then
                    create it
                    it.set_longlong (false)
                    it.set_unsigned (unsigned)
                    value := it
                end
                scan.advance -- Eat the "long"
            end

            if value = void then
                inspect scan.token

                when Boolean_token then
                    create {BOOLEAN_TYPE} value
                    scan.advance -- Eat the "boolean"

                when Char_token then
                    create {CHAR_TYPE} value
                    scan.advance -- Eat the "char"
         
                when Long_token then
                    create it
                    it.set_longlong (long)
                    it.set_unsigned (unsigned)
                    value := it
                    scan.advance -- Eat the "long"

                when Short_token then
                    create it
                    it.set_short
                    it.set_unsigned (unsigned)
                    value := it
                    scan.advance -- Eat the "short"

                when Enum_token then
                    create etp
                    etp.parse (scan)
                    value := etp.value

                else -- it had better be a scoped name
                    create snp
                    snp.parse (scan)
                    sn   := snp.value
                    simp := sn.last_name_component
                    if symbol_table.type_is_visible (simp) then
                        value := symbol_table.simple_name_to_full_type (simp)
                    elseif symbol_table.fulltype_is_visible (sn) then
                        value := sn
                    else
                        error (<<"A type ", sn.to_string,
                                 " is not visible from scope ",
                                 symbol_table.current_scope.to_string>>)
                    end
                end
            end
        end

end -- class SWITCH_TYPE_SPEC_PARSER

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

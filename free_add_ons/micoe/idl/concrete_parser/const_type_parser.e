indexing

description: "Parses production for <const_type>(28[2.3])";
keywords: "const_type";
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"

class CONST_TYPE_PARSER

inherit
    EXTENDED_SYNTAX_PARSER
        redefine
            parse, value
        end

feature

    value : CONST_TYPE

    parse (scan : SCANNER) is

        local
            long     : BOOLEAN
            unsigned : BOOLEAN
            snp      : SCOPED_NAME_PARSER
            it       : INTEGER_TYPE
            fpt      : FLOATING_PT_TYPE
            stp      : STRING_TYPE_PARSER
            sn       : SCOPED_NAME
            simp     : STRING

        do
            if scan.token = Unsigned_token then
                unsigned := true
                scan.advance -- Eat the "unsigned"
            end

            if scan.token = Long_token then
                long := true
                scan.advance -- Eat the "long"

                if scan.token = Long_token then
                    create it
                    it.set_longlong (true)
                    it.set_unsigned (unsigned)
                    value := it
                    scan.advance -- Eat the "long"
                elseif scan.token = Double_token then
                    create fpt
                    fpt.set_double
                    fpt.set_long (true)
                    value := fpt
                    scan.advance -- Eat the "double"
                else
                    create it
                    it.set_longlong (false)
                    it.set_unsigned (unsigned)
                    value := it
                end
            end

            if value = void then
                inspect scan.token

                when Boolean_token then
                    create {BOOLEAN_TYPE} value
                    scan.advance -- Eat the "boolean"

                when Char_token then
                    create {CHAR_TYPE} value
                    scan.advance -- Eat the "char"
         
                when Double_token then
                    create fpt
                    fpt.set_double
                    fpt.set_long (long)
                    value := fpt
                    scan.advance -- Eat the "double"

                when Float_token then
                    create {FLOATING_PT_TYPE} value
                    scan.advance -- Eat the "float"
                    
                when Fixed_token then
                    create {FIXED_PT_TYPE} value
                    scan.advance -- Eat the "fixed"

                when Short_token then
                    create it
                    it.set_short
                    it.set_unsigned (unsigned)
                    value := it
                    scan.advance -- Eat the "short"

                when String_token then
                    create stp
                    stp.parse (scan)
                    value := stp.value

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

end -- class CONST_TYPE_PARSER

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

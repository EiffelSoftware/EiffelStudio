indexing

description: "Parses production for <base_type_spec>(46[2.3])";
keywords: "base_type_spec";
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"

class BASE_TYPE_SPEC_PARSER

inherit
    CONCRETE_SYNTAX_PARSER
        redefine
            parse, value
        end

feature

    value : BASE_TYPE_SPEC

    parse (scan : SCANNER) is

        local
            tok      : INTEGER
            long     : BOOLEAN
            unsigned : BOOLEAN
            it       : INTEGER_TYPE
            fpt      : FLOATING_PT_TYPE

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

                when Any_token then
                    create {ANY_TYPE} value
                    scan.advance -- Eat the "any"

                when Boolean_token then
                    create {BOOLEAN_TYPE} value
                    scan.advance -- Eat the "boolean"

                when Char_token then
                    create {CHAR_TYPE} value
                    scan.advance -- Eat the "char"

                when Wchar_token then
                    create {WIDE_CHAR_TYPE} value
                    scan.advance -- Eat the "wchar"
         
                when Double_token then
                    create fpt
                    fpt.set_double
                    fpt.set_long (long)
                    value := fpt
                    scan.advance -- Eat the "double"

                when Float_token then
                    create {FLOATING_PT_TYPE} value
                    scan.advance -- Eat the "float"
                    
                when Long_token then
                    create it
                    it.set_longlong (long)
                    it.set_unsigned (unsigned)
                    value := it
                    scan.advance -- Eat the "long"

                when Octet_token then
                    create {OCTET_TYPE} value
                    scan.advance -- Eat the "octet"

                when Short_token then
                    create it
                    it.set_short
                    it.set_unsigned (unsigned)
                    value := it
                    scan.advance -- Eat the "short"

                else
                    error (<<"Invalid type">>)
                end
            end
        end

end -- class BASE_TYPE_SPEC_PARSER

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

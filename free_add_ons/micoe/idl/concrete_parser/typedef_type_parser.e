indexing

description: "Parses typedefs(s. 42[2.3])";
keywords: "typedef";
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"
class TYPEDEF_TYPE_PARSER

inherit
    EXTENDED_SYNTAX_PARSER
        redefine
            parse, value
        end

feature

    value : TYPEDEF_TYPE

    parse (scan : SCANNER) is

        local
            dp  : DECLARATOR_PARSER
            sd  : SIMPLE_DECLARATOR
            tsp : TYPE_SPEC_PARSER
            tok : INTEGER
            str : STRING
            sn  : SCOPED_NAME
            st  : SEQUENCE_TYPE

        do
            scan.advance -- Eat the "typedef"

            create value.make
            create tsp
            tsp.parse (scan)
            value.set_type_spec (tsp.value)

            tok := scan.token
            if tok /= Doublecolon and then tok /= Identifier then
                error (<<"Expecting an identifier">>)
            end

            from
                create dp
                dp.parse (scan)
                value.add_component (dp.value)
                sd ?= dp.value
                if sd /= void then
                    str := sd.identifier
                    create sn.make
                    sn.add_name_component (str)
                else
                    sn  := dp.value.name
                    str := sn.last_name_component
                end
                if symbol_table.fulltype_is_visible (sn) then
                    error (<<"The typedef name ", str,
                             " conflicts wth another name in the same scope">>)
                else
                    sn := symbol_table.register_type (str)
                    st ?= value.type_spec
                    if st /= void then
                        st.set_name (sn)
                    end
                    dp.value.set_name (sn)
                end

                tok := scan.token
            until
                tok /= Comma
            loop
                scan.advance -- Eat the ','
                dp.parse (scan)
                value.add_component (dp.value)
                sd ?= dp.value
                if sd /= void then
                    str := sd.identifier
                else
                    str := dp.value.name.last_name_component
                end
                if symbol_table.type_is_visible (str) then
                    error (<<"The typedef name ", str,
                             " conflicts wth another name in the same scope">>)
                else
                    sn := symbol_table.register_type (str)
                    st ?= value.type_spec
                    if st /= void then
                        st.set_name (sn)
                    end
                    dp.value.set_name (sn)
                end
                tok := scan.token
            end
        end

end -- class TYPEDEF_TYPE_PARSER

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

indexing

description: "Parses production for <constr_type_spec>(48[2.3])";
keywords: "constr_type_spec";
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"

class CONSTR_TYPE_SPEC_PARSER

inherit
    CONCRETE_SYNTAX_PARSER
        redefine
            parse, value
        end

feature

    value : CONSTR_TYPE_SPEC

    parse (scan : SCANNER) is

        local
            stp : STRUCT_TYPE_PARSER
            utp : UNION_TYPE_PARSER
            etp : ENUM_TYPE_PARSER

        do
            inspect scan.token

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

            end
        end

end -- class CONSTR_TYPE_SPEC_PARSER

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

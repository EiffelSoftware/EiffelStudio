indexing

description: "Parses production for <type_spec>(44[2.3])";
keywords: "type_spec";
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"

class TYPE_SPEC_PARSER

inherit
    CONCRETE_SYNTAX_PARSER
        redefine
            parse, value
        end

feature

    value : TYPE_SPEC

    parse (scan : SCANNER) is

        local
            stsp : SIMPLE_TYPE_SPEC_PARSER
            ctsp : CONSTR_TYPE_SPEC_PARSER

        do
            inspect scan.token

            when Struct_token, Union_token, Enum_token then
                create ctsp
                ctsp.parse (scan)
                value := ctsp.value

            else
                create stsp
                stsp.parse (scan)
                value := stsp.value

            end                
        end

end -- class TYPE_SPEC_PARSER

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

indexing

description: "Parses production for <element_spec>(77[2.3])";
keywords: "element_spec";
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"

class ELEMENT_SPEC_PARSER

inherit
    CONCRETE_SYNTAX_PARSER
        redefine
            parse, value
        end

feature

    value : ELEMENT_SPEC

    parse (scan : SCANNER) is

        local
            tsp : TYPE_SPEC_PARSER
            dcp : DECLARATOR_PARSER

        do
            create value
            create tsp
            tsp.parse (scan)
            value.set_type_spec (tsp.value)
            create dcp
            dcp.parse (scan)
            value.set_declarator (dcp.value)
        end

end -- class ELEMENT_SPEC_PARSER

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

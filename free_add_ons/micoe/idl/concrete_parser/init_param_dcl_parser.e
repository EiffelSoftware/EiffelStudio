indexing

description: "Parses production for <init_param_dcl>(25[2.3])";
keywords: "interface";
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"

class INIT_PARAM_DCL_PARSER

inherit
    EXTENDED_SYNTAX_PARSER
        redefine
            parse, value
        end

feature

    value : INIT_PARAM_DCL

    parse (scan : SCANNER) is

        local
            ptsp : PARAM_TYPE_SPEC_PARSER
            dp   : DECLARATOR_PARSER
            sd   : SIMPLE_DECLARATOR

        do
            if scan.token /= In_token then
                error (<<"Expecting %"in%"">>)
            else
                scan.advance -- Eat the "in"
            end

            create value

            create ptsp
            ptsp.parse (scan)
            value.set_param_type_spec (ptsp.value)

            if scan.token /= Identifier  or else
               scan.look_ahead = Left_brack then
                error (<<"Expecting a simple declarator">>)
            end
            create dp
            dp.parse (scan)
            sd ?= dp.value
            value.set_simple_declarator (sd)
        end

end -- class INIT_PARAM_DCL_PARSER

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

indexing

description: "Parses production for <template_type_spec>(47[2.3])";
keywords: "template_type_spec";
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"

class TEMPLATE_TYPE_SPEC_PARSER

inherit
    CONCRETE_SYNTAX_PARSER
        redefine
            parse, value
        end

feature

    value : TEMPLATE_TYPE_SPEC

    parse (scan : SCANNER) is

        local
            setp : SEQUENCE_TYPE_PARSER
            fptp : FIXED_PT_TYPE_PARSER
            stp  : STRING_TYPE_PARSER
            wstp : WIDE_STRING_TYPE_PARSER

        do
            inspect scan.token

            when Sequence_token then
                create setp
                setp.parse (scan)
                value := setp.value

            when String_token then
                create stp
                stp.parse (scan)
                value := stp.value

            when Wstring_token then
                create wstp
                wstp.parse (scan)
                value := wstp.value

            when Fixed_token then
                create fptp
                fptp.parse (scan)
                value := fptp.value

            else
                error (<<"Expecting %"sequence%" or %"string%"">>)
            end
        end

end -- class TEMPLATE_TYPE_SPEC_PARSER

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

indexing

description: "Parses production for <sequence_type>(80[2.3])";
keywords: "sequence_type";
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"

class SEQUENCE_TYPE_PARSER

inherit
    EXTENDED_SYNTAX_PARSER
        redefine
            parse, value
        end

feature

    value : SEQUENCE_TYPE

    parse (scan : SCANNER) is

        local
            stsp : SIMPLE_TYPE_SPEC_PARSER

        do
            create value

            scan.advance -- Eat the "sequence"

            if scan.token /= Left_angle then
                error (<<"Expecting '<'">>)
            else
                scan.advance -- Eat the '<'
            end

            create stsp
            stsp.parse (scan)
            value.set_simple_type_spec (stsp.value)

            if scan.token = Comma then
                scan.advance -- Eat the ','

                if scan.token /= Integer_literal then
                    error (<<"Expecting a positive integer constant">>)
                elseif scan.integer_value <= 0 then
                    error (<<"A sequence length must be positive">>)
                else
                    value.set_length (scan.integer_value)
                    scan.advance -- Eat the constant
                end
            else
                value.set_unbounded
            end

            if scan.token /= Right_angle then
                if value.length /= 0 then
                    error (<<"Expecting '>'">>)
                else
                    error (<<"Expecting ',' or '>'">>)
                end
            else
                scan.advance -- Eat the '>'
            end            
        end

end -- class SEQUENCE_TYPE_PARSER

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

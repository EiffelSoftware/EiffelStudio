indexing

description: "Parses production for <attr_dcl>(85[2.3])";
keywords: "attr_dcl";
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"

class ATTR_DCL_PARSER

inherit
    EXTENDED_SYNTAX_PARSER
        redefine
            parse, value
        end

feature

    value : ATTR_DCL

    parse (scan : SCANNER) is

        local
            ptsp : PARAM_TYPE_SPEC_PARSER
            sd   : SIMPLE_DECLARATOR
            tok  : INTEGER

        do
            if scan.token = Readonly_token then
                create value.make (true)
                scan.advance -- Eat the "readonly"
            else
                create value.make (false)
            end

            if scan.token /= Attribute_token then
                error (<<"Expecting %"attribute%"">>)
            else
                scan.advance -- Eat the "attribute"
            end

            create ptsp
            ptsp.parse (scan)
            value.set_param_type_spec (ptsp.value)
            from
                if scan.token /= Identifier then
                    error (<<"Expecting an identifier">>)
                else
                    create sd.make (scan.lexeme, void)
                    scan.advance -- Eat the identifier
                    value.add_component (sd)
                end
                tok := scan.token
            until
                tok /= Comma
            loop
                scan.advance -- Eat the ','
                if scan.token /= Identifier then
                    error (<<"Expecting an identifier">>)
                else
                    create sd.make (scan.lexeme, void)
                    scan.advance -- Eat the identifier
                    value.add_component (sd)
                end                
                tok := scan.token
            end
        end

end -- class ATTR_DCL_PARSER

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

indexing

description: "Parses production for <declarator>(50[2.3])";
keywords: "declarator";
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"

class DECLARATOR_PARSER

inherit
    EXTENDED_SYNTAX_PARSER
        redefine
            parse, value
        end

feature

    value : IDL_DECLARATOR

    parse (scan : SCANNER) is

        local
            tok : INTEGER
            ad  : ARRAY_DECLARATOR

        do
            if scan.look_ahead /= Left_brack then
                create {SIMPLE_DECLARATOR} value.make (scan.lexeme, void)
                scan.advance -- Eat the identifier
            else -- <array_declarator>
                create ad. make (build_scoped_name (scan.lexeme))
                scan.advance -- Eat the identifier
                from
                    tok := scan.token
                until
                    tok /= Left_brack
                loop
                    scan.advance -- Eat the '['
                    if scan.token /= Integer_literal then
                        error (<<"Expecting an integer constant">>)
                    else
                        ad.add_size (scan.integer_value)
                        scan.advance -- Eat the constant
                    end
                    if scan.token /= Right_brack then
                        error (<<"Expecting a ']'">>)
                    else
                        scan.advance -- Eat the ']'
                    end
                    tok := scan.token
                end
                value := ad
            end
        end

end -- class DECLARATOR_PARSER

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

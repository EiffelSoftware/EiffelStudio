indexing

description: "Parses production for <op_dcl>(87[2.3])";
keywords: "op_dcl";
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"

class OP_DCL_PARSER

inherit
    CONCRETE_SYNTAX_PARSER
        redefine
            parse, value
        end

feature

    value : OP_DCL

    parse (scan : SCANNER) is

        local
            otsp : OP_TYPE_SPEC_PARSER
            tok  : INTEGER
            pdp  : PARAM_DCL_PARSER
            rep  : RAISES_EXPR_PARSER
            cep  : CONTEXT_EXPR_PARSER

        do
            create value.make
            if scan.token = Oneway_token then
                value.set_oneway
                scan.advance -- Eat the "oneway"
            end

            create otsp
            otsp.parse (scan)
            value.set_op_type_spec (otsp.value)

            if scan.token /= Identifier then
                error (<<"Expecting an identifier">>)
            else
                value.set_name (scan.lexeme)
                scan.advance -- Eat the identifier
            end

            if scan.token /= Left_paren then
                error (<<"Expecting '('">>)
            else
                scan.advance -- Eat the '('
            end

            if scan.token /= Right_paren then
                 -- The operation might have no parameters
                from
                    create pdp
                    pdp.parse (scan)
                    value.add_component (pdp.value)
                    tok := scan.token
                until
                    tok /= Comma
                loop
                    scan.advance -- Eat the ','
                    pdp.parse (scan)
                    value.add_component (pdp.value)
                    tok := scan.token
                end
            end

            if scan.token /= Right_paren then
                error (<<"Expecting ')'">>)
            else
                scan.advance -- Eat the ')'
            end

            if scan.token = Raises_token then
                if value.oneway then
                    error (<<"Oneway operations can't have a raises clause">>)
                else
                    create rep
                    rep.parse (scan)
                    value.set_raises_expr (rep.value)
                end
            end

            if scan.token = Context_token then
                create cep
                cep.parse (scan)
                value.set_context_expr (cep.value)
            end
        end

end -- class OP_DCL_PARSER

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

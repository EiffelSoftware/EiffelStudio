indexing

description: "Parses production for <case_label>(76[2.3])";
keywords: "case_label";
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"

class CASE_LABEL_PARSER

inherit
    CONCRETE_SYNTAX_PARSER
        redefine
            parse, value
        end

feature

    value : CASE_LABEL

    parse (scan : SCANNER) is

        local
            cep : CONST_EXP_PARSER

        do
            create value

            if scan.token /= Case_token and then
               scan.token /= Default_token then
                error (<<"Expecting %"case%" or %"default%"">>)
            else
                if scan.token = Default_token then
                    value.set_to_default
                end

                scan.advance -- Eat the "case" or "default"
            end

            if not value.is_default then
                if scan.token = Colon then
                    error (<<"Unexpected ':'">>)
                else
                    create cep
                    cep.parse (scan)
                    value.set_const_exp (cep.value)
                end
            end

            if scan.token /= Colon then
                error (<<"Expecting ':'">>)
            else
                scan.advance -- Eat the ':'
            end
        end

end -- class CASE_LABEL_PARSER

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

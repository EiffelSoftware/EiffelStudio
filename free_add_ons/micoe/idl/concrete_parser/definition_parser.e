indexing

description: "Parses production for <definition>(2[2.3])";
keywords: "definition";
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"

class DEFINITION_PARSER

inherit
    EXTENDED_SYNTAX_PARSER
        redefine
            parse, value
        end

feature

    value   : DEFINITION
    its_new : BOOLEAN

    parse (scan : SCANNER) is

        local
            tdp : TYPE_DCL_PARSER
            cdp : CONST_DCL_PARSER
            edp : EXCEPT_DCL_PARSER
            ip  : INTERFACE_PARSER
            vp  : VALUE_PARSER
            mp  : MODULE_PARSER

        do
            its_new := true
            inspect scan.token

            when Module_token then
                create mp
                mp.parse (scan)
                value  := mp.value
                its_new := mp.its_new

            when Abstract_token then
                scan.advance -- Eat the "abstract"
                if scan.token = Interface_token then
                    create ip
                    ip.set_abstract
                    ip.parse (scan)
                    value := ip.value
                elseif scan.token = Custom_token then
                    scan.advance -- Eat the "custom"
                    if scan.token = Valuetype_token then
                        create vp
                        vp.set_abstract
                        vp.parse (scan)
                        vp.value.set_custom
                        value := vp.value
                    else
                        error (<<"Expecting %"valuetype%"">>)
                    end
                elseif scan.token = Valuetype_token then
                    create vp
                    vp.set_abstract
                    vp.parse (scan)
                    value := vp.value
                else
                    error (<<"Expecting %"interface%" ",
                             "or %"valuetype%"">>) 
                end

            when Custom_token then
                if scan.token = Valuetype_token then
                    create vp
                    vp.parse (scan)
                    vp.value.set_custom
                    value := vp.value
                else
                    error (<<"Expecting %"valuetype%"">>)
                end

            when Interface_token then
                create ip
                ip.parse (scan)
                value   := ip.value

            when Valuetype_token then
                create vp
                vp.parse (scan)
                value := vp.value

            when Exception_token then
                create edp
                edp.parse (scan)
                value   := edp.value

            when Typedef_token, Struct_token,
                 Union_token, Enum_token, Native_token then
                create tdp
                tdp.parse (scan)
                value   := tdp.value

            when Const_token then
                create cdp
                cdp.parse (scan)
                value := cdp.value

            when Attribute_token then
                 error (<<"Attributes are not allowed outside an interface">>)

            else -- it's probably an <op_dcl> outside an interface
                error (<<"Invalid definition; possibly an operation %
                         %outside an interface">>)
            end

            if scan.token /= Semicolon then
                error (<<"Expecting ';'">>)
            else
                scan.advance -- Eat the ';'
            end
        end

end -- class DEFINITION_PARSER

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

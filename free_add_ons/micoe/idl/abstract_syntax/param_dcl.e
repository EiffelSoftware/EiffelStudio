indexing

description: "Represents nonterminal <param_dcl>(91[2.3])";
keywords: "param_dcl";
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"

class PARAM_DCL

inherit
    IDL_SYNTAX_ELEMENT
        redefine
            accept
        end

feature { CONCRETE_SYNTAX_PARSER, SEMANTIC_VISITOR }

    param_attribute : STRING
    param_type_spec : PARAM_TYPE_SPEC
    declarator      : STRING

    set_param_attribute (attr : STRING) is

        do
            param_attribute := attr
        end
----------------------------------------------------

    set_param_type_spec (spec : PARAM_TYPE_SPEC) is

        do
            param_type_spec := spec
        end
----------------------------------------------------

    set_declarator (decl : STRING) is

        do
            declarator := decl
        end
----------------------------------------------------
feature { SEMANTIC_VISITOR }

    accept (v : SEMANTIC_VISITOR) is

        do
            v.visit_param_dcl (current)
        end

end -- class PARAM_DCL

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

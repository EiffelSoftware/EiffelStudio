indexing

description: "Represents nonterminal <attr_dcl>(85[2.3])";
keywords: "attr_dcl";
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"

class ATTR_DCL

inherit
    INTERFACE_EXPORT;
    COMPOSITE_SYNTAX_ELEMENT
        rename
            make as comp_make
        redefine
            anchor
        end

creation { CONCRETE_SYNTAX_PARSER }
    make

feature { CONCRETE_SYNTAX_PARSER, SEMANTIC_VISITOR }

    is_readonly     : BOOLEAN
    param_type_spec : PARAM_TYPE_SPEC

    make (readonly : BOOLEAN) is

        do
            is_readonly := readonly
            comp_make
        end
---------------------------------------------------

    set_param_type_spec (spec : PARAM_TYPE_SPEC) is

        do
            param_type_spec := spec
        end
---------------------------------------------------
feature { SEMANTIC_VISITOR }

    accept (v : SEMANTIC_VISITOR) is

        do
            v.visit_attr_dcl (current)
        end
---------------------------------------------------
feature { NONE }

    anchor : SIMPLE_DECLARATOR

end -- class ATTR_DCL

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

indexing

description: "Represents nonterminal <init_param_dcl>(25[2.3])";
keywords: "interface";
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"

class INIT_PARAM_DCL

inherit
    ABSTRACT_SYNTAX_ELEMENT

feature

    factory : BOOLEAN
        -- Is `current' a factory?
    param_type_spec   : PARAM_TYPE_SPEC
    simple_declarator : SIMPLE_DECLARATOR
----------------------
feature { CONCRETE_SYNTAX_PARSER }

    set_factory is

        do
            factory := true
        end
----------------------

    set_param_type_spec (val : PARAM_TYPE_SPEC) is

        do
            param_type_spec := val
        end
----------------------

    set_simple_declarator (val : SIMPLE_DECLARATOR) is

        do
            simple_declarator := val
        end
----------------------
feature { SEMANTIC_VISITOR }

    name : SCOPED_NAME

    accept (v : SEMANTIC_VISITOR) is

        do
            v.visit_init_param_dcl (current)
        end

end -- class INIT_PARAM_DCL

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

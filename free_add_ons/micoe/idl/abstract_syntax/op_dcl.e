indexing

description: "Represents nonterminal <op_dcl>(87[2.3])";
keywords: "op_dcl";
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"

class OP_DCL

inherit
    INTERFACE_EXPORT;
    COMPOSITE_SYNTAX_ELEMENT
        redefine
            anchor
        end

creation
    make

feature {SEMANTIC_VISITOR }

    op_type_spec : OP_TYPE_SPEC
    name         : STRING
    raises_expr  : RAISES_EXPR
    context_expr : CONTEXT_EXPR
----------------------

    accept (v : SEMANTIC_VISITOR) is

        do
            v.visit_op_dcl (current)
        end
----------------------
feature { CONCRETE_SYNTAX_PARSER, SEMANTIC_VISITOR }
    -- NOTE: The mutator routines are exported to
    -- SEMANTIC_VISITOR because the code generation
    -- visitors handicraft OP_DCLs for attribute mutators
    -- for each (writable) attribute of an interface.

    oneway : BOOLEAN
        -- Has to be exported to OP_DCL_PARSER, because
        -- raises expressions are not permitted for oneway
        -- operations
----------------------

    set_oneway is

        do
            oneway := true
        end
--------------------------------------------

    set_op_type_spec (spec : OP_TYPE_SPEC) is

        do
            op_type_spec := spec
        end
--------------------------------------------

    set_name (nm : STRING) is

        do
            name := nm
        end
--------------------------------------------

    set_raises_expr (exp : RAISES_EXPR) is

        do
            raises_expr := exp
        end
--------------------------------------------

    set_context_expr (exp : CONTEXT_EXPR) is

        do
            context_expr := exp
        end
--------------------------------------------
feature { NONE }

    anchor : PARAM_DCL

end -- class OP_DCL

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

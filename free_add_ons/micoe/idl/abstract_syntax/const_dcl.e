indexing

description: "Represents nonterminal <const_dcl>(27[2.3])";
keywords: "const_dcl";
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"

class CONST_DCL

inherit
    DEFINITION;
    INTERFACE_EXPORT

feature { CONCRETE_SYNTAX_PARSER, SEMANTIC_VISITOR }

    name       : SCOPED_NAME
    type       : CHARACTER
        -- 'b', 'c' 'i', 'r', 's' or 'x'; set by
        -- TYPE_COMPUTING_VISITOR and needed by
        -- TYPECODE_VISITOR
    const_type : CONST_TYPE
    const_exp  : CONST_EXP

    set_const_type (ct : CONST_TYPE) is

        do
            const_type := ct
        end
----------------------

    set_name (n : SCOPED_NAME) is

        do
            name := n
        end
----------------------

    set_type (t : CHARACTER) is

        do
            type := t
        end
----------------------

    set_const_exp (exp : CONST_EXP) is

        do
            const_exp := exp
        end
----------------------
feature { SEMANTIC_VISITOR }

    accept (v : SEMANTIC_VISITOR) is

        do
            v.visit_const_dcl (current)
        end

end -- class CONST_DCL

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

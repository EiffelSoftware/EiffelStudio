indexing

description: "Represents nonterminal <context_expr>(94[2.3])";
keywords: "context_expr";
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"

class CONTEXT_EXPR

inherit
    COMPOSITE_SYNTAX_ELEMENT
        redefine
            accept, anchor
        end

creation { CONCRETE_SYNTAX_PARSER }
    make

feature { SEMANTIC_VISITOR }

    accept (v : SEMANTIC_VISITOR) is

        do
            v.visit_context_expr (current)
        end
----------------------------------------------------
feature { NONE }

    anchor : STRING_LITERAL

end -- class CONTEXT_EXPR

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

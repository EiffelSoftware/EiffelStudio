indexing

description: "Represents nonterminal <state_member>(22[2.3])";
keywords: "interface";
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"

class STATE_MEMBER

inherit
    VALUE_ELEMENT;
    COMPOSITE_SYNTAX_ELEMENT
        redefine
            anchor
        end

creation { STATE_MEMBER_PARSER }
    make

feature

    public : BOOLEAN
        -- Is this a public member?
    type_spec : TYPE_SPEC
----------------------
feature { CONCRETE_SYNTAX_PARSER }

    set_public (val : BOOLEAN) is

        do
            public := val
        end
----------------------

    set_type_spec (val : TYPE_SPEC) is

        do
            type_spec := val
        end
----------------------
feature { SEMANTIC_VISITOR }

    accept (v : SEMANTIC_VISITOR) is

        do
            v.visit_state_member (current)
        end
----------------------
feature { NONE }

    anchor  : IDL_DECLARATOR

end -- class STATE_MEMBER

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

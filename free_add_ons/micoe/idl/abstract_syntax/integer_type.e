indexing

description: "Represents nonterminal <integer_type>(54[2.3])";
keywords: "integer_type";
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"

class INTEGER_TYPE

inherit
    CONST_TYPE;
    BASE_TYPE_SPEC;
    SWITCH_TYPE_SPEC;

feature { CONCRETE_SYNTAX_PARSER, SEMANTIC_VISITOR }

    short    : BOOLEAN
    longlong : BOOLEAN
    unsigned : BOOLEAN

    set_longlong (ll : BOOLEAN) is

        do
            longlong := ll
        end
------------------------------------------------------

   set_unsigned (u : BOOLEAN) is

        do
            unsigned := u
        end
------------------------------------------------------

    set_short is

        do
            short := true
        end
------------------------------------------------------
feature { SEMANTIC_VISITOR }

    accept (v : SEMANTIC_VISITOR) is

        do
            v.visit_integer_type (current)
        end

end -- class INTEGER_TYPE

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

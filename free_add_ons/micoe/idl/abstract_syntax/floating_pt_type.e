indexing

description: "Represents nonterminal <floating_pt_type>(53[2.3])";
keywords: "floating_pt_type";
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"

class FLOATING_PT_TYPE

inherit
    BASE_TYPE_SPEC;
    CONST_TYPE

feature { CONCRETE_SYNTAX_PARSER, SEMANTIC_VISITOR }

    is_double : BOOLEAN
    long      : BOOLEAN
    unsigned  : BOOLEAN
        -- not really needed; but it makes
        -- our life somewhat simpler.

    set_double is

        do
            is_double := true
        end 
------------------------------------------------

    set_long (l : BOOLEAN) is

        do
            long := l
        end
------------------------------------------------

    set_unsigned (u : BOOLEAN) is

        do
            unsigned := u
        end
------------------------------------------------
feature { SEMANTIC_VISITOR }

    accept (v : SEMANTIC_VISITOR) is

        do
            v.visit_floating_pt_type (current)
        end

end -- class FLOATING_PT_TYPE

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

indexing

description: "Represents nonterminal <sequence_type>(80[2.3])";
keywords: "sequence_type";
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"

class SEQUENCE_TYPE

inherit
    TEMPLATE_TYPE_SPEC
        redefine
            is_equal
        end

feature

    is_equal (other : like current) : BOOLEAN is

        do
            result := (length = other.length and then
                       (simple_type_spec.same_type (other.simple_type_spec)
                        and then
                        equal (simple_type_spec, other.simple_type_spec)))
        end

feature { CONCRETE_SYNTAX_PARSER, SEMANTIC_VISITOR, SEQUENCE_TYPE }

    name             : SCOPED_NAME
    simple_type_spec : SIMPLE_TYPE_SPEC
    length           : INTEGER
    unbounded        : BOOLEAN

    set_name (sn : SCOPED_NAME) is

        do
            name := sn
        end
---------------------------------------------------------

    set_simple_type_spec (spec : SIMPLE_TYPE_SPEC) is

        do
            simple_type_spec := spec
        end
---------------------------------------------------------

    set_length (l : INTEGER) is

        do
            length := l
        end
---------------------------------------------------------

    set_unbounded is

        do
            unbounded := true
        end
---------------------------------------------------------
feature { SEMANTIC_VISITOR }

    accept (v : SEMANTIC_VISITOR) is

        do
            v.visit_sequence_type (current)
        end

end -- class SEQUENCE_TYPE

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

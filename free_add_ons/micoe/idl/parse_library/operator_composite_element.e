indexing

description: "Still to be entered";
keywords: "Parsing framework";
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"

deferred class OPERATOR_COMPOSITE_ELEMENT

inherit
    ABSTRACT_SYNTAX_ELEMENT

feature { CONCRETE_SYNTAX_PARSER, SEMANTIC_VISITOR }

    make is

        do
            create components.make (false)
            create operators.make (false)
        end
------------------------------------------------------

    add_operator (op : ABSTRACT_SYNTAX_ELEMENT) is

        do
            operators.append (op)
        end
------------------------------------------------------

    add_component (elemnt : like anchor) is

        do
            components.append (elemnt)
        end
------------------------------------------------------
feature

    valid_index (index : INTEGER) : BOOLEAN is

        do
            result := (1 <= index and
                       index <= component_count)
        end
------------------------------------------------------

    component_count : INTEGER is

        do
            result := components.count
        end
------------------------------------------------------

    operator_at (index : INTEGER) : ABSTRACT_SYNTAX_ELEMENT is

        require
            valid_index : 1 <= index and
                          index <= component_count

        do
            result := operators.at (index)
        end
------------------------------------------------------

    component_at (index : INTEGER) : like anchor is

        require
            valid_index : valid_index (index)

        do
            result := components.at (index)
        end
------------------------------------------------------
feature { COMPOSITE_SYNTAX_ELEMENT }

    anchor : ABSTRACT_SYNTAX_ELEMENT
    components : INDEXED_LIST [like anchor]
    operators  : INDEXED_LIST [ABSTRACT_SYNTAX_ELEMENT]

end -- class OPERATOR_COMPOSITE_ELEMENT

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

indexing

description: "Composite element in a parse tree";
keywords: "Parsing framework", "Composite Pattern";
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"

deferred class COMPOSITE_SYNTAX_ELEMENT

inherit
    ABSTRACT_SYNTAX_ELEMENT

feature { CONCRETE_SYNTAX_PARSER, SEMANTIC_VISITOR }

    make is

        do
            create components.make (false)
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

end -- class COMPOSITE_SYNTAX_ELEMENT

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

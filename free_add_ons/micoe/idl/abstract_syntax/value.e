indexing

description: "Represents nonterminal <value>(13[2.3])";
keywords: "interface";
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"

class VALUE

inherit
    DEFINITION;
    COMPOSITE_SYNTAX_ELEMENT
        rename
            make as comp_make
        redefine
            anchor
        end

creation { VALUE_PARSER }
    make

feature

    name : SCOPED_NAME
    abstract : BOOLEAN
        -- Is `current' an abstract value?
    custom : BOOLEAN
        -- Is `current' a custom value?
    forward_declaration : BOOLEAN
        -- Is `current' a forward declaration?
    box : BOOLEAN
        -- Is `current' a value box?
    truncatable : BOOLEAN
        -- Is this a truncatable parent?
    finished : INTEGER
        -- Visitor of this type is finished with this value.

    make (value_name : SCOPED_NAME) is

        do
            name := value_name
            create parents.make (false)
            comp_make
        end
----------------------
feature { CONCRETE_SYNTAX_PARSER }

    set_abstract is

        do
            abstract := true
        end
----------------------

    set_custom is

        do
            custom := true
        end
----------------------

    set_forward_declaration is

        do
            forward_declaration := true
        end
----------------------

    set_box is

        do
            box := true
        end
----------------------

    set_truncatable is

        do
            truncatable := true
        end
----------------------

    add_parent (sn : SCOPED_NAME) is

        do
            parents.append (sn)
        end
----------------------

    parent_count : INTEGER is

        do
            result := parents.count
        end
----------------------

    parent_at (index : INTEGER) : SCOPED_NAME is

        require
            valid_index : 1 <= index and then index <= parent_count

        do
            result := parents.at (index)
        end
----------------------

    already_has_parent (sn : SCOPED_NAME) : BOOLEAN is

        do
            parents.search (sn)
            result := parents.found
        end
----------------------
feature { SEMANTIC_VISITOR }

    accept (v : SEMANTIC_VISITOR) is

        do
            v.visit_value (current)
        end
----------------------

    finish (vtype : INTEGER) is

        do
            finished := vtype
        end
----------------------
feature { NONE }

    anchor  : VALUE_ELEMENT
    parents : INDEXED_LIST [SCOPED_NAME]

end -- class VALUE

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

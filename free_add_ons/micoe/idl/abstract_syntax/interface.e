indexing

description: "Represents nonterminal <interface>(4[2.3])";
keywords: "interface";
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"

class INTERFACE

inherit
    DEFINITION;
    COMPOSITE_SYNTAX_ELEMENT
        rename
            make as comp_make
        redefine
            anchor
        end

creation { INTERFACE_PARSER }
    make

feature

    name : SCOPED_NAME
    abstract : BOOLEAN
        -- Is this an abstract interface
    forward_declaration : BOOLEAN
        -- Is this a forward declaration?
    finished : INTEGER
        -- Visitor of this type is finished with this interface.

    make (interf_name : SCOPED_NAME) is

        do
            name := interf_name
            create parents.make (false)
            comp_make
        end
----------------------

    set_abstract is

        do
            abstract := true
        end
----------------------

    set_forward_declaration is

        do
            forward_declaration := true
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
            v.visit_interface (current)
        end
----------------------

    finish (vtype : INTEGER) is

        do
            finished := vtype
        end
----------------------
feature { NONE }

    anchor  : INTERFACE_EXPORT
    parents : INDEXED_LIST [SCOPED_NAME]

end -- class INTERFACE

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

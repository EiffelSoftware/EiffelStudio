indexing

description: "Nonterminal used to support typedefs(s. 42[2.3])";
keywords: "typedef";
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"

class TYPEDEF_TYPE

inherit
    COMPOSITE_SYNTAX_ELEMENT
        redefine
            anchor, make
        end;
    TYPE_DCL

creation { CONCRETE_SYNTAX_PARSER }
    make

feature -- Initialization

    make is

        do
            precursor
            create typecodes.make (false)
        end

feature { CONCRETE_SYNTAX_PARSER, SEMANTIC_VISITOR }

    type_spec : TYPE_SPEC
    aliased   : SCOPED_NAME
        -- Fully scoped name of type aliased by `current'

----------------------

    set_aliased (sn : like aliased) is

        do
            aliased := sn
        end
----------------------

    set_aliased_simple (simple : STRING) is
        -- Create aliased with only one name component `simple'.

        do
            create aliased.make
            aliased.add_name_component (simple)
        end
----------------------

    set_type_spec (spec : TYPE_SPEC) is

        do
            type_spec := spec
        end
----------------------

    typecode_at (idx : INTEGER) : CORBA_TYPECODE is

        require
            valid_index : 1 <= idx and then
                          idx <= component_count

        do
            result := typecodes.at (idx)
        end
----------------------

    add_typecode (tc : CORBA_TYPECODE) is

        do
            typecodes.append (tc)
            typecode := tc
                -- In the typical case this will
                -- be what we want.
        end
----------------------
feature { SEMANTIC_VISITOR }

    accept ( v : SEMANTIC_VISITOR) is


        do
            v.visit_typedef_type (current)
        end
----------------------
feature { NONE }

    anchor    : IDL_DECLARATOR
    typecodes : INDEXED_LIST [CORBA_TYPECODE]
        -- One for each component

end -- class TYPEDEF_TYPE

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

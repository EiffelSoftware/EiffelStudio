indexing

description: "Represents nonterminal <enum_type>(78[2.3])";
keywords: "enum_type";
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"

class ENUM_TYPE

inherit
    CONSTR_TYPE_SPEC;
    SWITCH_TYPE_SPEC
    TYPE_DCL

creation { CONCRETE_SYNTAX_PARSER }
    make

feature { CONCRETE_SYNTAX_PARSER, SEMANTIC_VISITOR }

    name : SCOPED_NAME

    make (nm : SCOPED_NAME) is

        do
            name := nm
            create enumerators.make (false)
        end
---------------------------------------------------

    add_enumerator (s : STRING) is

        do
             enumerators.append (s)
        end
---------------------------------------------------

    enumerator_count : INTEGER is

        do
            result := enumerators.count
        end
---------------------------------------------------

    enumerator_at (index : INTEGER) : STRING is

        require
            valid_index : 1 <= index and then index <= enumerator_count

        do
             result := enumerators.at (index)
        end
---------------------------------------------------
feature { SEMANTIC_VISITOR }

    accept ( v : SEMANTIC_VISITOR) is


        do
            v.visit_enum_type (current)
        end
---------------------------------------------------
feature { NONE }

    enumerators : INDEXED_LIST [STRING]

end -- class ENUM_TYPE

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

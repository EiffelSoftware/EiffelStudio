indexing

description: "Represents nonterminal <array_declarator>(83[2.3])";
keywords: "array_declarator";
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"

class ARRAY_DECLARATOR

inherit
    IDL_DECLARATOR
        redefine
            accept
        end

creation
    make

feature { CONCRETE_SYNTAX_PARSER, SEMANTIC_VISITOR }

    type_spec : TYPE_SPEC

    make (nm : SCOPED_NAME) is

        do
            name := nm
            create sizes.make (false)
        end
----------------------

    set_type_spec (ts : TYPE_SPEC) is

        do
            type_spec := ts
        end
----------------------

    add_size (size : INTEGER) is

        do
            sizes.append (size)
        end
----------------------

    size_count : INTEGER is

        do
            result := sizes.count
        end
----------------------

    size_at (index : INTEGER) : INTEGER is

        require
            valid_index : 1 <= index and then index <= size_count

        do
            result := sizes.at (index)
        end
----------------------
feature { SEMANTIC_VISITOR }

    accept (v : SEMANTIC_VISITOR) is

        do
            v.visit_array_declarator (current)
        end
----------------------
feature { NONE }

    sizes : INDEXED_LIST [INTEGER]

end -- class ARRAY_DECLARATOR

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

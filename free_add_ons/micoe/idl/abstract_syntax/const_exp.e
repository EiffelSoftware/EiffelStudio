indexing

description: "Represents nonterminal <const_exp>(29[2.3])";
keywords: "const_exp";
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"

class CONST_EXP

inherit
    COMPOSITE_SYNTAX_ELEMENT
        rename
            make as comp_make
        redefine
            anchor, accept, add_component, component_at,
            component_count
        end

creation { CONCRETE_SYNTAX_PARSER }
    make

feature

    size : INTEGER
        -- 16 for short
        -- 32 for long
        -- 64 for long long
        -- 32 for float
        -- 64 for double
----------------------

    set_size (sz : INTEGER) is

        do
            size := sz
        end
----------------------
feature { CONCRETE_SYNTAX_PARSER }

    make is

        do
            create operators.make (false)
            -- components is created as needed.
        end
-------------------------------------------

    add_component (elmnt : like anchor) is

        do
            if components = void and then anchor /= void then
                create components.make (false)
                components.append (anchor)
                components.append (elmnt)
                anchor := void
            else
                anchor := elmnt
            end
        end
-------------------------------------------

    add_operator (op : CHARACTER) is

        do
            operators.append (op)
        end
-------------------------------------------
feature { ANY }

    operator_at (index : INTEGER) : CHARACTER is

        require
            valid_index : 1 <= index and then
                          index <= operator_count

        do
            result := operators.at (index)
        end
-------------------------------------------

    operator_count : INTEGER is

        do
            result := operators.count
        end
-------------------------------------------

    component_count : INTEGER is

        do
            if components = void then
                if anchor /= void then
                    result := 1
                else
                    result := 0
                end
            else
                result := components.count
            end
        end
------------------------------------------------------

    component_at (index : INTEGER) : like anchor is

        do
            if components /= void then
                result := components.at (index)
            else
                result := anchor
            end
        end
------------------------------------------------------

    accept (v : SEMANTIC_VISITOR) is

        do
            v.visit_const_exp (current)
        end
-------------------------------------------
feature { NONE }

    anchor    : CONST_EXP
        -- The use of `anchor' makes it easier to
        -- debug constant expressions and it may
        -- save a _small_ amount of memory in
        -- _some_ cases. The use of the interface
        -- with `add_component', `component_count'
        -- and `component_at' makes these manipulations
        -- with `anchor' completely transparent to
        -- the clients.
    operators : INDEXED_LIST [CHARACTER]
        -- '+' or '-' for <add_expr>
        -- '*' or '/' for <mult_expr>
        -- 'l' or 'r' for <shift_expr>

end -- class CONST_EXP

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

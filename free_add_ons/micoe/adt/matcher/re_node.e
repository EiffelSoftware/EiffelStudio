indexing

description: "The nodes in the syntax tree for a regular expression.";
keywords: "regular expression", "syntax tree"
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"
  
class RE_NODE

creation { FAST_RE_MATCHER }
    make_leaf, make_cat, make_alt, make_star

feature { FAST_RE_MATCHER, RE_NODE }

    Leaf      : INTEGER is unique
    Cat_node  : INTEGER is unique
    Alt_node  : INTEGER is unique
    Star_node : INTEGER is unique

    type     : INTEGER
    nullable : BOOLEAN
    firstpos : SMALL_SORTED_SET [INTEGER]
    lastpos  : SMALL_SORTED_SET [INTEGER]

-----------------------------------------------------------

    make_leaf (pos : INTEGER) is

        do
            type := Leaf
            create firstpos.make 
            create lastpos.make

            if pos > 0 then
                nullable := false
                firstpos.add (pos)
                lastpos.add (pos)
            else
                nullable := true
            end
        end
-----------------------------------------------------------

    make_cat (left, right : RE_NODE) is

        require
            real_children : left /= void and then right /= void

        do
            type     := Cat_node
            nullable := (left.nullable and then right.nullable)

            if left.nullable then
                firstpos := left.firstpos + right.firstpos
            else
                firstpos := clone (left.firstpos)
            end

            if right.nullable then
                lastpos := left.lastpos + right.lastpos
            else
                lastpos := clone (right.lastpos)
            end
        end
-----------------------------------------------------------

    make_alt (left, right : RE_NODE) is

        require
            real_children : left /= void and then right /= void

        do
            type     := Alt_node
            nullable := (left.nullable or else right.nullable)
            firstpos := left.firstpos + right.firstpos
            lastpos  := left.lastpos + right.lastpos
        end
-----------------------------------------------------------

    make_star (child : RE_NODE) is

        require
            real_child : child /= void

        do
            type     := Star_node
            nullable := true
            firstpos := clone (child.firstpos)
            lastpos  := clone (child.lastpos)
        end

end -- class RE_NODE

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

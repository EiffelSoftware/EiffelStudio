indexing

description: "This concrete implementation of MATCHER uses the algorithm %
             %of Knuth, Morris and Pratt.";
keywords: "Knuth Morris Pratt", "string matching"
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"
  
class KMP_MATCHER

inherit
    MATCHER
        redefine
            build_automat, advance, accept, reset
    end

creation
    make

feature { NONE }

    accept : BOOLEAN
    next   : ARRAY [INTEGER]    -- used by the automat
                                -- next[t] = s <==>
                                -- p[1 .. s] is longest proper
                                -- suffix of p[1 .. t]
    fst_ch : CHARACTER          -- first character of pattern

-----------------------------------------------------------
 
    build_automat is

        local
            i, s : INTEGER

        do
            length  := p.count
            start_i := 1
            start_s := 0

            create next.make (1, length)
            next.put (0, 1)

            from
                i := 2
                s := 0
            invariant
                -- p[1 .. s] is longest proper suffix of
                -- p[1 .. i - 1]
            until
                i > length
            loop
                if p.item (i) = p.item (s + 1) then
                    s := s + 1 
                    next.put (s, i)
                    i := i + 1
                elseif s = 0 then
                    next.put (0, i)
                    i := i + 1
                else
                    s := next.item (s)
                end
            end

            fst_ch := p.item (1)
        end
-----------------------------------------------------------

    advance is

        local
            i, s : INTEGER
            n    : ARRAY [INTEGER]

        do
            from
                i := shift
            until
                i > t.count or else t.item (i) = fst_ch
            loop
                i := i + 1
            end

            from
                accept := false
                s      := state
                n      := next
            until
                s >= length or else i > t.count
            loop
                if t.item (i) = p.item (s + 1) then
                    i := i + 1
                    s := s + 1
                elseif s = 0 then
                    i := i + 1
                else
                    s := n.item (s)
                end
            end

            shift  := i
            state  := s
            accept := (state = p.count)
        end
-----------------------------------------------------------

    reset is

        do
            state := next.item (state)
        end
-----------------------------------------------------------

end -- class KMP_MATCHER

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

indexing

description: "This concrete implementation of MATCHER uses the algorithm of Rabin and Karp.";
keywords: "Rabin Karp", "string matching"
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"
  
class   RK_MATCHER

inherit
    MATCHER
        redefine
            set_text, build_automat, advance, accept, reset
    end

creation
    make

feature -- Mutation


    set_text (the_text : STRING) is

        local
            i, j : INTEGER

        do
            t     := the_text
            index := 0      -- prevent next_match before first_match

            from
                i := 1
            until
                i > t.count or else t.item (i) = fst_ch
            loop
                i := i + 1
            end

            start_i := i + length

            from
                start_s := 0
                j       := 1
            until
                j > length or else i > t.count
            loop
                start_s := (d * start_s + t.item(i).code) \\ q
                i       := i + 1
                j       := j + 1
            end

            if start_s = p_hash then
                shift := start_i 
                test_collision
            else
                accept := false
            end
        end
-----------------------------------------------------------
 
feature { NONE }

    q      : INTEGER is 3355439     -- a large prime 
    p_hash : INTEGER                -- hash value of pattern
    d      : INTEGER                -- basis for arithmetic
    h      : INTEGER                -- d ^ (m - 1) mod q
    accept : BOOLEAN
    fst_ch : CHARACTER              -- first character in pattern

-----------------------------------------------------------
 
    build_automat is

        local
            i : INTEGER
        do
            d       := 128
            length  := p.count
            start_i := length + 1

            from
                h := 1
            until
                i >= length - 1
            loop
                h := (h * d) \\ q
                i := i + 1
            end

            from
                i       := 1
                p_hash  := 0
            until
                i > length
            loop
                p_hash := (d * p_hash  + p.item(i).code) \\ q
                i      := i + 1
            end

            fst_ch := p.item (1)
        end
-----------------------------------------------------------

    advance is

        local
            i, s : INTEGER

        do
            from
                i := shift
                s := state
            until
                accept or else i > t.count
            loop
                s := (s - h * t.item (i - length).code) \\ q

                if s < 0 then
                    s := s + q
                end

                s := (d * s + t.item (i).code) \\ q
                i := i + 1

                if s = p_hash then
                    shift := i
                    state := s
                    test_collision
                end
            end

            shift := i
            state := s
        end
-----------------------------------------------------------

    test_collision is

        local
            i, j : INTEGER

        do
            from
                i := 1
                j := shift - length 
            until
                i > length or else p.item (i) /= t.item (j) 
            loop
                i := i + 1
                j := j + 1
            end

            accept := (i > length)
        end
-----------------------------------------------------------

    reset is

        do
            if shift <= t.count then
                state := (state - h * t.item (shift - length).code) \\ q

                if state < 0 then
                    state := state + q
                end

                state := (d * state + t.item (shift).code) \\ q
                shift := shift + 1

                if state = p_hash then
                    test_collision
                else
                    accept := false
                end
            else
                accept := false
            end
        end
-----------------------------------------------------------

end -- class RK_MATCHER

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

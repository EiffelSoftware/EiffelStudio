indexing

description: "This concrete implementation of MATCHER uses the algorithm of Boyer and Moore.";
keywords: "Boyer Moore", "string matching"
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"
  
class   BM_MATCHER

inherit
    MATCHER
        redefine
            build_automat, advance, accept, reset
    end

creation
    make

feature { NONE }

    next_f : ARRAY [INTEGER] -- prefix function for original pattern
    next_b : ARRAY [INTEGER] -- prefix function for reversed pattern
    gd_suf : ARRAY [INTEGER] -- good suffix function
    bd_chr : ARRAY [INTEGER] -- bad character function
    gd_s0  : INTEGER         -- gd_suf[0]; our arrays begin at 1 ...
    accept : BOOLEAN
    lst_ch : CHARACTER       -- last character in pattern

-----------------------------------------------------------
 
    build_automat is

        local
            p_r : STRING         -- reversed pattern 
            i   : INTEGER
        do
            length  := p.count
            start_i := length
            start_s := 0

            from
                p_r := p.clone (p)
                i   := 1
            until
                i > length
            loop
                p_r.put (p.item (length - i + 1), i)
                i := i + 1
            end

            create next_f.make (1, length)
            next_f.put (0, 1)

            create next_b.make (1, length)
            next_b.put (0, 1)

            from
                shift := 2
                state := 0
            invariant
                -- p[1 .. state] is longest proper suffix of
                -- p[1 .. shift - 1]
            until
                shift > length
            loop
                if p.item (shift) = p.item (state + 1) then
                    state := state + 1 
                    next_f.put (state, shift)
                    shift := shift + 1
                elseif state = 0 then
                    next_f.put (0, shift)
                    shift := shift + 1
                else
                    state := next_f.item (state)
                end
            end

            from
                shift := 2
                state := 0
            invariant
                -- p_r[1 .. state] is longest proper suffix of
                -- p_r[1 .. shift - 1]
            until
                shift > length
            loop
                if p_r.item (shift) = p_r.item (state + 1) then
                    state := state + 1 
                    next_b.put (state, shift)
                    shift := shift + 1
                elseif state = 0 then
                    next_b.put (0, shift)
                    shift := shift + 1
                else
                    state := next_b.item (state)
                end
            end

            compute_bad_character_function
            compute_good_suffix_function

            lst_ch := p.item (length)
        end
-----------------------------------------------------------

    advance is

        local
            d0, d1 : INTEGER
            s, i   : INTEGER

        do
            from
                i := shift
            until
                i > t.count or else t.item (i) = lst_ch
            loop
                i := i + 1
            end

            from
                -- empty statement
            invariant
                -- p[length - s + 1 .. length] matches
                -- t[i - s + 1 .. i]
            until
                s = length or else i > t.count
            loop
                if p.item (length - s) = t.item (i - s) then
                    s := s + 1
                else
                    d0 := gd_suf.item (length - s)
                    d1 := length - s
                            - bd_chr.item (t.item (i - s).code)

                    if d0 > d1 then
                        i := i + d0
                    else
                        i := i + d1
                    end

                    s := 0
                end
            end

            state  := s
            accept := (state = length)
            shift  := i + 1
        end
-----------------------------------------------------------
 
    reset is

        do
            shift := shift + gd_s0 - 1
        end
-----------------------------------------------------------

    compute_bad_character_function is

        local
            j : INTEGER
        do
            create bd_chr.make (1, 128)

            from
                j := 1
            until
                j > length
            loop
                bd_chr.put (j, p.item (j).code)
                j := j + 1
            end
        end
-----------------------------------------------------------

    compute_good_suffix_function is

        local
            j, k, l : INTEGER
        do
            create gd_suf.make (1, length)

            from
                l     := length - next_f.item (length)
                j     := 1 
                gd_s0 := l
            until
                j > length
            loop
                gd_suf.put (l, j)
                j := j + 1
            end

            from
                l := 1
            until
                l > length
            loop
                j := length - next_b.item (l)
                k := l - next_b.item (l)

                if gd_suf.item (j) > k then
                    gd_suf.put (k, j)
                end

                l := l + 1
            end
        end
-----------------------------------------------------------

end -- class BM_MATCHER

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

indexing

description: "This concrete implementation of the class SORTER uses%
             % the bottom-up heapsort algorithm, which is typically%
             % somewhat faster then the classical heapsort and can%
             % beat quicksort when the elements to be sorted have%
             % relatively costly comparison operators -- e.g. STRING.";
keywords: "bottom-up heapsort"
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"
  
class   HEAP_SORTER [G -> COMPARABLE]

inherit
    SORTER [G]
        redefine
            sort
        end

--
-- The heap condition: H[i, j] holds if and only if
-- i)   2 * i > j or else a[base + i] >= a[base + 2 * i]
-- ii)  2 * i + 1 > j or else a[base + i] >= a[base + 2 * i + 1]
-- iii) H[k, j] holds for i < k < j

feature

    sort (arr : ARRAY [G]; lower, upper : INTEGER) is
        -- See version in SORTER.

        do
            if lower < upper then
                base := lower - 1
                n    := upper - base
                a    := arr

                if base = 0 then
                    spec_heapsort
                else
                    bu_heapsort
                end
            end
        end
-----------------------------------------------------------

feature { NONE } 
 
    base : INTEGER 
    n    : INTEGER 
    a    : ARRAY [G] 
 
-----------------------------------------------------------

    bu_heapsort is

        local
            i : INTEGER
            x : G
        do
            from                -- build heap
                i := n // 2
            invariant
                -- H[i + 1, n]
            until
                i = 0
            loop
                bu_heapify (i, n)

                i := i - 1
            end
    
            -- now H[1, n] holds

            from
                i := n
            invariant
                -- a[base + i .. base + n] is sorted
            until
                i = 1
            loop
                x := a.item (base + 1)
                a.put (a.item (base + i), base + 1)
                a.put (x, base + i)

                i := i - 1
                bu_heapify (1, i)
            end
        ensure
            -- a[base + 1 .. base + n] is sorted
        end         
-----------------------------------------------------------

    spec_heapsort is
        -- This special version takes advantage of the fact that
        -- base is 0.

        local
            i : INTEGER
            x : G
        do
            from                -- build heap
                i := n // 2
            invariant
                -- H[i + 1, n]
            until
                i = 0
            loop
                spec_heapify (i, n)

                i := i - 1
            end
    
            -- now H[1, n] holds

            from
                i := n
            invariant
                -- a[i .. n] is sorted
            until
                i = 1
            loop
                x := a.item (1)
                a.put (a.item (i), 1)
                a.put (x, i)

                i := i - 1
                spec_heapify (1, i)
            end
        ensure
            -- a[1 .. n] is sorted
        end         
-----------------------------------------------------------

    bu_heapify (left, right : INTEGER) is
        -- bottom up heap sort

        require
            -- H[left + 1, right]

        local
            k    : INTEGER
            x, y : G

        do
            from            -- descend
                k := left
            until
                2 * k > right
            loop
                k := 2 * k
                if k + 1 <= right          and then 
                   a.item (k) < a.item (k + 1) then
                    k := k + 1
                end
            end

            from            -- ascend again
                x := a.item (base + left)
            until
                a.item (base + k) >= x
            loop
                k := k // 2
            end

            from
                -- empty statement
            until
                k < left
            loop
                y := a.item (base + k)
                a.put (x, base + k)
                x := y
                k := k // 2
            end
        ensure
            -- H[left, right]
        end
-----------------------------------------------------------

    spec_heapify (left, right : INTEGER) is
        -- bottom up heap sort for the case base = 0.

        require
            -- H[left + 1, right]

        local
            k    : INTEGER
            x, y : G

        do
            from            -- descend
                k := left
            until
                2 * k > right
            loop
                k := 2 * k
                if k + 1 <= right          and then 
                   a.item (k) < a.item (k + 1) then
                    k := k + 1
                end
            end

            from            -- ascend again
                x := a.item (left)
            until
                a.item (k) >= x
            loop
                k := k // 2
            end

            from
                -- empty statement
            until
                k < left
            loop
                y := a.item (k)
                a.put (x, k)
                x := y
                k := k // 2
            end
        ensure
            -- H[left, right]
        end

end -- class SORTER

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

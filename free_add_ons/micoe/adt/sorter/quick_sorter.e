indexing

description: "This concrete implementation of SORTER uses the famous quicksort%
             % algorithm due to C. A. R. Hoare.";
keywords: "quicksort"  
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"
  
class   QUICK_SORTER [G -> COMPARABLE]

inherit
    SORTER [G]
        redefine
            sort
        end

feature

    sort (arr : ARRAY [G]; lower, upper : INTEGER) is
        -- See version in SORTER.

        do
            a := arr

            if upper > lower then
                quicksort (lower, upper)
            end
        end
-----------------------------------------------------------
feature { NONE }

    quicksort (left, right : INTEGER) is

        local
            lt, rt   : INTEGER
            l, r     : INTEGER
            pivot, x : G

        do
            from
                lt := left
                rt := right
            until
                lt >= rt
            loop
                pivot := a.item ((lt + rt) // 2)

                from
                    l := lt - 1
                    r := rt + 1
                invariant
                    -- a[lt .. l] <= pivot
                    -- a[r .. rt] >= pivot
                until
                    l >= r
                loop
                    from
                        r := r - 1
                    until
                        a.item (r) <= pivot
                    loop
                        r := r - 1
                    end

                    from
                        l := l + 1
                    until
                        a.item (l) >= pivot
                    loop
                        l := l + 1
                    end

                   if l < r then
                        x := a.item (l)
                        a.put (a.item (r), l)
                        a.put (x, r)
                    end
                end

                if (r - lt) < (rt - r) then
                    if lt < r then
                        quicksort (lt, r)
                    end

                    lt := r + 1
                else
                    if r + 1 < rt then
                        quicksort (r + 1, rt)
                    end

                    rt := r
                end
            end
        end
-----------------------------------------------------------
 
feature { NONE } 
 
    a : ARRAY [G] 

end -- class QSORTER

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

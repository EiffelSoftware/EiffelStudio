indexing

description: "This cousin of the class SORTED_SET is more%
             % parsimonious with space at the price of reduced%
             % speed. Use it if your sets only have a couple dozen%
             % elements.";
keywords: "set" , "union", "intersection", "difference", "sorting"
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"
  
class SMALL_SORTED_SET [G -> COMPARABLE]

inherit
    SHORT_SORTED_LIST [G]
        rename
            make as SL_make
        export { SMALL_SORTED_SET }
            items
        end

creation
    make

feature -- Initialization

    make is

        do
            SL_make (true)
        end
--------------------------------------------------------------
feature -- Access

    has (x : G) : BOOLEAN is

        do
            search (x)
            result := found
        end
--------------------------------------------------------------
feature -- Set-theoretic operations

    union, infix "+" (other : like current) : like current is

        require
            not_void : other /= void

        local
            i, j : INTEGER
            a, b : ARRAY [G]
            x, y : G
            cnt1 : INTEGER
            cnt2 : INTEGER
            stop : BOOLEAN

        do
            if count = 0 then
                result := clone (other)
            elseif other.count = 0 then
                result := clone (current)
            else
                create result.make
                a    := items
                b    := other.items
                cnt1 := count
                cnt2 := other.count

                from
                    i := 1
                    j := 1
                    x := a.item (i) 
                    y := b.item (j) 
                until
                    stop
                loop
                    if x <= y then
                        result.append (x)

                        if x >= y then
                            j := j + 1

                            if j <= cnt2 then
                                y := b.item (j)
                            else
                                stop := true
                            end
                        end
  
                        i := i + 1 
 
                        if i <= cnt1 then
                            x := a.item (i)
                        else
                            stop := true
                        end
                    else              -- x > y
                        result.append (y)
                        j := j + 1

                        if j <= cnt2 then
                            y := b.item (j)
                        else
                            stop := true
                        end
                    end
                end
            
                from
                    -- nothing
                until
                    i > cnt1
                loop
                    result.append (a.item (i))
                    i := i + 1
                end
            
                from
                    -- nothing
                until
                    j > cnt2
                loop
                    result.append (b.item (j))
                    j := j + 1
                end
            end
        end
--------------------------------------------------------------

    intersection, infix "*" (other : like current) : like current is

        require
            not_void : other /= void

        local
            a, b : ARRAY [G]
            i, j : INTEGER
            cnt1 : INTEGER
            cnt2 : INTEGER
            x, y : G
            stop : BOOLEAN

        do
            create result.make 

            if count /= 0 and then other.count /= 0 then
                a    := items
                b    := other.items
                cnt1 := count
                cnt2 := other.count

                from
                    i := 1
                    j := 1
                    x := a.item (i)
                    y := b.item (j)
                until
                    stop
                loop
                    if x <= y then      -- possible candidate
                        if x >= y then  -- take this one ...
                            result.append (x)

                            j := j + 1

                            if j <= cnt2 then
                                y := b.item (j)
                            else
                                stop := true
                            end
                        end

                        i := i + 1

                        if i <= cnt1 then
                            x := a.item (i)
                        else
                            stop := true
                        end
                    else                -- skip this y
                        j := j + 1

                        if j <= cnt2 then
                            y := b.item (j)
                        else
                            stop := true
                        end
                    end
                end
            end
        end
--------------------------------------------------------------

    difference, infix "-" (other : like current) : like current is

        require
            not_void : other /= void

        local
            a, b : ARRAY [G]
            i, j : INTEGER
            cnt1 : INTEGER
            cnt2 : INTEGER
            x, y : G
            stop : BOOLEAN

        do
            create result.make 

            if other.count = 0 then
                result.copy (current)
            elseif count > 0 then
                a    := items
                b    := other.items
                cnt1 := count
                cnt2 := other.count

                from
                    i := 1
                    j := 1
                    x := a.item (i)
                    y := b.item (j)
                until
                    stop
                loop
                    if x <= y then     -- possible candidate
                        if x < y then  -- take this x ...
                            result.append (x)
                        else
                            j := j + 1

                            if j <= cnt2 then
                                y := b.item (j)
                            else
                                stop := true
                            end
                        end

                        i := i + 1

                        if i <= cnt1 then
                            x := a.item (i)
                        else
                            stop := true
                        end
                    else                 -- x > y; go to next y
                        j := j + 1

                        if j <= cnt2 then
                            y := b.item (j)
                        else
                            stop := true
                        end          
                    end 
                end

                from
                    -- nothing
                until
                    i > cnt1
                loop
                    result.append (a.item (i))
                    i := i + 1
                end
            end
        end
--------------------------------------------------------------

feature { SMALL_SORTED_SET }

    append (x : G) is

        require
            belongs_there : -- x >= last element in set

        do
            if items = void or else count = items.count then
                expand
            end

            count := count + 1
            items.put (x, count)
        end

end -- class SMALL_SORTED_SET

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

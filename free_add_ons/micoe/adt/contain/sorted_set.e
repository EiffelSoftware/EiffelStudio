indexing

description: "This class implements the mathematical abstraction%
             % set with its operations union. intersection and%
             % set-theoretic difference. It keeps its elements%
             % sorted in order to be able to implement the set%
             % in a fairly efficient manner.";
keywords: "set", "union", "intersection", "difference", "sorting"
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"
  
class SORTED_SET [G -> COMPARABLE]

inherit
    SORTED_LIST [G]
        rename
            make as SL_make
        end

creation
    make

feature -- Initialization

    make is

        do
            SL_make (true)
                -- This is not quite as silly as it looks at first:
                -- We _must_ have uniqueness to get a set rather
                -- than a bag; but we don't want our `make' to have
                -- an argument.
        end
--------------------------------------------------------------
feature -- Access

    has (x : G) : BOOLEAN is

        do
            search (x)
            result := found
        end
--------------------------------------------------------------

    contains (other : like current) : BOOLEAN is
        -- Does `current' contain `other' as a subset?
        -- NOTE: if `other' is void it is treated like
        -- the empty set; i.e. the result is true.

        local
            it : ITERATOR

        do
            if other /= void then
                from
                    it     := other.iterator
                    result := true
                until
                    it.finished
                loop
                    if has (other.item (it)) then
                        it.forth
                    else -- this element is not in `current'
                        result := false
                        it.stop
                    end
                end
            else -- treat `other' like the empty set
                result := true
            end
        end
--------------------------------------------------------------
feature -- Set-theoretic operations


    join (other : like current) is
        -- This is a `destructive' union; it simply adds
        -- all elements of `other' to `current'.
        -- NOTE: if `other' = `current' there is nothing to
        -- do. If `other' is void, it is treated like the empty
        -- set; also nothing to do.

        local
            it : ITERATOR

        do
            if other /= current and then other /= void then
                from
                    it := other.iterator
                until
                    it.finished
                loop
                    add (other.item (it))
                    it.forth
                end
            else
                -- nothing to do.
            end

        ensure
            join_effected : contains (other)
        end
--------------------------------------------------------------

    union, infix "+" (other : like current) : like current is
        -- In contrast to `join' this is a `nondestructive' union;
        -- it returns a _new_ sorted set that is the union of
        -- `current' and `other'.

        do
            result := clone (current)
            result.join (other)

        ensure
            proper_union : result.contains (current) and then
                           result.contains (other)
        end
--------------------------------------------------------------

    common_subset (other : like current) is
        -- This is a `destructive' intersection; it
        -- removes from `current' all elements that are
        -- not also in `other'.
        -- NOTE: if `other' is void then `current' is
        -- completely emptied. If `other' = `current'
        -- nothing is done.

        local
            it  : ITERATOR
            aux : SORTED_LIST [G]

        do
            if other = void then
                remove_all
            elseif other /= current then
                from
                    it := iterator
                    create aux.make (true)
                until
                    it.finished
                loop
                    other.search (item (it))
                    if not other.found then
                        aux.add (item (it))
                    end
                    it.forth
                end
                from
                    it := aux.iterator
                until
                    it.finished
                loop
                    remove (aux.item (it))
                    it.forth
                end
            else -- `other' = `current'.
                -- do nothing
            end

        ensure
            proper_inclusion : other /= void implies
                               other.contains (current)
        end
--------------------------------------------------------------

    intersection, infix "*" (other : like current) : like current is
        -- In contrast to `common_subset' this is a `nondestructive'
        -- intersection; it returns a _new_ sorted set that is the
        -- intersection of `current' and `other'.


        do
            result := clone (current)
            result.common_subset (other)

        ensure
            proper_inclusion : current.contains (result) and then
                               (other /= void implies other.contains (result))
        end
--------------------------------------------------------------

    rest (other : like current) is
        -- This is a `destructive' set theoretic difference;
        -- it removes from `current' all elements that are also
        -- in `other'.
        -- NOTE: if `other' = `current', `current' is
        -- completely emptied. If `other' is void nothing
        -- at all happens.

        local
            it : ITERATOR

        do
            if other = current then
                remove_all
            elseif other /= void then
                from
                    it := other.iterator
                until
                    it.finished
                loop
                    remove (other.item (it))
                    it.forth
                end
            else -- `other' = void.
                -- do nothing
            end

        ensure
            proper_exclusion : (current * other).empty
        end
--------------------------------------------------------------

    difference, infix "-" (other : like current) : like current is
        -- In contrast to `rest' this is a `nondestructive'
        -- set theoretic difference; it returns a _new_ sorted
        -- set that is the set theoretic difference  of `current'
        -- and `other'.

        do
            result := clone (current)
            result.rest (other)

        ensure
            proper_exclusion : (result * other).empty
        end

end -- class SORTED_SET

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

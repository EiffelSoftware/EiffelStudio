indexing

description: "A generic pair, whose elements can be of differing types.";
keywords: "Still to be entered";
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"

class PAIR [G1, G2]

creation
    make

feature -- Initializtion

    make (fst : G1; sec : G2) is
        -- Initialize `current' with `first' = `fst'
        -- and `second' = `sec'.

        do
            first  := fst
            second := sec

        ensure
            pair_set : first = fst and then second = sec
        end

feature -- Access

        first  : G1
        second : G2

feature -- Mutation

    set_first (f : like first) is

        do
            first := f

        ensure
            first_set : first = f
        end
------------------------------------------

    set_second (s : like second) is

        do
            second := s

        ensure
            second_set : second = s
        end

end -- class PAIR

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

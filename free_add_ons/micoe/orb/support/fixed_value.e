indexing

description: "A representation for real numbers with a fixed precision.";
keywords: "Still to be entered";
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"

class FIXED_VALUE

creation
    make

feature -- Initialization

    make (m, f, d, s : INTEGER) is

        do
            mantissa := m
            fraction := f
            digits   := d
            scale    := s
        end
---------------------------------------------------------
feature -- Access

    mantissa : INTEGER
    fraction : INTEGER
    digits   : INTEGER
    scale    : INTEGER
---------------------------------------------------------

    length : INTEGER is
        -- Sum of digits in mantissa and fraction is

        do
            result := nr_digits (mantissa) + nr_digits (fraction)
        end
---------------------------------------------------------
feature -- Implementation

    nr_digits (n : INTEGER) : INTEGER is
        -- There may be some more intelligent way to do this.

        local
            tmp : STRING

        do
            tmp := ""
            tmp.append_integer (n)
            result := tmp.count
        end

end -- class FIXED_VALUE

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

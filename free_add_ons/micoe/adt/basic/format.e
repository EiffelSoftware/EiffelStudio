indexing

description: "For converting numbers to strings in a given format and vice versa.";
keywords: "conversion", "formatting"
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"

class FORMAT

feature -- Conversion number->string

    i2s (fmt : STRING; n : INTEGER) : STRING is

        local
            dummy : ANY

        do
            dummy := fmt.to_c
            result := ext_i2s ($dummy, n)
        end
-------------------------------------------------

    r2s (fmt : STRING; r : DOUBLE) : STRING is

        local
            dummy : ANY

        do
            dummy := fmt.to_c
            result := ext_r2s ($dummy, r)
        end
-------------------------------------------------
feature -- Conversion string->number

    s2i (str :STRING) : INTEGER is

        local
            dummy : ANY
            i, n  : INTEGER
            ch    : CHARACTER
            sgn   : INTEGER
            zero  : CHARACTER

        do
            zero := '0'
            from
                n := str.count
                if n > 0 and then str.item (1) = '-' then
                    sgn := -1
                    i   := 2
                else
                    sgn := 1
                    i   := 1
                end
            until
                i > n
            loop
                ch := str.item (i)
                if '0' <= ch and then ch <= '9' then
                    result := 10 * result + (ch.code - zero.code)
                    i      := i + 1
                else
                    except.raise ("Not an integer")
                end
            end
            result := sgn * result
        end
-------------------------------------------------

    s2r (str : STRING) : REAL is

        local
            dummy : ANY

        do
            dummy := str.to_c
            result := ext_s2r ($dummy)
        end
-------------------------------------------------
feature { NONE }

    ext_i2s (f : POINTER; n : INTEGER) : STRING is

        external "C"
        alias    "c_i2s"

        end
-------------------------------------------------

    ext_r2s (f : POINTER; r : DOUBLE) : STRING is

        external "C"
        alias    "c_r2s"

        end
-------------------------------------------------

    ext_s2i (s : POINTER) : INTEGER is

       external "C"
       alias    "c_s2i"

       end        
-------------------------------------------------

    ext_s2r (s : POINTER) : REAL is

        external "C"
        alias    "c_s2r"

        end
-------------------------------------------------

    except : EXCEPTIONS is

        once
            create result
        end

end -- class FORMAT

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

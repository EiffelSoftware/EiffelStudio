indexing

description: "Still to be entered";
keywords: "Still to be entered";
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"

class CORBA_SYSTEM_EXCEPTION

inherit
    THE_EXCEPTIONS;
    EXCEPTION_STATICS;
    CORBA_EXCEPTION
        redefine
            encode, print_it
        end

creation
    make, make_with_minor

feature

    make is

        do
        end
----------------------

    make_with_minor (min, stat : INTEGER) is

        do
            minor       := min
            completed   := stat
        end
----------------------

    get_minor : INTEGER is

        do
            result := minor
        end
----------------------

    set_minor (min : INTEGER) is

        do
            minor := min
        end
----------------------

    get_completed : INTEGER is

        do
            result := completed
        end
----------------------

    set_completed (stat : INTEGER) is

        do
            completed := stat
        end
----------------------
feature -- Encoding

    encode (ec : DATA_ENCODER) is

        do
            ec.except_begin (repoid)
            ec.put_ulong (minor)
            ec.put_enumeration_value (completed)
            ec.except_end
        end
----------------------
feature -- Miscellaneous

    print_it is

        do
            io.put_string (repoid)
            io.put_string (" (")
            io.putint (minor)
            io.put_string (", ")
            inspect completed

            when Completed_yes then
                io.put_string ("completed")
            when Completed_no then
                io.put_string ("not-completed")
            when Completed_maybe then
                io.put_string ("maybe-completed")
            else
                io.put_string ("illegal status")
            end
            io.put_string (")%N")
        end
----------------------

    throwit is

        local
            except : EXCEPTIONS

        do
            raised_exceptions.set_last_exception (current)
            create except
            except.raise ("SystemException%N")
        end
----------------------

    repoid : STRING is

        do
            result := "IDL:omg.org/CORBA/SystemException:1.0"
        end
----------------------
feature { NONE } -- Implementation

    minor     : INTEGER
    completed : INTEGER

end -- class CORBA_SYSTEM_EXCEPTION

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

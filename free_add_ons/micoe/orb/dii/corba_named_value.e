indexing

description: "Still to be entered";
keywords: "Still to be entered";
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"

class CORBA_NAMED_VALUE

inherit
    THE_FLAGS
        redefine
            copy, is_equal
        end

creation
    make, make_with_flags, make_with_name_and_flags,
    make_with_name_value_and_flags


feature -- Initialization

    make is

        do
            name     := void
            value    := void
            my_flags := void
        end
----------------------

    make_with_flags (f : FLAGS) is

        do
            my_flags := f
            create value.make
        end
----------------------

    make_with_name_and_flags (n : STRING; f : FLAGS) is

        do
            name     := n
            my_flags := f
            create value.make
        end
----------------------

    make_with_name_value_and_flags (n : STRING; v : CORBA_ANY; f : FLAGS) is

        do
            name     := n
            value    := v
            my_flags := f
        end
----------------------

    set_argument, set_value (v : CORBA_ANY) is

        do
            value := v
        end
----------------------
feature -- Access

    name            : STRING
    argument, value : CORBA_ANY
        -- IMHO `argument' is an idiotic name for this attribute
        -- but it doesn't cost much to add this synonym if it makes
        -- the OMG happy.
----------------------

    is_arg_in : BOOLEAN is
        -- Is this an "in" argument?

        do
            result := ((my_flags & flags.Arg_in).value /= 0)
        end
----------------------

    is_arg_out : BOOLEAN is
        -- Is this an "out" argument?

        do
            result := ((my_flags & flags.Arg_out).value /= 0)
        end
----------------------

    is_arg_inout : BOOLEAN is
        -- Is this an "inout" argument?

        do
            result := ((my_flags & flags.Arg_inout).value /= 0)
        end
----------------------
feature -- Mutation

    set_name (n : STRING) is

        do
            name := n
        end
----------------------

    copy (other : like current) is

        do
            name     := clone (other.name)
            value    := other.value
            my_flags := other.my_flags
        end
----------------------

    is_equal (other : like current) : BOOLEAN is

        do
            result := (equal (name, other.name)   and then
                       equal (value, other.value) and then
                       equal (my_flags, other.my_flags))
        end
----------------------
feature { CORBA_NAMED_VALUE, CORBA_NV_LIST, CORBA_CONTEXT,ORB_REQUEST }

    my_flags : FLAGS

end -- class CORBA_NAMED_VALUE

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

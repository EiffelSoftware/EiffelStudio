indexing

description: "Still to be entered";
keywords: "Still to be entered";
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"

class CORBA_NV_LIST

inherit
    THE_FLAGS

creation
    make

feature -- Initialization


    make is

        do
            create the_list.make (false)
        end
----------------------
feature -- Access

    count : INTEGER is

        do
            result := the_list.count
        end
----------------------

    item (index : INTEGER) : CORBA_NAMED_VALUE is

        require
            valid_index : 1 <= index and then index <= count

        do
            result := the_list.at (index)
        end
----------------------

    item_by_name (n : STRING) : CORBA_NAMED_VALUE is

        do
            result := find_by_name (n)
        end
----------------------
feature -- Mutation

    add_arg_in (name : STRING; value : CORBA_ANY) is

        local
            dummy : CORBA_NAMED_VALUE

        do
            dummy := add_value (name, value, flags.Arg_in)
        end
----------------------

    add_arg_out (name : STRING; value : CORBA_ANY) is

        local
            dummy : CORBA_NAMED_VALUE

        do
            dummy := add_value (name, value, flags.Arg_out)
        end
----------------------

    add_arg_inout (name : STRING; value : CORBA_ANY) is

        local
            dummy : CORBA_NAMED_VALUE

        do
            dummy := add_value (name, value, flags.Arg_inout)
        end
----------------------
feature -- MICO interface

    get_integer_value_by_name (n: STRING) : INTEGER is

        local
            nv : CORBA_NAMED_VALUE

        do
            nv     := find_by_name (n)
            result := nv.value.get_long
        end
----------------------

    get_real_value_by_name (n : STRING) : REAL is

        local
            nv : CORBA_NAMED_VALUE

        do
            nv     := find_by_name (n)
            result := nv.value.get_float
        end
----------------------

    get_double_value_by_name (n : STRING) : DOUBLE is

        local
            nv : CORBA_NAMED_VALUE

        do
            nv     := find_by_name (n)
            result := nv.value.get_double
        end
----------------------

    get_character_value_by_name (n : STRING) : CHARACTER is

        local
            nv  : CORBA_NAMED_VALUE

        do
            nv     := find_by_name (n)
            result := nv.value.get_char
        end
----------------------

    get_boolean_value_by_name (n : STRING) : BOOLEAN is

        local
            nv  : CORBA_NAMED_VALUE

        do
            nv     := find_by_name (n)
            result := nv.value.get_boolean
        end
----------------------

    get_string_value_by_name (n : STRING) : STRING is

        local
            nv : CORBA_NAMED_VALUE

        do
            nv     := find_by_name (n)
            result := nv.value.get_string (0)
        end
----------------------

    get_wstring_value_by_name (n : STRING) : ARRAY [INTEGER] is

        local
            nv : CORBA_NAMED_VALUE

        do
            nv     := find_by_name (n)
            result := nv.value.get_wstring (0)
        end
----------------------

    get_any_value_by_name (n : STRING) : CORBA_ANY is

        local
            nv : CORBA_NAMED_VALUE

        do
            nv     := find_by_name (n)
            result := nv.value
        end
----------------------

    get_ref_value_by_name (clss, n : STRING) : CORBA_OBJECT is

        local
            nv : CORBA_NAMED_VALUE

        do
            nv     := find_by_name (n)
            result := nv.value.get_object (clss)
        end
----------------------

    get_typecode_value_by_name (n : STRING) : CORBA_TYPECODE is

        local
            nv : CORBA_NAMED_VALUE

        do
            nv     := find_by_name (n)
            result := nv.value.get_typecode
        end
----------------------
feature -- Modification

    add (f : FLAGS) : CORBA_NAMED_VALUE is

        do
            create result.make_with_flags (f)
            the_list.append (result)
        end
----------------------

    add_item (n : STRING; f : FLAGS) : CORBA_NAMED_VALUE is

        do
            create result.make_with_name_and_flags (n, f)
            the_list.append (result)
        end
----------------------

    add_value (n : STRING; v : CORBA_ANY; f : FLAGS) : CORBA_NAMED_VALUE is

        do
            create result.make_with_name_value_and_flags (n, v, f)
            the_list.append (result)
        end
----------------------

    replace_value (n: STRING; v : CORBA_ANY) is

        local
            nv : CORBA_NAMED_VALUE

        do
            nv := find_by_name (n)
            nv.set_value (v)
        end
----------------------

    replace_name (old_name, new_name : STRING) is

        local
            nv : CORBA_NAMED_VALUE

        do
            nv := find_by_name (old_name)
            nv.set_name (new_name)
        end
----------------------

    remove (index : INTEGER) is

        require
            valid_index : 1 <= index and then index <= count

        do
            the_list.remove_at (index)
        end
----------------------
feature -- Duplication

    copy_using_flags (other : like current; f : FLAGS) is
        -- This routine is needed in ORB.

        local
            s, d   : INTEGER
            src_nv : CORBA_NAMED_VALUE
            dst_nv : CORBA_NAMED_VALUE

        do
            from
                d := 1
                s := 1
            until
                d > the_list.count or else s > other.the_list.count
            loop
                from
                     dst_nv := the_list.at (d)
                until
                     d > the_list.count or else
                     (f & dst_nv.my_flags).value /= 0
                loop
                    d := d + 1
                    if d <= the_list.count then
                        dst_nv := the_list.at (d)
                    end
                end
                from
                     src_nv := other.the_list.at (s)
                until
                     s > other.the_list.count or else
                     (f & src_nv.my_flags).value /= 0
                loop
                    s := s + 1
                    if s <= other.the_list.count then
                        src_nv := other.the_list.at (s)
                    end
                end
                check
                    counts_match : (s >= other.the_list.count
                                    or else
                                    d >= the_list.count)
                                   implies
                                   (s >= other.the_list.count
                                    and then
                                    d >= the_list.count)
                end
                check
                    types_match : (dst_nv.my_flags & f).value =
                                  (src_nv.my_flags & f).value
                end
                dst_nv.value.copy (src_nv.value)
                s := s + 1
                d := d + 1
            end
        end
----------------------
feature { CORBA_NV_LIST }

    the_list : INDEXED_LIST [CORBA_NAMED_VALUE]

----------------------------------------------    
feature { REQUEST }

    find_by_name (nm : STRING) : CORBA_NAMED_VALUE is

        local
            i, n : INTEGER

        do
             from
                 i := 1
                 n := the_list.count
             until
                 i > n or else equal (nm, the_list.at (i).name)
             loop
                 i := i + 1
             end
             if i <= n then
                 result := the_list.at (i)
             end

        ensure
            nonvoid_result : result /= void
        end

end -- class CORBA_NV_LIST

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

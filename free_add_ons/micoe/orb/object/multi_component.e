indexing

description: "Still to be entered";
keywords: "Still to be entered";
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"

class MULTI_COMPONENT

inherit
    IOR_STATICS
        undefine
            copy, is_equal
        end;
    COMPARABLE
        redefine
            infix "<", copy, is_equal
        end

creation
    make

feature -- Initialization

    make is

        do
            create comps.make (false)
        end
----------------------------------------------
feature -- Access

    component (id : INTEGER) : CORBA_COMPONENT is

        local
            i, n : INTEGER

        do
            from
                i := 1
                n := comps.count
            until
                i > n or else result /= void
            loop
                if comps.at (i).id = id then
                    result := comps.at (i)
                end
                i := i + 1
            end
        end
----------------------------------------------

    size : INTEGER is

        do
            result := comps.count
        end
----------------------------------------------
feature -- Mutation

    add_component (c : CORBA_COMPONENT) is

        local
            i : INTEGER
        do
            from
                i := comps.count
            invariant
                ok_so_far : i < comps.count implies
                            c <= comps.at (i + 1)
            variant
                i
            until
                i < 1 or else c >= comps.at (i)
            loop
                i := i - 1
            end
            check
                right_position : (i > 0 implies comps.at (i) <= c)
                                 and then
                                 (i < comps.count implies c < comps.at (i + 1))
            end
            comps.insert (c, i) -- inserts c _after_ position i.
        end
----------------------------------------------
feature -- Encoding and Decoding

    encode (ec : DATA_ENCODER) is

        local
            i, n  : INTEGER
            state : ENCAPS_STATE

        do
            ec.seq_begin (comps.count)
            from
                i := 1
                n := comps.count
            until
                i > n
            loop
                ec.struct_begin
                ec.put_ulong (comps.at (i).id)
                create state
                ec.encaps_begin (state)
                comps.at (i).encode (ec)
                ec.encaps_end (state)
                ec.struct_end
                i := i + 1
            end
            ec.seq_end
        end
----------------------------------------------

    decode (dc : DATA_DECODER) is

        local
            i, n : INTEGER
            c    : CORBA_COMPONENT

        do
            create comps.make (false)
            n := dc.seq_begin
            from
                i := 1
            until
                i > n
            loop
                c := comp_decode (dc)
                check
                    nonvoid_component : c /= void
                end
                add_component (c)
                i := i + 1
            end
            dc.seq_end
        end
----------------------------------------------
feature -- Miscellaneous

   print_it is

       local
           i, n : INTEGER

       do
           io.put_string (" Components:  ")
           from
               i := 1
               n := comps.count
           until
               i > n
           loop
               if i > 1 then
                   io.put_string ("              ")
               end
               comps.at (i).print_it
               i := i + 1
           end
       end
----------------------------------------------
feature -- Copying

    copy (other : like current) is

        local
            i, n : INTEGER

        do
             from
                 create comps.make (false)
                     -- XXX I'm worried about this reinitialization;
                     -- the C++ code doesn't do this, it just seems to
                     -- add the components of `other' to the ones already
                     -- in `current' ...
                 i := 1
                 n := other.comps.count
             until
                 i > n
             loop
                 comps.append (clone (other.comps.at (i)))
                 i := i + 1
             end
        end
----------------------------------------------
feature -- Equality Test

    is_equal (other : like current) : BOOLEAN is

        do
            result := (compare (other) = 0)
        end
----------------------------------------------
feature -- Comparison

    infix "<" (other : like current) : BOOLEAN is

        do
            result := (compare (other) < 0)
        end   
----------------------------------------------

    compare (other : like current) : INTEGER is

        local
            i, n : INTEGER

        do
            from
                i := 1
                n := comps.count
            until
                i > n or else result /= 0
            loop
                result := comps.at(i).compare (other.comps.at (i))
                i      := i + 1
            end
            if result = 0 then
                result := (comps.count - other.comps.count)
            end
        end
----------------------------------------------
feature { MULTI_COMPONENT } -- Implementation

    comps : INDEXED_LIST [CORBA_COMPONENT]
        -- The components are maintained in increasing order.

end -- class MULTI_COMPONENT

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

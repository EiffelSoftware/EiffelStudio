indexing

description: "The class that does the type checking typecodes are supposed %
             %to make possible";
keywords: "type checking";
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"

class TYPECODE_CHECKER

inherit
    TYPECODE_CHECKER_CONSTANTS;
    TYPECODE_STATICS

creation
    make, make_with_typecode, make_from_other

feature -- Initialization

    make is

        do
            done := true
            tc   := Tc_void
            top  := Tc_void
        end
----------------------------------------------

    make_with_typecode (t : CORBA_TYPECODE) is

        do
            done := true
            tc   := void
            top  := void
            restart_with_typecode (t)
--            done := true
              -- This has to be this way; otherwise it
              -- breaks all kinds of things.
        end
----------------------------------------------

    make_from_other (other : like current) is

        do
            tc  := void
            top := void
            restart_with_typecode (other.top)
        end
----------------------------------------------

    inside (kind : INTEGER) : BOOLEAN is

        local
            l : LEVEL_RECORD

        do
            l      := level
            result := (l /= void and then l.tc.unalias.kind = kind)
        end
----------------------------------------------

    level_count : INTEGER is

        do
            result := levelvec.count
        end
----------------------------------------------

    level : LEVEL_RECORD is
        -- Level record at top of level stack, if stack not empty.

        do
            if not levelvec.empty then
                result := levelvec.item
            end
        end
----------------------------------------------

    level_finished : BOOLEAN is

        local
            l : LEVEL_RECORD

        do
            if done then
                result := true
            else
               l := level
               if l = void then
                   -- at toplevel, but not finished
                   result := false
               elseif l.i >= l.n then
                   -- no more elements in structured type
                   result := true
               else
                   result := false
               end -- if l /= void then ...
            end -- if done then ...
        end
----------------------------------------------

    current_tc : CORBA_TYPECODE is

        local
            dum : BOOLEAN

        do
            dum := nexttc

            if not done then
                result := tc
            else
                result := Tc_void
            end

        ensure
            nonvoid_result : result /= void
        end
----------------------------------------------

    basic (t : CORBA_TYPECODE) : BOOLEAN is

        do
            if nexttc and then tc.omg_equal (t.unalias) then
                advance
                if level = void then
                    done := true
                end
                result := true
            end
        end
----------------------------------------------

    enumeration (val : INTEGER) : BOOLEAN is

        do
            if not nexttc then
                result := false
            elseif tc.kind /= Tk_enum or else val >= tc.member_count then
                result := false
            else
                advance
                if level = void then
                    done := true
                end
                result := true
            end
        end
----------------------------------------------

    union_begin : BOOLEAN is

        local
            rec : LEVEL_RECORD

        do
            if not nexttc then
                result := false
            elseif tc.kind /= Tk_union then
                result := false
            else
                advance
                create rec.make5 (Level_union, tc, 1, 1, 1)
                enter (rec)
                result := true
            end
        end
----------------------------------------------           

    union_selection_at (idx : INTEGER) : BOOLEAN is

        local
            l : LEVEL_RECORD

        do
            l := level
            if l = void               or else
               l.level /= Level_union or else
               l.i >= 1                  then
                result := false
            elseif idx >= 0 and then idx >= l.tc.member_count then
                result := false
            else
                if idx < 0 then
                    l.set_n (1)
                else
                    l.set_n (2)
                end
                l.set_x (idx)
                result := true
            end
        end
----------------------------------------------

    union_selection : BOOLEAN is

        do
            result := union_selection_at (-1)
        end
----------------------------------------------

    union_end : BOOLEAN is

        do
            result := leave (Level_union)
        end
----------------------------------------------

    struct_begin : BOOLEAN is

        local
            rec : LEVEL_RECORD

        do
            if not nexttc then
                result := false
            elseif tc.kind /= Tk_struct then
                result := false
            else
                advance
                create rec.make5 (Level_struct, tc, tc.member_count, 1, 0)
                    -- Note: we must begin with i = 1 since nexttc
                    -- will be called before the next advance
                enter (rec)
                result := true
            end
        end
----------------------------------------------

    struct_end : BOOLEAN is

        do
            result := leave (Level_struct)
        end
----------------------------------------------

    except_begin : BOOLEAN is

        local
            rec : LEVEL_RECORD

        do
            if not nexttc then
                result := false
            elseif tc.kind /= Tk_except then
                result := false
            else
                advance
                create rec.make5 (Level_except, tc, tc.member_count, 1, 0)
                    -- Note: we must begin with i = 1 since nexttc
                    -- will be called before the next advance
                enter (rec)
                result := true
            end
        end
----------------------------------------------

    except_end : BOOLEAN is

        do
            result := leave (Level_except)
        end
----------------------------------------------

    seq_begin (len : INTEGER) : BOOLEAN is

        local
            rec : LEVEL_RECORD

        do
            if not nexttc then
                result := false
            elseif tc.kind /= Tk_sequence or else (tc.length > 0 and then
               len > tc.length    )                              then
                result := false
            else
                advance
                create rec.make5 (Level_sequence, tc, len, 0, 0)
                enter (rec)
                result := true
            end
        end
----------------------------------------------

    seq_end : BOOLEAN is

        do
            result := leave (Level_sequence)
        end
----------------------------------------------

    arr_begin : BOOLEAN is

        local
            rec : LEVEL_RECORD

        do
            if not nexttc then
                result := false
            elseif tc.kind /= Tk_array then
                result := false
            else
                advance
                create rec.make5 (Level_array, tc, tc.length, 1, 0)
                enter (rec)
                result := true
            end
        end
----------------------------------------------

    arr_end : BOOLEAN is

        do
            result := leave (Level_array)
        end
----------------------------------------------

    completed : BOOLEAN is

        do
            result := done
        end
----------------------------------------------

    restart_with_typecode (t : CORBA_TYPECODE) is

        do
            create levelvec.make
            done := false
            top := t
            tc  := t
        end
----------------------------------------------

    restart is

        do
            create levelvec.make
            done := true
            top := Tc_void
            tc  := top
        end
----------------------------------------------
feature { TYPECODE_CHECKER } -- Implementation

    top      : CORBA_TYPECODE
    tc       : CORBA_TYPECODE
    done     : BOOLEAN
    levelvec : STACK [LEVEL_RECORD]

----------------------------------------------

    enter (rec : LEVEL_RECORD) is
        -- Push `rec' on the level stack.

        do
            levelvec.add (rec)
        end
----------------------------------------------

    nexttc : BOOLEAN is

        local
            l : LEVEL_RECORD
            t : CORBA_TYPECODE

        do
            result := not done
            if result then
                l := level
                if l = void then
                    -- at toplevel
                elseif l.i > l.n then
                    -- no more elements in structured type
                    result := false
                else
                    inspect l.level

                    when Level_array, Level_sequence then
                        tc := l.tc.content_type
                        -- since `tc' is never modified a `clone'
                        -- is unnecessary.

                    when Level_struct, Level_except then
                        check
                            valid_index : l.i > 0 and then l.i <= l.n
                        end
                            tc := l.tc.member_type (l.i)
                            -- since `tc' is never modified a `clone'
                            -- is unnecessary.

                    when Level_union then
                        check
                            valid_index : l.i > 0 and then l.i <= l.n
                        end
                        if l.i = 1 then
                            tc := l.tc.discriminator_type
                            -- since `tc' is never modified a `clone'
                            -- is unnecessary.
                        elseif l.x > 0 then
                            tc := l.tc.member_type (l.x)
                            -- since `tc' is never modified a `clone'
                            -- is unnecessary.
                        end
                    end -- inspect
                end -- if l = void then ...
            end -- if done then ...
        end
----------------------------------------------

    advance is
        -- Called by `basic', `numeration' and all xxx_begin routines
        -- to move on to next member of a complex type.

        local
            l : LEVEL_RECORD

        do
            l := level
            if not done and then l /= void and then l.i < l.n then
                l.set_i (l.i + 1)
            end
        end
----------------------------------------------

    leave (lev : INTEGER) : BOOLEAN is
        -- Is the current level of type `lev' and is it finished?
        -- This function has a side effect; if it answers true, it
        -- moves on to next level on stack and sets `done' accordingly.

        local
            l : LEVEL_RECORD

        do
            l := level
            if l= void        or else
               l.level /= lev or else
               l.i < l.n        then
                result := false
            else
                levelvec.remove
                if levelvec.empty then
                    done := true
                end
                result := true
            end -- if l = void ...
        end
----------------------------------------------

    unalias_tc (t : CORBA_TYPECODE) is

        do
            tc := t.unalias
        end

end -- class TYPECODE_CHECKER

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

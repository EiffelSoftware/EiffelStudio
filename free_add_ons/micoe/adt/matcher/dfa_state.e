indexing

description: "These are the state objects used in the DFA of FAST_RE_MATCHER.";
keywords: "DFA"
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"
  
class DFA_STATE

inherit
    ANY
        rename
            default as unused
        end

creation { FAST_RE_MATCHER }
    make

feature { FAST_RE_MATCHER } -- Initialization

    make (acpt : BOOLEAN) is
        -- If `acpt' = true, then this is an accepting state.

        do
            accept := acpt

            modulus := 4
            count   := 0
            create next.make (1, modulus)
            create test.make (1, modulus)
            create default.make (1, modulus)
        end
------------------------------------------------------------

    add_transition (st : DFA_STATE; input : INTEGER) is
        -- On input `input' make transition to state `st'.

        local
            i : INTEGER

        do
            if count >= modulus then
                expand
            end

            from
                i := (input \\ modulus) + 1
            until
                next.item (i) = void
            loop
                if default.item (i) = 0 then
                    default.put (free_slot, i)
                end

                i := default.item (i)
            end

            count := count + 1
            next.put (st, i)
            test.put (input, i)
        end
------------------------------------------------------------

    add_dot_transition (nxt : DFA_STATE) is
        -- On any input I am to make a transition to state `nxt'.

        require
            good_state : nxt /= void

        do
            dot_state := true
            dot_next  := nxt
        end
------------------------------------------------------------
feature { FAST_RE_MATCHER }-- Operation

    accept : BOOLEAN

    next_state (input : INTEGER) : DFA_STATE is
        -- Take input `input' and compute the state I am supposed to make a transition to.

        local
            i : INTEGER

        do
            if dot_state then
                result := dot_next
            else
                from
                    i := (input \\ modulus) + 1
                until
                    i = 0 or else test.item (i) = input
                loop
                    i := default.item (i)
                end

                if i > 0 then
                    result := next.item (i)
                end
            end
        end
------------------------------------------------------------


feature { NONE }

    dot_state   : BOOLEAN   -- Am i a "dot state"?
    dot_next    : DFA_STATE -- If I am a "dot state" this is the state I am supposed
                            -- to go to on _any_ input.
    modulus     : INTEGER
    count       : INTEGER
    next        : ARRAY [DFA_STATE] -- These are the possible successor states.
    test        : ARRAY [INTEGER]   -- And these the inputs that cause a transition.
    default     : ARRAY [INTEGER]

------------------------------------------------------------

    free_slot : INTEGER is

        require
            not_full : count < modulus

        do
            from
                result := 1
            until
                next.item (result) = void
            loop
                result := result + 1
            end
        end
------------------------------------------------------------

    expand is

        local
            m : INTEGER
            n : ARRAY [DFA_STATE]
            t : ARRAY [INTEGER]
            i : INTEGER

        do
            m := modulus
            n := next
            t := test 

            count   := 0
            modulus := 2 * modulus
            create next.make (1, modulus)
            create test.make (1, modulus)
            create default.make (1, modulus)

            from
                i := 1
            until
                i > m
            loop
                if n.item (i) /= void then
                    add_transition (n.item (i), t.item (i))
                end

                i := i + 1
            end
        end

end -- class DFA_STATE

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

indexing

description: "This concrete implementation of MATCHER is capable%
             % of searching for a regular expression. It uses a%
             % nondeterministic finite automaton (NFA).";
keywords: "regular expression", "NFA", "string matching";
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$";
  
class   RE_MATCHER

inherit
    MATCHER
        redefine
            build_automat, match_init, advance, accept, reset
    end

    EXCEPTIONS 
    end

creation
    make

feature { NONE }

    SYM_TOK   : INTEGER is unique   -- terminal symbol
    ALT_TOK   : INTEGER is unique   -- alternative '|'
    CLO_TOK   : INTEGER is unique   -- closure '*'
    LPA_TOK   : INTEGER is unique   -- left parenthesis '('
    RPA_TOK   : INTEGER is unique   -- right parenthesis ')'
    LBR_TOK   : INTEGER is unique   -- left bracket '['
    RBR_TOK   : INTEGER is unique   -- right bracket ']'
    DSH_TOK   : INTEGER is unique   -- dash '-'
    DOT_TOK   : INTEGER is unique   -- dot '.'
    EOP_TOK   : INTEGER is unique   -- end of pattern

    GRANULE   : INTEGER is 5

    token     : INTEGER
    sym       : INTEGER
    la_tok    : INTEGER             -- look ahead
    la_sym    : CHARACTER           --  "     "

    dot_ch    : INTEGER is -1
    null_ch   : INTEGER is 0
    scan      : INTEGER is -1

    input     : ARRAY [INTEGER]
    next1     : ARRAY [INTEGER]
    next2     : ARRAY [INTEGER]

    s         : STACK [INTEGER]
    q         : QUEUE [INTEGER]

    new_range : INTEGER             -- shift in range arrays
    rg_lower  : ARRAY [INTEGER]
    rg_upper  : ARRAY [INTEGER]

    lasti     : INTEGER             -- remember where last match was
    exit      : INTEGER             -- for back-patching
    accept    : BOOLEAN

-----------------------------------------------------------

    match_init is

        do
            lasti := 1
            shift := 1
        end
-----------------------------------------------------------

    advance is

        local
            t_ch : INTEGER
            p_ch : INTEGER
        do
            from
                accept := false

                if not s.empty then
                    clear_stack
                end

                if not q.empty then
                    clear_queue
                end
            until
                accept or else shift > t.count
            loop
                from
                    length := 0 
                    state  := start_s
                    q.add (scan)
                until
                    s.empty and then q.empty
                loop
                    if state = 0 then
                        length := shift - lasti

                    elseif state = scan then
                        shift := shift + 1
                        q.add (scan)

                    elseif input.item (state) = null_ch then
                        s.add (next1.item (state))

                        if next2.item (state) /= -1 then
                            s.add (next2.item (state))
                        end

                    elseif input.item (state) < dot_ch and then
                           shift <= t.count           then
                        p_ch := -input.item (state) - 1
                        t_ch := t.item (shift).code 

                        if t_ch >= rg_lower.item (p_ch) and then 
                           t_ch <= rg_upper.item (p_ch)     then
                            q.add (next1.item (state))
                        end

                    elseif input.item (state) = dot_ch and then
                           shift <= t.count                then
                        q.add (next1.item (state))

                    elseif shift <= t.count               and then 
                           input.item (state) =
                                    t.item (shift).code then 
                        q.add (next1.item (state)) 
                    else
                        -- empty statement
                    end

                    if not s.empty then
                        state := s.item
                        s.remove
                    else
                        state := q.item
                        q.remove
                    end
                end

                if length > 0 then
                    accept := true
                else
                    accept := false
                    lasti  := lasti + 1
                    shift  := lasti
                end
            end
        end
-----------------------------------------------------------

    reset is

        do
            lasti := lasti + 1
            shift := lasti
        end
-----------------------------------------------------------

    build_automat is

        do
            start_i := 1

            create input.make (1, 2 * p.count)
            create next1.make (1, 2 * p.count)
            create next2.make (1, 2 * p.count)
            create rg_lower.make (1, GRANULE)
            create rg_upper.make (1, GRANULE)

            new_range := 1

            init_scan

            state   := 1
            start_s := expression

            set_state (state, null_ch, 0, -1)

            optimize

            create q.make
            create s.make

            if token /= EOP_TOK then
                error_hdlr("Extra characters in pattern")
            end
        end
-----------------------------------------------------------

    set_state (st, ch, s1, s2 : INTEGER) is

        do
            input.put (ch, st)
            next1.put (s1, st)
            next2.put (s2, st)
        end
-----------------------------------------------------------

    back_patch (st, idx : INTEGER) is

        do
            next1.put (st, idx)
        end
-----------------------------------------------------------

    optimize is

        local
            i, j : INTEGER
        do
            from
                i := 1
            until
                i = state
            loop
                j := next1.item (i)

                if j > 0                     and then
                    input.item (j) = null_ch and then
                    next2.item (j) = -1          then
                    next1.put (next1.item (j), i)
                end

                j := next2.item (i)

                if j > 0                     and then
                    input.item (j) = null_ch and then
                    next2.item (j) = -1          then
                    next2.put (next1.item (j), i)
                end

                i := i + 1
            end
        end
-----------------------------------------------------------

    expression : INTEGER is

        local
            s1, s2 : INTEGER
        do
            from
                result := term
            until
                token /= ALT_TOK
            loop
                scan_advance
                s1     := result
                s2     := exit          -- exit from 'term' 
                result := state
                state  := state + 1

                set_state (result, null_ch, s1, expression)
                back_patch (state, exit)
                back_patch (state, s2)
                set_state (state, null_ch, state + 1, -1)
                exit  := state
                state := state + 1 
            end
        end
-----------------------------------------------------------

    term : INTEGER is

        local
            e : INTEGER
        do
            result := factor

            if token = SYM_TOK or else
               token = LPA_TOK or else
               token = LBR_TOK or else
               token = DOT_TOK    then
                e := exit
                back_patch (term, e)
            end
        end
-----------------------------------------------------------

    factor : INTEGER is

        do 
            inspect token
            when LPA_TOK then
                scan_advance
                result := expression

                if token = RPA_TOK then
                    scan_advance
                else
                    error_hdlr("Missing right parenthesis")
                end
            when SYM_TOK then
                result := state
                state  := state + 1
                set_state (result, sym, state, -1)
                exit := result
                scan_advance 
            when DOT_TOK then
                result := state
                state  := state + 1 
                set_state (result, dot_ch, state, -1)
                exit := result
                scan_advance
            when LBR_TOK then
                result := range 
            else
                error_hdlr("Syntax error")
            end

            if token = CLO_TOK then
                scan_advance
                set_state (state, null_ch, state + 1, result)
                result := state
                state  := state + 1
                back_patch (result, exit)
                exit   := result 
            end
        end
-----------------------------------------------------------

    range : INTEGER is

        do
            scan_advance     -- eat the '['

            if new_range > rg_lower.count then
                rg_lower.resize (1, rg_lower.count + GRANULE)
                rg_upper.resize (1, rg_upper.count + GRANULE)
            end

            rg_lower.put (sym, new_range)
            scan_advance
 
            if token = DSH_TOK then
                scan_advance    -- eat the '-'
            else
                error_hdlr("Missing dash")
            end

            rg_upper.put (sym, new_range)
            scan_advance
 
            if token = RBR_TOK then
                scan_advance    -- eat the ']'
            else
                error_hdlr("Missing right bracket")
            end
 
            new_range := new_range + 1 
 
            result := state
            state  := state + 1 
            set_state (result, -new_range, state, -1)
            exit := result
        end
-----------------------------------------------------------

    init_scan is

        do
            shift := 1

            if shift > p.count then
                la_tok := EOP_TOK
            else
                la_sym := p.item (shift)

                inspect la_sym
                when '|' then
                    la_tok := ALT_TOK
                when '*' then
                    la_tok := CLO_TOK
                when '(' then
                    la_tok := LPA_TOK
                when ')' then
                    la_tok := RPA_TOK
                when '[' then
                    la_tok := LBR_TOK
                when ']' then
                    la_tok := RBR_TOK
                when '-' then
                    la_tok := DSH_TOK
                when '.' then
                    la_tok := DOT_TOK
                when '\' then
                    shift  := shift + 1
                    la_sym := p.item (shift)
                    la_tok := SYM_TOK
                else
                    la_tok := SYM_TOK
                end
            end

            scan_advance
        end
-----------------------------------------------------------

    scan_advance is

        do
            token := la_tok
            sym   := la_sym.code

            shift := shift + 1

            if shift > p.count then
                la_tok := EOP_TOK
            else
                la_sym := p.item (shift)

                inspect la_sym
                when '|' then
                    la_tok := ALT_TOK
                when '*' then
                    la_tok := CLO_TOK
                when '(' then
                    la_tok := LPA_TOK
                when ')' then
                    la_tok := RPA_TOK
                when '[' then
                    la_tok := LBR_TOK
                when ']' then
                    la_tok := RBR_TOK
                when '-' then
                    la_tok := DSH_TOK
                when '.' then
                    la_tok := DOT_TOK
                when '\' then
                    shift  := shift + 1
                    la_sym := p.item (shift)
                    la_tok := SYM_TOK
                else
                    la_tok := SYM_TOK
                end
            end
        end
-----------------------------------------------------------

    clear_stack is

        do
            from
                s.remove
            until
                s.empty
            loop
                s.remove
            end
        end
-----------------------------------------------------------

    clear_queue is

        do
            from
                q.remove
            until
                q.empty
            loop
                q.remove
            end
        end
-----------------------------------------------------------

    error_hdlr (msg : STRING) is

        do
            raise ("re_mtch.build_automat")
        end
-----------------------------------------------------------

end -- class RE_MATCHER

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

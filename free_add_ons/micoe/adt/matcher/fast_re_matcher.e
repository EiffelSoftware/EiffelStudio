indexing

description: "This concrete implementation of MATCHER is capasble of%
             % searching for an extended regular expression: it accepts%
             % the metasymbols `|', `(', `)', `[', `]' and `-'. It uses%
             % a deterministic finite automaton (DFA) and is thus%
             % significantly faster than RE_MATCHER especially for long%
             % texts. It has a nontrivial setup time since building a%
             % DFA is costly.";
keywords: "extended regular expressions", "DFA", "string matching"
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"
  
class   FAST_RE_MATCHER  -- match regular expression using a dfa

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

    token     : INTEGER
    sym       : INTEGER
    la_tok    : INTEGER             -- look ahead
    la_sym    : CHARACTER           --  "     "

    Eof_sym   : INTEGER is 0
    Dot_sym   : INTEGER is 1

    lower     : ARRAY [INTEGER]
    upper     : ARRAY [INTEGER]
    occurs    : SORTED_LIST [INTEGER]
    followpos : ARRAY [SMALL_SORTED_SET [INTEGER]]
    start     : DFA_STATE

    new_pos   : INTEGER      
    lasti     : INTEGER             -- remember where last match was
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
            st : DFA_STATE

        do
            from
                accept := false
            until
                accept or else shift > t.count
            loop
                from
                    st := start
                until
                    st = void or else shift > t.count
                loop
                    if st.accept then
                        accept := true
                        length := shift - lasti
                    end

                    st    := st.next_state (t.item (shift).code)
                    shift := shift + 1
                end
 
                if shift > t.count and then
                   st /= void      and then
                   st.accept           then
                    accept := true
                    length := shift - lasti
                end

                if accept then 
                    shift  := lasti + length
                else
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

        local
            n1 : RE_NODE
            n2 : RE_NODE
            i  : INTEGER
            s  : SMALL_SORTED_SET [INTEGER]

        do
            create followpos.make (1, p.count + 1)
            create lower.make (1, p.count + 1)
            create upper.make (1, p.count + 1)
            create occurs.make (true)

            new_pos := 0

            from
                i := 1
            until
                i > followpos.count
            loop
                create s.make
                followpos.put (s, i)
                i := i + 1
            end

            init_scan
            n1 := expression

            if token /= EOP_TOK then
                error_hdlr("Extra characters in pattern")
            end

            new_pos := new_pos + 1
            create n2.make_leaf (new_pos)
            occurs.add (Eof_sym)
            lower.put (Eof_sym, new_pos)
            upper.put (Eof_sym, new_pos)
 
            compute_automat (make_cat_node (n1, n2).firstpos)
        end
-----------------------------------------------------------

    expression : RE_NODE is

        local
            n1, n2 : RE_NODE

        do
            from
                result := term
            until
                token /= ALT_TOK
            loop
                scan_advance
                n1 := result
                n2 := term
                create result.make_alt (n1, n2)
            end    
        end
-----------------------------------------------------------

    term : RE_NODE is

        local
            n1, n2 : RE_NODE
 
        do
            from
                result := factor
            until
                token /= SYM_TOK and then
                token /= LPA_TOK and then
                token /= LBR_TOK and then
                token /= DOT_TOK
            loop
                n1 := result
                n2 := factor
                result := make_cat_node (n1, n2)
            end
        end
-----------------------------------------------------------

    factor : RE_NODE is

        local
            n   : RE_NODE
            pos : INTEGER
            it  : ITERATOR

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
                new_pos := new_pos + 1
                create result.make_leaf (new_pos)
                lower.put (sym, new_pos)
                upper.put (sym, new_pos)
                occurs.add (sym)
                scan_advance

            when DOT_TOK then
                new_pos := new_pos + 1
                create result.make_leaf (new_pos)
                lower.put (Dot_sym, new_pos)
                upper.put (Dot_sym, new_pos)
                occurs.add (Dot_sym)
                scan_advance

            when LBR_TOK then
                result := range 

            else
                error_hdlr("Syntax error")
            end

            if token = CLO_TOK then
                scan_advance
                n := result
                create result.make_star (n)

                from
                    it := n.lastpos.iterator
                until
                    it.finished
                loop
                    pos := n.lastpos.item (it)
                    followpos.put (followpos.item (pos) + n.firstpos, pos)
                    it.forth
                end
            end
        end
-----------------------------------------------------------

    range : RE_NODE is

        local
            i : INTEGER

        do
            scan_advance     -- eat the '['

            new_pos := new_pos + 1
            lower.put (sym, new_pos)
            scan_advance
 
            if token = DSH_TOK then
                scan_advance    -- eat the '-'
            else
                error_hdlr("Missing dash")
            end

            upper.put (sym, new_pos)
            scan_advance
 
            if token = RBR_TOK then
                scan_advance    -- eat the ']'
            else
                error_hdlr("Missing right bracket")
            end
 
            create result.make_leaf (new_pos)

            from
                i := lower.item (new_pos)
            until
                i > upper.item (new_pos)
            loop
                occurs.add (i)
                i := i + 1
            end
        end
-----------------------------------------------------------

    make_cat_node (n1, n2 : RE_NODE) : RE_NODE is

        local
            pos : INTEGER
            it  : ITERATOR

        do
            create result.make_cat (n1, n2)

            from
                it := n1.lastpos.iterator
            until
                it.finished
            loop
                pos := n1.lastpos.item (it)
                followpos.put (followpos.item (pos) + n2.firstpos, pos)
                it.forth
            end
        end
-----------------------------------------------------------

    compute_automat (s : SMALL_SORTED_SET [INTEGER]) is

        local
            state_queue : QUEUE [DFA_STATE]
            set_queue   : QUEUE [SMALL_SORTED_SET [INTEGER]]
            state_table : SIMPLE_TABLE [DFA_STATE, SMALL_SORTED_SET [INTEGER]]
            s1, s2, u   : SMALL_SORTED_SET [INTEGER]
            st1, st2    : DFA_STATE
            it1, it2    : ITERATOR
            pos         : INTEGER
            ch          : INTEGER
            acpt        : BOOLEAN

        do
            create state_queue.make
            create set_queue.make
            create state_table.make (false)
            acpt := s.has (new_pos)
            create start.make (acpt)
            state_table.add (start, s)

            from
                state_queue.add (start)
                set_queue.add (s)
            until
                set_queue.empty
            loop
                st1 := state_queue.item
                s1  := set_queue.item
                state_queue.remove
                set_queue.remove

                from
                    it1 := occurs.iterator
                until
                    it1.finished
                loop
                    ch := occurs.item (it1)
                    create u.make

                    from
                        it2 := s1.iterator
                    until
                        it2.finished
                    loop
                        pos := s1.item (it2)

                        if lower.item (pos) <= ch and then
                           ch <= upper.item (pos)     then
                            u := u + followpos.item (pos)
                        end

                        it2.forth
                    end

                    state_table.search (u)

                    if state_table.found then
                        st2 := state_table.found_item
                    elseif u.count > 0 then
                        acpt := u.has (new_pos)
                        create st2.make (acpt)
                        state_table.add (st2, u)
                        state_queue.add (st2)
                        set_queue.add (u)
                    else
                        st2 := void
                    end

                    if st2 /= void then
                        if ch = Dot_sym then
                            st1.add_dot_transition (st2)
                        else
                            st1.add_transition (st2, ch)
                        end
                    end

                    it1.forth
                end
            end
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

    error_hdlr (msg : STRING) is

        do
            raise ("fast_re_matcher.build_automat")
        end
-----------------------------------------------------------

end -- class FAST_RE_MATCHER

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

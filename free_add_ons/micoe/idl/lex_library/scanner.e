indexing

description: "Generic scanner. Works with DFAs";
keywords: "Lex framework";
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"

deferred class SCANNER

inherit
    LEX_TOKENS;
    OBSERVER

feature

    token : INTEGER
        -- the current token
    look_ahead : INTEGER  
        -- the next token
    lexeme : STRING
        -- the current lexeme
    next_lexeme : STRING
        -- the look_ahead lexeme
    text : STRING
        -- Line of text token is in
    next_text : STRING
        -- Line of text look_ahead is in
    line : INTEGER
        -- line number for current token
    column : INTEGER
        -- Column number for the current token
    path : STRING
        -- Path of file for current token
 
    make (r : READER) is

        do
            read := r
            r.add_observer (current)
            build_dfa
            if r.has_text then
                restart
            end
        end
----------------------


    frozen advance is
        -- Go to next lexeme resp. token.

        local
            s    : STATE
            dfa  : INTEGER -- no. of current DFA
            stop : BOOLEAN

        do
            check
                reader_has_text : read.has_text
            end

            token  := look_ahead
            lexeme := next_lexeme
            line   := next_line
            column := next_col
            text   := next_text
            path   := next_path

            if read.end_of_text then
                look_ahead := End_of_text
            else
                from
                    look_ahead := Error_token
                    dfa        := 1
                    if dfa <= nr_dfa then
                        s := start.item (dfa)
                    end
                invariant
                    legal_dfa : dfa <= nr_dfa
                until
                    look_ahead /= Error_token or else stop
                loop
                    s := s.transition (read.input)

                    if s = fail then
                        if dfa >= nr_dfa then
                            stop := true
                        else 
                            dfa := dfa + 1 
                            s   := start.item (dfa )
                            read.return
                        end
                    elseif s.accept then
                        look_ahead := s.token

                        if s.put_back then
                            read.retreat
                        end

                        read.accept

                        if look_ahead = Space and then skip_space then
                            look_ahead := Error_token
                            dfa        := 1
                            s          := start.item (dfa)
                        end
                    else
                        read.advance
                        if read.end_of_text then
                            look_ahead := End_of_text
                        end
                    end -- if s = fail then ...
                end -- loop

                next_lexeme := read.lexeme 
                next_line   := read.line 
                next_col    := read.col
                next_text   := read.text 
                next_path   := read.path

                if look_ahead /= Error_token then
                    recompute_token
                end
            end -- if read.end_of_text then ...
        end -- advance
----------------------

    frozen character_value : CHARACTER is

        require
            right_token : token = Character_literal

        do
            if lexeme.count = 3 then
                result := lexeme.item (2)
            else
                inspect lexeme.item (3)

                when 'b' then
                    result := '%B'

                when 'n' then
                    result := '%N'

                when 'r' then
                    result := '%R'

                when 't' then
                    result := '%T'

                when '\' then
                    result := '\'

                else
                    -- Eiffel can't handle any other
                    -- special characters.
                end
            end
        end
----------------------

    frozen string_value : STRING is

        require
            right_token : token = String_literal

        do
            if lexeme.count >= 3 then
                result := lexeme.substring (2, lexeme.count - 1)
                result.prune_all ('\')
                    -- replace each \" with ".
            else
                result := ""
            end
        end
----------------------

    frozen integer_value : INTEGER is

        require
            right_token : token = Integer_literal

        do
            result := fmt.s2i (lexeme)
        end
----------------------

    frozen real_value : DOUBLE is

        require
            right_token : token = Real_literal

        do
            result := fmt.s2r (lexeme)
        end
----------------------

    frozen boolean_value : BOOLEAN is

        require
            right_token : token = Boolean_literal

        do
            if equal (lexeme, "TRUE") then
                result := true
            end
        end
----------------------

    frozen update (s : SUBJECT) is

        do
            restart
        end
----------------------
feature { NONE }

    fail  : STATE
        -- A void state
    nr_dfa     : INTEGER
        -- Number of DFAs; should always be <= start.count.
    start      : ARRAY [STATE]
        -- Start states of the individual DFAs
    read       : READER
        -- Reader supplying us a stream of input characters.
    skip_space : BOOLEAN
        -- Do we ignore white space?
    next_line  : INTEGER
        -- Line in which `next_lexeme' begins.
    next_col   : INTEGER
        -- Column in which `next_lexeme' begins.
    next_path  : STRING
        -- Path of file in which `next_lexeme' occurs.

----------------------

    frozen restart is

        require
            reader_known    : read /= void
            reader_has_text : read.has_text

        do
            next_line := 1
            next_col  := 1
            next_text := read.text
            from
                advance
            until
                lexeme /= void
            loop
                advance
            end
        end
----------------------

    build_dfa is

        do
            standard_build_dfa
            -- if you need some other dfa's
            -- redefine this routine and build them here.
            -- Otherwise you don't need to redefine this
            -- routine.
        end
----------------------

    frozen standard_build_dfa is

        do
            skip_space := true

            create start.make (1, 1)

            -- Handle white space.

            build_space_dfa

            -- Handle identifiers

            build_identifier_dfa

            -- Handle numeric constants.

            build_numeric_dfa

            -- Handle string constants.

            build_string_literal_dfa ('\')

            -- Handle character constants.

            build_character_literal_dfa ('\')
        end
----------------------

    recompute_token is

        do
            standard_recompute_token
        end
----------------------

    frozen standard_recompute_token is

        local
            ident : STRING

        do
           if look_ahead = Identifier then
               ident := clone (next_lexeme)
               ident.to_lower

               if keywords /= void and then
                  keywords.has (ident) then
                   look_ahead := keywords.at (ident)
               end
           else
               -- it's not a keyword; leave it alone
           end
        end
----------------------

    keywords : DICTIONARY [INTEGER, STRING] is

        deferred
        end
----------------------

    build_space_dfa is

        local
            s1  : SPACE_STATE
            s2  : SPACE_STATE
            as1 : ACCEPTING_STATE

        do
            nr_dfa := nr_dfa + 1
            if nr_dfa > start.count then
                start.resize (1, nr_dfa)
            end
            create as1.make (true, Space)
            create s2.make (void, as1)
            s2.set_yes_state (s2)
            create s1.make (s2, fail) 
            start.put (s1, nr_dfa)
        end
----------------------

    build_identifier_dfa is

        local
            al  : ALPHA_STATE
            an  : ALPHANUM_STATE
            as1 : ACCEPTING_STATE

        do
            nr_dfa := nr_dfa + 1
            if nr_dfa > start.count then
                start.resize (1, nr_dfa)
            end
            create as1.make (true, Identifier)
            create an.make (void, as1)
            an.set_yes_state (an)
            create al.make (an, fail)
            start.put (al, nr_dfa)
        end
----------------------

    build_multicharacter_dfa (chars : ARRAY [CHARACTER];
                              toks  : ARRAY [INTEGER]) is

        require
            match : toks.lower = chars.lower and
                    toks.upper = chars.upper

        local
            ms  : MULTI_STATE
            as1 : ACCEPTING_STATE
            sa  : ARRAY [STATE]
            i   : INTEGER

        do
            nr_dfa := nr_dfa + 1
            if nr_dfa > start.count then
                start.resize (1, nr_dfa)
            end
            from
                create sa.make (1, chars.count)
                i := chars.lower
            until
                i > chars.upper
            loop
                create as1.make (false, toks.item (i))
                sa.put (as1, i)
                i := i + 1
            end

            create ms.make (chars, sa, fail)
            start.put (ms, nr_dfa)
        end
----------------------

    build_two_character_dfa (ch1, ch2 : CHARACTER; tok1, tok2 : INTEGER) is
        -- Useful for tokens like "->" built of two distinct characters of
        -- which the first might be a token in its own right. Return token
        -- `tok1' if only `ch1' occurs and `tok2' if both `ch1 and `ch2' occur.

        local
            sc1 : SINGLE_CHAR_STATE
            sc2 : SINGLE_CHAR_STATE
            as1 : ACCEPTING_STATE
            as2 : ACCEPTING_STATE

        do
            nr_dfa := nr_dfa + 1
            if nr_dfa > start.count then
                start.resize (1, nr_dfa)
            end
            create as1.make (true, tok1)
            create as2.make (false, tok2)
            create sc2.make (ch2, as2, as1)
            create sc1.make (ch1, sc2, fail)
            start.put (sc1, nr_dfa)
        end
----------------------

    build_double_character_dfa (ch : CHARACTER; tok1, tok2 : INTEGER) is
        -- Return token `tok1' if character 'ch' occurs only once.
        -- Return token `tok2' if character `ch' occurs twice.

        local
            sc1 : SINGLE_CHAR_STATE
            sc2 : SINGLE_CHAR_STATE
            as1 : ACCEPTING_STATE
            as2 : ACCEPTING_STATE

        do
            nr_dfa := nr_dfa + 1
            if nr_dfa > start.count then
                start.resize (1, nr_dfa)
            end
            create as1.make (true, tok1)
            create as2.make (false, tok2)
            create sc2.make (ch, as2, as1)
            create sc1.make (ch, sc2, fail)
            start.put (sc1, nr_dfa)
        end
----------------------

    build_string_literal_dfa (esc : CHARACTER) is
        -- `esc' can be used to escape a quote '"'
        -- inside a string. In IDL and C++ esc is \
        -- and in Eiffel it is %.

        local
            sc1 : SINGLE_CHAR_STATE
            ms1 : MULTI_STATE
            sc2 : SINGLE_CHAR_STATE
            as1 : ACCEPTING_STATE

        do
            nr_dfa := nr_dfa + 1
            if nr_dfa > start.count then
                start.resize (1, nr_dfa)
            end
            create as1.make (false, String_literal)
            create sc2.make ('"', void, fail)
            create ms1.make (<<'"', esc>>, <<as1, sc2>>, void)
            ms1.set_alternate (ms1)
            sc2.set_yes_state (ms1)
            create sc1.make ('"', ms1, fail)
            start.put (sc1, nr_dfa)
        end
----------------------

    build_character_literal_dfa (esc : CHARACTER) is
        -- `esc' can be used to escape nonprintable characters
        -- such as newline, etc. In IDL and C++ `esc' is \
        -- and in Eiffel it is %.

        local
            sc1 : SINGLE_CHAR_STATE
            ms  : MULTI_STATE
            sc2 : SINGLE_CHAR_STATE
            acs : ANY_CHAR_STATE
            as1 : ACCEPTING_STATE

        do
            nr_dfa := nr_dfa + 1
            if nr_dfa > start.count then
                start.resize (1, nr_dfa)
            end
            create as1.make (false, Character_literal)
            create sc2.make ('%'', as1, fail)
            create acs.make (sc2)
            create ms.make (<<'%'', esc>>, <<fail, acs>>, sc2)
            create sc1.make ('%'', ms, fail)
            start.put (sc1, nr_dfa)
        end
----------------------

    build_numeric_dfa is

         local
             dm1 : DIGIT_MINUS_STATE
             dm2 : DIGIT_MINUS_STATE
             dd1 : DIGIT_DOT_STATE
             dd2 : DIGIT_DOT_STATE
             as1 : ACCEPTING_STATE

         do
             nr_dfa := nr_dfa + 1
             if nr_dfa > start.count then
                 start.resize (1, nr_dfa)
             end
             create as1.make (true, Real_literal)
             create dd2.make (void, fail, as1)
             dd2.set_digit_state (dd2)
             create as1.make (true, Integer_literal)
             create dd1.make (void, dd2, as1)
             dd1.set_digit_state (dd1)
             create as1.make (true, Minus_token)
             create dm2.make (dd1, fail, as1)
             create dm1.make (dd1, dm2, fail)
             start.put (dm1, nr_dfa)
         end
----------------------

    fmt : FORMAT is

        once
            create result
        end

end -- class SCANNER

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

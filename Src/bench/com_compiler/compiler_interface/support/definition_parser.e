indexing
    description: "Simple parser to parse Eiffel class text to retrieve a formatted expression or class"
    date: "$Date$"
    revision: "$Revision$"

class
    DEFINITION_PARSER
    
create
    make

feature {NONE} -- Initialization

    make is
            -- creation routine
        do
            reset_state
        end

feature -- Basic Operations

    parse (str: STRING; row, col: INTEGER) is
            -- parse string `str' to locate symbol at position `n' .
        require
            non_void_str: str /= Void
            valid_str: not str.is_empty
            row_big_enough: row > 0
            col_big_enough: col > 0
        local
            formatted_str: STRING
            formatted_prev_str: STRING
            complete_string: BOOLEAN
            parse_res: STRING
            i: INTEGER
            lines: LIST [STRING]
            parsed_feature: RX_PCRE_MATCHER
            cap_str: STRING
        do
            is_class := False
            is_feature_call := False
            parse_successful := False
            parsed_result := Void
            call_type := standard_call
            
            lines := str.split ('%N')
            lines.go_i_th (row)
            if not lines.last.is_equal (lines.item) then
                from
                    lines.forth
                until
                    lines.after
                loop
                    lines.remove            
                end
            end
            
            -- remove trailing garbage from position `n' to end of string `str'
            parse_res := lines.last
            from
                i := col
            until
                i > parse_res.count
            loop
                if not parse_res.item (i).is_alpha and not parse_res.item (i).is_digit and parse_res.item (i) /= '_' then
                    if i >= 1 then
                        if parse_res.count > 1 then
                            parse_res := parse_res.substring (1, i - 1)
                        else
                            create parse_res.make_empty
                        end
                    else
                        create parse_res.make_empty
                    end
                    i := parse_res.count + 1
                else
                    i := i + 1
                end
            end
            
            check
                non_void_parse_res: parse_res /= Void
            end
            
            lines.finish
            lines.replace (parse_res)
            if not parse_res.is_empty then
                create parse_res.make_empty
    
                -- process formatted string
                from
                    complete_string := False
                until
                    complete_string = True or lines.is_empty
                loop
                    -- check previous lines for trailing '.' and current line for leading '.' or '{',
                    -- which denotes continuation of expression
                    if lines.count >= 2 then
                        formatted_prev_str := prune_redundant_whitespace (lines.i_th (lines.count - 1))
                        formatted_str := prune_redundant_whitespace (lines.last)
                        if (not formatted_str.is_empty and formatted_str.item (1) = '.') or 
                                (not formatted_str.is_empty and formatted_str.item (1) = '}') or 
                                (not formatted_prev_str.is_empty and formatted_prev_str.item (formatted_prev_str.count) = '.') then
                            parse_res.prepend (lines.last)
                            lines.finish
                            lines.remove
                        end
                    end
                    parse_res.prepend (lines.last)
    
                    -- check current parse string for completness
                    reset_state
                    formatted_str := format_string (parse_res)
                    if not formatted_str.is_empty then
                        complete_string := is_string_complete (formatted_str)                       
                    end
    
                    lines.finish
                    lines.remove
                end
            
                parse_successful := True
                parsed_result := retrieve_final_string (parse_res)
                
                -- set flags to indicate a class or feature
                if parsed_result.index_of ('.', 1) > 0 then
                    is_feature_call := True
                else
                    if not is_class then
                        is_class := True
                        from
                            i := 1
                        until
                            i > parsed_result.count or
                            is_class = False
                        loop
                            if parsed_result.item (i).is_lower then
                                is_class := False
                                is_feature_call := True
                            end
                            i := i + 1
                        end
                    end
                end 
                
                -- retrieve feature name and return type of parsed feature
                if not is_class then
                    create parsed_feature.make
                    parsed_feature.compile ("^[ \t]*([a-zA-Z][a-zA-Z0-9_]*)[ \t]*.*[ \t)]*is[ \t]*$")
                    from
                        lines.finish
                    until
                        lines.before or parsed_result_feature /= Void
                    loop
                        lines.item.replace_substring_all ("%R", "")
                        if (parsed_feature.matches (lines.item)) then
                            parsed_result_feature := clone (parsed_feature.captured_substring (1))
                            cap_str := clone (parsed_feature.captured_substring (0))
                            create parsed_feature.make
                            parsed_feature.compile (":[ \t]*([a-zA-Z][a-zA-Z0-9_]*)[ \t]*is[ \t]*$")
                            if (parsed_feature.matches (cap_str)) then
                                parsed_result_return_type := parsed_feature.captured_substring (1)
                            end
                        end
                        lines.back
                    end
                    -- if there is no feature declaration then we must be in `convert' clause
                    if parsed_result_feature = Void then
                        create parsed_feature.make
                        parsed_feature.compile ("^[ \t]*[cC][oO][nN][vV][eE][rR][tT][ \t]*")
                        from
                            lines.finish
                        until
                            lines.before or parsed_result_feature /= Void
                        loop
                            if (parsed_feature.matches (lines.item)) then
                                parsed_result_feature := "convert"
                            end
                            lines.back
                        end
                    end
                end
            end
        ensure
            non_void_parsed_result: parsed_result /= Void
        end
        
    extract_feature_name_from_text (class_text: STRING; target_row, target_col: INTEGER): STRING is
            -- extract a feature name from `class_text'
        require
            non_void_class_text: class_text /= Void
            valid_class_text: not class_text.is_empty
            valid_target_row: target_row >= 1
            valid_target_col: target_col >= 1
        local
            lines: LIST [STRING]
            line: STRING
            i: INTEGER
        do
            lines := class_text.split ('%N')
            if target_row <= lines.count then
                line := lines.i_th (target_row)
                if not line.is_empty then
                    -- remove trailing garbage from position `target_col' to end of string `str'
                    from
                        i := target_col
                    until
                        i > line.count
                    loop
                        if not line.item (i).is_alpha and not line.item (i).is_digit and line.item (i) /= '_' then
                            if i >= 1 then
                                if line.count > 1 then
                                    line := line.substring (1, i - 1)
                                else
                                    create line.make_empty
                                end
                            else
                                create line.make_empty
                            end
                            i := line.count + 1
                        else
                            i := i + 1
                        end
                    end
                    from
                        i := line.count
                    until
                        i = 0
                    loop
                        if not line.item (i).is_alpha and not line.item (i).is_digit and line.item (i) /= '_' then
                            if line.count > i then
                                line := line.substring (i + 1, line.count)
                            else
                                create line.make_empty
                            end
                            i := 0
                        else
                            i := i - 1
                        end
                    end
                    
                    Result := line
                end
            end     
        end
        
feature -- Access

    is_class: BOOLEAN
            -- was parsed result a class symbol?
            
    is_feature_call: BOOLEAN
            -- was parsed result a feature call symbol?
            
    parse_successful: BOOLEAN
            -- was parse successful?
            
    parsed_result: STRING
            -- result of parse
            
    parsed_result_feature: STRING
            -- feature name of `parsed_result'

    parsed_result_return_type: STRING
            -- feature return type of `parsed_result'
    
    call_type: INTEGER
            -- type of parsed call
    
    standard_call,
    creation_call,
    static_call,
    precursor_call: INTEGER is unique
            -- types of call
    
    
feature {NONE} -- Formatting

    format_string (str: STRING): STRING is
            -- format `str' reading RTL
        require
            non_void_str: str /= Void
            valid_str: not str.is_empty
        local
            i: INTEGER
        do
            Result := prune_redundant_whitespace (str)

            -- Prune trailing illegal identifier characters
            from
                i := Result.count
            until
                i = 0 or
                Result.item (i).is_alpha or
                Result.item (i).is_digit or
                Result.item (i) = '_'
            loop
                i := i - 1
            end
            if i > 0 then
                Result := Result.substring (1, i)
            else
                create Result.make_empty
            end
        ensure
            non_void_result: Result /= Void
        end

    retrieve_final_string (str: STRING): STRING is
            -- retrieve final string for simple parsing
        local
            final_str: STRING
            i: INTEGER
            was_in_quote: BOOLEAN
            was_in_parenthesis: BOOLEAN
        do
            reset_state
            final_str := format_string (str)
            create Result.make_empty
            from
                i := final_str.count
            until
                i = 0 or can_stop
            loop
                was_in_quote := is_in_quote
                was_in_parenthesis := is_in_parenthesis
                inspect_char (final_str.item (i))
                if not is_in_parenthesis and not was_in_parenthesis and not is_in_quote and not was_in_quote then
                    if not ignore_stop_char then
                        Result.prepend_character (final_str.item (i))
                    end
                end
                i := i - 1
            end
        ensure
            non_void_result: Result /= Void
        end

feature {NONE} -- Inspection and Processing

    inspect_char (char: CHARACTER) is
            -- inspect `char' and process
        require
            non_void_char: char /= Void
            non_void_last_word: last_word /= Void
        local
            word_delim: BOOLEAN
            unprocessed: BOOLEAN
        do
            inspect char
            when '%%' then
                if last_char /= Void then
                    -- will reset "' etc.
                    inspect_char (last_char)
                end
            when '%"' then
                is_in_double_quote := not is_in_double_quote
            when '%'' then
                is_in_single_quote := not is_in_single_quote
            when ')' then
                if not is_in_quote then
                    parenthesis_count := parenthesis_count + 1
                    word_delim := True
                end
            when '}' then
                if not is_in_quote then
                    brases_count := brases_count + 1
                    word_delim := True
                end
            when ']' then
                if not is_in_quote then
                    tuple_count := tuple_count + 1
                    word_delim := True
                end
            when '(' then
                if parenthesis_count > 0 and not is_in_quote then
                    parenthesis_count := parenthesis_count - 1
                    word_delim := True
                else
                    ignore_stop_char := True
                    word_delim := True
                    can_stop := True
                end
            when '{' then
                if brases_count = 0 and not is_in_quote and not is_in_parenthesis and not is_in_array and not is_in_tuple then
                    can_stop := True
                    is_class := True
                    ignore_stop_char := True
                elseif brases_count > 0 and not is_in_quote  then
                    brases_count := brases_count - 1
                    word_delim := True
                end
            when '[' then
                if tuple_count > 0 and not is_in_quote then
                    tuple_count := tuple_count - 1
                    word_delim := True
                else
                    ignore_stop_char := True
                    word_delim := True
                    can_stop := True
                end
            when '>' then
                if last_char = '>' and not is_in_quote then
                    array_count := array_count + 1
                    word_delim := True
                end
            when '<' then
                if array_count > 0 and last_char = '<' and not is_in_quote then
                    array_count := array_count - 1
                    word_delim := True
                end
            when ',' then
                if not is_in_quote and not is_in_parenthesis and not is_in_brases and not is_in_tuple and not is_in_array then
                    can_stop := True
                    ignore_stop_char := True
                end
                if not is_in_quote then
                    word_delim := True
                end
            when ':' then
                if not is_in_quote and not is_in_parenthesis and not is_in_brases and not is_in_tuple and not is_in_array then
                    if last_char /= '=' then
                        can_stop := True
                        ignore_stop_char := True
                        is_class := True                        
                    end
                end
                if not is_in_quote and last_char /= '=' then
                    word_delim := True
                end
            when '.' then
                if not is_in_quote then
                    word_delim := True
                end
            when ' ' then
                if not is_in_quote then
                    word_delim := True
                    if last_char /= '{' and not is_in_parenthesis and not is_in_brases and not is_in_array and not is_in_tuple then
                        can_stop := True
                        ignore_stop_char := True
                    end
                end
            else
                if not is_in_quote then
                    -- build last_word string to process
                    last_word.prepend_character (char)
                    unprocessed := True
                end
            end

            if unprocessed then
                -- process common characters
                if common_operators.has (char) then
                    if not is_in_quote and not is_in_parenthesis and not is_in_brases and not is_in_tuple and not is_in_array then
                        can_stop := True
                        ignore_stop_char := True
                        word_delim := True
                        last_word.keep_tail (last_word.count - 1)
                    end
                end
            end

            if word_delim then
                -- set `last_word'
                if not last_word.is_empty then
                    inspect_word (last_word)
                    create last_word.make_empty
                end
            end

            -- set last char
            last_char := char
        end

    inspect_word (word: STRING) is
            -- inspect `word'
        require
            non_void_word: word /= Void
            valid_word: not word.is_empty
        local
            lwr_word: STRING
        do
            lwr_word := clone (word)
            lwr_word.to_lower
            
            if lwr_word.is_equal ("create") then
                call_type := creation_call
                can_stop := True
            elseif lwr_word.is_equal ("feature") then
                call_type := static_call
                can_stop := True
            elseif lwr_word.is_equal ("precursor") then
                call_type := precursor_call
                can_stop := True
            end
        end

feature -- Removal

    prune_redundant_whitespace (str: STRING): STRING is
            -- remove unneeded whitespace characters
        require
            non_void_str: str /= Void
            valid_str: not str.is_empty
        local
            i: INTEGER
        do
            Result := clone (str)

            -- Remove all %T and double spaces
            from
                i := 0
            until
                i = Result.count
            loop
                i := Result.count
                Result.replace_substring_all ("%T", " ")
                Result.replace_substring_all ("  ", " ")
            end
            Result.replace_substring_all ("( ", "(")
            Result.replace_substring_all (" )", ")")
            Result.replace_substring_all ("{ ", "{")
            Result.replace_substring_all (" }", "}")
            Result.replace_substring_all ("[ ", "[")
            Result.replace_substring_all (" ]", "]")
            Result.replace_substring_all ("<< ", "<<")
            Result.replace_substring_all (" >>", ">>")
            Result.replace_substring_all (" (", "(")
            Result.replace_substring_all (") ", ")")
            Result.replace_substring_all (" {", "{")
            Result.replace_substring_all ("{", " {") -- this ensures we have as ' ' between create {...} etc.
            Result.replace_substring_all ("} ", "}")
            Result.replace_substring_all (" [", "[")
            Result.replace_substring_all ("] ", "]")
            Result.replace_substring_all (" <<", "<<")
            Result.replace_substring_all (">> ", ">>")
            Result.replace_substring_all (" .", ".")
            Result.replace_substring_all (". ", ".")
            Result.prune_all ('%R')
            Result.prune_all_leading (' ')
            Result.prune_all_trailing (' ')
        ensure
            non_void_result: Result /= Void
        end

feature {NONE} -- State Setting

    reset_state is
            -- reset internal state
        do
            is_in_double_quote := False
            is_in_single_quote := False
            parenthesis_count := 0
            brases_count := 0
            tuple_count := 0
            array_count := 0
            can_stop := False
            ignore_stop_char := False
            last_char := '%%'
            parsed_result := Void
            parsed_result_feature := Void
            parsed_result_return_type := Void
            create last_word.make_empty
        end

feature {NONE} -- Implementation

    is_string_complete (str: STRING): BOOLEAN is
            -- determins is `str' is considered a complete expression, or at least the start of
            -- a complete expression
        require
            non_void_str: str /= Void
            valid_str: not str.is_empty
        local
            i: INTEGER
        do
            from
                i := str.count
            until
                i = 0 or
                can_stop
            loop
                inspect_char (str.item (i))
                i := i - 1
            end

            -- now check all matching pair of parenthsis.
            -- If there aren't matches then retrieve the previous buffer line up
            Result := not (is_in_quote or is_in_parenthesis or is_in_brases or is_in_tuple or is_in_array) and can_stop
        end

    is_in_double_quote: BOOLEAN
            -- is processing in ""?

    is_in_single_quote: BOOLEAN
            -- is processing in ''?

    is_in_quote: BOOLEAN is
            -- is processing in quotes
        do
            Result := is_in_single_quote or is_in_double_quote
        end

    is_in_parenthesis: BOOLEAN is
            -- is processing in ()?
        do
            Result := parenthesis_count > 0
        end

    is_in_brases: BOOLEAN is
            -- is processing in {}?
        do
            Result := brases_count > 0
        end

    is_in_tuple: BOOLEAN is
            -- is processing in []?
        do
            Result := tuple_count > 0
        end

    is_in_array: BOOLEAN is
            -- is processing in <<>>
        do
            Result := array_count > 0
        end

    last_char: CHARACTER
            -- last character processed

    last_word: STRING
            -- last word processed

    parenthesis_count: INTEGER
            -- number of nested parenthesis

    brases_count: INTEGER
            -- number of nested brases

    tuple_count: INTEGER
            -- number of nested tuples

    array_count: INTEGER
            -- number of nested arrays

    can_stop: BOOLEAN
            -- can processing stop because there is enough information available?

    ignore_stop_char: BOOLEAN
            -- should char which set `can_stop' to True be ignored

    common_operators: ARRAYED_LIST [CHARACTER] is
            -- array or common character Eiffel uses for operators
        once
            create Result.make (11)
            Result.compare_objects
            Result.extend ('@')
            Result.extend ('$')
            Result.extend ('^')
            Result.extend ('&')
            Result.extend ('/')
            Result.extend ('\')
            Result.extend ('-')
            Result.extend ('=')
            Result.extend ('+')
            Result.extend ('*')
            Result.extend (';')
        ensure
            non_void_result: Result /= Void
        end

end -- class DEFINITION_PARSER


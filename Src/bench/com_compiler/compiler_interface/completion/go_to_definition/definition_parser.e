indexing
	description: "Simple parser to parse Eiffel class text to retrieve a formatted expression or class"
	date: "$Date$"
	revision: "$Revision$"

class
	DEFINITION_PARSER
	
create
	default_create

feature -- Basic Operations

	parse (class_text: STRING; row, col: INTEGER): DEFINITION_PARSED_RESULT is
			-- parse class text `class_text' to find a definition for a feature or class located at position (`row', `col')
		require
			non_void_class_text: class_text /= Void
			valid_class_text: not class_text.is_empty
			row_big_enough: row > 0
			col_big_enough: col > 0
		local
			retried: BOOLEAN
		do
			if not retried then
				create parsed_result.make (class_text, row, col)
				retrieve_complete_definition
				retrieve_feature_name_and_return_type
				
				Result := parsed_result
			end
		rescue
			retried := True
			retry
		end
		
	extract_feature_name_from_text (class_text: STRING; row, col: INTEGER): DEFINITION_PARSED_RESULT is
			-- extract a feature name from `class_text'
		require
			non_void_class_text: class_text /= Void
			valid_class_text: not class_text.is_empty
			row_big_enough: row > 0
			col_big_enough: col > 0
		local
			retried: BOOLEAN
			final_text: STRING
		do
			if not retried then
				create parsed_result.make (class_text, row, col)
				final_text := retrieve_final_string (parsed_result.lines.last)
				parsed_result.set_parse_successful (True)
				parsed_result.set_parsed_result_string (final_text)
				Result := parsed_result
			end
		rescue
			retried := True
			retry
		end
		
feature {NONE} -- Parse operations

	retrieve_complete_definition is
			-- retrieve complete expression for defintion located on last line of `lines' as column `col'
		require
			non_void_parsed_result: parsed_result /= Void
		local
			parse_res: STRING
			formatted_prev_str: STRING
			formatted_str: STRING
			lines: LIST [STRING]
			done: BOOLEAN
		do
			create parse_res.make_empty
			lines := parsed_result.lines

			from
			until
				done = True or lines.is_empty
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
				formatted_str := format_string (parse_res)
				if not formatted_str.is_empty then
					done := is_expression_complete (formatted_str)					   
				end

				lines.finish
				lines.remove
			end
			
			if done then
				formatted_str := retrieve_final_string (parse_res)
				parsed_result.set_parsed_result_string (formatted_str)
				parsed_result.set_parse_successful (True)
			else
				parsed_result.set_parse_successful (False)
			end
		end
	
	retrieve_feature_name_and_return_type is
			-- retrieve feature name and return type of parsed feature
		require
			non_void_parsed_result: parsed_result /= Void
			valid_parsed_result: parsed_result.parse_successful
		local
			rx_feature: RX_PCRE_MATCHER
			cap_str: STRING
			lines: LIST [STRING]
		do
			if not parsed_result.parsed_result_is_class then
				lines := parsed_result.lines
				create rx_feature.make
				rx_feature.compile ("^[ \t]*([a-zA-Z][a-zA-Z0-9_]*)[ \t]*.*[ \t)]*is[ \t]*$")
				from
					lines.finish
				until
					lines.before or parsed_result.parsed_result_containing_feature /= Void
				loop
					lines.item.replace_substring_all ("%R", "")
					if (rx_feature.matches (lines.item)) then
						parsed_result.set_parsed_result_containing_feature (rx_feature.captured_substring (1))
						parsed_result.set_parsed_result_containing_feature_row (lines.index)
						cap_str := clone (rx_feature.captured_substring (0))
						
						create rx_feature.make
						rx_feature.compile (":[ \t]*([a-zA-Z][a-zA-Z0-9_]*)[ \t]*is[ \t]*$")
						if (rx_feature.matches (cap_str)) then
							parsed_result.set_parsed_result_containing_feature_return_type (rx_feature.captured_substring (1))
						end
					end
					lines.back
				end
			end
		end
	
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
			-- retrieve final string from `str' for simple parsing
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
			-- inspect `char' and process it
		require
			non_void_char: char /= Void
			non_void_last_word: last_word /= Void
			non_void_parsed_result: parsed_result /= Void
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
					parsed_result.set_parsed_result_is_class (True)
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
						parsed_result.set_parsed_result_is_class (True)						
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
			lwr_word := word.as_lower
			
			if lwr_word.is_equal ("create") then
				can_stop := True
			elseif lwr_word.is_equal ("feature") then
				can_stop := True
			elseif lwr_word.is_equal ("precursor") then
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
			create last_word.make_empty
		end
	
feature {NONE} -- Implementation

	is_expression_complete (str: STRING): BOOLEAN is
			-- determins is `str' is considered a complete expression, or at least the start of
			-- a complete expression
		require
			non_void_str: str /= Void
			valid_str: not str.is_empty
		local
			i: INTEGER
		do
			reset_state
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

	parsed_result: DEFINITION_PARSED_RESULT
			-- parsed result
	
end -- class DEFINITION_PARSER
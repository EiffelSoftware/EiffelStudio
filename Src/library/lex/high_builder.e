indexing

	description:
		"Mechanisms for building lexical analyzers from regular expressions. %
		%This class may be used as ancestor by classes needing its facilities.";

	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class HIGH_BUILDER inherit

	LEX_BUILDER
		export
			{ANY} store_analyzer, retrieve_analyzer
		end

	BASIC_ROUTINES
		export
			{NONE} ALL
		undefine
			setup, consistent, copy, is_equal
		end

create

	make, make_extended

feature -- Element change

	put_nameless_expression (s: STRING; n: INTEGER) is
			-- Record the regular expression described
			-- by `s', and associate it with token type `n'.
		require
			source_long_enough: s.count > 0
		do
			description := clone (s);
			description.extend ('%/001/');
			remove_separators;
			cursor := 0;
			if not parsing_stopped then
				build_sequence ('%/001/')
			end;
			if not parsing_stopped then
				select_tool (last_created_tool);
				associate (last_created_tool, n)
			end
		end; 

	build_dollar_any is
			-- Build $., matching any character.
		require
			good_first_character: description.item (cursor) = '.'
		do
			any_character
		end; 

	build_dollar_p is
			-- Build $P, matching any printable character.
		require
			good_first_character: description.item (cursor) = 'P'
		do
			any_printable
		end; 

	build_dollar_b is
			-- Build $B, matching any number of break characters:
			-- blank, new-line, tabulation, carriage-return.
		do
			interval (' ', ' ');
			interval ('%T', '%T');
			interval ('%F', '%F');
			interval ('%N', '%N');
			union (last_created_tool - 3, last_created_tool)
		end; 

	build_dollar_n is
			-- Build $N, matching natural integer constants.
			-- +('0'..'9')
		do
			interval ('0', '9');
			iteration1 (last_created_tool);
			dollar_n := last_created_tool
		end; 

	build_dollar_z is
			-- Build $Z, matching possibly signed integer constants.
			-- ['+' | '-'] +('0'..'9')
		do
			if dollar_n = 0 then
				build_dollar_n
			end;
			interval ('+', '+');
			interval ('-', '-');
			union2 (last_created_tool - 1, last_created_tool);
			prepend_optional (last_created_tool, dollar_n);
			dollar_z := last_created_tool
		end; 

	build_dollar_r is
			-- Build $R, matching floating point constants.
			-- ['+' | '-'] +('0'..'9') '.' *('0'..'9') ['e' | 'E' ['+' | '-']
			-- +('0'..'9')]
		do
			if dollar_z = 0 then
				build_dollar_z
			end;
			interval ('.', '.');
			append (dollar_z, last_created_tool);
			dollar_r := last_created_tool;
			interval ('0', '9');
			iteration (last_created_tool);
			append (dollar_r, last_created_tool);
			dollar_r := last_created_tool;
			interval ('e', 'e');
			interval ('E', 'E');
			union2 (last_created_tool - 1, last_created_tool);
			append (last_created_tool, dollar_z);
			append_optional (dollar_r, last_created_tool);
			dollar_r := last_created_tool
		end 

feature -- Implementation

	description: STRING;
			-- Description of the regular expression
			
	cursor: INTEGER;
			-- Position in description.

feature {NONE} -- Implementation


	description_length: INTEGER;
			-- Length of description.

	parsing_stopped: BOOLEAN;
			-- Is the parsing stopped?

	current_char: CHARACTER;
			-- Character.

	last_string: STRING;
			-- String used in `action_set_word' and `action_up_to'.

	build_sequence (end_sequence: CHARACTER) is
			-- Build the tool corresponding to the next sequence
			-- in description.
		local
			former_tool: INTEGER
		do
			--| Cursor on the opening character ('(', '[',..).
			from
				cursor := cursor + 1;
				build_tool
			until
				description.item (cursor) = end_sequence
			 			or else parsing_stopped
			loop
				former_tool := last_created_tool;
				if description.item (cursor) = '|' then
					cursor := cursor + 1;
					build_tool;
					if not parsing_stopped then
						union2 (former_tool, last_created_tool)
					end
				else
					build_tool;
					if not parsing_stopped then
						append (former_tool, last_created_tool)
					end
				end
			end;
			if description.item (cursor) /= end_sequence and then
					not parsing_stopped then
				raise_error (cursor, end_sequence, "")
			end
		ensure
			cursor_on_end_sequence: parsing_stopped or else
				description.item (cursor) = end_sequence
		end; 

	build_tool is
			-- Build the tool corresponding to the current
			-- position in description.
		require
			parsing_not_stopped: not parsing_stopped
		do
			current_char := description.item (cursor);
			inspect current_char
			when '(' then
				action_parenthesis
			when '%'' then
				action_quote
			when '[' then
				action_bracket
			when '*' then
				action_star
			when '+' then
				action_plus
			when '-' then
				action_up_to
			when '"' then
				action_set_word
			when '$' then
				action_dollar
			when '~' then
				action_tilde
			when '0'..'9' then
				action_digit
			else
				if current_char = '%/001/' then
					raise_error (cursor, '%U',
							"Missing character at the end of description.")
				else
					raise_error (cursor, '%U', "Unexpected character.")
				end
			end
			--| Cursor has to be on the next regular expression.
		end; 

	action_parenthesis is
			-- Build the sequence included in parenthesis.
		require
			good_first_character: description.item (cursor) = '('
		do
			build_sequence (')');
			if not parsing_stopped then
				cursor := cursor + 1
			end
		ensure
			cursor_after_parenthesis:
				parsing_stopped or else description.item (cursor - 1) = ')'
		end; 

	action_bracket is
			-- Build a tool and make it optional.
		require
			good_first_character: description.item (cursor) = '['
		do
			build_sequence (']');
			if not parsing_stopped then
				optional (last_created_tool);
				cursor := cursor + 1
			end
		ensure
			cursor_after_bracket: parsing_stopped or else
					description.item (cursor - 1) = ']'
		end; 

	action_quote is
			-- Look for the first char, eventually for the second,
			-- and build 'first_char' or 'first_char'..'second_char'.
		require
			good_first_character: description.item (cursor) = '%''
		do
			cursor := cursor + 1;
			get_char_in_quotes;
			if not parsing_stopped then
				if description.item (cursor) = '.' then
					action_two_char (current_char)
				else
					interval (current_char, current_char)
				end
			end
		ensure
			-- cursor after last quote.
		end; 

	action_two_char (first_char: CHARACTER) is
			-- Look for the second character and build the
			-- category 'first_char'..'second_char'.
			-- If there is a minus sign build:
			-- 'first'.. 'second'-'third'-'fourth'..
		require
			good_first_character: description.item (cursor) = '.'
		local
			second_char: CHARACTER
		do
			if description_length < cursor + 5 then
				raise_error (description_length, '%U',
						"Missing character at the end of regular expression.")
			elseif description.item (cursor + 1) /= '.' then
				raise_error (cursor + 1, '.', "")
			else
				cursor := cursor + 2;
				if description.item (cursor) /= '%'' then
					raise_error (cursor, '%'', "")
				else
					cursor := cursor + 1;
					get_char_in_quotes;
					second_char := current_char;
					if not parsing_stopped and then first_char <= current_char then
						interval (first_char, second_char)
					elseif not parsing_stopped then
						raise_error (cursor - 3, '%U', "Wrong order for characters.")
					end
				end
			end;
			from
				-- This second part is for cases like:
				-- 'a'..'z'-'e'-'x'
			until
				parsing_stopped or else description.item (cursor) /= '-'
			loop
				cursor := cursor + 1;
				if description.item (cursor) /= '%'' then
					raise_error (cursor, '%'', "")
				else
					cursor := cursor + 1;
					get_char_in_quotes;
					if not parsing_stopped then
						if current_char <= second_char and then
								current_char >= first_char then
							difference (last_created_tool, current_char)
						else
							raise_error (cursor - 1, '%U',
								"Character not belonging to the preceding category.")
						end
					end
				end
			end
		end; 

	get_char_in_quotes is
			-- Set `current_char' to character found between two quotes.
			-- "quote" if '\'', "return" if '\n', "tab" if '\t' etc.
			-- If the character is '\s' set current_char to '\0' and
			-- build a tool "any separator".
			-- If the character is '\p' set current_char to '\0' and
			-- build a tool "any printable character".
		require
			following_quote: description.item (cursor - 1) = '%''
		local
			scanning_char: CHARACTER
		do
			scanning_char := description.item (cursor);
			if description_length < cursor + 2 then
				raise_error (description_length, '%U',
					"Missing character at the end of regular expression.")
			elseif scanning_char = '%'' then
				raise_error (cursor, '%U', "Quote unexpected.")
			elseif scanning_char /= '\' then
				current_char := scanning_char;
				if description.item (cursor + 1) /= '%'' then
					raise_error (cursor + 1, '%'', "")
				else
					cursor := cursor + 2
				end
			elseif description_length < cursor + 3 then
				raise_error (description_length, '%U',
					"Missing character at the end of regular expression.")
			else
				cursor := cursor + 1;
				scanning_char := description.item (cursor);
				inspect scanning_char
				when '%'' then
					current_char := '%''; cursor := cursor + 1
				when '\' then
					current_char := '\'; cursor := cursor + 1
				when '"' then
					current_char := '"'; cursor := cursor + 1
				when 't' then
					current_char := '%T'; cursor := cursor + 1
				when 'n' then
					current_char := '%N'; cursor := cursor + 1
				when 'r' then
					current_char := '%R'; cursor := cursor + 1
				when 'a' then
					current_char := 'a'; cursor := cursor + 1
				when 'b' then
					current_char := '%B'; cursor := cursor + 1
				when 'f' then
					current_char := '%F'; cursor := cursor + 1
				when 'v' then
					current_char := 'v'; cursor := cursor + 1
				when '$' then
					current_char := '$'; cursor := cursor + 1
				when '?' then
					current_char := '?'; cursor := cursor + 1
				when 'x' then
					get_hexadecimal
				when '0'..'7' then
					get_octal
				else
					raise_error (cursor, '%U', "Unexpected_character.")
				end;
				if description.item (cursor) /= '%'' and then
						not parsing_stopped then
					raise_error (cursor, '%'', "")
				else
					cursor := cursor + 1
				end
			end
		ensure
			cursor_after_quote: parsing_stopped or else
				description.item (cursor - 1) = '%''
		end; 

	action_star is
			-- Build a tool and then an iteration of any number,
			-- including none, of this tool.
		require
			good_first_character: description.item (cursor) = '*'
		do
			cursor := cursor + 1;
			build_tool;
			if not parsing_stopped then
				iteration (last_created_tool)
			end
		end; 

	action_plus is
			-- Build a tool and then an iteration of any number,
			-- greater than one, of this tool.
		require
			good_first_character: description.item (cursor) = '+'
		do
			cursor := cursor + 1;
			build_tool;
			if not parsing_stopped then
				iteration1 (last_created_tool)
			end
		end; 

	action_tilde is
			-- Build a tool and then another identical,
			-- but case insensitive.
		require
			good_first_character: description.item (cursor) = '~'
		do
			cursor := cursor + 1;
			build_tool;
			if not parsing_stopped then
				case_insensitive (last_created_tool)
			end
		end; 

	action_dollar is
			-- Build tools described with the dollar sign and
			-- a character.
		require
			good_first_character: description.item (cursor) = '$'
		do
			cursor := cursor + 1;
			current_char := description.item (cursor);
			inspect current_char
			when '.' then
				build_dollar_any
			when 'P' then
				build_dollar_p
			when 'B' then
				build_dollar_b
			when 'N' then
				build_dollar_n
			when 'Z' then
				build_dollar_z
			when 'R' then
				build_dollar_r
			when 'W' then
				build_dollar_w
			when 'L' then
				build_dollar_l
			else
				raise_error (cursor,'%U', "., P, B, N, Z, R or W expected")
			end;
			cursor := cursor + 1;
			from
				-- This second part is for cases like:
				-- $L-'e'-'x'
			until
				parsing_stopped or else description.item (cursor) /= '-'
			loop
				cursor := cursor + 1;
				if description.item (cursor) /= '%'' then
					raise_error (cursor, '%'', "")
				else
					cursor := cursor + 1;
					get_char_in_quotes;
					if not parsing_stopped then
						-- WARNING: does not check:
						-- "Character not belonging to the preceding category.");
						difference (last_created_tool, current_char)
					end
				end
			end
		ensure
			cursor_after: is_cursor_after
		end; 

	is_cursor_after: BOOLEAN is
		do
			Result := parsing_stopped or else description.item (cursor - 1) = '.'
				or else description.item (cursor - 1) = 'P';
			Result := Result or else description.item (cursor - 1) = 'B'
				or else description.item (cursor - 1) = 'N';
			Result := Result or else description.item (cursor - 1) = 'Z'
				or else description.item (cursor - 1) = 'R';
			Result := Result or else description.item (cursor - 1) = 'W'
			 	or else description.item (cursor - 1) = '%''
		end; 

	dollar_n, dollar_z, dollar_r: INTEGER;
			-- Tool numbers of $N, $Z, and $R

	build_dollar_w is
			-- Build $W: one or more printable characters,
			-- excluding break characters.
			-- +($P-' '-'\`t''-'\`n''-'\`r'')
		do
			any_printable;
			difference (last_created_tool, ' ');
			difference (last_created_tool, '%T');
			difference (last_created_tool, '%N');
			difference (last_created_tool, '%R');
			iteration1 (last_created_tool)
		end; 

	build_dollar_l is
			-- Build $L: a new-line character.
		do
			interval ('%N', '%N')
		end; 

	action_set_word is
			-- Build a tool "word", same as ('w' 'o' 'r' 'd').
		require
			good_first_character: description.item (cursor) = '"'
		do
			get_string;
			set_word (last_string)
		ensure
			cursor_after_double_quote: parsing_stopped or else
				description.item (cursor - 1) = '"'
		end; 

	action_up_to is
			-- Build a tool which is a sequence of any character,
			-- finished by a given word.
		require
			good_first_character: description.item (cursor) = '-'
		do
			if description.item (cursor + 1) /= '>' then
				raise_error (cursor + 1, '>', "")
			elseif description.item (cursor + 2) /= '"' then
				raise_error (cursor + 2, '"', "")
			else
				cursor := cursor + 2;
				get_string;
				up_to (last_string)
			end
		ensure
			cursor_after_double_quote: parsing_stopped or else
				description.item (cursor - 1) = '"'
		end; 

	get_string is
			-- Set last_string to the string value beginning at cursor.
		require
			good_first_character: description.item (cursor) = '"'
		local
			back_slashed, endword: BOOLEAN
		do
			!! last_string.make (0);
			from
			until
				endword or parsing_stopped
			loop
				cursor := cursor + 1;
				current_char := description.item (cursor);
				if back_slashed then
					if current_char = 'n' then
						last_string.extend ('%N')
					elseif current_char = '"' then
						last_string.extend ('"')
					elseif current_char = '\' then
						last_string.extend ('\')
					elseif current_char = '%'' then
						last_string.extend ('%'')
					else
						raise_error (cursor, '%U', "Unexpected character.")
					end;
					back_slashed := False
				elseif current_char = '\' then
					back_slashed := True
				elseif current_char = '"' then
					endword := True
				elseif current_char = '%/001/' then
					raise_error (cursor, '"', "")
				else
					last_string.extend (current_char)
				end
			end;
			if not parsing_stopped then
				cursor := cursor + 1
			end
		ensure
			cursor_after_double_quote: parsing_stopped or else
				description.item (cursor - 1) = '"'
		end; 

	action_digit is
			-- Build a tool and then an iteration of n times this tool.
		require
			good_first_character: description.item (cursor) >= '0' and
				description.item (cursor) <= '9'
		local
			mult, current_code: INTEGER
		do
			from
				current_code := description.item_code (cursor);
				mult := current_code - Zero;
				cursor := cursor + 1;
				current_code := description.item_code (cursor)
			until
				current_code < Zero or current_code > Nine
			loop
				mult := mult * 10;
				mult := mult + current_code - Zero;
				cursor := cursor + 1;
				current_code := description.item_code (cursor)
			end;
			build_tool;
			if not parsing_stopped then
				iteration_n (mult, last_created_tool)
			end
		end; 

	get_octal is
			-- Set the value of current_char to the character
			-- corresponding to the octal number beginning at cursor.
			-- Format: '\ooo'.
		require
			good_first_character:
				description.item(cursor) >= '0' and description.item(cursor) <= '7';
			good_preceding_characters:
				description.item(cursor-1)='\' and description.item(cursor-2)='%''
		local
			octal1, octal2, octal3: INTEGER
		do
			if description_length < cursor + 3 then
				raise_error (description_length, '%U',
					"Missing character at the end of the description.")
			else
				octal1 := description.item_code (cursor) - Zero;
				octal2 := description.item_code (cursor + 1) - Zero;
				octal3 := description.item_code (cursor + 2) - Zero;
				if octal1 < 0 or octal1 > 8 then
					raise_error (cursor, '%U', "Octal number expected.")
				elseif octal2 < 0 or octal2 > 8 then
					raise_error (cursor + 1, '%U', "Octal number expected.")
				elseif octal3 < 0 or octal3 > 8 then
					raise_error (cursor + 2, '%U', "Octal number expected.")
				else
					current_char := charconv (octal1 * 64 + octal2 * 8 + octal3)
				end
			end;
			if not parsing_stopped then
				cursor := cursor + 3
			end
		ensure
			-- cursor after octal number
		end; 

	get_hexadecimal is
			-- Set the value of current_char to the character
			-- corresponding to the hexadecimal number beginning
			-- at cursor. Format: '\xhh'.
		require
			good_first_character: description.item (cursor) = 'x'
		local
			first, second: INTEGER
		do
			if description_length < cursor + 3 then
				raise_error (description_length, '%U',
					"Missing character at the end of the description.")
			else
				first := hexa_value (description.item (cursor + 1));
				second := hexa_value (description.item (cursor + 2));
				if first = -1 then
					raise_error (cursor + 1, '%U', "Hexadecimal number expected.")
				elseif first > 7 then
					raise_error (cursor + 1, '%U',
						"The last ascii possible code is 7f in hexadecimal.")
				elseif second = -1 then
					raise_error (cursor + 2, '%U',
						"Another hexadecimal figure expected.")
				else
					current_char := charconv ((16 * first) + second)
				end
			end;
			if not parsing_stopped then
				cursor := cursor + 3
			end
		ensure
			-- cursor_after_hexadecimal:
		end; 

	hexa_value (c: CHARACTER): INTEGER is
			-- O if c = '0', 1 if c = '1',.., 15 if c = 'f' or 'F',
			-- -1 otherwiswe.
		local
			i: INTEGER
		do
			i := c.code;
			if i >= Zero and i <= Nine then
				Result := i - Zero
			elseif i >= Upper_a and i <= Upper_f then
				Result := i - Upper_a + 10
			elseif i >= Lower_a and i <= Lower_f then
				Result := i - Lower_a + 10
			else
				Result := -1
			end
		end; 

	remove_separators is
			-- Remove ' ' '\n' and '\t' of description except
			-- when they are between quotes.
			-- This routine also computes description_length.
		require
			dollar_in_description: description.item (description.count) = '%/001/'
		local
			quote_open: BOOLEAN;
			backslash_nb: INTEGER
		do
			from
				description_length := description.count;
				cursor := 1;
				current_char := description.item (cursor)
			until
				current_char = '%/001/' and then cursor = description.count
			loop
				if current_char = '%'' then
					from
						backslash_nb := 0
					until
						cursor - backslash_nb = 1 or
								description.item (cursor - backslash_nb -1) /= '\'
					loop
						backslash_nb := backslash_nb + 1
					end;
					if backslash_nb \\ 2 = 0 then
						quote_open := not quote_open
					end;
					cursor := cursor + 1
				elseif quote_open then
					cursor := cursor + 1
				elseif current_char = ' ' or else current_char = '%T' or else
						current_char = '%N' then
					description.remove (cursor)
				else
					cursor := cursor + 1
				end;
				current_char := description.item (cursor)
			end;
			description_length := cursor;
			if quote_open then
				raise_error (cursor, '%U', "Missing quote or double quote.")
			elseif description_length = 1 then
				raise_error (1, '%U', "Nothing in the description.")
			end
		end; 

	raise_error (pos: INTEGER; expected: CHARACTER; mes: STRING) is
			-- Print an error message and stop parsing.
			-- Two kind of messages are possible, whether expected
			-- is '\0' or not.
		require
			parsing_not_stopped: not parsing_stopped
		local
			error_position: INTEGER;
			message: STRING
		do
			!! message.make (0);
			if description_length = 1 or pos < 1 then
				error_position := 1
			elseif pos < description_length then
				error_position := pos
			else
				error_position := description_length - 1
			end;
			message.append ("Error in format near: ``");
			message.extend (description.item (error_position));
			message.append ("''%N(");
			message.append_integer (error_position);
			message.append ("-th significant character of the description).%N");
			if expected = '%U' then
				message.append (mes)
			else
				message.append ("``");
				message.extend (expected);
				message.append ("'' expected.")
			end;
			message.extend ('%N');
			error_list.add_message (message);
			parsing_stopped := True
		end 

invariant

	cursor_not_too_far: cursor <= description_length

end -- class HIGH_BUILDER
 

--|----------------------------------------------------------------
--| EiffelLex: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------


indexing

	description:
		"Lexical analyzers";

	copyright: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class LEXICAL inherit

	TEXT_FILLER;

	STORABLE

creation

	make

feature

	make is
			-- Make `last_token'
		do
			!!last_token
		end; -- make

			-- Tokens' attributes

	token_type: INTEGER;
			-- Type of last token recognized

	other_possible_tokens: ARRAY [INTEGER];
			-- Other possible types of tokens recognized on the same state

	end_of_text: BOOLEAN;
			-- Is end of input reached?

	set_separator_type (type : INTEGER) is
			-- Set `type' to be the type of tokens
			-- used as separators.
        do
            separator_token_type := type
        end; -- set_separator_type

	get_token is
			-- Read new token, recognize the longest possible string,
			-- ignore unrecognized tokens and designated separators.
		local
			found: BOOLEAN
		do
			from
			until
				end_of_text or found
			loop
				get_any_token;
				found := token_type /= separator_token_type and token_type /= 0
			end
		end; -- get_token

	get_any_token is
			-- Read new token, recognize the longest possible string,
			--| Thus, when a token is recognized, this routine keeps
			--| track of its type, but goes on analyzing, until the
			--| current state has a void successor.
		require
			dfa_not_Void: dfa /= Void;
			not_end_of_text: not end_of_text;
			buffers_created: buffer /= Void
		local
			state: STATE_OF_DFA;
			retried, too_big, buffer_resized: BOOLEAN;
			local_string: STRING
		do
			if token_end >= almost_end_of_buffer then
				fill_buffer (token_end);
				token_end := 0
			end;
			if buffer.item_code (read_index) = -1 then
				end_of_text := true;
				token_type := -1;
				token_start := token_end;
				other_possible_tokens := Void
			else
				token_type := 0;
				token_start := token_end + 1
			end;
			read_index := token_end + 1;
			if read_index > buffer_size then
				if token_start = 1 then
					buffer_resized := true;
					resize_and_fill_buffer (buffer_size + extra_buffer_size, 0)
				else
					fill_buffer (token_start - 1);
					token_end := 0
				end;
				get_any_token
			else
				from
					state := dfa.item (1);
					state := state.item (categories_table.item
							(buffer.item_code (read_index)))
				until
					state = Void or too_big
				loop
					if state.final /= 0 then
						token_type := state.final;
						other_possible_tokens := state.final_array;
						token_end := read_index
					end;
					read_index := read_index + 1;
					if read_index > buffer_size then
						too_big := true
					else
						state := state.item (categories_table.item
								(buffer.item_code (read_index)))
					end
				end;
				if too_big then
					if token_start = 1 then
						buffer_resized := true;
						resize_and_fill_buffer (buffer_size + extra_buffer_size, 0)
					else
						fill_buffer (token_start - 1);
						token_end := 0
					end;
					get_any_token
				else
					if token_type = 0 then
						token_end := token_end + 1;
						read_index := read_index + 1
					end;
					local_string := buffer.substring (token_start, token_end);
					last_token.set (token_type,
							line_nb_array.item (token_start),
							column_nb_array.item (token_start),
							keyword_code (local_string),
							local_string);
					debug
						io.putstring ("Last token:%N");
						io.putstring (last_token.tagged_out);
						io.putstring ("Type return:");
						io.readchar
					end
				end
			end;
			if buffer_resized then
				resize_and_fill_buffer (standard_buffer_size, token_end);
				token_end := 0
			end
		rescue
			if read_index > buffer_size and not retried then
				fill_buffer (token_start - 1);
				token_end := 0;
				retried := true;
				retry
			end
				-- Warning: if a token more than max_token_length long
				-- is at the end of the buffer, the rescue clause will
				-- not be triggered in check 0, because the
				-- precondition "index_small_enough" of
				-- buffer.item_code will not be checked.
				-- If string is compiled in check 1 or 2, the
				-- precondition will be violated, the rescue clause
				-- executed, and the case properly handled.
		end; -- get_any_token

	get_short_token is
			-- Read new token, recognize the shortest possible string,
		require
			dfa_not_Void: dfa /= Void;
			not_end_of_text: not end_of_text;
			buffers_created: buffer /= Void
		local
			state: STATE_OF_DFA;
			retried, recognized: BOOLEAN;
			local_string: STRING
		do
			if token_end >= almost_end_of_buffer then
				fill_buffer (token_end);
				token_end := 0
			end;
			if buffer.item_code (read_index) = -1 then
				end_of_text := true;
				token_type := -1;
				token_start := token_end;
				other_possible_tokens := Void
			else
				token_type := 0;
				token_start := token_end + 1
			end;
			read_index := token_end + 1;
			from
				state := dfa.item (1);
				state := state.item (categories_table.item
							(buffer.item_code (read_index)));
			until
				state = Void or recognized
			loop
				if state.final /= 0 then
					token_type := state.final;
					other_possible_tokens := state.final_array;
					token_end := read_index;
					recognized := true
				end;
				read_index := read_index + 1;
				state := state.item (categories_table.item
							(buffer.item_code (read_index)))
			end;
			if token_type = 0 then
				token_end := token_end + 1;
				read_index := read_index + 1
			end;
			local_string := buffer.substring (token_start, token_end);
			last_token.set (token_type,
							line_nb_array.item (token_start),
							column_nb_array.item (token_start),
							keyword_code (local_string),
							local_string)
		rescue
			if read_index > buffer_size and not retried then
				fill_buffer (token_start - 1);
				token_end := 0;
				retried := true;
				retry
			end
				-- Warning if a token more than max_token_length long
				-- is at the end of the buffer, the rescue clause will
				-- not be triggered in check 0, because the
				-- precondition "index_small_enough" of
				-- buffer.item_code will not be checked.
				-- If string is compiled in check 1 or 2, the
				-- precondition will be violated, the rescue clause
				-- executed, and the case properly handled.
		end; -- get_short_token

	get_fixed_token (l: INTEGER) is
			-- Read new token, recognize the longest possible string,
			-- which length is less than or equal to `l'.
		require
			dfa_not_Void: dfa /= Void;
			not_end_of_text: not end_of_text;
			buffers_created: buffer /= Void
		local
			state: STATE_OF_DFA;
			retried: BOOLEAN;
			local_string: STRING
		do
			if token_end >= almost_end_of_buffer then
				fill_buffer (token_end);
				token_end := 0
			end;
			if buffer.item_code (read_index) = -1 then
				end_of_text := true;
				token_type := -1;
				token_start := token_end;
				other_possible_tokens := Void
			else
				token_type := 0;
				token_start := token_end + 1
			end;
			read_index := token_end + 1;
			from
				state := dfa.item (1);
				state := state.item (categories_table.item
							(buffer.item_code (read_index)))
			until
				state = Void or (read_index - token_start) = l
			loop
				if state.final /= 0 then
					token_type := state.final;
					other_possible_tokens := state.final_array;
					token_end := read_index
				end;
				read_index := read_index + 1;
				state := state.item (categories_table.item
							(buffer.item_code (read_index)))
			end;
			if token_type = 0 then
				token_end := token_end + 1;
				read_index := read_index + 1
			end;
			local_string := buffer.substring (token_start, token_end);
			last_token.set (token_type,
							line_nb_array.item (token_start),
							column_nb_array.item (token_start),
							keyword_code (local_string),
							local_string)
		rescue
			if read_index > buffer_size and not retried then
				fill_buffer (token_start - 1);
				token_end := 0;
				retried := true;
				retry
			end
				-- Warning: if a token more than max_token_length long
				-- is at the end of the buffer, the rescue clause will
				-- not be triggered in check 0, because the
				-- precondition "index_small_enough" of
				-- buffer.item_code will not be checked.
				-- If string is compiled in check 1 or 2, the
				-- precondition will be violated, the rescue clause
				-- executed, and the case properly handled.
		end; -- get_fixed_token

	go_on is
			-- Read tokens until one is recognized.
		do
			from
				get_token
			until
				token_type /= 0 or end_of_text
			loop
				get_token
			end
		end; -- go_on

	last_token: TOKEN;
			-- Last token recognized in the text

	token_line_number: INTEGER is
			-- Line number of last token read
		do
			Result := line_nb_array.item (token_start)
		end; -- token_line_number

	token_column_number: INTEGER is
			-- Column number of last token read
		do
			Result := column_nb_array.item (token_start)
		end; -- token_column_number

	last_string_read: STRING is
			-- String value of the last token
		do
				-- Create a new string at each call
			Result := buffer.substring (token_start, token_end)
		end; -- last_string_read

	keyword_code (word: STRING): INTEGER is
			-- Keyword code for `word'.
			-- -1 if not a keyword.
		do
			if keywords_case_sensitive then
				if keyword_h_table.has (word) then
					Result := keyword_h_table.position
				else
					Result := -1
				end
			else
				lower_word := clone (word);
				lower_word.to_lower;
				if keyword_h_table.has (lower_word) then
					Result := keyword_h_table.position
				else
					Result := -1
				end
			end
		end; -- keyword_code

	last_is_keyword: BOOLEAN is
			-- Is the last read token a keyword?
		do
			Result := is_keyword (last_string_read)
		end; -- last_is_keyword

	last_keyword_code: INTEGER is
			-- Keyword code for last token.
			-- -1 if not a keyword.
		do
			Result := keyword_code (last_string_read)
		ensure
			-- Result = -1 or last_string_read is in keyword_h_table.
		end; -- last_keyword_code

	last_keyword_text: STRING is
			-- Last read string if recognized as a keyword;
			-- Void otherwise.
		do
			if last_is_keyword then
				Result := last_string_read
			end
		end; -- last_keyword_text

	keyword_string (n: INTEGER): STRING is
			-- Keyword corresponding to keyword code `n'
		do
			Result := keyword_h_table.key_at (n)
		end; -- keyword_string

	trace is
			-- Output an internal representation of the lexical analyzer.
		local
			i, ol_d: INTEGER
		do
			from
				i := categories_table.lower;
				io.putstring (" LEXICAL%N Categories table.%N From ");
				io.putint (i)
			until
				i = categories_table.upper
			loop
				i := i + 1;
				if categories_table.item (i) /= categories_table.item (i - 1) then
					io.putstring (" to ");
					io.putint (i - 1);
					io.putstring (" ");
					io.putint (categories_table.item (i - 1));
					io.putstring ("th category.%N From ");
					io.putint (i)
				end
			end;
			io.putstring (" to ");
			io.putint (i);
			io.putstring (" ");
			io.putint (categories_table.item (i));
			io.putstring ("-th category.%N End of categories table.%N");
			dfa.trace;
			io.putstring (" End LEXICAL.");
			io.new_line
		end -- trace

feature {LEXICAL}

	initialize is
			-- Create data structures for the lexical analyzer.
		do
			create_buffers (standard_buffer_size, standard_line_length);
			if keyword_h_table = Void then
				!!keyword_h_table.make (1)
			end;
			end_of_text := false
		end -- initialize

feature {LEXICAL, LEX_BUILDER}

	initialize_attributes (d: FIXED_DFA; c: ARRAY [INTEGER];
					k: HASH_TABLE [INTEGER, STRING]; b: BOOLEAN) is
			-- Set the first four attributes of Current.
		do
			dfa := d;
			categories_table := c;
			keyword_h_table := k;
			keywords_case_sensitive := b
		end -- initialize_attributes

feature {NONE}

			-- Constants

	standard_buffer_size: INTEGER is 10240;
			-- Standard buffer size

	extra_buffer_size: INTEGER is 4096;
			-- size added to the initial `buffer_size' when the current token
			-- is too big.
			-- `extra_buffer_size' should be less than `standard_buffer_size'.

	standard_line_length: INTEGER is 1024;
			-- Standard line length

	max_token_length: INTEGER is 256;
			-- Maximum length for a token

	almost_end_of_buffer: INTEGER is 9984;
			-- Buffer_size minus max_token_length


			-- Attributes created by LEX_BUILDER

	dfa: FIXED_DFA;
			-- Automaton used for the parsing

	categories_table: ARRAY [INTEGER];
			-- For each input, category number

	keyword_h_table: HASH_TABLE [INTEGER, STRING];
			-- Keywords table

	keywords_case_sensitive: BOOLEAN;
			-- Are the keyword case sensitive?

	separator_token_type : INTEGER;
			-- Type of token used as separators, (e.g. white space)

	token_end: INTEGER;
			-- Position in buffer of the end
			-- of the last recognized token

	token_start: INTEGER;
			-- Position in buffer of the beginning
			-- of the last recognized token

	lower_word: STRING;
			-- String used to avoid modifying last_string_read

	read_index: INTEGER;
			-- Current position in buffer

	reset_data is
		do
			read_index := 1;
			token_end := buffer_size
		end; -- reset_data

	is_keyword (word: STRING): BOOLEAN is
			-- Is `word' a keyword included in the
			-- last token type read?
		do
			Result := token_type = keyword_h_table.item (word);
			if not Result and not keywords_case_sensitive then
				lower_word := clone (word);
				lower_word.to_lower;
				Result := token_type = keyword_h_table.item (lower_word)
			end
		end -- is_keyword

end -- class LEXICAL
 

--|----------------------------------------------------------------
--| EiffelLex: library of reusable components for ISE Eiffel 3,
--| Copyright (C) 1986, 1990, 1993, Interactive Software
--|   Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <eiffel@eiffel.com>
--|----------------------------------------------------------------

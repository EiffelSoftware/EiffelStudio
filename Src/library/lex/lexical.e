indexing

	description:
		"Lexical analyzers";

	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class LEXICAL inherit

	TEXT_FILLER

create

	make, make_new

feature -- Initialization

	make is
			-- Set up lexical analyzer for retrieval.
		do
			create last_token
		end;

	make_new is
			-- Set up a new lexical analyzer
		do
			create last_token;
			initialize
		end

feature -- Access

	last_token: TOKEN;
			-- Last token read

	token_line_number: INTEGER is
			-- Line number of last token read
		do
			Result := line_nb_array.item (token_start)
		ensure
			Result >= 1
		end;

	token_column_number: INTEGER is
			-- Column number of last token read
		do
			Result := column_nb_array.item (token_start)
		ensure
			Result >= 1
		end;

	last_string_read: STRING is
			-- String value of last token read
		do
				-- Create a new string at each call
			Result := buffer.substring (token_start, token_end)
		end;

	keyword_code (word: STRING): INTEGER is
			-- Keyword code for `word'.
			-- -1 if not a keyword.
		do
			if keywords_case_sensitive then
				if keyword_h_table.has (word) then
					Result := word.hash_code
				else
					Result := -1
				end
			else
				lower_word := clone (word);
				lower_word.to_lower;
				if keyword_h_table.has (lower_word) then
					Result := lower_word.hash_code
				else
					Result := -1
				end
			end
		end;

	last_is_keyword: BOOLEAN is
			-- Is the last read token a keyword?
		do
			Result := is_keyword (last_string_read)
		ensure
			Result = is_keyword (last_string_read)
		end;

	last_keyword_code: INTEGER is
			-- Keyword code for last token.
			-- -1 if not a keyword.
		do
			Result := keyword_code (last_string_read)
		ensure
			-- Result = -1 or last_string_read is in keyword_h_table.
		end;

	last_keyword_text: STRING is
			-- Last read string if recognized as a keyword;
			-- void otherwise.
		do
			if last_is_keyword then
				Result := last_string_read
			end
		end;

	keyword_string (n: INTEGER): STRING is
			-- Keyword corresponding to keyword code `n'
		local
			finished: BOOLEAN
		do
			from
				keyword_h_table.start
			until
				finished or keyword_h_table.after
			loop
				finished := n = keyword_h_table.key_for_iteration.hash_code
				if finished then
					Result := keyword_h_table.key_for_iteration
				end
				keyword_h_table.forth
			end
		ensure
			keyword_found: Result /= Void
		end;

	token_type: INTEGER;
			-- Type of last token read

	No_token: INTEGER is 0;
			-- Token type for no token recognized.

	other_possible_tokens: ARRAY [INTEGER];
			-- Other candidate types for last recognized token

	end_of_text: BOOLEAN;
			-- Has end of input been reached?

feature -- Status setting

	set_separator_type (type : INTEGER) is
			-- Set `type' to be the type of tokens
			-- used as separators.
		do
			separator_token_type := type
		ensure
			separator_token_type = type
		end;

feature -- Input

	get_token is
			-- Read new token matching one of the regular
			-- expressions of the lexical grammar.
			-- Recognize longest possible string;
			-- ignore unrecognized tokens and separators.
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
		ensure
			end_of_text or
			(token_type /= separator_token_type
			and token_type /= 0)
		end;

	buffer_item_code (c: INTEGER): INTEGER is
		do
			Result := buffer.item_code (c);
			if Result = 255 then
				Result := -1
			end;
		end;

	get_any_token is
			-- Try to read a new token.
			-- Recognize longest possible string.
			--| Thus, when a token is recognized, this routine keeps
			--| track of its type, but goes on analyzing, until the
			--| current state has a void successor.
		require
			dfa_not_void: dfa /= Void;
			not_end_of_text: not end_of_text;
			buffers_created: buffer /= Void
		local
			state: STATE_OF_DFA;
			too_big, buffer_resized: BOOLEAN;
			local_string: STRING
		do
			if token_end >= almost_end_of_buffer then
				fill_buffer (token_end);
				token_end := 0
			end;
			read_index := token_end + 1;
			if
				buffer_item_code (read_index) = -1
			then
				end_of_text := True;
				token_type := -1;
				token_start := token_end;
				other_possible_tokens := Void
			else
				token_type := 0;
				token_start := token_end + 1
			end;
			if read_index > buffer_size then
				if token_start = 1 then
					buffer_resized := True;
					resize_and_fill_buffer (buffer_size + Extra_buffer_size, 0)
				else
					fill_buffer (token_start - 1);
					token_end := 0
				end;
				get_any_token
			else
				from
					state := dfa.item (1);
					state := state.item (categories_table.item
							(buffer_item_code (read_index)))
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
						too_big := True
					else
						state := state.item (categories_table.item
								(buffer_item_code (read_index)))
					end
				end;
				if too_big then
					if token_start = 1 then
						buffer_resized := True;
						resize_and_fill_buffer (buffer_size + Extra_buffer_size, 0)
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
						io.put_string ("Last token:%N");
						io.put_string (last_token.tagged_out);
						io.put_string ("Type return:");
						io.read_character
					end
				end
			end;
			if buffer_resized then
				resize_and_fill_buffer (Standard_buffer_size, token_end);
				token_end := 0
			end
		end;

	get_short_token is
			-- Read shortest token that matches one of the
			-- lexical grammar's regular expressions.
		require
			dfa_not_void: dfa /= Void;
			not_end_of_text: not end_of_text;
			buffers_created: buffer /= Void
		local
			state: STATE_OF_DFA;
			too_big, recognized, buffer_resized: BOOLEAN;
			local_string: STRING
		do
			if token_end >= almost_end_of_buffer then
				fill_buffer (token_end);
				token_end := 0
			end;
			read_index := token_end + 1;
			if buffer_item_code (read_index) = -1 then
				end_of_text := True;
				token_type := -1;
				token_start := token_end;
				other_possible_tokens := Void
			else
				token_type := 0;
				token_start := token_end + 1
			end;
			if read_index > buffer_size then
				if token_start = 1 then
					buffer_resized := True;
					resize_and_fill_buffer (buffer_size + Extra_buffer_size, 0)
				else
					fill_buffer (token_start - 1);
					token_end := 0
				end;
				get_short_token
			else
				from
					state := dfa.item (1);
					state := state.item (categories_table.item
								(buffer_item_code (read_index)));
				until
					state = Void or recognized or too_big
				loop
					if state.final /= 0 then
						token_type := state.final;
						other_possible_tokens := state.final_array;
						token_end := read_index;
						recognized := True
					end;
					read_index := read_index + 1;
					if read_index > buffer_size then
						too_big := True
					else
						state := state.item (categories_table.item
									(buffer_item_code (read_index)))
					end
				end;
				if too_big then
					if token_start = 1 then
						buffer_resized := True;
						resize_and_fill_buffer (buffer_size + Extra_buffer_size, 0)
					else
						fill_buffer (token_start - 1);
						token_end := 0
					end;
					get_short_token
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
									local_string)
				end
			end;
			if buffer_resized then
				resize_and_fill_buffer (Standard_buffer_size, token_end);
				token_end := 0
			end
		end;

	get_fixed_token (l: INTEGER) is
			-- Read new token that matches one of the
			-- lexical grammar's regular expressions.
			-- Recognize longest possible string with
			-- length less than or equal to `l'.
		require
			dfa_not_void: dfa /= Void;
			not_end_of_text: not end_of_text;
			buffers_created: buffer /= Void
		local
			state: STATE_OF_DFA;
			too_big, buffer_resized: BOOLEAN;
			local_string: STRING
		do
			if token_end >= almost_end_of_buffer then
				fill_buffer (token_end);
				token_end := 0
			end;
			read_index := token_end + 1;
			if buffer_item_code (read_index) = -1 then
				end_of_text := True;
				token_type := -1;
				token_start := token_end;
				other_possible_tokens := Void
			else
				token_type := 0;
				token_start := token_end + 1
			end;
			if read_index > buffer_size then
				if token_start = 1 then
					buffer_resized := True;
					resize_and_fill_buffer (buffer_size + Extra_buffer_size, 0)
				else
					fill_buffer (token_start - 1);
					token_end := 0
				end;
				get_fixed_token (l)
			else
				from
					state := dfa.item (1);
					state := state.item (categories_table.item
								(buffer_item_code (read_index)))
				until
					state = Void or (read_index - token_start) = l or too_big
				loop
					if state.final /= 0 then
						token_type := state.final;
						other_possible_tokens := state.final_array;
						token_end := read_index
					end;
					read_index := read_index + 1;
					if read_index > buffer_size then
						too_big := True
					else
						state := state.item (categories_table.item
								(buffer_item_code (read_index)))
					end
				end;
				if too_big then
					if token_start = 1 then
						buffer_resized := True;
						resize_and_fill_buffer (buffer_size + Extra_buffer_size, 0)
					else
						fill_buffer (token_start - 1);
						token_end := 0
					end;
					get_fixed_token (l)
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
									local_string)
				end
			end
			if buffer_resized then
				resize_and_fill_buffer (Standard_buffer_size, token_end);
               	token_end := 0
			end 
		end;

feature -- Output

	trace is
			-- Output information about the analyzer's
			-- current status.
		local
			i: INTEGER
		do
			from
				i := categories_table.lower;
				io.put_string (" LEXICAL%N Categories table.%N From ");
				io.put_integer (i)
			until
				i = categories_table.upper
			loop
				i := i + 1;
				if categories_table.item (i) /= categories_table.item (i - 1) then
					io.put_string (" to ");
					io.put_integer (i - 1);
					io.put_string (" ");
					io.put_integer (categories_table.item (i - 1));
					io.put_string ("th category.%N From ");
					io.put_integer (i)
				end
			end;
			io.put_string (" to ");
			io.put_integer (i);
			io.put_string (" ");
			io.put_integer (categories_table.item (i));
			io.put_string ("-th category.%N End of categories table.%N");
			dfa.trace;
			io.put_string (" End LEXICAL.");
			io.new_line
		end;

feature -- Obsolete

	go_on is
			obsolete "Use ``get_token'' directly"
		do
			from
				get_token
			until
				token_type /= 0 or end_of_text
			loop
				get_token
			end
		end;

feature {LEXICAL} -- Implementation

	initialize is
			-- Create data structures for the lexical analyzer.
		do
			create_buffers (Standard_buffer_size, Standard_line_length);
			if keyword_h_table = Void then
				create keyword_h_table.make (1)
			end;
			end_of_text := False
		end;

feature {LEXICAL, LEX_BUILDER} -- Implementation

	initialize_attributes (d: FIXED_DFA; c: ARRAY [INTEGER];
					k: HASH_TABLE [INTEGER, STRING]; b: BOOLEAN) is
			-- Set the first four attributes of Current.
		do
			dfa := d;
			categories_table := c;
			keyword_h_table := k;
			keywords_case_sensitive := b
		end;

feature -- Implementation

	dfa: FIXED_DFA;
			-- Automaton used for the parsing

feature {NONE} -- Implementation

	Standard_buffer_size: INTEGER is 10240;
			-- Standard buffer size

	Extra_buffer_size: INTEGER is 4096;
			-- size added to the initial `buffer_size' when the current token
			-- is too big.
			-- `Extra_buffer_size' should be less than `Standard_buffer_size'.

	Standard_line_length: INTEGER is 1024;
			-- Standard line length

	Max_token_length: INTEGER is 256;
			-- Maximum length for a token

	Almost_end_of_buffer: INTEGER is 9984;
			-- Buffer_size minus Max_token_length

	Close_of_file: INTEGER is 255;
			-- End-of-file indicator on some platforms

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
		end;

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
		end;

end -- class LEXICAL

--|----------------------------------------------------------------
--| EiffelLex: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------


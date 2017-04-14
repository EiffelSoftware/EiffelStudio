note

	description: "Lexical analyzers."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class LEXICAL inherit

	TEXT_FILLER

create

	make, make_new

feature {NONE} -- Initialization

	make
			-- Set up lexical analyzer for retrieval.
		do
			create last_token
			create categories_table.make_empty
			create dfa.make (1, 0)
			create buffer.make_empty
			create line_nb_array.make_empty
			create column_nb_array.make_empty
			create keyword_h_table.make (0)
		end;

	make_new
			-- Set up a new lexical analyzer
		obsolete
			"Use make instead. [2017-05-31]"
		do
			make
			initialize
		end

feature -- Access

	last_token: TOKEN;
			-- Last token read

	token_line_number: INTEGER
			-- Line number of last token read
		do
			Result := line_nb_array.item (token_start)
		ensure
			Result >= 1
		end;

	token_column_number: INTEGER
			-- Column number of last token read
		do
			Result := column_nb_array.item (token_start)
		ensure
			Result >= 1
		end;

	last_string_read: STRING
			-- String value of last token read
		do
				-- Create a new string at each call
			Result := buffer.substring (token_start, token_end)
		end;

	keyword_code (word: STRING): INTEGER
			-- Keyword code for `word'.
			-- -1 if not a keyword.
		require
			word_not_void: word /= Void
		local
			l_lower_word: like lower_word
		do
			if keywords_case_sensitive then
				if keyword_h_table.has (word) then
					Result := word.hash_code
				else
					Result := -1
				end
			else
				l_lower_word := word.as_lower
				lower_word := l_lower_word
				if keyword_h_table.has (l_lower_word) then
					Result := l_lower_word.hash_code
				else
					Result := -1
				end
			end
		end;

	last_is_keyword: BOOLEAN
			-- Is the last read token a keyword?
		do
			Result := is_keyword (last_string_read)
		ensure
			Result = is_keyword (last_string_read)
		end;

	last_keyword_code: INTEGER
			-- Keyword code for last token.
			-- -1 if not a keyword.
		do
			Result := keyword_code (last_string_read)
		ensure
			-- Result = -1 or last_string_read is in keyword_h_table.
		end;

	last_keyword_text: detachable STRING
			-- Last read string if recognized as a keyword;
			-- void otherwise.
		do
			if last_is_keyword then
				Result := last_string_read
			end
		end

	keyword_string (n: INTEGER): STRING
			-- Keyword corresponding to keyword code `n'
		local
			finished: BOOLEAN
		do
			create Result.make_empty
			from
				keyword_h_table.start
			until
				finished or keyword_h_table.after
			loop
				finished := n = keyword_h_table.key_for_iteration.hash_code
				if finished then
					Result.append (keyword_h_table.key_for_iteration)
				end
				keyword_h_table.forth
			end
		ensure
			keyword_found: Result /= Void
		end;

	token_type: INTEGER;
			-- Type of last token read

	No_token: INTEGER = 0;
			-- Token type for no token recognized.

	other_possible_tokens: detachable ARRAY [INTEGER];
			-- Other candidate types for last recognized token

	end_of_text: BOOLEAN;
			-- Has end of input been reached?

feature -- Status setting

	set_separator_type (type : INTEGER)
			-- Set `type' to be the type of tokens
			-- used as separators.
		do
			separator_token_type := type
		ensure
			separator_token_type = type
		end;

feature -- Input

	get_token
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

	buffer_item_code (c: INTEGER): INTEGER
		do
			Result := buffer.item_code (c);
			if Result = 255 then
				Result := -1
			end;
		end;

	get_any_token
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
			state: detachable STATE_OF_DFA;
			too_big, buffer_resized: BOOLEAN;
			local_string: STRING
			l_dfa: like dfa
			l_cat_table: like categories_table
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
					l_dfa := dfa
					l_cat_table := categories_table
					state := l_dfa.item (1);
					if state /= Void then
						state := state.item (l_cat_table.item
							(buffer_item_code (read_index)))
					end
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
						state := state.item (l_cat_table.item
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
					debug ("lex_output")
						io.put_string ("Last token:%N");
						io.put_string (last_token.out);
						io.put_string ("Type return:");
						io.new_line
						--io.read_character
					end
				end
			end;
			if buffer_resized then
				resize_and_fill_buffer (Standard_buffer_size, token_end);
				token_end := 0
			end
		end;

	get_short_token
			-- Read shortest token that matches one of the
			-- lexical grammar's regular expressions.
		require
			dfa_not_void: dfa /= Void;
			not_end_of_text: not end_of_text;
			buffers_created: buffer /= Void
		local
			state: detachable STATE_OF_DFA;
			too_big, recognized, buffer_resized: BOOLEAN;
			local_string: STRING
			l_dfa: like dfa
			l_cat_table: like categories_table
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
					l_dfa := dfa
					l_cat_table := categories_table
					state := l_dfa.item (1)
					if state /= Void then
						state := state.item (l_cat_table.item
								(buffer_item_code (read_index)));
					end
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
						state := state.item (l_cat_table.item
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

	get_fixed_token (l: INTEGER)
			-- Read new token that matches one of the
			-- lexical grammar's regular expressions.
			-- Recognize longest possible string with
			-- length less than or equal to `l'.
		require
			dfa_not_void: dfa /= Void;
			not_end_of_text: not end_of_text;
			buffers_created: buffer /= Void
		local
			state: detachable STATE_OF_DFA;
			too_big, buffer_resized: BOOLEAN;
			local_string: STRING
			l_dfa: like dfa
			l_cat_table: like categories_table
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
					l_dfa := dfa
					l_cat_table := categories_table
					state := l_dfa.item (1)
					if state /= Void then
						state := state.item (l_cat_table.item
								(buffer_item_code (read_index)))
					end
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
						state := state.item (l_cat_table.item
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

	trace
			-- Output information about the analyzer's
			-- current status.
		local
			l_dfa: like dfa
			l_cat_table: like categories_table
			i: INTEGER
		do
			l_dfa := dfa
			l_cat_table := categories_table
			from
				i := l_cat_table.lower;
				io.put_string (" LEXICAL%N Categories table.%N From ");
				io.put_integer (i)
			until
				i = l_cat_table.upper
			loop
				i := i + 1;
				if l_cat_table.item (i) /= l_cat_table.item (i - 1) then
					io.put_string (" to ");
					io.put_integer (i - 1);
					io.put_string (" ");
					io.put_integer (l_cat_table.item (i - 1));
					io.put_string ("th category.%N From ");
					io.put_integer (i)
				end
			end;
			io.put_string (" to ");
			io.put_integer (i);
			io.put_string (" ");
			io.put_integer (l_cat_table.item (i));
			io.put_string ("-th category.%N End of categories table.%N");
			l_dfa.trace;
			io.put_string (" End LEXICAL.");
			io.new_line
		end;

feature -- Obsolete

	go_on
			obsolete "Use `get_token' directly. [2017-05-31]"
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

	initialize
			-- Create data structures for the lexical analyzer.
		do
			create_buffers (Standard_buffer_size, Standard_line_length);
			if keyword_h_table = Void then
				create keyword_h_table.make (1)
			end;
			end_of_text := False
		end;

feature {LEXICAL, LEX_BUILDER} -- Implementation

	initialize_attributes (d: FIXED_DFA; c: ARRAY [INTEGER]; k: detachable HASH_TABLE [INTEGER, STRING]; b: BOOLEAN)
			-- Set the first four attributes of Current.
		do
			dfa := d;
			categories_table := c;
			if k = Void then
				create keyword_h_table.make (1)
			else
				keyword_h_table := k;
			end
			keywords_case_sensitive := b
		end;

feature -- Implementation

	dfa: FIXED_DFA
			-- Automaton used for the parsing

feature {NONE} -- Implementation

	Standard_buffer_size: INTEGER = 10240;
			-- Standard buffer size

	Extra_buffer_size: INTEGER = 4096;
			-- size added to the initial `buffer_size' when the current token
			-- is too big.
			-- `Extra_buffer_size' should be less than `Standard_buffer_size'.

	Standard_line_length: INTEGER = 1024;
			-- Standard line length

	Max_token_length: INTEGER = 256;
			-- Maximum length for a token

	Almost_end_of_buffer: INTEGER = 9984;
			-- Buffer_size minus Max_token_length

	Close_of_file: INTEGER = 255;
			-- End-of-file indicator on some platforms

	categories_table: ARRAY [INTEGER];
			-- For each input, category number

	keyword_h_table: HASH_TABLE [INTEGER, STRING]
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

	lower_word: detachable STRING;
			-- String used to avoid modifying last_string_read

	read_index: INTEGER;
			-- Current position in buffer

	reset_data
		do
			read_index := 1;
			token_end := buffer_size
		end;

	is_keyword (word: STRING): BOOLEAN
			-- Is `word' a keyword included in the
			-- last token type read?
		local
			l_word: like lower_word
		do
			Result := token_type = keyword_h_table.item (word);
			if not Result and not keywords_case_sensitive then
				l_word := word.as_lower
				lower_word := l_word
				Result := token_type = keyword_h_table.item (l_word)
			end
		end;

note
	copyright:	"Copyright (c) 1984-2017, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end

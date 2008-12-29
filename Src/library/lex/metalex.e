note

	description:
		"Mechanisms for building lexical analyzers from regular expressions."
	legal: "See notice at end of class."

	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class METALEX inherit

	HIGH_BUILDER
		export
			{NONE} freeze_lexical
		redefine
			raise_error
		end

create

	make, make_extended

feature -- Initialization

	make_analyzer
			-- Create analyzer (if Void) and initialize it.
		require
			not_initialized: not initialized
		do
			freeze_lexical;
			if analyzer = Void then
				create analyzer.make
			end;
			analyzer.initialize_attributes (dfa, categories_table,
				keyword_h_table, keywords_case_sensitive);
			initialized := True
		ensure
			initialized;
			analyzer_created: analyzer /= Void;
			lexical_frozen
		end; 

feature -- Element change

	put_expression (s: STRING; n: INTEGER; c: STRING)
			-- Record the regular expression described by `s'
			-- and associate it with token type `n' and name `c'.
		require
			source_long_enough: s.capacity > 0
		do
			construct := c;
			put_nameless_expression (s, n)
		end; 

	add_word (s: STRING; n: INTEGER)
			-- Record the word `s' and
			-- associate it with token type `n'.
		require
			s_not_void: s /= Void;
			s_not_empty: s.capacity >= 1
		do
			set_word (s);
			select_tool (last_created_tool);
			associate (last_created_tool, n)
		end; 

feature -- Input

	read_grammar (token_file_name: STRING)
			-- Create lexical analyzer for grammar in file of name
			-- `token_file_name'. File structure:
			-- One or more lines of the form
			-- `name'  `regular_expression'
			-- then a line beginning with two dashes --
			-- then zero or more lines containing one keyword each.
		do
			create token_file.make_open_read (token_file_name);
			record_atomics;
			record_keywords;
			make_analyzer
		ensure
			analyzer_exists: analyzer /= Void
		end; 

	No_token: INTEGER = 0

feature {NONE} -- Implementation

	construct: STRING;
			-- Construct including description
			-- For error messages

	give_h_table (d: HASH_TABLE [INTEGER, STRING])
			-- Set the h_table to d.
			-- Used when the h_table is not built by a `LEX_BUILDER'.
		do
			keyword_h_table := d
		end; 

	token_file: PLAIN_TEXT_FILE;

	record_atomics
			-- Record the regular expressions with their names and
			-- their line numbers as token identifiers.
		local
			token_name, regular: STRING;
			id: INTEGER
		do
			from
				id := 1;
				token_file.read_word;
				token_name := token_file.last_string.twin
				token_file.read_line;
				regular := token_file.last_string.twin
			until
				token_name.is_equal ("--")
			loop
				put_expression (regular, id, token_name);
				token_file.read_word;
				token_name := token_file.last_string.twin
				token_file.read_line;
				regular := token_file.last_string.twin
				id := id + 1
			end
		end; 

	record_keywords
			-- Record the keywords with their names, with type
			-- corresponding to the last atomic expression read.
		local
			keyword_name: STRING;
			keyword_type: INTEGER
		do
			from
					-- The type of the keywords
					-- corresponds to the last type recorded.
				keyword_type := token_type_list.last;
				token_file.read_word;
				keyword_name := token_file.last_string.twin
			until
				token_file.end_of_file
			loop
				put_keyword (keyword_name, keyword_type);
				token_file.read_word;
				keyword_name := token_file.last_string.twin
			end
		end; 

	raise_error (pos: INTEGER; expected: CHARACTER; mes: STRING)
			-- Print an error message and stop parsing.
			-- The message is recorded in "error_list".
		require else
			parsing_not_stopped: not parsing_stopped
		local
			error_position: INTEGER;
			message: STRING
		do
			create message.make (0);
			if description_length = 1 or pos < 1 then
				error_position := 1
			elseif pos < description_length then
				error_position := pos
			else
				error_position := description_length - 1
			end;
			message.append ("Metalex, construct ");
			message.append (construct);
			message.append (", error in format near: ``");
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
			message.append ("%NParsing of the grammar stopped.%N");
			error_list.add_message (message);
			parsing_stopped := True
		end 

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class METALEX


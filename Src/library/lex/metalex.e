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
		local
			l_dfa: like dfa
			l_categories_table: like categories_table
			l_keyword_h_table: like keyword_h_table
			l_analyzer: like analyzer
		do
			freeze_lexical;
			l_analyzer := analyzer
			if l_analyzer = Void then
				create l_analyzer.make
				analyzer := l_analyzer
			end;

			l_dfa := dfa
			l_categories_table := categories_table
			l_keyword_h_table := keyword_h_table
				--| implied by post-condition of `freeze_lexical'
			check
				l_dfa_attached: l_dfa /= Void
				l_categories_table_attached: l_categories_table /= Void
				l_keyword_h_table_attached: l_keyword_h_table /= Void
			end
			l_analyzer.initialize_attributes (l_dfa, l_categories_table, l_keyword_h_table, keywords_case_sensitive);
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

	construct: detachable STRING;
			-- Construct including description
			-- For error messages

	give_h_table (d: HASH_TABLE [INTEGER, STRING])
			-- Set the h_table to d.
			-- Used when the h_table is not built by a `LEX_BUILDER'.
		do
			keyword_h_table := d
		end;

	token_file: detachable PLAIN_TEXT_FILE;

	record_atomics
			-- Record the regular expressions with their names and
			-- their line numbers as token identifiers.
		require
			token_file_attached: token_file /= Void
		local
			l_token_file: like token_file
			l_token_name: detachable STRING;
			l_regular: detachable STRING
			id: INTEGER
		do
			l_token_file := token_file
			check l_token_file_attached: l_token_file /= Void end

			l_token_file.read_word;
			l_token_name := l_token_file.last_string
			check l_token_name_attached: l_token_name /= Void end
			l_token_name := l_token_name.twin
			l_token_file.read_line;
			l_regular := l_token_file.last_string
			check l_regular_attached: l_regular /= Void end
			l_regular := l_regular.twin

			from
				id := 1;
			until
				l_token_name ~ "--"
			loop
				put_expression (l_regular, id, l_token_name);
				l_token_file.read_word;
				l_token_name := l_token_file.last_string
				check l_token_name_attached: l_token_name /= Void end
				l_token_name := l_token_name.twin
				l_token_file.read_line;
				l_regular := l_token_file.last_string
				check l_regular_attached: l_regular /= Void end
				l_regular := l_regular.twin
				id := id + 1
			end
		end;

	record_keywords
			-- Record the keywords with their names, with type
			-- corresponding to the last atomic expression read.
		require
			token_file_attached: token_file /= Void
			token_type_list_attached: token_type_list /= Void
		local
			l_token_file: like token_file
			l_token_type_list: like token_type_list
			l_keyword_name: detachable STRING;
			l_keyword_type: INTEGER
		do
			l_token_file := token_file
			l_token_type_list := token_type_list

				--| Implied by preconditions
			check
				l_token_file_attached: l_token_file /= Void
				l_token_type_list_attached: l_token_type_list /= Void
			end

				-- The type of the keywords
				-- corresponds to the last type recorded.
			l_keyword_type := l_token_type_list.last;
			l_token_file.read_word;
			l_keyword_name := l_token_file.last_string
			check l_keyword_name_attached: l_keyword_name /= Void end
			l_keyword_name := l_keyword_name.twin

			from
			until
				l_token_file.end_of_file
			loop
				put_keyword (l_keyword_name, l_keyword_type);
				l_token_file.read_word;
				l_keyword_name := l_token_file.last_string
				check l_keyword_name_attached: l_keyword_name /= Void end
				l_keyword_name := l_keyword_name.twin
			end

				-- The file should have read to the end.
			check l_token_file_read: l_token_file.end_of_file end
		end;

	raise_error (pos: INTEGER; expected: CHARACTER; mes: STRING)
			-- Print an error message and stop parsing.
			-- The message is recorded in "error_list".
		local
			error_position: INTEGER;
			message: STRING
			l_construct: like construct
			l_description: like description
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
			l_construct := construct
			check l_construct_attached: l_construct /= Void end
			message.append (l_construct);
			message.append (", error in format near: ``");
			l_description := description
			check l_description_attached: l_description /= Void end
			message.extend (l_description.item (error_position));
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
	copyright:	"Copyright (c) 1984-2009, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"




end -- class METALEX


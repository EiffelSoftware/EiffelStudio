
indexing

	description:
		"Mechanisms for building lexical analyzers from regular expressions."

	copyright: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class METALEX inherit

	HIGH_BUILDER
		redefine
			raise_error
		end

creation

	make

feature

	make_analyzer is
			-- Create analyzer (if Void) and initialize it.
		do
			freeze;
			if analyzer = Void then
				!!analyzer.make
			end;
			analyzer.initialize_attributes (dfa, categories_table,
				keyword_h_table, keywords_case_sensitive);
			initialized := True
		end; -- make_analyzer

	put_expression (s: STRING; n: INTEGER; c: STRING) is
			-- Record the regular expression described by `s',
			-- associate it with token type `n' and name `c'.
		require
			source_long_enough: s.capacity > 0
		do
			construct := c;
			put_nameless_expression (s, n)
		end; -- put_expression

	read_grammar (token_file_name: STRING) is
			-- Create lexical analyzer for grammar
			-- given in file of name `token_file_name'.
			-- The file should be structured as follows:
			-- One or more lines of the form
			-- `name regular_expression',
			-- Then a line beginning with two dashes --,
			-- Then zero or more lines containing one
			-- keyword each.
		do
			!!token_file.make_open_read (token_file_name);
			record_atomics;
			record_keywords;
			make_analyzer
		ensure
			analyzer_exists: analyzer /= Void
		end; -- read_grammar

	add_word (s: STRING; n: INTEGER) is
			-- Record the word `s',
			-- associate it with token type `n'.
		require
			s_not_void: s /= Void;
			s_not_empty: s.capacity >= 1
		do
			set_word (s);
			select_tool (last_created_tool);
			associate (last_created_tool, n)
		end; -- add_word

	No_token: INTEGER is 0

feature {NONE}

	construct: STRING;
			-- Construct including description
			-- For error messages

	give_h_table (d: HASH_TABLE [INTEGER, STRING]) is
			-- Set the h_table to d.
			-- Used when the h_table is not built by a LEX_BUILDER.
		do
			keyword_h_table := d
		end; -- give_h_table

	token_file: UNIX_FILE;

	record_atomics is
			-- Record the regular expressions with their names and
			-- their line numbers as token identifiers.
		local
			token_name, regular: STRING;
			id: INTEGER
		do
			from
				id := 1;
				token_file.readword;
				token_name := clone (token_file.laststring);
				token_file.readline;
				regular := clone (token_file.laststring);
			until
				token_name.is_equal ("--")
			loop
				put_expression (regular, id, token_name);
				token_file.readword;
				token_name := clone (token_file.laststring);
				token_file.readline;
				regular := clone (token_file.laststring);
				id := id + 1
			end
		end; -- record_atomics

	record_keywords is
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
				token_file.readword;
				keyword_name := clone (token_file.laststring);
			until
				token_file.end_of_file
			loop
				put_keyword (keyword_name, keyword_type);
				token_file.readword;
				keyword_name := clone (token_file.laststring)
			end
		end; -- record_keywords

	raise_error (pos: INTEGER; expected: CHARACTER; mes: STRING) is
			-- Print an error message and stop parsing.
			-- The message is recorded in "error_list".
		require else
			parsing_not_stopped: not parsing_stopped
		local
			error_position: INTEGER;
			message: STRING
		do
			!!message.make (0);
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
			message.append (error_position.out);
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
		end -- raise_error

invariant

	cursor_not_too_far: cursor <= description_length

end -- METALEX
 

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

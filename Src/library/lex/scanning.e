--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

-- Class for building and using lexical analyzers.

indexing

	date: "$Date$";
	revision: "$Revision$"

class SCANNING

inherit

	METALEX

creation

	make

feature

	build (store_file_name, grammar_file_name: STRING) is
			-- Create a lexical analyzer.
			-- If `store_file_name' is the name of an existing file,
			-- use the analyzer stored in that file.
			-- Otherwise read in the grammar from `grammar_file_name',
			-- create an analyzer, and store it in `store_file_name'.
		require
			store_file_name /= Void
		local
			store_file: UNIX_FILE
		do
			!!store_file.make (store_file_name);
			if not store_file.exists then
				build_from_grammar (store_file_name, grammar_file_name)
			end;
			retrieve_analyzer (store_file_name)
		ensure
			analyzer_exists: analyzer /= Void
		end; -- build

	analyze (input_file_name: STRING) is
			-- Perform lexical analysis on file of name `input_file_name'.
		do
			from
				analyzer.set_file (input_file_name);
				begin_analysis
			until
				analyzer.end_of_text
			loop
				analyzer.get_any_token;
				do_a_token (analyzer.last_token)
			end;
			end_analysis
		end; -- decode

	end_analysis is
			-- Terminate lexical analysis.
			-- The default version of this procedure, given here,
			-- does nothing.
			-- This may be redefined in descendants of this class
			-- for specific processing.
		do
		end; -- end_analysis

	begin_analysis is
			-- Initialize lexical analysis.
			-- The default version of this procedure, given here,
			-- simply prints header information.
			-- This may be redefined in descendants of this class
			-- for specific processing.
		do
				io.new_line;
				io.new_line;
				io.putstring ("--------------- LEXICAL ANALYSIS: ----");
				io.new_line;
				io.new_line
		end; -- begin_analysis

	do_a_token (read_token: TOKEN) is
			-- Handle `read_token'.
			-- The default version of this procedure, given here,
			-- simply prints information on `read_token'.
			-- This may be redefined in descendants of this class
			-- for specific processing.
		require
			argument_not_void: read_token /= Void
		local
			type: INTEGER
		do
			type := read_token.type;
			if read_token.keyword_code /= -1 then
				io.putstring ("Keyword:  ");
				io.putstring (read_token.string_value);
				io.new_line
			elseif type /= 0 then
				io.putstring ("Token type ");
				io.putint (read_token.type);
				io.putstring (": ");
				io.putstring (read_token.string_value);
				io.new_line
			end
		end -- do_a_token

feature {NONE}

	build_from_grammar (store_file_name, grammar_file_name: STRING) is
			-- From the grammar in file of name `grammar_file_name',
			-- make a lexical analyzer for Eiffel
			-- and store it into file of name `store_file_name'
		do
			make;
			read_grammar (grammar_file_name);
			store_analyzer (store_file_name)
		ensure
			analyzer_exists: analyzer /= Void
		end -- build_from_grammar

end -- class SCANNING

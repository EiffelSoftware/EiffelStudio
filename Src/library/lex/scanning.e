indexing

	description:
		"Mechanisms for building and using lexical analyzers. %
		%This class may be used as ancestor by classes needing its facilities.";

	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class SCANNING inherit

	METALEX

create

	make, make_extended

feature -- Initialization

	build (store_file_name, grammar_file_name: STRING) is
			-- Create a lexical analyzer.
			-- If `store_file_name' is the name of an existing file,
			-- use  analyzer stored in that file.
			-- Otherwise read grammar from `grammar_file_name',
			-- create an analyzer, and store it in `store_file_name'.
		require
			store_file_name /= Void
		local
			store_file: RAW_FILE
		do
			create store_file.make (store_file_name);
			if not store_file.exists then
				build_from_grammar (store_file_name, grammar_file_name)
			end;
			retrieve_analyzer (store_file_name)
		ensure
			analyzer_exists: analyzer /= Void
		end; 

feature -- Status setting

	analyze (input_file_name: STRING) is
			-- Perform lexical analysis on file
			-- of name `input_file_name'.
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
		end; 

feature -- Output

	end_analysis is
			-- Terminate lexical analysis.
			-- This default version of the procedure
			-- does nothing.
			-- It may be redefined in descendants
			-- for specific processing.
		do
		end;

	begin_analysis is
			-- Initialize lexical analysis.
			-- This default version of the procedure
			-- simply prints header information.
			-- It may be redefined in descendants
			-- for specific processing.
		do
				io.new_line;
				io.new_line;
				io.put_string ("--------------- LEXICAL ANALYSIS: ----");
				io.new_line;
				io.new_line
		end;

	do_a_token (read_token: TOKEN) is
			-- Handle `read_token'.
			-- This default version of the procedure
			-- simply prints information on `read_token'.
			-- It may be redefined in descendants
			-- for specific processing.
		require
			argument_not_void: read_token /= Void
		local
			type: INTEGER
		do
			type := read_token.type;
			if read_token.keyword_code /= -1 then
				io.put_string ("Keyword:  ");
				io.put_string (read_token.string_value);
				io.put_string (" Code: ");
				io.put_integer (read_token.keyword_code);
				io.new_line
			elseif type /= 0 then
				io.put_string ("Token type ");
				io.put_integer (read_token.type);
				io.put_string (": ");
				io.put_string (read_token.string_value);
				io.new_line
			end
		end 

feature {NONE} -- Implementation

	build_from_grammar (store_file_name, grammar_file_name: STRING) is
			-- From the grammar in file of name `grammar_file_name',
			-- make a lexical analyzer for Eiffel
			-- and store it into file of name `store_file_name'
		do
			make_extended (last_character_code);
			read_grammar (grammar_file_name);
			store_analyzer (store_file_name)
		ensure
			analyzer_exists: analyzer /= Void
		end 

end -- class SCANNING

--|----------------------------------------------------------------
--| EiffelLex: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
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


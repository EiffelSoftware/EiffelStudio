-- Syntax error

class SYNTAX_ERROR

inherit

	ERROR
		redefine
			trace, stone
		end

creation

	init

feature -- Attributes

	file_name: STRING;
			-- Path to the file where the syntax error happened

	start_position: INTEGER;
			-- Stating position of the token involved in the syntax error

	end_position: INTEGER;
			-- Ending position of the of the token involved in the syntax
			-- error

feature -- Creation

	init is
			-- Initialize `start_position' and `end_position'.
		do
			start_position := get_start_position;
			end_position := get_end_position;
			file_name := get_yacc_file_name;
		end;

feature -- Conveniences

	set_file_name (s: STRING) is
			-- Assign `s' to `file_name'.
		do
			file_name := s;
		end;

	set_start_position (i: INTEGER) is
			-- Assign `i' to `start_position'.
		do
			start_position := i;
		end;

	set_end_position (i: INTEGER) is
			-- Assign `i' to `end_position'.
		do
			end_position := i;
		end;

feature -- Error code

	code: STRING is "Syntax error";
			-- Error code

feature

	build_explain is
		do
		end;

	trace is
			-- Debug purpose
		local
			dummy_reference: CLASS_C;
			file: UNIX_FILE;
			previous_line: STRING;
			current_line: STRING;
			next_line: STRING;
			start_line_pos: INTEGER;
			line_number: INTEGER;
		do
			!!file.make_open_read (file_name);
			from
			until
				file.position > start_position or else file.end_of_file
			loop
				previous_line := current_line;
				start_line_pos := file.position;
				line_number := line_number + 1;
				file.readline;
				current_line := file.laststring.duplicate;
			end;
			if not file.end_of_file then
				file.readline;
				next_line := file.laststring.duplicate;
			end;
			file.close;

			put_string ("Syntax error at line ");
			put_int (line_number);
			if Lace.parsed then
				-- Error happened in a class
				put_string (" in class ");
				put_clickable_string (
						stone (dummy_reference),
						System.current_class.signature)
			else
				put_clickable_string (stone (dummy_reference), " in Ace file")
			end;
			new_line;
			build_explain;
			display_line (previous_line);
			display_error_line (current_line, start_position - start_line_pos);
			display_line (next_line);
		end;

	display_line (a_line: STRING) is
		local
			i: INTEGER;
			nb: INTEGER;
			c: CHARACTER;
		do
			from
				nb := a_line.count;
			until
				i = nb
			loop
				i := i + 1;
				c := a_line.item (i);
				if c = '%T' then
					put_string ("    ")
				else
					put_char (c)
				end;
			end;
			new_line;
		end;

	display_error_line (a_line: STRING; pos: INTEGER) is
		local
			i, nb: INTEGER;
			c: CHARACTER;
			position, nb_tab: INTEGER;
		do
			from
				nb := a_line.count;
			until
				i = nb
			loop
				i := i + 1;
				c := a_line.item (i);
				if c = '%T' then
					put_string ("    ");
					if i < pos then
						nb_tab := nb_tab + 1;
					end;
				else
					put_char (c)
				end;
			end;
			new_line;
			position := pos + 3*nb_tab;
			if position = 0 then
				put_string ("^---------------------------%N");
			else
				from
					i := 1;
				until
					i > position
				loop
					put_char ('-');
					i := i + 1;
				end;
				put_string ("^%N");
			end;
		end;

feature {NONE} -- Externals

	get_start_position: INTEGER is
			-- Get start position processed by yacc
		external
			"C"
		end;

	get_end_position: INTEGER is
			-- Get end position processed by yacc.
		external	
			"C"
		end;

	get_yacc_file_name: STRING is
			-- Get file name processed by yacc.
		external
			"C"
		end;

feature -- stoning

	stone (reference_class: CLASS_C): SYNTAX_STONE is
			-- Reference class is useless here
		do
			!!Result.make (Current)
		end

end

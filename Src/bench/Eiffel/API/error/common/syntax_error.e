-- Syntax error

class SYNTAX_ERROR

inherit

	ERROR
		redefine
			trace
		end;
	SHARED_WORKBENCH

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

feature -- Property

	code: STRING is "Syntax error";
			-- Error code

	syntax_message: STRING is 
			-- Specific syntax message. 
			-- (By default, it is empty)
		do
			Result := ""
		ensure
			non_void_result: Result /= Void
		end;	

feature

	build_explain (ow: OUTPUT_WINDOW) is
		local
			msg: STRING
		do
			msg := syntax_message;
			if not msg.empty then
				ow.put_char ('(');
				ow.put_string (msg)
				ow.put_string (")%N");
			end
		end;

	trace (ow: OUTPUT_WINDOW) is
			-- Debug purpose
		local
			file: PLAIN_TEXT_FILE;
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
				current_line := clone (file.laststring)
			end;
			if not file.end_of_file then
				file.readline;
				next_line := clone (file.laststring)
			end;
			file.close;

			ow.put_string ("Syntax error at line ");
			ow.put_int (line_number);
			if Lace.parsed then
				if Lace.successfull then
						-- Error happened in a class
					ow.put_string (" in class ");
					ow.put_class_syntax (Current, System.current_class.e_class, 
							System.current_class.signature)
				else
						-- Error happened while parsing a "use" file
					ow.put_string (" in Cluster_properties %"Use%" file")
					if file_name /= Void then
						ow.put_string ("%N     File: "); 
						ow.put_string (file_name);
					end;
				end
			else
				ow.put_ace_syntax (Current, " in Ace file")
			end;
			ow.new_line;
			build_explain (ow);
			display_line (ow, previous_line);
			display_error_line (ow, current_line, 
						start_position - start_line_pos);
			display_line (ow, next_line);
		end;

	display_line (ow: OUTPUT_WINDOW; a_line: STRING) is
		local
			i: INTEGER;
			nb: INTEGER;
			c: CHARACTER;
		do
			if a_line /= Void then
				from
					nb := a_line.count;
				until
					i = nb
				loop
					i := i + 1;
					c := a_line.item (i);
					if c = '%T' then
						ow.put_string ("    ")
					else
						ow.put_char (c)
					end;
				end;
				ow.new_line;
			end;
		end;

	display_error_line (ow: OUTPUT_WINDOW; a_line: STRING; pos: INTEGER) is
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
					ow.put_string ("    ");
					if i <= pos then
						nb_tab := nb_tab + 1;
					end;
				else
					ow.put_char (c)
				end;
			end;
			ow.new_line;
			position := pos + 3*nb_tab;
			if position = 0 then
				ow.put_string ("^---------------------------%N");
			else
				from
					i := 1;
				until
					i > position
				loop
					ow.put_char ('-');
					i := i + 1;
				end;
				ow.put_string ("^%N");
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

end

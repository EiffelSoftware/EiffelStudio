indexing

	description: 
		"Syntax error.";
	date: "$Date$";
	revision: "$Revision $"

class SYNTAX_ERROR

inherit

	ERROR
		redefine
			trace
		end;
	SHARED_WORKBENCH

creation {ERROR_HANDLER}

	init

feature {NONE} -- Initialization

	init is
			-- Initialize `start_position' and `end_position'.
		do
			start_position := get_start_position;
			end_position := get_end_position;
			file_name := get_yacc_file_name;
			error_code := get_yacc_error_code
			error_message := get_yacc_error_message
		end;

feature -- Properties

	file_name: STRING;
			-- Path to the file where the syntax error happened

	start_position: INTEGER;
			-- Stating position of the token involved in the syntax error

	end_position: INTEGER;
			-- Ending position of the of the token involved in the syntax
			-- error

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

	error_code: INTEGER
			-- Specify the syntax error.

	error_message: STRING
			-- Specify the syntax error message.

feature -- Output

	build_explain (st: STRUCTURED_TEXT) is
		local
			msg: STRING
		do
			msg := syntax_message;
			if not msg.empty then
				st.add_char ('(');
				st.add_string (msg)
				st.add_string (")");
				st.add_new_line
			end
		end;

	trace (st: STRUCTURED_TEXT) is
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

			st.add_string ("Syntax error number `")
			st.add_int (error_code)
			st.add_string ("' at line ");
			st.add_int (line_number);
			if Lace.parsed then
				if Lace.successful then
						-- Error happened in a class
					st.add_string (" in class ");
					st.add_class_syntax (Current, System.current_class, 
							System.current_class.signature)
					if error_message /= Void then
						st.add_new_line;
						st.add_string (error_message)
						st.add_new_line;
					end
				else
						-- Error happened while parsing a "use" file
					st.add_string (" in Cluster_properties %"Use%" file")
					if file_name /= Void then
						st.add_new_line;
						st.add_string ("	 File: "); 
						st.add_string (file_name);
					end;
				end
			else
				st.add_ace_syntax (Current, " in Ace file")
			end;
			st.add_new_line;
			build_explain (st);
			display_line (st, previous_line);
			display_error_line (st, current_line, 
						start_position - start_line_pos);
			display_line (st, next_line);
		end;

	display_line (st: STRUCTURED_TEXT; a_line: STRING) is
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
						st.add_indent
					else
						st.add_char (c)
					end;
				end;
				st.add_new_line;
			end;
		end;

	display_error_line (st: STRUCTURED_TEXT; a_line: STRING; pos: INTEGER) is
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
					st.add_indent
					if i <= pos then
						nb_tab := nb_tab + 1;
					end;
				else
					st.add_char (c)
				end;
			end;
			st.add_new_line;
			position := pos + 3*nb_tab;
			if position = 0 then
				st.add_string ("^---------------------------");
				st.add_new_line
			else
				from
					i := 1;
				until
					i > position
				loop
					st.add_char ('-');
					i := i + 1;
				end;
				st.add_string ("^");
				st.add_new_line
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

	get_yacc_error_code: INTEGER is
			-- Get error code processed by yacc.
		external
			"C"
		end;

	get_yacc_error_message: STRING is
			-- Get error message processed by yacc.
		external
			"C"
		end;

end -- class SYNTAX_ERROR

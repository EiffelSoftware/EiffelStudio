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
		end

	SHARED_WORKBENCH
		undefine
			is_equal
		end

	SHARED_EIFFEL_PARSER
		undefine
			is_equal
		end

creation {ERROR_HANDLER}

	init

creation

	make

feature {NONE} -- Initialization

	make (s, e: INTEGER; f: like file_name; c: INTEGER; m: STRING; u: BOOLEAN) is
			-- Create a new SYNTAX_ERROR.
		require
			f_not_void: f /= Void
			m_not_void: m /= Void
		do
			start_position := s
			end_position := e
			file_name := f
			error_code := c
			error_message := m
			is_in_use_file := u
		ensure
			start_position_set: start_position = s
			end_position_set: end_position = e
			file_name_set: file_name = f
			error_code_set: error_code = c
			error_message_set: error_message = m
		end

	init is
			-- Initialize `start_position' and `end_position'.
		local
			p: like Eiffel_parser
			a_filename: FILE_NAME
		do
			p := Eiffel_parser
			create a_filename.make_from_string (p.filename)
			make (p.start_position, p.end_position, a_filename,
				p.error_code, p.error_message, False)
		end

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

	is_in_use_file: BOOLEAN
			-- Did error occurred when parsing `Use' clause of an Ace file.

feature -- Output

	build_explain (st: STRUCTURED_TEXT) is
		local
			msg: STRING
		do
			msg := syntax_message;
			if not msg.is_empty then
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

			st.add_string ("Syntax error at line ");
			st.add_int (line_number);
			if Lace.successful then
					-- Error happened in a class
				st.add_string (" in class ");
				st.add_class_syntax (Current, System.current_class, 
						System.current_class.class_signature)
				if error_message /= Void then
					st.add_new_line;
					st.add_string (error_message)
					st.add_new_line;
				end
			else
				if not is_in_use_file then
					st.add_ace_syntax (Current, " in Ace file")
				else
						-- Error happened while parsing a "use" file
					st.add_string (" in Cluster_properties %"Use%" file")
					if file_name /= Void then
						st.add_new_line
						st.add_string ("	 File: ");
						st.add_string (file_name)
					end
				end
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

end -- class SYNTAX_ERROR

indexing

	description: 
		"Syntax error."
	date: "$Date$"
	revision: "$Revision $"

class SYNTAX_ERROR

inherit
	ERROR
		redefine
			trace, file_name
		end

	SYNTAX_MESSAGE
		
	SHARED_WORKBENCH

	SHARED_EIFFEL_PARSER

create
	make, init

feature {NONE} -- Initialization

	make (s, e: INTEGER; f: like file_name; m: STRING; u: BOOLEAN) is
			-- Create a new SYNTAX_ERROR.
		require
			f_not_void: f /= Void
			m_not_void: m /= Void
		do
			set_position (s, e)
			file_name := f
			error_message := m
			is_in_use_file := u
		ensure
			line_set: line = s
			column_set: column = e
			file_name_set: file_name = f
			error_message_set: error_message = m
			is_in_use_file_set: is_in_use_file = u
		end

	init is
			-- Initialize `line' and `column'.
		local
			p: like Eiffel_parser
			a_filename: FILE_NAME
		do
			p := Eiffel_parser
			create a_filename.make_from_string (p.filename)
			make (p.line, p.column, a_filename, p.error_message, False)
		end

feature -- Properties

	error_message: STRING
			-- Specify syntax issue message.

	file_name: STRING
			-- Path to file where syntax issue happened

	code: STRING is "Syntax error"
			-- Error code

	syntax_message: STRING is 
			-- Specific syntax message. 
			-- (By default, it is empty)
		do
			Result := ""
		ensure
			non_void_result: Result /= Void
		end

	is_in_use_file: BOOLEAN
			-- Did error occurred when parsing `Use' clause of an Ace file.

feature -- Output

	build_explain (st: STRUCTURED_TEXT) is
		local
			msg: STRING
		do
			msg := syntax_message
			if not msg.is_empty then
				st.add_char ('(')
				st.add_string (msg)
				st.add_string (")")
				st.add_new_line
			end
		end

	trace (st: STRUCTURED_TEXT) is
			-- Debug purpose
		do
			initialize_output
			st.add_string ("Syntax error at line ")
			st.add_int (line)
			if Lace.successful then
					-- Error happened in a class
				st.add_string (" in class ")
				st.add_class_syntax (Current, System.current_class, 
						System.current_class.class_signature)
				if error_message /= Void then
					st.add_new_line
					st.add_string (error_message)
					st.add_new_line
				end
			else
				if not is_in_use_file then
					st.add_ace_syntax (Current, " in Ace file")
				else
						-- Error happened while parsing a "use" file
					st.add_string (" in Cluster_properties %"Use%" file")
					if file_name /= Void then
						st.add_new_line
						st.add_string ("	 File: ")
						st.add_string (file_name)
					end
				end
			end
			st.add_new_line
			build_explain (st)
			display_line (st, previous_line)
			display_syntax_line (st, current_line)
			display_line (st, next_line)
		end

end -- class SYNTAX_ERROR

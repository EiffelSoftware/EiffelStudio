indexing
	description: "To represent a message related to syntax."
	date: "$Date$"
	revision: "$Revision$"

class
	SYNTAX_MESSAGE

create
	make

feature {NONE} -- Initialization

	make (s, e: INTEGER; f: like file_name; c: INTEGER; m: STRING) is
			-- Create a new SYNTAX_ERROR.
		require
			f_not_void: f /= Void
			m_not_void: m /= Void
		do
			start_position := s
			end_position := e
			file_name := f
			code := c
			message := m
		ensure
			start_position_set: start_position = s
			end_position_set: end_position = e
			file_name_set: file_name = f
			code_set: code = c
			message_set: message = m
		end

feature -- Properties

	file_name: STRING
			-- Path to file where syntax issue happened

	start_position: INTEGER
			-- Stating position token involved in syntax issue

	end_position: INTEGER
			-- Ending position of of token involved in syntax issue

	code: INTEGER
			-- Specify syntax issue.

	message: STRING
			-- Specify syntax issue message.

	line_number: INTEGER
			-- Line number in `filename' where `start_position' is located.

feature {NONE} -- Output

	previous_line, current_line, next_line: STRING
			-- Surrounding lines where syntax message occurs.
			
	start_line_pos: INTEGER
			-- Start position of line in `filename' where `start_position' is located.
			
	initialize_output is
			-- Set `previous_line', `current_line' and `next_line' with their proper values
			-- taken from file `file_name'.
		local
			file: PLAIN_TEXT_FILE
		do
			create file.make_open_read (file_name)
			from
			until
				file.position > start_position or else file.end_of_file
			loop
				previous_line := current_line
				start_line_pos := file.position
				line_number := line_number + 1
				file.readline
				current_line := file.laststring.twin
			end
			if not file.end_of_file then
				file.readline
				next_line := file.laststring.twin
			end
			file.close
		end

	display_line (st: STRUCTURED_TEXT; a_line: STRING) is
			-- Display `a_line' in `st'. It translates `%T' accordingly to `st' specification
			-- which is to call `add_indent'.
		require
			st_not_void: st /= Void
		local
			i: INTEGER
			nb: INTEGER
			c: CHARACTER
		do
			if a_line /= Void then
				from
					nb := a_line.count
				until
					i = nb
				loop
					i := i + 1
					c := a_line.item (i)
					if c = '%T' then
						st.add_indent
					else
						st.add_char (c)
					end
				end
				st.add_new_line
			end
		end

	display_syntax_line (st: STRUCTURED_TEXT; a_line: STRING; pos: INTEGER) is
			-- Display `a_line' which does like `display_line' but with an additional
			-- arrowed line that points out to `pos' where syntax issue is located.
		require
			st_not_void: st /= Void
			a_line_not_void: a_line /= Void
		local
			i, nb: INTEGER
			c: CHARACTER
			position, nb_tab: INTEGER
		do
			from
				nb := a_line.count
			until
				i = nb
			loop
				i := i + 1
				c := a_line.item (i)
				if c = '%T' then
					st.add_indent
					if i <= pos then
						nb_tab := nb_tab + 1
					end
				else
					st.add_char (c)
				end
			end
			st.add_new_line
			position := pos + 3*nb_tab
			if position = 0 then
				st.add_string ("^---------------------------")
				st.add_new_line
			else
				from
					i := 1
				until
					i > position
				loop
					st.add_char ('-')
					i := i + 1
				end
				st.add_string ("^")
				st.add_new_line
			end
		end

end -- class SYNTAX_MESSAGE

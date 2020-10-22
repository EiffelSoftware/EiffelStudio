note
	description: "Summary description for {WRAPC_WIZARD_FUNCTION_GENERATOR}."
	date: "$Date$"
	revision: "$Revision$"

class
	WRAPC_WIZARD_FUNCTION_GENERATOR

create
	make

feature {NONE} -- Initialization

	make (a_header_path: STRING_32)
		do
			create list_of_functions.make (100)
			compile_function_expression
			read_file_line_by_line (create {PATH}.make_from_string (a_header_path))
		end

feature -- Access

	list_of_functions: ARRAYED_LIST [STRING]
			-- List of c functions

feature {NONE} -- Implementation

	read_file_line_by_line (a_path: PATH)
			-- Read a file located at `a_path` line by line.
			-- and extract the C function signatures.
		local
			l_file: FILE
			line: STRING
		do
			create {PLAIN_TEXT_FILE} l_file.make_with_path (a_path)
			if l_file.exists and then l_file.is_readable then
				l_file.open_read
				from
				until
					l_file.end_of_file
				loop
					l_file.read_line
					line := l_file.last_string
					extract_function (line)
				end
				l_file.close
			else
					--  Could not read the file `a_path`
			end
		end

	extract_function (a_line: STRING)
			-- Extract C function from the line.
			-- Update the list of c functions.
		local
			l_line: STRING
			is_first: BOOLEAN
			cc: CHARACTER_8
			i: INTEGER
			l_function: STRING
		do
			if is_valid_function (a_line) then
				l_line := a_line.twin
				i := l_line.last_index_of ('(', l_line.count)
				if i > 1 then
					from
						i := i - 1
						cc := l_line.at (i)
						if cc = ' ' then
								-- Skip spaces
							from
							until
								i = 0 or cc /= ' '
							loop
								i := i - 1
								if i >= 1 then
									cc := l_line.at (i)
								end
							end
						end
						is_first := False
						i := i - 1
					until
						i = 0 or is_first
					loop
						cc := l_line.at (i)
						if cc.is_space and not is_first then
							is_first := True
						else
							i := i - 1
						end
					end
				end
				if i = 0 then
					if not l_line.substring (1, l_line.count).is_empty then
						l_function := l_line.substring (1, l_line.count)
					end
				else
					if not l_line.substring (i, l_line.count).is_empty then
						l_function := l_line.substring (i, l_line.count)
					end
				end
				if l_function /= void then
					l_function.adjust
					if not l_function.starts_with ("(") then
						list_of_functions.force (l_function)
					end
				end
			end
		end

	c_function_expression: RX_PCRE_REGULAR_EXPRESSION

	c_function_pattern: STRING = "^(.+)?([a-zA-Z]\w*)(\s*)?\(.+\);"
			-- Regular expression to extract C function signature.

	is_valid_function (a_string: STRING): BOOLEAN
		local
			l_str: STRING
		do
			create l_str.make_from_string (a_string)
			Result := c_function_expression.recognizes (l_str)
		end

	compile_function_expression
			-- compile regular expression.
		do
			create c_function_expression.make
			c_function_expression.compile (c_function_pattern)
		end

end

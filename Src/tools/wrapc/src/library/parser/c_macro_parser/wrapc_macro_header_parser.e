note
	description: "[
		Macro support to WrapC, but only for macro definitions used to define constants. Everything else will be ignored.
	 	
	 	Grammar
	 	=======
		#define CNAME value
		or
		#define CNAME (expression)
		        
		CNAME
		    The name of the constant
		value
		    The value of the constant.
		expression
		    An expression whose value is assigned to the constant. The expression must be enclosed in parentheses.

		Examples:
		#define PI    3.1415926535897932384
		#define MULTI_LINE_STRING "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"\
		                          "bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb"\
		                          "ccccccccccccccccccccccccccccccccccccccccccccc"
		#define STRING "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
		#define A (20 / 2)
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	WRAPC_MACRO_HEADER_PARSER


create

	make

feature {NONE} -- Initialization

	make (a_path: PATH)
		do
			path := a_path
			create last_line.make_empty
			create last_constant.make_empty
			create last_type.make_empty
			create last_value.make_empty
			create {ARRAYED_LIST [TUPLE [constant:STRING; type: STRING; value: STRING]]} constants.make (5)
			compile_integer_regex
			compile_double_regex
			compile_hexa_regex
			compile_integer_expression
			compile_double_expression
			compile_comments_expression
		end

feature -- Parser

	reset
		do
			error_description := Void
		end

	constants: 	LIST [TUPLE [constant:STRING; type: STRING; value: STRING]]
			-- List of macro definitions used to define constants
			-- with constant name and type of the value.
			-- [INTEGER_64, REAL_64, STRING, CHARACTER_32, UNKOWN]



	parse_macro
		do
			initialize
			if not has_error and then has_next_line then
				from
					next_line
				until
					has_error or else end_of_file
				loop
					parse_line
					if has_next_line then
						next_line
					end
				end
			end
			finalize
		end

feature {NONE} -- Parser implementation


	initialize
		local
			l_file: like file
		do
			create {PLAIN_TEXT_FILE} l_file.make_with_path (path)
			if l_file.exists and then l_file.is_readable then
				l_file.open_read
				file := l_file
			else
				create error_description.make_from_string ("File is not readable or does not exist at path: " + path.out)
			end
		end

	finalize
		do
			if attached file as l_file then
				l_file.close
			end
		end

	parse_line
			-- #define cname value
			-- #define cname (expression)
		do
			if not last_line.is_empty then
				skip_white_spaces
				if last_line.at (cursor) = '#' then
					next
					if is_define then
						-- mark_define
						is_defined_supported := True
						next
						next
						next
						next
						next
						next
						skip_white_spaces
						create last_constant.make_empty
						parse_constant_name
						if is_defined_supported then
							skip_white_spaces
							is_value_supported := True
							parse_value
							if is_value_supported then
								last_constant.adjust
								constants.force ([last_constant, last_type.twin, last_value.twin])
							end
						end

					end
				end
			end
		end

	skip_white_spaces
			-- Remove white spaces
		do
			from
			until
				(last_line.at (cursor) /= ' ' and last_line.at (cursor) /= '%N' and last_line.at (cursor) /= '%R' and last_line.at (cursor) /= '%U' and last_line.at (cursor) /= '%T') or not has_next
			loop
				next
			end
		end

	is_define: BOOLEAN
			-- Word at index represents define?
		do
			Result := last_line.same_characters_general (define_id, 1, 6, cursor) -- 6 = define_id.count
		end


	parse_constant_name
		local
			l_constant_name: STRING
		do
			from
				create l_constant_name.make_empty
				l_constant_name.append_character (last_line.at (cursor))
				next
			until
				(last_line.at (cursor) = ' ' or last_line.at (cursor) = '%N' or last_line.at (cursor) = '%R' or last_line.at (cursor) = '%U' or last_line.at (cursor) = '%T' or last_line.at (cursor) = '(' ) or not has_next
			loop
				l_constant_name.append_character (last_line.at (cursor))
				next
			end
			if last_line.at (cursor) = '('  then
				is_defined_supported := False
				last_constant.append (l_constant_name)
			else
				if (last_line.at (cursor) /= ' ' or last_line.at (cursor) /= '%N' or last_line.at (cursor) /= '%R' or last_line.at (cursor) /= '%U' or last_line.at (cursor) /= '%T') then
					l_constant_name.append_character (last_line.at (cursor))
				end
				last_constant.append_string (l_constant_name)
			end
		end


	parse_value
		do
			last_type.wipe_out
			last_value.wipe_out
			if last_line.at (cursor) = '(' or last_line.at (cursor).is_digit or last_line.at (cursor) = '"'  or last_line.at (cursor) = ''' then
				if last_line.at (cursor) = '"'  then
					last_type := "STRING"
				end
				if last_line.at (cursor) = '''  then
					last_type := "CHARACTER_32"
				end
				skip_value
				clean_comments
				if last_type.is_empty then
					if is_valid_integer (last_value) then
						last_type := "INTEGER_64"
					elseif is_valid_double (last_value)	then
						last_type := "REAL_64"
					elseif is_valid_hexa (last_value) then
						last_type := "INTEGER"
					elseif is_valid_integer_expression (last_value) then
						last_type := "INTEGER_64"
						last_value.wipe_out
					elseif is_valid_double_expression (last_value) then
						last_type := "REAL_64"
						last_value.wipe_out
					else
						last_type := "UNKOWN"
					end
				else
					if last_type.is_equal ("CHARACTER_32") then
						last_value.replace_substring_all ("'", "")
					end
					if last_type.is_equal ("STRING") then
						last_value.replace_substring_all ("%"", "")
					end
				end
			else
				is_value_supported := False
			end
		end

	skip_value
		local
			is_multiline: BOOLEAN
		do
			if has_next then
				last_value.append_character (last_line.at (cursor))
				from
					next
					if last_line.at (cursor) = '\' then
						is_multiline := True
					end
				until
					not has_next
				loop
					last_value.append_character (last_line.at (cursor))
					next
				end
				if last_line.at (cursor) = '\' then
					is_multiline := True
				end

				if is_multiline and then has_next_line then
					last_value.append_string ("%N")
					next_line
					skip_value
				else
					last_value.append_character (last_line.at (cursor))
				end
			elseif last_line.at (cursor).is_digit  then
				last_value.append_character (last_line.at (cursor))
			end
		end

feature {NONE} -- Implementation

	is_value_supported: BOOLEAN

	is_defined_supported: BOOLEAN

	last_line: STRING

	last_constant: STRING

	last_type: STRING

	last_value: STRING

	cursor: INTEGER

	next
		require
			has_next
		do
			if cursor < last_line.count then
				cursor := cursor + 1
			end
		ensure
			limits: cursor <= last_line.count
		end

	has_next: BOOLEAN
		do
			Result := cursor < last_line.count
		end

	end_of_file: BOOLEAN
		do
			if not has_error and then attached file as l_file then
				Result := l_file.end_of_file
			else
				Result := True
			end
		end

	has_next_line: BOOLEAN
		do
			Result := not end_of_file
		end

	next_line
		require
			has_next_line: has_next_line
			not_has_error: not has_error
		do
			if attached file as l_file then
				l_file.read_line
				last_line := l_file.last_string.twin
				cursor := 1
			else
				last_line := ""
				cursor := 1
			end
		end


feature {NONE} -- Implementation

	path: PATH

	file: detachable FILE

	error_description: detachable STRING

	has_error: BOOLEAN
		do
			Result := attached error_description
		end


feature {NONE} -- Constants

	define_id: STRING = "define"

feature {NONE} -- Regex for Values.

	is_valid_integer (a_string: STRING): BOOLEAN
		local
			l_str: STRING
		do
			create l_str.make_from_string (a_string)
			l_str.prune_all (' ')
			Result := integer_regex.recognizes (l_str)
		end

	is_valid_double (a_string: STRING): BOOLEAN
		local
			l_str: STRING
		do
			create l_str.make_from_string (a_string)
			l_str.prune_all (' ')
			Result := double_regex.recognizes (l_str)
		end

	is_valid_hexa (a_string: STRING): BOOLEAN
		local
			l_str: STRING
		do
			create l_str.make_from_string (a_string)
			l_str.prune_all (' ')
			Result := hexa_regex.recognizes (l_str)
		end

	is_valid_integer_expression (a_string: STRING): BOOLEAN
		local
			l_str: STRING
		do
			create l_str.make_from_string (a_string)
			l_str.prune_all (' ')
			Result := integer_expression.recognizes (l_str)
		end

	clean_comments
			-- Remove comments from last_value.
		local
			l_str: STRING
		do
			create l_str.make_from_string (last_value)
			comments_expression.match_substring (l_str, 1, l_str.count)
			if comments_expression.match_count > 1 then
				last_value.remove_tail ((comments_expression.captured_end_position (1) - comments_expression.captured_start_position (1)) + 1)
				last_value.adjust
			end
		end

	is_valid_double_expression (a_string: STRING): BOOLEAN
		local
			l_str: STRING
		do
			create l_str.make_from_string (a_string)
			l_str.prune_all (' ')
			Result := double_expression.recognizes (l_str)
		end

	compile_integer_regex
		do
			create integer_regex.make
			integer_regex.compile (integer_pattern)
		end

	compile_double_regex
		do
			create double_regex.make
			double_regex.compile (double_pattern)
		end

	compile_hexa_regex
		do
			create hexa_regex.make
			hexa_regex.compile (hexadecimal_pattern)
		end

	compile_integer_expression
		do
			create integer_expression.make
			integer_expression.compile (integer_expressions_pattern)
		end

	compile_double_expression
		do
			create double_expression.make
			double_expression.compile (double_expressions_pattern)
		end

	compile_comments_expression
		do
			create comments_expression.make
			comments_expression.compile (comments_expressions_pattern)
		end


--For integers:         d+
--For decimal numbers:  \b\d+.\d+
--For scientific:       \b\d+e\d+
--For hexadecimal:      ^0([xX]{1})?[A-Fa-f0-9]+
--For integer expressions:  [-+(]*[\d]+[)]*([-+*/][-+(]*[\d]+[)]*)*
--For double expressions :  [-+(]*[\d|\d+.\d*]+[)]*([-+*/][-+(]*[\d]+[)]*)*
--For comments:				(/\*.*?\*/)|(//.*)

	integer_regex: RX_PCRE_REGULAR_EXPRESSION
	double_regex: RX_PCRE_REGULAR_EXPRESSION
	hexa_regex :RX_PCRE_REGULAR_EXPRESSION
	integer_expression: RX_PCRE_REGULAR_EXPRESSION
	double_expression: RX_PCRE_REGULAR_EXPRESSION
	comments_expression: RX_PCRE_REGULAR_EXPRESSION



	integer_pattern: STRING = "\d+"

	double_pattern: STRING = "\d*\.\d+"

	hexadecimal_pattern: STRING = "0([xX]{1})?[A-Fa-f0-9]+"

	integer_expressions_pattern: STRING = "[-+(]*[\d]+[)]*[>]*[<]*([-+*/][-+(]*[\d]+[)]*)*"

	double_expressions_pattern: STRING = "[-+(]*[\d|\d*\.\d*]+[)]*[>]*[<]*([-+*/][-+(]*[\d]+[)]*)*"

	comments_expressions_pattern: STRING = "(\/\*.*?\*\/)|(\/\/.*)"
end

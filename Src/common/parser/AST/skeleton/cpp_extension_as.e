indexing

	description:
		"Encapsulation of a C++ external extension.";
	date: "$Date$";
	revision: "$Revision$"

class CPP_EXTENSION_AS

inherit
	EXTERNAL_EXTENSION_AS
		redefine
			parse_special_part
		end
	SHARED_CPP_CONSTANTS

feature

	language_name: STRING is "C++"
			-- External language name

feature -- Properties

	type: INTEGER

	class_name: STRING

	class_header_file: STRING

feature {NONE} -- Implementation

	parse_special_part is
			-- Parse the special part clause.
		local
			word, lower_word, special: STRING
			parse_class_name, is_static: BOOLEAN
			end_keyword: INTEGER
		do
debug
	io.error.putstring ("Parsing special part: ");
	io.error.putstring (special_part)
	io.error.new_line
end
			special := special_part

			end_keyword := next_white_space (special, 1)
			if end_keyword = 0 then
				raise_error ("Only one word in C++ specific part")
			end

			word := special.substring (1, end_keyword - 1)
			lower_word := clone (word)
			lower_word.to_lower

			special := special.substring (end_keyword, special.count)
			special.left_adjust

			if lower_word.is_equal (static_keyword) then
				is_static := True
				end_keyword := next_white_space (special, 1)
				if end_keyword = 0 then
					raise_error ("Header file is missing in C++ specific part")
				end
				word := special.substring (1, end_keyword - 1)
				lower_word := clone (word)
				lower_word.to_lower

				special := special.substring (end_keyword, special.count)
				special.left_adjust
			end

			parse_class_name := True
			if lower_word.is_equal (new_keyword) then
				type := new
				if is_static then
					 raise_error ("`static' cannot be used with `new'")
				end
			elseif lower_word.is_equal (delete_keyword) then
				type := delete
				if is_static then
					raise_error ("`static' cannot be used with `delete'")
				end
			elseif lower_word.is_equal (static_keyword) then
				raise_error ("`static' cannot appear twice in C++ specific part")
			elseif lower_word.is_equal (data_member_keyword) then
				if is_static then
					type := static_data_member
				else
					type := data_member
				end
			else
				parse_class_name := False
				if is_static then
					type := static
				else
					type := standard
				end
			end

			if parse_class_name then
				end_keyword := next_white_space (special, 1)
				if end_keyword = 0 then
					raise_error ("Header file is missing in C++ specific part")
				end
				word := special.substring (1, end_keyword - 1)
				special := special.substring (end_keyword, special.count)
				special.left_adjust
			end

			class_name := word

			end_keyword := parse_file_name (special, 1)
			if end_keyword = 0 then
				raise_error ("Invalid include file")
			end
			class_header_file := special.substring (1, end_keyword)
			special.tail (special.count - end_keyword)
			special.left_adjust
			if not special.empty then
				 raise_error ("Invalid character after include file")
			end
		end

	next_white_space (s: STRING; start: INTEGER): INTEGER is
			-- Return the position of the next white space
			-- in `s' starting at `start'.
		local
			tab_pos: INTEGER
		do
			Result := s.index_of (' ', start)
			tab_pos := s.index_of ('%T', start)
			if tab_pos /= 0 then
				if Result = 0 then
					Result := tab_pos
				else
					Result := tab_pos.min (Result)
				end
			end
		end

end -- class CPP_EXTENSION_AS

indexing

	description:
		"Encapsulation of a C external extension.";
	date: "$Date$";
	revision: "$Revision$"

class C_EXTENSION_AS

inherit
	EXTERNAL_EXTENSION_AS
		redefine
			parse_special_part
		end

feature

	language_name: STRING is "C"
			-- External language name

feature -- {NONE} Implementation

	special_file_name: STRING
			-- File name associated with extension

feature -- {NONE} Implementation

	parse_special_part is
			-- Parse the special part
			--| By default, it is empty
		do
			if special_part.count /= 0 then
				raise_error ("Invalid special routine clause")
			end
		end

	parse_special_file_name is
			-- Parse the end of the special part: it should only have a
			-- file name
		local
			end_file: INTEGER
			count : INTEGER
			remaining: STRING
		do
			end_file := parse_file_name (special_part, 1)
debug
	io.error.putstring (special_part)
	io.error.new_line
	io.error.putint (special_part.count)
	io.error.new_line
	io.error.putint (end_file)
	io.error.new_line
end
			if end_file = 0 then
					-- Invalid file
				raise_error ("Invalid file name")
			else
				special_file_name := special_part.substring (1, end_file)
				count := special_part.count
				if end_file /= count then
					remaining := special_part.substring (end_file + 1,
						count)
					remaining.left_adjust
					if remaining.count > 0 then
						raise_error ("Extra characters after file name")
					end
				end
			end
		end
 
end -- class C_EXTENSION_AS

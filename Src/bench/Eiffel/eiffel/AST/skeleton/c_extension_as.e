indexing
	description: "Encapsulation of a C external extension.";
	date: "$Date$";
	revision: "$Revision$"

class C_EXTENSION_AS

inherit
	EXTERNAL_EXTENSION_AS
		redefine
			init_byte_node, parse_special_part
		end

feature -- Properties

	language_name: STRING is "C"
			-- External language name

feature -- Get the C extension

	extension_i (external_as: EXTERNAL_AS): C_EXTENSION_I is
			-- EXTERNAL_EXT_I corresponding to current extension
		do
			!! Result
			init_extension_i (Result)
			Result.set_special_file_name (special_file_name)
		end

feature -- Encapsulation

	need_encapsulation: BOOLEAN is
			-- Does a C external need an encapsulation?
			--| Only when it is a macro, otherwise we
			--| can use the new name of the redefinition
			--| in the routine tables.
		do
		end

feature -- Byte code

	byte_node: C_EXT_BYTE_CODE is
			-- Byte code for external extension
		do
			!! Result
		end

	init_byte_node (b: C_EXT_BYTE_CODE) is
			-- Initialize byte node.
		do
			{EXTERNAL_EXTENSION_AS} Precursor (b)
			b.set_special_file_name (special_file_name)
		end

feature {NONE} -- Implementation

	special_file_name: STRING
			-- File name associated with extension

feature {NONE} -- Implementation

	parse_special_part is
			-- Parse the special part
			--| By default, it is empty
		local
			s: like special_part
		do
			s := special_part
			if s /= Void and then s.count /= 0 then
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
					remaining := special_part.substring (end_file + 1, count)
					remaining.left_adjust
					if remaining.count > 0 then
						raise_error ("Extra characters after file name")
					end
				end
			end
		end
 
end -- class C_EXTENSION_AS

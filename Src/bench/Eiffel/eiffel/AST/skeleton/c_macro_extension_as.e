indexing
	description: "Encapsulation of a macro external extension.";
	date: "$Date$";
	revision: "$Revision$"

class MACRO_EXTENSION_AS

inherit
	EXTERNAL_EXTENSION_AS
		redefine
			parse_special_part, is_macro, init_byte_node,
			extension_i, byte_node, need_encapsulation
		end

create
	make

feature  -- Initialization

	make (is_cpp_macro: BOOLEAN) is
			-- Create Current object
			-- Set `is_cpp' to `is_cpp_macro'.
		do
			is_cpp := is_cpp_macro
		ensure
			is_cpp_set: is_cpp = is_cpp_macro
		end

feature -- Properties

	is_macro: BOOLEAN is True

	language_name: STRING is "C/C++"
			-- External language name

	is_cpp: BOOLEAN
			-- Is Current macro a C++ one?

feature -- Get the macro extension

	extension_i (external_as: EXTERNAL_AS): MACRO_EXTENSION_I is
			-- EXTERNAL_EXT_I corresponding to current extension
		do
			!! Result.make (is_cpp)
			init_extension_i (Result)
			Result.set_special_file_name (special_file_name)
		end

feature -- Encapsulation

	need_encapsulation: BOOLEAN is True
			-- A macro needs to be encapsulated for polymorphic purpose.

feature -- Byte code

	byte_node: MACRO_EXT_BYTE_CODE is
			-- Byte code for external extension
		do
			!! Result
			Result.set_is_cpp_code (is_cpp)
		end

	init_byte_node (b: MACRO_EXT_BYTE_CODE) is
			-- Initialize byte node.
		do
			Precursor {EXTERNAL_EXTENSION_AS} (b)
			b.set_special_file_name (special_file_name)

		end

feature {NONE} -- Implementation

	special_file_name: STRING
			-- File name associated with extension

	parse_special_part is
			-- Parse include file containing macro definition
		local
			end_file: INTEGER
			count : INTEGER
			remaining: STRING
		do
			end_file := parse_file_name (special_part, 1)

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

end -- class MACRO_EXTENSION_AS

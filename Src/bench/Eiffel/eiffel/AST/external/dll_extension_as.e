indexing
	description: "Encapsulation of a DLL external extension.";
	date: "$Date$";
	revision: "$Revision$"

class DLL_EXTENSION_AS

inherit
	EXTERNAL_EXTENSION_AS
		redefine
			parse_special_part, is_dll,
			type_check
		end

feature -- Properties

	is_dll: BOOLEAN is True

feature -- Initialization

	extension_i: DLL_EXTENSION_I is
			-- DLL_EXTENSION_I corresponding to current extension
		do
			create Result
			init_extension_i (Result)
			Result.set_dll_type (dll_type)
			Result.set_dll_index (dll_index)
			Result.set_dll_name (dll_name)
		end

feature -- Encapsulation

	need_encapsulation: BOOLEAN is True
			-- A dll call needs to be encapsulated for polymorphic purpose.

feature -- Type check

	type_check (ext_as_b: EXTERNAL_AS) is
			-- Perform type check on Current associated with `ext_as_b'.
		local
			error: BOOLEAN
			ext_dll_sign: EXT_DLL_SIGN
		do
			type_check_signature

				-- For DLL - Windows, a signature is compulsory
			if context.current_feature.argument_count > 0 and argument_types = Void then
				error := True
			end
			if context.current_feature.is_function = (return_type = 0) then
				error := True
			end
			if error then
				!! ext_dll_sign
				context.init_error (ext_dll_sign)
				Error_handler.insert_error (ext_dll_sign)
				Error_handler.raise_error
			end
		end

feature -- Byte code

	byte_node: DLL_EXT_BYTE_CODE is
			-- Byte code for external extension
		do
			!! Result
			init_byte_node (Result)
			Result.set_dll_type (dll_type)
			Result.set_dll_index (dll_index)
			Result.set_dll_name (dll_name)
		end

feature {NONE} -- Implementation

	dll_name: STRING
			-- File name associated with extension

	parse_special_part is
			-- Parse the dll name
		do
			parse_dll_name
		end

	parse_dll_name is
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
				dll_name := special_part.substring (1, end_file)
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
 
feature {NONE} -- Implementation

	dll_type: INTEGER
		-- Dll type

	dll_index: INTEGER
		-- Dll index

feature -- {EXTERNAL_LANG_AS} Implementation

	set_dll_type (t: INTEGER) is
			-- Assign `t' to `dll_type'.
		do
			dll_type := t
		end

	set_dll_index (i: INTEGER) is
			-- Assign `i' to `dll_index'.
		do
			dll_index := i
		end

end -- class DLL_EXTENSION_AS

indexing
	description: "Encapsulation of a DLL external extension.";
	date: "$Date$";
	revision: "$Revision$"

class C_DLL_EXTENSION_AS

inherit
	C_EXTENSION_AS
		redefine
			parse_special_part, is_dll,
			type_check, extension_i, init_extension_i, byte_node, need_encapsulation
		end

feature -- Properties

	is_dll: BOOLEAN is True

feature -- Get the dll extension

	extension_i (external_as: EXTERNAL_AS): C_DLL_EXTENSION_I is
			-- EXTERNAL_EXT_I corresponding to current extension
		do
			!! Result
			init_extension_i (Result)
			Result.set_dll_type (dll_type)
			Result.set_dll_index (dll_index)
			Result.set_special_file_name (special_file_name)
		end

	init_extension_i (ext_i: like extension_i) is
			-- Initialize `ext_i' based on current extension.
		do
			ext_i.set_argument_types (argument_types)
			ext_i.set_return_type (return_type)
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
			if context.a_feature.argument_count > 0 and argument_types = Void then
				error := True
			end
			if context.a_feature.is_function = (return_type = Void) then
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
			Result.set_dll_type (dll_type)
			Result.set_dll_index (dll_index)
		end

feature {NONE} -- Implementation

	parse_special_part is
			-- Parse the dll name
		do
			parse_special_file_name
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

end -- class C_DLL_EXTENSION_AS

indexing
	description: "Encapsulation of a DLL extension."
	date: "$Date$"
	revision: "$Revision$"

class DLL_EXTENSION_I

inherit
	EXTERNAL_EXT_I
		redefine
			is_dll,
			is_equal, 
			has_standard_prototype, 
			generate_parameter_cast
		end

feature -- Access

	is_dll: BOOLEAN is True

feature -- Properties

	dll_type: INTEGER
		-- Dll type

	dll_index: INTEGER
		-- Dll index

	dll_name: STRING
			-- Special file name (dll or macro)

feature -- Initialization

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

	set_dll_name (f: STRING) is
			-- Assign `f' to `dll_name'.
		do
			dll_name := f
		end

feature -- Comparison

	is_equal (other: like Current): BOOLEAN is
		do
			Result := same_type (other) and then
				equal (return_type, other.return_type) and then
				array_is_equal (argument_types, other.argument_types) and then
				array_is_equal (header_files, other.header_files) and then
				equal (dll_name, other.dll_name) and then
				dll_type = other.dll_type
		end

feature -- Code generation

	has_standard_prototype: BOOLEAN is True

	generate_parameter_cast: BOOLEAN is False

end -- class DLL_EXTENSION_I

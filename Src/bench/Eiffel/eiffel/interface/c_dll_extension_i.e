indexing

	description:
		"Encapsulation of a DLL extension.";
	date: "$Date$";
	revision: "$Revision$"

class C_DLL_EXTENSION_I

inherit
	C_EXTENSION_I
		rename
			is_equal as c_is_equal
		redefine
			has_standard_prototype, generate_external_name,
			generate_parameter_cast
		end
	C_EXTENSION_I
		redefine
			is_equal, has_standard_prototype, generate_external_name,
			generate_parameter_cast
		select
			is_equal
		end

feature -- Properties

	dll_type: INTEGER
		-- Dll type

feature -- Initialization

	set_dll_type (t: INTEGER) is
			-- Assign `t' to `dll_type'.
		do
			dll_type := t
		end

feature -- Comparison

	is_equal (other: like Current): BOOLEAN is
		do
			Result := c_is_equal (other) and then
				dll_type = other.dll_type
		end

feature -- Code generation

    generate_external_name (gen_file: INDENT_FILE; external_name: STRING;
				e: POLY_TABLE [ENTRY]; type: CL_TYPE_I; ret_type: TYPE_C) is
            -- Generate the C name associated with the extension
		local
			rout_table: ROUT_TABLE
			name: STRING
        do
			rout_table ?= e
			name := rout_table.feature_name (type.type_id)
            gen_file.putstring (name)

			Extern_declarations.add_routine (ret_type, name)
        end

	has_standard_prototype: BOOLEAN is True

	generate_parameter_cast: BOOLEAN is False

end -- class C_DLL_EXTENSION_I

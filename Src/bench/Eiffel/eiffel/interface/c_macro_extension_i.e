indexing
	description: "Encapsulation of a C macro extension."
	date: "$Date$"
	revision: "$Revision$"

class MACRO_EXTENSION_I

inherit
	EXTERNAL_EXT_I
		redefine
			is_macro, is_equal, is_cpp,
			has_standard_prototype, 
			generate_external_name
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

	is_cpp: BOOLEAN
		-- Is Current macro a C++ one?

feature -- Comparison

	is_equal (other: like Current): BOOLEAN is
		do	
			Result := same_type (other) and then
				return_type = other.return_type and then
				array_is_equal (argument_types, other.argument_types) and then
				array_is_equal (header_files, other.header_files)
		end

feature -- Code generation

	generate_external_name (buffer: GENERATION_BUFFER; external_name: STRING
				type: CL_TYPE_I; ret_type: TYPE_C) is
			-- Generate the C name associated with the extension
		do
			if is_cpp then
				context.set_has_cpp_externals_calls (True)
			end
			if has_return_type then
				buffer.putchar ('(')
			end
			buffer.putstring (external_name)
		end

	has_standard_prototype: BOOLEAN is False

end -- class MACRO_EXTENSION_I

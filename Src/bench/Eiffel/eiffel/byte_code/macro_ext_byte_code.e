indexing
	description:
		"Encapsulation of a macro extension in C or C++ mode.";
	date: "$Date$";
	revision: "$Revision$"

class MACRO_EXT_BYTE_CODE

inherit
	EXT_EXT_BYTE_CODE
		redefine
			is_special, generate, generate_body, generate_signature,
			generate_arguments_with_cast
		end

feature -- Properties

	is_cpp_code: BOOLEAN
			-- Is current macro to be generated in a CPP context?

feature -- Initialization

	set_is_cpp_code (v: BOOLEAN) is
			-- Assign `v' to `is_cpp_code'.
		do
			is_cpp_code := v
		ensure
			is_cpp_code_set: is_cpp_code = v
		end

feature -- Code generation

	generate is
		do
			generate_include_files
			generate_signature
		end

	generate_body is
			-- Generate the body for an external of type macro
		do
			if is_cpp_code then
				context.set_has_cpp_externals_calls (True)
			end
			generate_basic_body
		end

	generate_signature is
			-- Generate the signature for the macro.
		do
			generate_basic_signature
		end

	generate_arguments_with_cast is
			-- Generate the arguments list if there is one
		local
			buf: GENERATION_BUFFER
		do
			if arguments /= Void then
				buf := buffer
				buf.putchar ('(')
				generate_basic_arguments_with_cast
				buf.putchar (')')
			end
		end

feature -- Convenience

	is_special: BOOLEAN is True

end -- class MACRO_EXT_BYTE_CODE

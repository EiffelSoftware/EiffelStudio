indexing
	description:
		"Encapsulation of a macro extension in C or C++ mode.";
	date: "$Date$";
	revision: "$Revision$"

class STRUCT_EXT_BYTE_CODE

inherit
	EXT_EXT_BYTE_CODE
		redefine
			is_special, generate, generate_body, generate_signature
		end

feature -- Properties

	special_file_name: STRING
			-- Special file name (dll or macro)

	is_cpp_code: BOOLEAN
			-- Is current macro to be generated in a CPP context?

feature -- Initialization

	set_special_file_name (f: STRING) is
			-- Assign `f' to `special_file_name'.
		do
			special_file_name := f
		end

	set_is_cpp_code (v: BOOLEAN) is
			-- Assign `v' to `is_cpp_code'.
		do
			is_cpp_code := v
		ensure
			is_cpp_code_set: is_cpp_code = v
		end

feature -- Code generation

	generate is
		local
			buf: GENERATION_BUFFER
			queue: like shared_include_queue
		do
			generate_include_files
			queue := shared_include_queue
			if not queue.has (special_file_name) then
				queue.extend (special_file_name)
			end
			generate_signature
		end

	generate_body is
			-- Generate the body for an external of type macro
		local
			buf: GENERATION_BUFFER
		do
			buf := buffer
			if is_cpp_code then
				context.set_has_cpp_externals_calls (True)
			end

			if has_return_type then
				buf.putstring ("return ");
				result_type.c_type.generate_cast (buf)

					--| External structure access will be generated as:
					--| (type_2) (((type_1 *) arg1)->alias_name);
				buf.putstring ("(((")
				buf.putstring (argument_types.item(1))
				buf.putstring (" *) arg1");
				buf.putstring (")->")
				buf.putstring (external_name)
				buf.putstring (");")
				buf.new_line;
			else
					--| External structure setting will be generated as:
					--| ((type_1 *) arg1)->alias_name = (type_2) (arg2);
				buf.putstring ("((")
				buf.putstring (argument_types.item(1))
				buf.putstring (" *) arg1");
				buf.putstring (")->")
				buf.putstring (external_name)
				buf.putstring (" = (")
				buf.putstring (argument_types.item(2))
				buf.putstring (")(arg2);");
				buf.new_line;
			end
		end

	generate_signature is
			-- Generate the signature for the macro.
		do
			generate_basic_signature
		end

feature -- Convenience

	is_special: BOOLEAN is True

end -- class STRUCT_EXT_BYTE_CODE

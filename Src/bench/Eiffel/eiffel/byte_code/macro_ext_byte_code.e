indexing

	description:
		"Encapsulation of a macro extension.";
	date: "$Date$";
	revision: "$Revision$"

class MACRO_EXT_BYTE_CODE

inherit
	C_EXT_BYTE_CODE
		redefine
			is_special, generate, generate_body, generate_signature,
			generate_arguments_with_cast
		end

feature -- Code generation

	generate is
		do
			generate_include_files
			if not shared_include_queue.has (special_file_name) then
				shared_include_queue.extend (special_file_name)
				if not context.final_mode then
					generated_file.putstring ("#include ");
					generated_file.putstring (special_file_name);
					generated_file.new_line;
				end
			end
			generate_signature
		end

	generate_body is
			-- Generate the body for an external of type macro
		do
			generate_basic_body
		end

	generate_signature is
			-- Generate the signature for the macro.
		do
			generate_basic_signature
		end

	generate_arguments_with_cast is
			-- Generate the arguments list if there is one
		do
			if arguments /= Void then
				generated_file.putchar ('(')
				generate_basic_arguments_with_cast
				generated_file.putchar (')')
			end
		end

feature -- Convenience

	is_special: BOOLEAN is True

end -- class MACRO_EXT_BYTE_CODE

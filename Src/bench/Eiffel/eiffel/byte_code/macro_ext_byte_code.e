indexing

	description:
		"Encapsulation of a macro extension.";
	date: "$Date$";
	revision: "$Revision$"

class MACRO_EXT_BYTE_CODE

inherit
	C_EXT_BYTE_CODE
		redefine
			generate, generate_body
		end

feature -- Code generation

	generate is
		local	
			include_file: STRING
		do
			generate_include_files
			include_file := special_file_name
			if not shared_include_queue.has (include_file) then
				shared_include_queue.extend (include_file)
				if not context.final_mode then
					generated_file.putstring ("#include ");
					generated_file.putstring (include_file);
					generated_file.new_line;
				end
			end
			generate_signature
		end

	generate_body is
		do
			generate_macro_body
		end

end -- class MACRO_EXT_BYTE_CODE

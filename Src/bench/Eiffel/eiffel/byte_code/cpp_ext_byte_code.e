indexing

	description:
		"Encapsulation of a C++ external.";
	date: "$Date$";
	revision: "$Revision$"

class CPP_EXT_BYTE_CODE

inherit
	EXT_EXT_BYTE_CODE
		redefine
			is_special, generate, generate_body
		end

feature -- Properties

	class_name: STRING
 
	class_header_file: STRING
 
	type: INTEGER
 
feature -- Convenience
 
	set_class_header_file (h: STRING) is
			-- Assign `h' to `class_header_file'.
		do
			class_header_file := h
		end
 
	set_class_name (n: STRING) is
			-- Assign `n' to `class_name'.
		do
			class_name := n
		end
 
	set_type (t: INTEGER) is
			-- Assing `t' to `type'.
		do
			type := t
		end

feature -- Code generation

	is_special: BOOLEAN is True

	generate is
		local	
			h_file: STRING
		do
			generate_include_files
			h_file := class_header_file
			if not shared_include_set.has (h_file) then
				shared_include_set.extend (h_file)
				if not context.final_mode then
					generated_file.putstring ("#include ");
					generated_file.putstring (h_file);
					generated_file.new_line;
				end
			end
			generate_signature
		end

	generate_body is
		do
			io.putstring ("generate_body%N")
		end

end -- class CPP_EXT_BYTE_CODE

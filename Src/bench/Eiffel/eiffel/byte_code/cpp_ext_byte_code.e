indexing

	description:
		"Encapsulation of a C++ external.";
	date: "$Date$";
	revision: "$Revision$"

class CPP_EXT_BYTE_CODE

inherit
	EXT_EXT_BYTE_CODE
		redefine
			is_special, generate, generate_body, generate_arguments_with_cast
		end
	SHARED_CPP_CONSTANTS

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
			if not shared_include_queue.has (h_file) then
				shared_include_queue.extend (h_file)
				if not context.final_mode then
					generated_file.putstring ("#include ");
					generated_file.putstring (h_file);
					generated_file.new_line;
				end
			end
			generate_signature
		end

	generate_body is
		local
			i, count: INTEGER;
		do
				-- Check for null pointer to C++ object in workbench mode
			if not Context.final_mode then
				inspect
					type
				when standard, data_member then
					generated_file.putstring ("if ((")
					generated_file.putstring (class_name)
					generated_file.putstring ("*) arg1 == NULL) RTET(%"")
					generated_file.putstring (class_name)
					generated_file.putstring ("::")
					generated_file.putstring (external_name)
					generated_file.putstring ("%", EN_VOID);")
					generated_file.new_line
					generated_file.new_line
				else
				end
			end
			if not result_type.is_void then
				generated_file.putstring ("return ");
			end;
			--if has_return_type then
				--generated_file.putchar ('(');
				--generated_file.putstring (return_type);
				--generated_file.putchar (')');
				--generated_file.putchar (' ');
			if result_type /= Void then
				result_type.c_type.generate_cast (generated_file);
			else
				generated_file.putstring ("(void)");
			end;

			generated_file.putchar ('(')
			inspect
				type
			when standard, data_member then
				generated_file.putstring ("((")
				generated_file.putstring (class_name)
				generated_file.putstring ("*) arg1)->")
				generated_file.putstring (external_name);
			when static, static_data_member then
				generated_file.putstring (class_name)
				generated_file.putstring ("::")
				generated_file.putstring (external_name);
			when new then
				generated_file.putstring ("new ")
				generated_file.putstring (class_name)
			when delete then
				generated_file.putstring ("delete ((")
				generated_file.putstring (class_name)
				generated_file.putstring ("*)arg1)")
			end

			inspect
				type
			when delete, data_member, static_data_member then
					-- Nothing to generate
			when standard, static, new then
				generated_file.putchar ('(')
				generate_arguments_with_cast
				generated_file.putchar (')')
			end

			generated_file.putchar (')');
			generated_file.putchar (';');
			generated_file.new_line;
		end

	generate_arguments_with_cast is
			-- Generate C arguments, if any, with casts if there's a signature
		local
			i, j, count: INTEGER;
		do
			if arguments /= Void then
				from
					j := 1
					count := arguments.count
					if type = standard then
							-- First argument is the pointer to the C++ object
						i := 2
					else
							-- constructor or call to static routine
						i := 1
					end
				until
					i > count
				loop
					if j > 1 then
						generated_file.putstring (gc_comma);
					end
					if has_arg_list then
						generated_file.putchar ('(');
						generated_file.putstring (argument_types.item (j));
						generated_file.putstring (") ");
					end;
					generated_file.putstring ("arg");
					generated_file.putint (i);
					i := i + 1;
					j := j + 1
				end;
			end;
		end;

end -- class CPP_EXT_BYTE_CODE

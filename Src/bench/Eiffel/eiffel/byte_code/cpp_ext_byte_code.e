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
io.putstring ("generate_body%N")

			if not result_type.is_void or has_return_type then
				generated_file.putstring ("return ");
			end;
			if has_return_type then
				generated_file.putchar ('(');
				generated_file.putstring (return_type);
				generated_file.putchar (')');
				generated_file.putchar (' ');
			elseif result_type /= Void then
				result_type.c_type.generate_cast (generated_file);
			else
					-- I'm not sure this is really needed
				generated_file.putstring ("(void) ");
			end;
				--| External procedure will be generated as:
				--| (void) (c_proc (args));
				--| The extra parenthesis are necessary if c_proc is
				--| an affectation e.g. c_proc(arg1, arg2) arg1 = arg2
				--| Without the parenthesis, the cast is done only on the first
				--| argument, not the entire expression (affectation)
			generated_file.putchar ('(');
			generated_file.putstring (external_name);
			if arguments /= Void then
				generated_file.putchar ('(');
				generate_arguments_with_cast;
				generated_file.putchar (')');
			end;
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
					i := arguments.lower;
					count := arguments.count;
				until
					i > count
				loop
					if has_arg_list then
						inspect
							type
						when normal, delete, data_member then
								-- CPP type doesn't have a cast
							j := i - 1
						when new, static, static_data_member then
								-- Same number of arguments in signature
							j := i
						end
						if j > 0 then
							generated_file.putchar ('(');
							generated_file.putstring (argument_types.item (j));
							generated_file.putstring (") ");
						end
					end;
					generated_file.putstring ("arg");
					generated_file.putint (i);
					i := i + 1;
					if i <= count then
						generated_file.putstring (gc_comma);
					end;
				end;
			end;
		end;

end -- class CPP_EXT_BYTE_CODE

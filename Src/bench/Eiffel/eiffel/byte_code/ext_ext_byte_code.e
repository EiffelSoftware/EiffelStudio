indexing

	description:
		"Byte node for external extension.";
	date: "$Date$";
	revision: "$Revision$"

class EXT_EXT_BYTE_CODE

inherit
	EXT_BYTE_CODE
		redefine
			generate
		end

feature -- Properties

	argument_types: ARRAY [STRING]

	header_files: ARRAY [STRING]

	return_type: STRING

feature -- Setting

	set_argument_types (a: like argument_types) is
			-- Assign `a' to `argument_types'.
		do
			argument_types := a
		end

	set_header_files (h: like header_files) is
			-- Assign `h' to `header_files'.
		do
			header_files := h
		end

	set_return_type (r: like return_type) is
			-- Assign `r' to `return_type'.
		do
			return_type := r
		end

feature -- Code generation

	generate is
		do
			generate_include_files
			generate_signature
		end

	generate_include_files is
		local
			i, nb: INTEGER
			include_file: STRING
			queue: like shared_include_queue
		do
			if header_files /= Void then
				from
					i := header_files.lower
					nb := header_files.upper
					queue := shared_include_queue
				until
					i > nb
				loop
					include_file := header_files @ i
					if not queue.has (include_file) then
						queue.extend (include_file)
						if not context.final_mode then
							generated_file.putstring ("#include ");
							generated_file.putstring (include_file);
							generated_file.new_line;
						end
					end
					i := i + 1
				end
			end
		end

	generate_signature is
		local
			assignment: ASSIGN_B;
			type_i: TYPE_I;
			internal_name: STRING;
			i: INTEGER;
			ext: EXTERNAL_EXT_I
		do
if is_special or has_signature then
				-- Generate the header "int foo(Current, args)"
			type_i := real_type (result_type);
			type_i.c_type.generate (generated_file);

				-- Function's name
			internal_name := body_id.feature_name
				(System.class_type_of_id (context.current_type.type_id).id)

			add_in_log (internal_name);

				-- Generate function name
			generated_file.putstring (internal_name);
			generated_file.putchar ('(');
			generate_arguments;
			generated_file.putchar (')');
			generated_file.new_line;
				-- Now generate C declarations for arguments
			generate_arg_declarations;
				-- Starting body of C routine
			generated_file.putchar ('{');
			generated_file.new_line;
			generated_file.indent;
				-- Clone expanded parameters, raise exception in caller if
				-- needed (void assigned to expanded).
			generate_expanded_cloning;
				-- Generate execution trace information
			--generate_execution_trace;
				-- Generate the saving of the workbench mode assertion level
			--if context.workbench_mode then
				--generate_save_assertion_level;
			--end;
				-- Generate local expanded variable creations
			generate_expanded_variables;
				-- Now we want the body
			generate_body;
			generated_file.exdent;
			generated_file.putchar ('}');
			generated_file.new_line;
				-- Leave a blank line after function definition
			generated_file.new_line;
			Context.inherited_assertion.wipe_out;
elseif encapsulated then
	old_generate
end
end


	generate_basic_body is
		do
			if has_signature then
				generate_macro_body;
			end;
		end;
 
	generate_macro_body is
			-- Generate the body for an external of type macro
		local
			i, count: INTEGER;
		do
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
		end;

	generate_arguments_with_cast is
			-- Generate C arguments, if any, with casts if there's a signature
		local
			i,count: INTEGER;
		do
			if arguments /= Void then
				from
					i := arguments.lower;
					count := arguments.count;
				until
					i > count
				loop
					if has_arg_list then
						generated_file.putchar ('(');
						generated_file.putstring (argument_types.item (i));
						generated_file.putstring (") ");
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

	generate_body is
			-- Generates the return macro/function with casts if needed
		do
			generate_basic_body
		end;
 
feature -- Convenience

	is_special: BOOLEAN is do end

	has_signature: BOOLEAN is
		do
			Result := has_arg_list or else has_return_type;
		end

	has_return_type: BOOLEAN is
		do
			Result := return_type /= Void
		end

	has_arg_list: BOOLEAN is
		do
			Result := argument_types /= Void
		end

end -- class EXT_EXT_BYTE_CODE

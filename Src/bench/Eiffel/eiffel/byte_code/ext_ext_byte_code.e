indexing

	description:
		"Byte node for external extension.";
	date: "$Date$";
	revision: "$Revision$"

class EXT_EXT_BYTE_CODE

inherit
	EXT_BYTE_CODE
		rename
			argument_types as std_argument_types
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
			buf: GENERATION_BUFFER
		do
			if header_files /= Void then
				from
					i := header_files.lower
					nb := header_files.upper
					queue := shared_include_queue
					buf := header_generation_buffer
				until
					i > nb
				loop
					include_file := header_files.item (i)
					queue.put (include_file)
					i := i + 1
				end
			end
		end

	generate_signature is
		do
			if is_special then
				generate_basic_signature
			elseif encapsulated then
				old_generate
			end
		end

	generate_arguments_with_cast is
			-- Generate C arguments, if any, with casts if there's a signature
		local
			buf: GENERATION_BUFFER
		do
			buf := buffer
			buf.putchar ('(')
			if arguments /= Void then
				generate_basic_arguments_with_cast
			end
			buf.putchar (')')
		end

	generate_body is
			-- Generates the return macro/function with casts if needed
		do
			if is_special then
				generate_basic_body
			end
		end
 
feature -- Basic routine

	generate_basic_signature is
		local
			type_i: TYPE_I
			internal_name: STRING
			buf: GENERATION_BUFFER
		do
			buf := buffer

				-- Generate the header "int foo(Current, args)"
			type_i := real_type (result_type);

				-- Function's name
			internal_name := Encoder.feature_name (
					System.class_type_of_id (context.current_type.type_id).static_type_id,
					body_index)

			add_in_log (internal_name);

				-- Generate function signature
			 buf.generate_function_signature
				(type_i.c_type.c_string, internal_name, True,
				 Context.header_buffer, argument_names, std_argument_types)

				-- Starting body of C routine
			buf.indent;

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
			buf.exdent;

				-- Leave a blank line after function definition
			buf.putstring ("}%N%N");
			Context.inherited_assertion.wipe_out;
		end

	generate_basic_body is
			-- Generate the body for an external function
		local
			buf: GENERATION_BUFFER
			is_func: BOOLEAN
		do
			buf := buffer

			if has_return_type or else not result_type.is_void then
				is_func := True
				buf.putstring ("return ");
				result_type.c_type.generate_cast (buf)
			end

				--| For external functions only:
				--| External procedure will be generated as:
				--| (void) (c_proc (args));
				--| The extra parenthesis are necessary if c_proc is
				--| an affectation e.g. c_proc(arg1, arg2) arg1 = arg2
				--| Without the parenthesis, the cast is done only on the first
				--| argument, not the entire expression (affectation)
			if is_func then
				buf.putchar ('(');
			end
			buf.putstring (external_name);
			generate_arguments_with_cast;
			if is_func then
				buf.putchar (')');
			end
			buf.putchar (';');
			buf.new_line;
		end;

	generate_basic_arguments_with_cast is
			-- Generate C arguments, if any, with casts if there's a signature
		require
			arguments_not_void: arguments /= Void
		local
			i,count: INTEGER;
			buf: GENERATION_BUFFER
		do
			from
				i := arguments.lower
				count := arguments.count
				buf := buffer
			until
				i > count
			loop
				if has_arg_list then
					buf.putchar ('(')
					buf.putstring (argument_types.item (i))
					buf.putstring (") ")
				end
				buf.putstring ("arg")
				buf.putint (i)
				i := i + 1
				if i <= count then
					buf.putstring (gc_comma)
				end
			end
		end

feature -- Convenience

	is_special: BOOLEAN is
		do
		end

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

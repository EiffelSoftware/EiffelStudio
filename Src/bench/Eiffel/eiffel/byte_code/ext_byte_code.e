-- Byte code for external features

class EXT_BYTE_CODE 

inherit
	STD_BYTE_CODE
		rename
			argument_types as std_argument_types
		redefine
			generate,
			generate_return_exp,generate_compound,
			generate_current, is_external, pre_inlined_code,
			inlined_byte_code
		end

	SHARED_INCLUDE
		export
			{NONE} all
		end

	SHARED_NAMES_HEAP
		export
			{NONE} all
		end

	EXTERNAL_CONSTANTS
	
feature -- Access

	external_name: STRING is
			-- External name to call
		require
			external_name_id_positive: external_name_id > 0
		do
			Result := Names_heap.item (external_name_id)
		ensure
			external_name_not_void: Result /= Void
		end
		
	external_name_id: INTEGER
			-- Name ID of external.

	encapsulated: BOOLEAN
			-- Has the call to `external_name' to be encapsulated?

	argument_types: ARRAY [INTEGER]
			-- Type of arguments if specified.

	header_files: ARRAY [INTEGER]
			-- Header files if specified.

	return_type: INTEGER
			-- Return type if specified.
	
feature -- Status report

	is_during_il: BOOLEAN
			-- Is current being generated for IL code generation?

	is_external: BOOLEAN is True
			-- Is the current byte code a byte code for external
			-- features ?

feature -- Convenience

	is_special: BOOLEAN is
		do
			Result := is_during_il
		end

	has_signature: BOOLEAN is
		do
			Result := has_arg_list or else has_return_type;
		end

	has_return_type: BOOLEAN is
		do
			Result := return_type > 0
		end

	has_arg_list: BOOLEAN is
		do
			Result := argument_types /= Void
		end

feature -- Setting

	set_external_name_id (a_name_id: INTEGER) is
			-- Assign `s' to `a_name_id'.
		require
			a_name_id_positive: a_name_id > 0
		do
			external_name_id := a_name_id
		ensure
			external_name_id_set: external_name_id = a_name_id
		end

	set_encapsulated (e: BOOLEAN) is
			-- Assign `e' to `encapsulated'
		do
			encapsulated := e
		ensure
			encapsulated_set: encapsulated = e
		end

	set_argument_types (a: like argument_types) is
			-- Assign `a' to `argument_types'.
		do
			argument_types := a
		ensure
			argument_types_set: argument_types = a
		end

	set_header_files (h: like header_files) is
			-- Assign `h' to `header_files'.
		do
			header_files := h
		ensure
			header_files_set: header_files = h
		end

	set_return_type (r: like return_type) is
			-- Assign `r' to `return_type'.
		do
			return_type := r
		ensure
			return_type_set: return_type = r
		end

feature -- IL code generation

	generate_c_il is
			-- Generate C code in case of IL generation.
		do
			is_during_il := True
			generate
			is_during_il := False
		end

feature -- Byte code generation

	generate is
			-- Byte code generation
		do
			generate_include_files
			if is_special then
				generate_basic_signature
			elseif encapsulated then
				Precursor {STD_BYTE_CODE}
			end
		end

	generate_compound is
			-- Call the external function
		local
			buf: GENERATION_BUFFER
		do
			buf := buffer

			if not result_type.is_void then
				buf.putstring ("return ")
				result_type.c_type.generate_cast (buf)
			end

			buf.putstring (external_name)
			buf.putchar ('(')
			generate_arguments
			buf.putchar (')')
			buf.putchar (';')
			buf.new_line
		end

	generate_return_exp is
			-- Generate the final return
		local
			buf: GENERATION_BUFFER
		do
			if context.result_used or postcondition /= Void or context.has_invariant then
				buf := buffer
				buf.putstring ("return Result;")
				buf.new_line
			end
		end

	generate_current: BOOLEAN is False
			-- Do we need to generate `Current'?

feature -- Inlining

	pre_inlined_code: like Current is
			-- An external does not have a body
			-- Inlining is done differently
		do
		end

	inlined_byte_code: like Current is
		do
			Result := Current
		end

feature -- Code generation

	generate_include_files is
		local
			i, nb: INTEGER
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
					queue.put (header_files @ i)
					i := i + 1
				end
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
			l_names_heap: like Names_heap
		do
			from
				i := arguments.lower
				count := arguments.count
				l_names_heap := Names_heap
				buf := buffer
			until
				i > count
			loop
				if has_arg_list then
					buf.putchar ('(')
					buf.putstring (l_names_heap.item (argument_types.item (i)))
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

end

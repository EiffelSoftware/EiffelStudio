indexing
	description: "Byte code for external features."
	date: "$Date$"
	revision: "$Revision$"

class EXT_BYTE_CODE 

inherit
	STD_BYTE_CODE
		redefine
			generate, generate_current, generate_compound, is_external,
			pre_inlined_code, inlined_byte_code
		end

create
	make

feature {NONE} -- Initialization

	make (a_name_id: INTEGER) is
			-- Assign `s' to `a_name_id'.
		require
			a_name_id_positive: a_name_id > 0
		do
			external_name_id := a_name_id
		ensure
			external_name_id_set: external_name_id = a_name_id
		end

feature -- Access

	external_name: STRING is
			-- External name to call
		do
			Result := Names_heap.item (external_name_id)
		ensure
			external_name_not_void: Result /= Void
		end
		
	external_name_id: INTEGER
			-- Name ID of external.

feature -- Status report

	is_external: BOOLEAN is True
			-- Is the current byte code a byte code for external
			-- features ?

	generate_current: BOOLEAN is False
			-- Do we need to generate `Current'? No for externals.

feature -- C code generation

	generate is
			-- Byte code generation
		local
			internal_name: STRING
			buf: GENERATION_BUFFER
			l_result: RESULT_BL
			l_ret_type: TYPE_I
			l_ext: EXTERNAL_EXT_I
			l_result_protected: BOOLEAN
		do
			buf := buffer
			l_ext := Context.current_feature.extension

				-- Generate the header "int foo(Current, args)"
			l_ret_type := result_type
			result_type := real_type (result_type)

			if not result_type.is_void then
					-- Only creates a result when needed.
				create l_result.make (l_ret_type)
			end
				-- Function's name
			internal_name := Encoder.feature_name (
					System.class_type_of_id (context.current_type.type_id).static_type_id,
					body_index)

			add_in_log (internal_name);

				-- Generate function signature
			 buf.generate_function_signature
				(result_type.c_type.c_string, internal_name, True,
				 Context.header_buffer, argument_names, argument_types)

				-- Starting body of C routine
			buf.indent;

			if l_result /= Void then
					-- Generate `Result' declaration since needed. However no `volatile'
					-- qualifier.
				Context.mark_result_used
				generate_result_declaration (False)
				if
					--System.has_multithreaded and
					result_type.is_reference and l_ext.is_blocking_call
				then
						-- We need to protect `Result' only in `is_blocking_call' case
						-- as this where a GC collection might be triggered in
						-- multithreaded mode.
					l_result_protected := True
					buf.putstring ("RTLD;")
					buf.new_line
					buf.putstring ("RTLI(1);")
					buf.new_line
					buf.put_result_registration (0)
					buf.new_line
				end
			end

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
			if l_ext.is_blocking_call then
				buf.putstring ("EIF_ENTER_C;")
				buf.new_line
			end
			
			l_ext.generate_body (Current, l_result)
			
			if l_ext.is_blocking_call then
				buf.putstring ("RTGC;")
				buf.new_line
				buf.putstring ("EIF_EXIT_C;")
				buf.new_line
			end

			if l_result /= Void then
				if l_result_protected then
					buf.putstring ("RTLE;")
					buf.new_line
				end
				buf.putstring ("return ")
				l_result.print_register
				buf.putchar (';')
				buf.new_line
			end
			
			buf.exdent;

				-- Leave a blank line after function definition
			buf.putstring ("}%N%N");
			Context.inherited_assertion.wipe_out;

				-- Restore `result_type' as usually it is not kept evaluated.
			result_type := l_ret_type
		end

	generate_compound is
			-- Generate actual compound. Nothing to be done as it is all taken care
			-- in `generate'.
		do
		end
		
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

invariant
	external_name_id_positive: external_name_id > 0

end

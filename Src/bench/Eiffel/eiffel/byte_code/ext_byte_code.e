indexing
	description: "Byte code for external features."
	date: "$Date$"
	revision: "$Revision$"

class EXT_BYTE_CODE 

inherit
	STD_BYTE_CODE
		rename
			argument_names as std_argument_names,
			argument_types as std_argument_types
		redefine
			generate, generate_compound, generate_expanded_cloning,
			is_external, pre_inlined_code, inlined_byte_code
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

	argument_types: like std_argument_types is
			-- Type of arguments, not including Current.
		local
			l_lower, l_upper: INTEGER
		do
			Result := std_argument_types
			if Result.count > 1 then
				l_lower := Result.lower
				l_upper := Result.upper
				create Result.make (1, l_upper - l_lower)
				Result.subcopy (std_argument_types, l_lower + 1, l_upper, 1)
			else
				create Result.make (1, 0)
			end
		end

	argument_names: like std_argument_names is
			-- Type of arguments, not including Current.
		local
			l_lower, l_upper: INTEGER
		do
			Result := std_argument_names
			if Result.count > 1 then
				l_lower := Result.lower
				l_upper := Result.upper
				create Result.make (1, l_upper - l_lower)
				Result.subcopy (std_argument_names, l_lower + 1, l_upper, 1)
			else
				create Result.make (1, 0)
			end
		end

feature -- Status report

	is_external: BOOLEAN is True
			-- Is the current byte code a byte code for external
			-- features ?

feature -- C code generation

	generate is
			-- Generate body of routine.
		local
			l_ret_type: like result_type
		do
				-- Generate the header "int foo(Current, args)"
			l_ret_type := result_type
			result_type := real_type (result_type)

			if not result_type.is_void then
				Context.mark_result_used
			end

				-- Actual code generation.
			if system.il_generation then
				generate_il_code
			else
				Precursor {STD_BYTE_CODE}
			end

				-- Restore `result_type' as usually it is not kept evaluated.
			result_type := l_ret_type
		end

	generate_il_code is
			-- Generate code for IL code generation.
		local
			l_ret_type: TYPE_I
			internal_name: STRING
			buf: GENERATION_BUFFER
		do
			buf := buffer
			l_ret_type := result_type

			internal_name := encoder.feature_name (
				System.class_type_of_id (context.current_type.type_id).static_type_id, body_index)
			buf.generate_function_signature (l_ret_type.c_type.c_string, internal_name,
				True, context.header_buffer, argument_names, argument_types)

			buf.indent
			if not l_ret_type.is_void then
				l_ret_type.c_type.generate (buf)
				buf.putstring ("Result;")
				buf.new_line
			end
			generate_compound
			if not result_type.is_void then
				buf.putstring ("return Result;")
				buf.new_line
			end
			buf.exdent
			buf.putchar ('}')
			buf.new_line
		end
		
	generate_compound is
			-- Byte code generation
		local
			buf: GENERATION_BUFFER
			l_result: RESULT_BL
			l_ext: EXTERNAL_EXT_I
		do
			buf := buffer
			l_ext := Context.current_feature.extension
			check
				is_external: Context.current_feature.is_external
					-- Current feature should be an external one and therefore
					-- should have an extension.
				l_ext_not_void: l_ext /= Void
			end

				-- Now we want the body
			if l_ext.is_blocking_call then
				buf.putstring ("EIF_ENTER_C;")
				buf.new_line
			end
			
			if not result_type.is_void then
					-- Only creates a result when needed.
				create l_result.make (result_type)
			end

				-- Generate call to external.
			l_ext.generate_body (Current, l_result)
			
			if l_ext.is_blocking_call then
				buf.putstring ("EIF_EXIT_C;")
				buf.new_line
				buf.putstring ("RTGC;")
				buf.new_line
			end
		end
		
	generate_expanded_cloning is
			-- Clone expanded parameters.
		do
			-- FIXME: Manu 07/28/2003.
			-- When object is automatically promoted to an EIF_OBJECT for a C externals, cloning
			-- does not work as it is necessary to perform `eif_access' all the time. Because we 
			-- don't know how to do this yet, we have disabled cloning for expanded objects arguments
			-- when calling an external routine.
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

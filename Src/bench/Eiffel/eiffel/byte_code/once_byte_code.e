-- Byte code for once feature

class ONCE_BYTE_CODE

inherit
	STD_BYTE_CODE
		redefine
			is_once, is_global_once,
			pre_inlined_code, inlined_byte_code, generate_once_declaration,
			generate_once_data, generate_once_prologue, generate_once_epilogue,
			generate_il
		end

feature -- Access

	internal_is_global_once: BOOLEAN
			-- Is current once to be generated in multithreaded mode has a global once?

feature -- Status

	is_global_once: BOOLEAN is
			-- Is current once compiled in multithreaded mode with global status?
		do
			Result := (System.has_multithreaded or else System.il_generation) and then internal_is_global_once
		end

feature -- Setting

	set_is_global_once (v: BOOLEAN) is
			-- Assign `v' to `internal_is_global_once'.
		do
			internal_is_global_once := v
		ensure
			internal_is_global_once_set: internal_is_global_once = v
		end
		
feature -- IL code generation

	generate_il is
			-- Generate IL byte code
		do
				-- Put a breakable point on feature name.
			il_generator.put_line_info (start_line_number)
			il_generator.flush_sequence_points (context.class_type)
			generate_il_body
			il_generator.put_debug_info (end_location)
			il_generator.generate_once_epilogue
		end

feature -- C code generation

	is_once: BOOLEAN is True;
			-- Is the current byte code relative to a once feature ?

	generate_once_data (name: STRING) is
			-- Generate once-specific data
		local
			buf: like buffer
		do
			if is_global_once then
				buf := buffer
					-- Generate locals for global once routine
				buf.put_string ("RTOPD")
				buf.put_new_line
			elseif System.has_multithreaded or else not context.final_mode then
				generate_safe_once
			end
			init_dftype
			init_dtype
		end
	
	generate_once_prologue (name: STRING) is
			-- Generate test at the head of once routines
		local
			buf: like buffer
			l_res_name: STRING
		do
			buf := buffer
			if is_global_once then
				buf.put_string ("RTOPP (")
				buf.put_string (mutex_name (name))
				buf.put_string (");")
				buf.put_new_line
				if context.result_used then
					if real_type(result_type).c_type.is_pointer then
						buf.put_new_line
						buf.put_string ("RTOC_GLOBAL(")
						buf.put_string ("Result")
						buf.put_string (");")
					end
				end
			elseif System.has_multithreaded or else not context.final_mode then
				buf.put_string ("RTOTP;")
			else
				buf.put_string ("RTOSP (")
				buf.put_string (name)
				buf.put_string (");")
				l_res_name := result_name (name)
				if context.result_used then
					if real_type(result_type).c_type.is_pointer then
						buf.put_new_line
						buf.put_string ("RTOC_NEW(")
						buf.put_string (l_res_name)
						buf.put_string (");")
					end
				end
				buf.put_new_line
				buf.put_string ("%N#define Result ")
				buf.put_string (l_res_name)
			end
			buf.put_new_line
		end

	generate_once_declaration (name, type: STRING; is_procedure: BOOLEAN) is
			-- Generate declaration of static
		local
			head_buf, buf: GENERATION_BUFFER
			l_res_name: STRING
		do
			if is_global_once then
					-- Generate static mutex used to initialize global once
				buf := Context.buffer
				buf.put_string ("EIF_MUTEX_TYPE *")
				buf.put_character (' ')
				buf.put_string (mutex_name (name))
				buf.put_string (" = NULL;")
				buf.put_new_line
				buf.put_new_line
					-- Insert current global once in `context' so that
					-- mutex initialization call can be generated in the `EIF_MinitXX'
					-- routine of the type defining the global once.
					-- FIXME: Manu: 02/11/2003: Mutex are created in `EIF_MinitXX'
					-- but they are never freed, thus a memory leak if upon program
					-- termination the system does not get back the resources allocated
					-- for the mutex.
				context.global_onces.extend (body_index)
			elseif context.final_mode and then not System.has_multithreaded then
					-- Generate static declaration and definition of `once_done'
					-- and `once_result' variables used to find out if once has
					-- already been computed or not.
				head_buf := Context.header_buffer
				if not is_procedure then
					l_res_name := result_name (name)
					head_buf.put_new_line
					head_buf.put_string ("extern ")
					head_buf.put_string (type)
					head_buf.put_character (' ')
					head_buf.put_string (l_res_name)
					head_buf.put_character (';')
				end
				head_buf.put_new_line
				head_buf.put_string ("RTOSH(")
				head_buf.put_string (name)
				head_buf.put_character (')')
				head_buf.put_new_line
				head_buf.put_new_line

				buf := Context.buffer
				if not is_procedure then
					buf.put_string (type)
					buf.put_character (' ')
					buf.put_string (l_res_name)
					buf.put_string (" = (")
					buf.put_string (type)
					buf.put_string (") 0;")
				end
				buf.put_new_line
				buf.put_string ("RTOSD(")
				buf.put_string (name)
				buf.put_character (')')
				buf.put_new_line
				buf.put_new_line
			end
		end

	generate_once_epilogue (a_name: STRING) is
			-- Generate end of a once block.
		local
			l_buf: like buffer
		do
			l_buf := context.buffer
			if is_global_once then
				l_buf.put_string ("RTOPE (");
				l_buf.put_string (mutex_name (a_name))
				l_buf.put_string (");")
			elseif System.has_multithreaded or else not context.final_mode then
				l_buf.put_string ("RTOTE;")
			else
				l_buf.put_string ("RTOSE (")
				l_buf.put_string (a_name)
				l_buf.put_string (");")
			end
			l_buf.put_new_line
		end
		
feature -- Inlining

	pre_inlined_code: like Current is
			-- Never called!!! (a once function cannot be inlined)
		do
		end

	inlined_byte_code: STD_BYTE_CODE is
		local
			inlined_once_byte_code: INLINED_ONCE_BYTE_CODE
		do
			Result := Precursor
			if Result.has_inlined_code then
				create inlined_once_byte_code
				inlined_once_byte_code.fill_from (Result)
				Result := inlined_once_byte_code
			end;
		end

feature {NONE} -- Implementation

	generate_safe_once is
			-- Generate test at the head of once routines
		local
			type_i: TYPE_I
			buf: GENERATION_BUFFER
			class_id: INTEGER
		do
			buf := buffer
			type_i := real_type (result_type)
			class_id := context.original_class_type.static_type_id
			if
				result_type /= Void and then not result_type.is_void and then
				(context.workbench_mode or else context.result_used)
			then
				if type_i.c_type.is_pointer then
						-- Define "Result" macro for reference result type
					buf.put_string ("%N#define Result RTOTRR(")
				else
						-- Define "Result" macro for basic result type
					buf.put_string ("%N#define Result RTOTRB(")
				end
				if type_i.is_feature_pointer then
					buf.put_string ("EIF_POINTER")
				else
					buf.put_string (type_i.c_type.c_string)
				end
				buf.put_character (')')
				buf.put_new_line
				if type_i.c_type.is_pointer then
						-- Declare and initialize once data for reference result type
					buf.put_string ("RTOTDR(")
				else
						-- Declare and initialize once data for basic result type
					buf.put_string ("RTOTDB(")
						-- Use "EIF_POINTER" C type for TYPED_POINTER and CECIL type name for other types
					if type_i.is_feature_pointer then
						buf.put_string ("EIF_POINTER")
					else
						buf.put_string (type_i.c_type.c_string)
					end
					buf.put_string (gc_comma)
				end
			else
					-- Declare once data without initializing any result value
				buf.put_string ("RTOTDV(")
			end
			buf.put_string ("EIF_oidx_off")
			buf.put_integer (class_id)
			buf.put_string (" + ")
			buf.put_integer (context.once_index)
			buf.put_string (gc_rparan_semi_c)
			buf.put_new_line
			if context.workbench_mode then
					-- Real body id to be stored in the id list of already
					-- called once routines to prevent supermelting them
					-- (losing in that case their memory (already called and
					-- result)) and to allow result inspection.
				buf.put_string ("RTOTW(")
				buf.put_real_body_id (real_body_id)
				buf.put_string (gc_rparan_semi_c)
				buf.put_new_line
			end
		end

feature {NONE} -- Convenience

	result_name (a_name: STRING): STRING is
			-- Once result variable name using `a_name' as prefix
		require
			a_name_not_void: a_name /= Void
		do
			create Result.make (a_name.count + 7)
			Result.append (a_name)
			Result.append ("_result")
		ensure
			result_name_not_void: Result /= Void
		end

	done_name (a_name: STRING): STRING is
			-- Once result variable name using `a_name' as prefix
		require
			a_name_not_void: a_name /= Void
		do
			create Result.make (a_name.count + 5)
			Result.append (a_name)
			Result.append ("_done")
		ensure
			done_name_not_void: Result /= Void
		end

	mutex_name (a_name: STRING): STRING is
			-- Once mutex variable name using `a_name' as prefix
		require
			a_name_not_void: a_name /= Void
		do
			create Result.make (a_name.count + 6)
			Result.append (a_name)
			Result.append ("_mutex")
		ensure
			mutex_name_not_void: Result /= Void
		end
		
end

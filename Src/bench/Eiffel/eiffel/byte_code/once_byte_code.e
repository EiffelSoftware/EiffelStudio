-- Byte code for once feature

class ONCE_BYTE_CODE

inherit
	STD_BYTE_CODE
		redefine
			is_once, generate_once,
			pre_inlined_code, inlined_byte_code, generate_once_declaration,
			generate_global_once_termination, generate_il, is_global_once
		end

feature -- Access

	internal_is_global_once: BOOLEAN
			-- Is current once to be generated in multithreaded mode has a global once?

feature -- Status

	is_global_once: BOOLEAN is
			-- Is current once compiled in multithreaded mode with global status?
		do
			Result := System.has_multithreaded and then internal_is_global_once
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
		local
			has_result: BOOLEAN
			il_label_compute: IL_LABEL
			r_type: TYPE_I
		do
				-- Put a breakable point on feature name.
			il_generator.put_line_info (start_line_number)
			il_generator.flush_sequence_points (context.class_type)

			r_type := context.real_type(result_type)
			has_result := not r_type.is_void

			il_generator.set_once_generation (True)
			
			il_generator.generate_once_done_info (feature_name)
			if has_result then
				il_generator.generate_once_result_info (feature_name, r_type)
			end

			il_label_compute := il_label_factory.new_label
			il_generator.generate_once_test
			il_generator.branch_on_false (il_label_compute)

			if has_result then
				il_generator.generate_once_result
			end
			il_generator.generate_return

			il_generator.mark_label (il_label_compute)

				-- Mark once as being computed from now on.
			il_generator.generate_once_computed
			generate_il_body

			il_generator.put_debug_info (end_location)

			if has_result then
				il_generator.generate_result
			end
			il_generator.generate_return
			
			il_generator.set_once_generation (False)
		end

feature -- C code generation

	is_once: BOOLEAN is True;
			-- Is the current byte code relative to a once feature ?

	generate_once (name: STRING) is
			-- Generate test at the head of once routines
		do
			if is_global_once then
				generate_global_once (name)
			elseif System.has_multithreaded or else not context.final_mode then
				generate_safe_once
			else
				generate_optimized_once (name)
			end
		end

	generate_once_declaration (name, type: STRING; is_procedure: BOOLEAN) is
			-- Generate declaration of static
		local
			head_buf, buf: GENERATION_BUFFER
			l_res_name, l_done_name: STRING
		do
			if is_global_once then
					-- Generate static mutex used to initialize global once
				buf := Context.buffer
				buf.putstring ("EIF_MUTEX_TYPE *")
				buf.putchar (' ')
				buf.putstring (mutex_name (name))
				buf.putstring (" = NULL;")
				buf.new_line
				buf.new_line
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
					head_buf.new_line
					head_buf.putstring ("extern ")
					head_buf.putstring (type)
					head_buf.putchar (' ')
					head_buf.putstring (l_res_name)
					head_buf.putchar (';')
				end
				head_buf.new_line
				l_done_name := done_name (name)
				head_buf.putstring ("extern EIF_BOOLEAN ")
				head_buf.putstring (l_done_name)
				head_buf.putchar (';')
				head_buf.new_line
				head_buf.new_line

				buf := Context.buffer
				if not is_procedure then
					buf.putstring (type)
					buf.putchar (' ')
					buf.putstring (l_res_name)
					buf.putstring (" = (")
					buf.putstring (type)
					buf.putstring (") 0;")
				end
				buf.new_line
				buf.putstring ("EIF_BOOLEAN ")
				buf.putstring (l_done_name)
				buf.putstring (" = EIF_FALSE;")
				buf.new_line
				buf.new_line
			end
		end

	generate_global_once_termination (a_name: STRING) is
			-- Generate end of global once block.
		local
			l_buf: like buffer
			l_mutex_name: STRING
		do
			l_mutex_name := mutex_name (a_name)
			l_buf := context.buffer
			l_buf.exdent
			l_buf.putchar ('}')
			l_buf.new_line
			l_buf.putstring ("finished = EIF_TRUE;")
			l_buf.new_line
			l_buf.putstring ("eif_thr_mutex_unlock (")
			l_buf.putstring (l_mutex_name)
			l_buf.putstring (");")
			l_buf.new_line
			l_buf.exdent
			l_buf.putstring ("} else {")
			l_buf.new_line
			l_buf.indent
			l_buf.putstring ("if (!finished) {")
			l_buf.new_line
			l_buf.indent
			l_buf.putstring ("if (thread_id != eif_thr_thread_id()) {")
			l_buf.new_line
			l_buf.indent
			l_buf.putstring ("eif_thr_mutex_lock (")
			l_buf.putstring (l_mutex_name)
			l_buf.putstring (");")
			l_buf.new_line
			l_buf.putstring ("eif_thr_mutex_unlock (")
			l_buf.putstring (l_mutex_name)
			l_buf.putstring (");")
			l_buf.exdent
			l_buf.new_line
			l_buf.putchar ('}')
			l_buf.exdent
			l_buf.new_line
			l_buf.putchar ('}')
			l_buf.exdent
			l_buf.new_line
			l_buf.putchar ('}')
			l_buf.new_line
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

	generate_global_once (name: STRING) is
			-- Generate test at the head of once routine `name'.
		require
			multithreaded_mode: System.has_multithreaded
			is_global_once: internal_is_global_once
			name_not_void: name /= Void
		local
			type_i: TYPE_I
			buf: like buffer
			l_mutex_name: STRING
		do
			type_i := real_type (result_type)
			l_mutex_name := mutex_name (name)

			buf := buffer
			buf.putstring ("if (!done) {")
			buf.new_line
			buf.indent
			buf.putstring ("eif_thr_mutex_lock (")
			buf.putstring (l_mutex_name)
			buf.putstring (");")
			buf.new_line
				-- Double-Checked Locking on `done' is safe, because
				-- `done' is marked volatile.
			buf.putstring ("if (!done) {")
			buf.new_line
			buf.indent
			buf.putstring ("thread_id = eif_thr_thread_id();")
			buf.new_line
			buf.putstring ("done = EIF_TRUE;")

			if context.result_used then
				if real_type(result_type).c_type.is_pointer then
					buf.new_line
					buf.putstring ("RTOC_GLOBAL(")
					buf.putstring ("Result")
					buf.putstring (");")
				end
			end

			buf.new_line
			init_dftype
			init_dtype
		end

	generate_optimized_once (name: STRING) is
			-- Generate test at the head of once routines
		local
			type_i		: TYPE_I
			buf			: GENERATION_BUFFER
			l_res_name, l_done_name	: STRING
		do
			buf := buffer
			l_res_name := result_name (name)
			l_done_name := done_name (name)

			type_i := real_type (result_type)

			buf.putstring ("if (")
			buf.putstring (l_done_name)
			buf.putstring (") return")
			if result_type /= Void and then not result_type.is_void then
				buf.putchar (' ')
				buf.putstring (l_res_name)
			end
			buf.putchar (';')

			buf.new_line
			buf.putstring (l_done_name)
			buf.putstring (" = EIF_TRUE;")

			if context.result_used then
				if real_type(result_type).c_type.is_pointer then
					buf.new_line
					buf.putstring ("RTOC_NEW(")
					buf.putstring (l_res_name)
					buf.putstring (");")
				end
			end

			buf.new_line
			buf.putstring ("%N#define Result ")
			buf.putstring (l_res_name)
			buf.new_line
			init_dftype
			init_dtype
		end;
		
	generate_safe_once is
			-- Generate test at the head of once routines
		local
			type_i: TYPE_I;
			buf: GENERATION_BUFFER
			class_id: INTEGER
		do
			buf := buffer
			buf.putstring ("%N#define Result *PResult")
			buf.new_line
			type_i := real_type (result_type);
			class_id := context.original_class_type.static_type_id
			buf.putstring ("if (MTOG((");
			type_i.c_type.generate (buf);
			buf.putstring ("*),*(EIF_once_values + EIF_oidx_off")
			buf.putint (class_id)
			buf.putstring (" + ");
			buf.putint (context.once_index);
			buf.putstring ("),PResult))");
			buf.new_line;
			buf.indent;
				-- Full generation for a once function, but a single
				-- return for procedures.
			buf.putstring ("return");
			if result_type /= Void and then not result_type.is_void then
				buf.putchar (' ');
				if context.result_used then
					buf.putstring ("*PResult");
				else
					type_i.c_type.generate_cast (buf);
					buf.putchar ('0');
				end;
			end;
			buf.putstring (";%N");
			buf.exdent;
				-- Detach this block
			buf.new_line;
			buf.putstring ("PResult = (");
			type_i.c_type.generate (buf);
			if
				result_type /= Void and then not result_type.is_void and then
				(context.workbench_mode or else context.result_used)
			then
				if real_type(result_type).c_type.is_pointer then
						-- Record once by allocating room in once_set stack.
						-- This room will be updated to point to Result,
						-- only if it is a reference. This will raise an
						-- exception if the address cannot be recorded and
						-- 'PResult' won't be set via the key.
					buf.putstring ("*) RTOC(0);");
				else
						-- If not a reference, we need to allocate some place
						-- where to store the Result (We can't store Result
						-- directly, since it might be 0...)
					buf.putstring ("*) cmalloc(sizeof(");
					type_i.c_type.generate (buf);
					buf.putstring ("*));");
					buf.new_line
					buf.putstring ("Result = ")
					type_i.c_type.generate_cast (buf);
					buf.putstring ("0;");
				end;
			else
				buf.putstring ("*) 1;");
			end;
			buf.new_line;
			buf.putstring ("MTOS(*(EIF_once_values + EIF_oidx_off")
			buf.putint (class_id)
			buf.putstring (" + ");
			buf.putint (context.once_index);
			buf.putstring ("),PResult);");
			buf.new_line;
			if context.workbench_mode then
					-- Real body id to be stored in the id list of already
					-- called once routines to prevent supermelting them
					-- (losing in that case their memory (already called and
					-- result)) and to allow result inspection.
				buf.putstring ("RTWO(");
				buf.generate_real_body_id (real_body_id)
				buf.putstring (gc_rparan_semi_c);
				buf.new_line
			end;
			init_dftype
			init_dtype;
		end;

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

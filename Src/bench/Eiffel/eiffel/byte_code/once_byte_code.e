-- Byte code for once feature

class ONCE_BYTE_CODE

inherit
	STD_BYTE_CODE
		redefine
			is_once, generate_once,
			pre_inlined_code, inlined_byte_code, generate_once_declaration,
			generate_il, is_global_once
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
			il_label_compute, il_label_end, il_return_result: IL_LABEL
			r_type: TYPE_I
		do
			r_type := context.real_type(result_type)
			has_result := not r_type.is_void

			il_generator.generate_once_done_info (feature_name)
			if has_result then
				il_generator.generate_once_result_info (feature_name, r_type)
			end

			il_label_compute := il_label_factory.new_label
			il_label_end := il_label_factory.new_label
			il_generator.generate_once_test
			il_generator.branch_on_false (il_label_compute)
			if has_result then
				il_return_result := il_label_factory.new_label
				il_generator.generate_once_result
				il_generator.branch_to (il_return_result)
			else
				il_generator.branch_to (il_label_end)
			end
			il_generator.mark_label (il_label_compute)
			generate_il_body
			if has_result then
				il_generator.generate_result
				il_generator.generate_once_store_result
			end
			il_generator.branch_to (il_label_end)

			if has_result then
				il_generator.mark_label (il_return_result)
				il_generator.generate_result_assignment
			end

			il_generator.mark_label (il_label_end)
			generate_il_return (has_result)
		end

feature -- C code generation

	is_once: BOOLEAN is True;
			-- Is the current byte code relative to a once feature ?

	generate_once (name: STRING) is
			-- Generate test at the head of once routines
		do
			if is_global_once then
				generate_global_once
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
		do
			if
				not is_global_once and then
				context.final_mode and then not System.has_multithreaded
			then
				head_buf := Context.header_buffer
				if not is_procedure then
					head_buf.new_line
					head_buf.putstring ("extern ")
					head_buf.putstring (type)
					head_buf.putchar (' ')
					head_buf.putstring (name)
					head_buf.putstring ("_result;")
				end
				head_buf.new_line
				head_buf.putstring ("extern EIF_BOOLEAN ")
				head_buf.putstring (name)
				head_buf.putstring ("_done;")
				head_buf.new_line
				head_buf.new_line

				buf := Context.buffer
				if not is_procedure then
					buf.putstring (type)
					buf.putchar (' ')
					buf.putstring (name)
					buf.putstring ("_result = (")
					buf.putstring (type)
					buf.putstring (") 0;")
				end
				buf.new_line
				buf.putstring ("EIF_BOOLEAN ")
				buf.putstring (name)
				buf.putstring ("_done = EIF_FALSE;")
				buf.new_line
				buf.new_line
			end
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
				!!inlined_once_byte_code
				inlined_once_byte_code.fill_from (Result)
				Result := inlined_once_byte_code
			end;
		end

feature {NONE} -- Implementation

	generate_global_once is
			-- Generate test at the head of once routines
		local
			type_i: TYPE_I
			buf: like buffer
		do
			type_i := real_type (result_type)

			buf := buffer
			buf.putstring ("if (!done) {")
			buf.new_line
			buf.indent
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
			init_dtype
		end

	generate_optimized_once (name: STRING) is
			-- Generate test at the head of once routines
		local
			type_i		: TYPE_I
			buf			: GENERATION_BUFFER
			result_name	: STRING
		do
			buf := buffer
			create result_name.make (name.count + 8)
			result_name.append (name)
			result_name.append ("_result")

			type_i := real_type (result_type)

			buf.putstring ("if (")
			buf.putstring (name)
			buf.putstring ("_done) return")
			if result_type /= Void and then not result_type.is_void then
				buf.putchar (' ')
				buf.putstring (result_name)
			end
			buf.putchar (';')

			buf.new_line
			buf.putstring (name)
			buf.putstring ("_done = EIF_TRUE;")

			if context.result_used then
				if real_type(result_type).c_type.is_pointer then
					buf.new_line
					buf.putstring ("RTOC_NEW(")
					buf.putstring (result_name)
					buf.putstring (");")
				end
			end

			buf.new_line
			buf.putstring ("%N#define Result ")
			buf.putstring (result_name)
			buf.new_line
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
				buf.putstring (gc_rparan_comma);
				buf.new_line
			end;
			init_dtype;
		end;

end

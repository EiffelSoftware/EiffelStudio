-- Byte code for once feature

class ONCE_BYTE_CODE

inherit

	STD_BYTE_CODE
		rename
			inlined_byte_code as std_inlined_byte_code
		redefine
			is_once, generate_once, generate_result_declaration,
			pre_inlined_code
		end
	STD_BYTE_CODE
		redefine
			is_once, generate_once, generate_result_declaration,
			pre_inlined_code, inlined_byte_code
		select
			inlined_byte_code
		end

feature

	is_once: BOOLEAN is True;
			-- Is the current byte code relative to a once feature ?

	generate_once is
			-- Generate test at the head of once routines
		local
			type_i: TYPE_I;
			f: INDENT_FILE
		do
			f := generated_file
			type_i := real_type (result_type);
			f.putstring ("if (MTOG((");
			type_i.c_type.generate (f);
			f.putstring ("*),*(EIF_once_values + EIF_oidx_off + ");
			f.putint (context.once_index);
			f.putstring ("),PResult))");
			f.new_line;
			f.indent;
				-- Full generation for a once function, but a single
				-- return for procedures.
			f.putstring ("return");
			if result_type /= Void and then not result_type.is_void then
				f.putchar (' ');
				if context.result_used then
					f.putstring ("*PResult");
				else
					type_i.c_type.generate_cast (f);
					f.putchar ('0');
				end;
			end;
			f.putstring (";%N");
			f.exdent;
				-- Detach this block
			f.new_line;
			if context.result_used then
				if real_type(result_type).c_type.is_pointer then
						-- Record once by allocating room in once_set stack.
						-- This room will be updated to point to Result,
						-- only if it is a reference. This will raise an
						-- exception if the address cannot be recorded and
						-- 'PResult' won't be set via the key.
					f.putstring ("PResult = (");
					type_i.c_type.generate (f);
					f.putstring ("*) RTOC(0);");
				else
					-- If not a reference, we need to allocate some place
					-- where to store the Result (We can't store Result
					-- directly, since it might be 0...)
					f.putstring ("PResult = (");
					type_i.c_type.generate (f);
					f.putstring ("*) cmalloc(sizeof(");
					type_i.c_type.generate (f);
					f.putstring ("*));");
				end;
			else
				f.putstring ("PResult = (");
				type_i.c_type.generate (f);
				f.putstring ("*) 1;");
			end;
			f.new_line;
			f.putstring ("MTOS(*(EIF_once_values + EIF_oidx_off + ");
			f.putint (context.once_index);
			f.putstring ("),PResult);");
			f.new_line;
			if context.workbench_mode then
					-- Real body id to be stored in the id list of already
					-- called once routines to prevent supermelting them
					-- (losing in that case their memory (already called and
					-- result)) and to allow result inspection.
				f.putstring ("RTWO(");
				f.putstring (real_body_id.generated_id);
				f.putstring (gc_rparan_comma);
				f.new_line
			end;
			init_dtype;
		end;

	generate_result_declaration is
			-- Generate declaration of the Result entity
		do
			generated_file.putstring ("%N#define Result *PResult%N");
		end;

feature -- Inlining

	pre_inlined_code: like Current is
			-- Never called!!! (a once function cannot be inlined)
		do
		end

	inlined_byte_code: STD_BYTE_CODE is
		local
			inlined_once_byte_code: INLINED_ONCE_BYTE_CODE
		do
			Result := std_inlined_byte_code;
			if Result.has_inlined_code then
				!!inlined_once_byte_code
				inlined_once_byte_code.fill_from (Result)
				Result := inlined_once_byte_code
			end;
		end

end


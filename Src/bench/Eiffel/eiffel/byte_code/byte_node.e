-- Main description of a byte code tree node. All the classes which
-- describe the byte code inherit from us.

class BYTE_NODE 

inherit

	BYTE_CONST
		export
			{NONE} all
		end

	SHARED_BYTE_CONTEXT
		export
			{ANY} all
		end

	SHARED_WORKBENCH
		export
			{NONE} all
		end

	SHARED_TYPE_I
		export
			{NONE} all
		end

	SHARED_GENERATION

	COMPILER_EXPORTER

feature -- Eiffel source line information

	line_number : INTEGER is     
			-- Line number where construct
			-- begins in the Eiffel source.
		do
			Result := -1;
				-- Unknown by default.
		end

	set_line_number (lnr : INTEGER) is
			-- Set `line_number' to `lnr'.
		do
			-- Nothing by default
		end

	generate_line_info is
			-- Generate source line information.
		do
			if System.line_generation and then line_number > 0 then
				buffer.putstring ("%N#line ")
				buffer.putint (line_number)
				buffer.new_line
			end
		end
feature 

	buffer: GENERATION_BUFFER is
			-- Generated file
		do
			Result := context.buffer;
		end;

	real_type (typ: TYPE_I): TYPE_I is
			-- Real type
		do
			Result := context.constrained_type (typ);
			Result := context.instantiation_of (Result);
		end;

	enlarge_tree is
			-- Enlarges the tree for suitable decoration
		do
		end;

	enlarged: like Current is
			-- Enlarge current node for C code generation
		do
			Result := Current;
		end;

	need_enlarging: BOOLEAN is
			-- Does current node need to be enlarged ?
		do
		end;

	analyze is
			-- First pass to build a proper context
		do
		end;
	
	generate is
			-- Generate C code in `buffer'
		do
		end;

	find_assign_result is
			-- Find assignments in Result at the very last
			-- instruction in a function.
		do
		end;

	mark_last_instruction is
			-- Mark a last instruction if it needs special
			-- considerations (as formatting is concerned).
		do
		end;

	last_all_in_result: BOOLEAN is
			-- Are all the exit points in a function occupied
			-- by an assignment in Result ?
		do
		end;

	make_byte_code (ba: BYTE_ARRAY) is
			-- Build byte code array for Current byte node
		do
			-- Do nothing
		end;

	make_breakable (ba: BYTE_ARRAY) is
			-- Put a breakable point token
			-- hook when generating debuggable byte code.
		do
			if context.debug_mode then
				context.record_breakable (ba);
			end
		end; -- make_breakable

feature -- Array optimization

	calls_special_features (array_desc: INTEGER): BOOLEAN is
		do
		end

	is_unsafe: BOOLEAN is
		do
		end;

	assigns_to (i: INTEGER): BOOLEAN is
			-- i > 0:	Does this byte node assign something to the attribute
			--			of `feature_id' `i'?
			-- i = 0:	Does this byte node assign something to `Result'
			-- i < 0:	Does this byte node assign something to the local # <-n>
		do
		end

	optimized_byte_node: like Current is
			-- Modify the byte code if the loop optimization is safe
		do
			Result := Current
		end

feature -- Inlining

	size: INTEGER is
		do
			Result := 1
		end

	pre_inlined_code: like Current is
			-- Modified byte code: all the accesses to locals, Result,
			-- arguments, Current are modified to use local variables of
			-- the client
		do
			Result := Current
		end

	inlined_byte_code: like Current is
			-- Perform inlining in the current byte node
		do
			Result := Current
		end

feature -- Concurrent Eiffel

	has_separate_call: BOOLEAN is
			-- Is there a separate call in this byte node?
		do
			Result := False;
		end

feature -- Generic conformance

	generate_block_open is
			-- Open a new C block.
		do
			buffer.putchar ('{')
			buffer.new_line
			buffer.indent
		end

	generate_block_close is
			-- Close C block.
		do
			buffer.new_line
			buffer.exdent
			buffer.putchar ('}')
			buffer.new_line
		end

	generate_gen_type_conversion (gtype : GEN_TYPE_I) is
			-- Generate code for converting type id arrays
			-- into single id's.
		require
			valid_type : gtype /= Void
		local
			use_init : BOOLEAN
			idx_cnt : COUNTER
		do
			if gtype.is_explicit then
				-- Optimize: Use static array
				buffer.putstring ("static int16 typarr [] = {")
			else
				buffer.putstring ("int16 typarr [] = {")
				use_init := True
			end

			buffer.putint (context.current_type.generated_id (context.final_mode))
			buffer.putstring (", ")

			if use_init then
				!!idx_cnt
				idx_cnt.set_value (1)
				gtype.generate_cid_array (buffer, context.final_mode, True, idx_cnt)
			else
				gtype.generate_cid (buffer, context.final_mode, True)
			end
			buffer.putstring ("-1};")
			buffer.new_line
			buffer.putstring ("int16 typres;")
			buffer.new_line
			buffer.putstring ("static int16 typcache = -1;")
			buffer.new_line
			buffer.new_line

			if use_init then
				-- Reset counter
				idx_cnt.set_value (1)
				gtype.generate_cid_init (buffer, context.final_mode, True, idx_cnt)
			end

			buffer.putstring ("typres = RTCID(&typcache,")

			context.Current_register.print_register_by_name

			buffer.putstring (", ")
			buffer.putint (gtype.generated_id (context.final_mode))
			buffer.putstring (", typarr);")
			buffer.new_line
			buffer.new_line
		end

end

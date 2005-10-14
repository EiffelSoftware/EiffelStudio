indexing
	description	: "Main description of a byte code tree node. All the classes which %
				  %describe the byte code inherit from us."
	date		: "$Date$"
	revision	: "$Revision$"

deferred class BYTE_NODE 

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

	SHARED_TYPE_I
		export
			{NONE} all
		end

	SHARED_GENERATION

	COMPILER_EXPORTER

	SHARED_IL_CODE_GENERATOR

feature -- Visitor

	process (v: BYTE_NODE_VISITOR) is
			-- Visitor feature.
		require
			v_not_void: v /= Void
		deferred
		end
		
feature -- Eiffel source line information

	line_number: INTEGER is     
			-- Position where construct is located in Eiffel source.
		do
				-- Unknown by default.
			Result := -1
		ensure
			Result_positive: Result > 0
		end

	set_line_number (lnr: INTEGER) is
			-- Set `line_number' to `lnr'.
		require
			lnr_positive: lnr > 0
		do
			-- Nothing by default
		end

	generate_line_info is
			-- Generate source line information.
		local
			l_buffer: like buffer
		do
			if System.line_generation and then line_number > 0 then
				l_buffer := buffer
				l_buffer.put_string ("%N#line ")
				l_buffer.put_integer (line_number)
				l_buffer.put_character (' ')
				l_buffer.put_indivisible_string_literal (Context.associated_class.lace_class.base_name)
				l_buffer.put_new_line
			end
		end

	generate_il_line_info (breakable_for_studio_dbg: BOOLEAN) is
			-- Generate source line information in IL code.
		do
			if (System.line_generation or context.workbench_mode) and then line_number > 0 then
				if breakable_for_studio_dbg then
					il_generator.put_line_info (line_number)
				else
					il_generator.put_silent_line_info (line_number)
				end
			end
		end
		
	generate_ghost_debug_infos (n: INTEGER) is
			-- Generate `a_nb' ghost debug informations,
			-- this is to deal, for instance, with the not generated debug clauses
		do
			if (System.line_generation or context.workbench_mode) then
				if system.is_precompile_finalized then
					il_generator.put_ghost_debug_infos (line_number, n)
				end
			end
		end

	get_current_frozen_debugger_hook: INTEGER is
			-- Get the current hook number for the C debugger
		require
			workbench_mode: not context.final_mode or else system.exception_stack_managed
		do
			Result := context.get_breakpoint_slot
		end

	set_current_frozen_debugger_hook (a_hook_number: INTEGER) is
			-- Set the current hook number for the C debugger
			-- to `a_hook_number'
		require
			a_hook_number_positive: a_hook_number >= 0
		do
			context.set_breakpoint_slot (a_hook_number)
		end

	generate_frozen_debugger_hook is
			-- Generate the hook for the C debugger for the
			-- line number `lnr' (line number means breakpoint slot)
		local
			lnr: INTEGER
			l_buffer: like buffer
		do
			if not context.final_mode or else System.exception_stack_managed then
				lnr := context.get_next_breakpoint_slot
				check
					lnr > 0
				end
				l_buffer := buffer
				l_buffer.put_string("RTHOOK(")
				l_buffer.put_integer(lnr)
				l_buffer.put_string(");")
				l_buffer.put_new_line
			end
		end

	generate_frozen_end_debugger_hook is
			-- Generate the hook for the C debugger corresponding
			-- to the end of the feature.
		local
			l_buffer: like buffer
		do
			if not context.final_mode or else System.exception_stack_managed then
				l_buffer := buffer
				l_buffer.put_string("RTHOOK(")
				l_buffer.put_integer(context.current_feature.number_of_breakpoint_slots)
				l_buffer.put_string(");")
				l_buffer.put_new_line
			end
		end

	generate_frozen_debugger_hook_nested is
			-- Generate the hook for the C debugger for the
			-- line number `lnr' (line number means breakpoint slot)
		local
			lnr: INTEGER
			l_buffer: like buffer
		do
				-- used to generate a debugger hook in the middle of nested call
				-- to be able to enter in the function applicated to the object 
				-- with the debugger.
				--
				-- Example: a:A is 
				--            do
				--            	if ... then
				--					Result := a1
				--				else
				--					Result := a2
				--            end
				--
				-- "a.toto; b.titi" will be generated as follow
				--
				-- debugger_hook(line n)
				-- retrieve a
				-- debugger_hook_nested(line n)
				-- call toto
				-- debugger_hook(line n+1)
				-- call b.titi
				--
				-- Note: the line number is not increased !!

			if not context.final_mode then
				lnr := context.get_breakpoint_slot
					-- if lnr = 0 or -1 then we do nothing.
				if lnr > 0 then
					l_buffer := buffer
					l_buffer.put_string("RTNHOOK(")
					l_buffer.put_integer(lnr)
					l_buffer.put_string(");")
					l_buffer.put_new_line
				end
			end
		end

	generate_melted_debugger_hook (ba: BYTE_ARRAY) is
			-- Record breakable point (standard)
		require
			melting: not context.final_mode
		local
			lnr: INTEGER
		do
			lnr := context.get_next_breakpoint_slot
			check
				lnr > 0
			end
			ba.generate_melted_debugger_hook (lnr)
		end

	generate_melted_debugger_hook_nested (ba: BYTE_ARRAY) is
			-- Record breakable point for nested call
		local
			l_line: INTEGER
		do
			l_line := context.get_breakpoint_slot
			if l_line > 0 then
					-- Generate a hook when there is really need for one.
					-- (E.g. we do not need a hook for the code generation
					-- of an invariant).
				ba.generate_melted_debugger_hook_nested (l_line)
			end
		end

	generate_melted_end_debugger_hook (ba: BYTE_ARRAY) is
			-- Record the breakable point corresponding to the end of the feature.
		do
			ba.generate_melted_debugger_hook (context.current_feature.number_of_breakpoint_slots)
		end

feature 

	null_byte_node: BYTE_LIST [BYTE_NODE] is
			-- Null instructions
		once
			create Result.make (0)
		end
	
	buffer: GENERATION_BUFFER is
			-- Generated file
		do
			Result := context.buffer
		ensure
			Result_not_void: Result /= Void
		end

	real_type (typ: TYPE_I): TYPE_I is
			-- Real type
		require
			typ_not_void: typ /= Void
		do
			Result := context.real_type (typ)
		ensure
			Result_not_void: Result /= Void
		end

	enlarge_tree is
			-- Enlarges the tree for suitable decoration
		do
		end

	enlarged: like Current is
			-- Enlarge current node for C code generation
		do
			Result := Current
		ensure
			Result_not_void: Result /= Void
		end

	need_enlarging: BOOLEAN is
			-- Does current node need to be enlarged ?
		do
		end

	analyze is
			-- First pass to build a proper context
		do
		end
	
	generate is
			-- Generate C code in `buffer'
		do
		end

	generate_il is
			-- Generate IL byte code
		require
			il_generation: System.il_generation
		do
		end

	find_assign_result is
			-- Find assignments in Result at the very last
			-- instruction in a function.
		do
		end

	mark_last_instruction is
			-- Mark a last instruction if it needs special
			-- considerations (as formatting is concerned).
		do
		end

	last_all_in_result: BOOLEAN is
			-- Are all the exit points in a function occupied
			-- by an assignment in Result ?
		do
		end

	make_byte_code (ba: BYTE_ARRAY) is
			-- Build byte code array for Current byte node
		require
			ba_not_void: ba /= Void
		do
			-- Do nothing
		end

feature -- Array optimization

	calls_special_features (array_desc: INTEGER): BOOLEAN is
		do
		end

	is_unsafe: BOOLEAN is
		do
		end

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
		ensure
			Result_not_void: Result /= Void
		end

feature -- Inlining

	size: INTEGER is
		do
			Result := 0
		ensure
			Result_greater_or_equal_to_one: Result >= 0
		end

	pre_inlined_code: like Current is
			-- Modified byte code: all the accesses to locals, Result,
			-- arguments, Current are modified to use local variables of
			-- the client
		do
			Result := Current
		ensure
			Result_not_void: Result /= Void
		end

	inlined_byte_code: like Current is
			-- Perform inlining in the current byte node
		do
			Result := Current
		ensure
			Result_not_void: Result /= Void
		end

feature -- Generic conformance

	generate_block_open is
			-- Open a new C block.
		local
			l_buffer: like buffer
		do
			l_buffer := buffer
			l_buffer.put_character ('{')
			l_buffer.put_new_line
			l_buffer.indent
		end

	generate_block_close is
			-- Close C block.
		local
			l_buffer: like buffer
		do
			l_buffer := buffer
			l_buffer.put_new_line
			l_buffer.exdent
			l_buffer.put_character ('}')
			l_buffer.put_new_line
		end

	generate_gen_type_conversion (gtype : GEN_TYPE_I) is
			-- Generate code for converting type id arrays
			-- into single id's.
		require
			valid_type : gtype /= Void
		local
			use_init : BOOLEAN
			idx_cnt : COUNTER
			l_buffer: like buffer
		do
			l_buffer := buffer
			use_init := not gtype.is_explicit
			
				-- Optimize: Use static array only when `typarr' is
				-- not modified by generated code in multithreaded mode only.
				-- It is safe in monothreaded code as we are guaranteed that
				-- only one thread of execution will use the modified `typarr'.
			if not System.has_multithreaded or else not use_init then
				l_buffer.put_string ("static ")
			end
			l_buffer.put_string ("int16 typarr [] = {")

			l_buffer.put_integer (context.current_type.generated_id (context.final_mode))
			l_buffer.put_character (',')

			if use_init then
				create idx_cnt
				idx_cnt.set_value (1)
				gtype.generate_cid_array (l_buffer, context.final_mode, True, idx_cnt)
			else
				gtype.generate_cid (l_buffer, context.final_mode, True)
			end
			l_buffer.put_string ("-1};")
			l_buffer.put_new_line
			l_buffer.put_string ("int16 typres;")
			l_buffer.put_new_line
			if not use_init then
				l_buffer.put_string ("static int16 typcache = -1;")
				l_buffer.put_new_line
			end
			l_buffer.put_new_line

			if use_init then
				-- Reset counter
				idx_cnt.set_value (1)
				gtype.generate_cid_init (l_buffer, context.final_mode, True, idx_cnt)
			end

			if not use_init then
				l_buffer.put_string ("typres = RTCID2(&typcache, ")
			else
				l_buffer.put_string ("typres = RTCID2(NULL, ")
			end
			context.generate_current_dftype
			l_buffer.put_string (", ")
			l_buffer.put_integer (gtype.generated_id (context.final_mode))
			l_buffer.put_string (", typarr);")
			l_buffer.put_new_line
			l_buffer.put_new_line
		end
end

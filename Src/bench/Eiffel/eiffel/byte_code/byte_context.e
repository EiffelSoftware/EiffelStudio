-- Context variables for code generation and utilities.

class BYTE_CONTEXT

inherit

	SHARED_C_LEVEL
		export
			{NONE} all
		end
	ASSERT_TYPE
	SHARED_ARRAY_BYTE
	SHARED_SERVER
	SHARED_GENERATION
	COMPILER_EXPORTER

creation

	make, make_from_context

feature

	once_index : INTEGER        -- Index of current once routine

	set_once_index (idx : INTEGER) is
			-- Set `once_index' to `idx'
		require
			valid_index : idx >= 0
		do
			once_index := idx
		ensure
			index_set : once_index = idx
		end

	generation_mode: BOOLEAN
			-- Mode of generation: if set to True, generation of C code
			-- for the workbench otherwise generation of C code in final
			-- mode

	set_workbench_mode is
			-- Set `generation_mode' to True.
		do
			generation_mode := True
		end

	set_final_mode is
			-- Set `generation_mode' to False.
		do
			generation_mode := False
		end

	workbench_mode: BOOLEAN is
			-- Is `generation_mode' set to True ?
		do
			Result := generation_mode
		end

	final_mode: BOOLEAN is
			-- Is `generation_mode' set to False ?
		do
			Result := not generation_mode
		end

	current_type: CL_TYPE_I
			-- Current class type in which byte code is processed

	class_type: CLASS_TYPE
			-- The class type which we are generating
			--| will be changed for assertion chaining

	original_class_type: CLASS_TYPE
			-- class type we are generating

	buffer: GENERATION_BUFFER
			-- Buffer used for code generation

	header_buffer: GENERATION_BUFFER
			-- Buffer used for extern declaration generation

	inherited_assertion: INHERITED_ASSERTION
			-- Used to record inherited assertions

	byte_code: BYTE_CODE
			-- Current root of processed byte code

	old_expressions: LINKED_LIST [UN_OLD_B]
			-- Used to record old expressions in Pass 3.

	make is
			-- Initialization
		do
			!!register_server.make (true)
			!!local_vars.make (1, 1000)
			!!local_index_table.make (10)
			!!associated_register_table.make (10)
			!!local_list.make
			!!old_expressions.make
			!!inherited_assertion.make
		end

	set_buffer (b: like buffer) is
			-- Assign `b' to `buffer'.
		do
			buffer := b
		end

	set_header_buffer (b: like header_buffer) is
			-- Assign `b' to `header_buffer'.
		do
			header_buffer := b
		end

	non_gc_tmp_vars: INTEGER
			-- Total number of registers for references variables needed.

	non_gc_reg_vars: INTEGER
			-- Currently used registers for reference variables which do not
			-- need to be under GC control (e.g. Hector references).

	exp_args: INTEGER
			-- Number of (declared) expanded arguments.

	local_vars: ARRAY [BOOLEAN]
			-- Local variables used have their flag set to true.

	local_index_table: EXTEND_TABLE [INTEGER, STRING]
			-- Index in local variable array (C code) for a given register

	associated_register_table: HASH_TABLE [REGISTRABLE, STRING]
			-- Indexed by the same keys as `local_index_table', this associative
			-- array maps a name into a registrable instance.

	propagated: BOOLEAN
			-- Was the propagated value caught ?

	current_used: BOOLEAN
			-- Is Current used (apart from dtype computation) ?

	result_used: BOOLEAN
			-- Is Result used (apart from very last assignment) ?

	label: INTEGER
			-- For label generation

	dt_current: INTEGER
			-- Number of time we need to compute Current's type

	inlined_dt_current: INTEGER
			-- Number of time we need to compute Current's type

	local_index_counter: INTEGER
			-- Index for local reference variables

	assertion_type: INTEGER
			-- Type of assertion being generated

	is_prec_first_block: BOOLEAN
			-- Is precondition in first block

	Current_register: REGISTRABLE is
			-- An instance of Current register for local var index computation
		do
			Result := inlined_current_register
			if Result = Void then
				Result := Current_b
			end
		end

	Current_b: CURRENT_BL is
		once
			!! Result
		end

	Result_register: RESULT_B is
			-- An instace of Result register for local var index computation
		local
			dummy: NONE_I
		once
				-- This hack is needed because of the special treatment of
				-- the Result register in once functions. The Result is always
				-- recorded in the GC by RTOC, so there is no need to get an
				-- l[] variable from the GC hooks. Here we are going to call
				-- the print_register_by_name function on Result_register,
				-- and this has been carefully patched in RESULT_BL to handle
				-- the once cases.
			!! dummy
			!RESULT_BL! Result.make (dummy)
		end

	register_server: REGISTER_SERVER
			-- Register number server

	set_assertion_type (a: INTEGER) is
			-- Assign `a' to `assertion_type'
		do
			assertion_type := a
		end

	set_is_prec_first_block (a: BOOLEAN) is
			-- Assign `a' to `assertion_type'
		do
			is_prec_first_block := a
		end

	has_chained_prec: BOOLEAN is
			-- Feature has chained preconditions?
		do
			Result := (byte_code.precondition /= Void
					or else inherited_assertion.has_precondition)
				and then
					(	workbench_mode
						or else
						assertion_level.check_precond)
		end

	has_rescue: BOOLEAN is
			-- Feature has a rescue clause ?
		do
			Result := byte_code.rescue_clause /= Void
		end

	set_origin_has_precondition (b: BOOLEAN) is
		do
			origin_has_precondition := b
		end

	origin_has_precondition: BOOLEAN
			-- Is Current feature have origin feature with precondition?
			-- (This is used for cases where the origin of the
			-- routine does not have a precondition and thus
			-- the precondition will always be true)

	has_postcondition: BOOLEAN is
			-- Do we have to generate any postcondition ?
		do
			Result :=	workbench_mode
						or else
						(	assertion_level.check_postcond
							and
							(	byte_code.postcondition /= Void
								or else
								inherited_assertion.has_postcondition
							)
						)
		end

	has_precondition: BOOLEAN is
			-- Do we have to generate any precondition ?
		do
			Result := 	workbench_mode
						or else
						(
							assertion_level.check_precond
							and
							byte_code.precondition /= Void
						)
		end

	has_invariant: BOOLEAN is
			-- Do we have to generate invariant checks ?
		do
			Result := workbench_mode or assertion_level.check_invariant
		end

	assertion_level: ASSERTION_I is
			-- Assertion level description
		do
			Result := associated_class.assertion_level
		end

	associated_class: CLASS_C is
			-- Class associated with current type
		do
			Result := current_type.base_class
		end

	instantiation_of (type: TYPE_I): TYPE_I is
			-- Instantiation of `type' in `curent_type'.
		require
			current_type_exists: current_type /= Void
		local
			gen_type: GEN_TYPE_I
		do
			if type.has_formal then
				gen_type ?= current_type
				Result := type.instantiation_in (gen_type)
			else
				Result := type
			end
		end

	constrained_type (type: TYPE_I): TYPE_I is
			-- Constrained type
		require
			curent_type_exists: current_type /= Void
		local
			formal: FORMAL_I
			formal_position: INTEGER
			reference_i: REFERENCE_I
		do
			Result := type
			if Result.is_formal then
				formal ?= Result
				check
					current_type.meta_generic /= Void
				end
				formal_position := formal.position
				Result := current_type.meta_generic.item (formal_position)
				reference_i ?= Result
				if reference_i /= Void then
					Result := current_type.base_class.constraint
													(formal_position).type_i
				end
			end
		ensure
			not_formal: not Result.is_formal
		end

	real_type (type: TYPE_I): TYPE_I is
			-- Convenience
		require
			good_argument: type /= Void
			valid_class_type: class_type /= Void
		do
			Result := constrained_type (type)
			Result := instantiation_of (Result)
		ensure
			not Result.is_formal
		end


	set_byte_code (bc: BYTE_CODE) is
			-- Assign `bc' to byte_code.
		require
			good_argument: bc /= Void
		do
			byte_code := bc
		end

	init (t: CLASS_TYPE) is
			-- Initialization of byte context.
			-- Check to see if class type has inherited
			-- assertions. If it does not then set
			-- has_inherited_assertion to False. Otherwize,
			-- set has_inherited_assertion to True.
		do
			set_class_type (t)
			original_class_type := t
			--if System.Redef_feat_server.has (associated_class.id) then
				--has_inherited_assertion := True
			--else
				--has_inherited_assertion := False
			--end
		end

	set_class_type (t: CLASS_TYPE) is
			-- Assign `t' to class_type.
		require
			good_argument: t /= Void
		do
			class_type := t
			current_type := t.type
		end

	set_current_type (t: CL_TYPE_I) is
			-- Assign `t' to `current_type'
		require
			good_argument: t /= Void
		do
			current_type := t
		end

	add_non_gc_vars is
			-- Add a temporary reference variable not to be placed under GC.
		do
			non_gc_reg_vars := non_gc_reg_vars + 1
			if non_gc_tmp_vars < non_gc_reg_vars then
				non_gc_tmp_vars := non_gc_reg_vars
			end
		end

	free_non_gc_vars is
			-- Free a temporary reference not under GC control.
		require
			good_context: non_gc_reg_vars >= 1
		do
			non_gc_reg_vars := non_gc_reg_vars - 1
		end

	inc_exp_args is
			-- One more expanded parameter found
		do
			exp_args := exp_args + 1
		end

	init_propagation is
			-- Reset `propagated' to false.
		do
			propagated := false
		end

	set_propagated is
			-- Signals register has been caught.
		do
			propagated := true
		end

	propagate_no_register: BOOLEAN is
			-- Is the propagation of `No_register' allowed ?
		do
			Result := not (	workbench_mode
							or else
							assertion_level.check_precond)
		end

	add_dt_current is
			-- One more time we need to compute Current's type
		do
			if in_inlined_code then
				inlined_dt_current := inlined_dt_current + 1
			else
				dt_current := dt_current + 1
			end
		end

	add_to_dt_current (i: INTEGER) is
			-- Add `i' to dt_current.
		require
			valid_i: i > 0
		do
			dt_current := dt_current + i
		ensure
			added: old dt_current + i = dt_current
		end

	set_inlined_dt_current (i: INTEGER) is
			-- Set the value of `inlined_dt_current' to `i'
		do
			inlined_dt_current := i
		end

	reset_inlined_dt_current is
			-- Reset `inlined_dt_current' to 0
		do
			inlined_dt_current := 0
		end

	mark_current_used is
			-- Signals that a reference is made to Current (apart
			-- from computing a DT) and thus needs to be pushed on
			-- the local stack in case it'd be moved by the GC.
			-- As a side effect, compute an index for Current in the
			-- local variable array
		do
				-- Not marking if inside inlined code:
				-- Current is NOT in Current_b
			if not (current_used or else in_inlined_code) then
				set_local_index ("Current", Current_b)
				current_used := true
			end
		end

	mark_result_used is
			-- Signals that an assignment in Result is made
			-- As a side effect, compute an index for Result in the local
			-- variable array, if the type is a pointer one and we are not
			-- inside a once function.
		do
			if not in_inlined_code then
				if not result_used and
					real_type (byte_code.result_type).c_type.is_pointer and
					not byte_code.is_once
				then
					set_local_index ("Result", Result_register)
				end
				result_used := true
			end
		end

	mark_local_used (l: INTEGER) is
			-- Signals that local variable `l' is used
		do
			local_vars.force(true, l)
		end

	inc_label is
			-- Increment `label'
		do
			label := label + 1
		end

	generate_body_label is
			-- Generate label "body"
			--|Note: the semi-colon is added, otherwise C compilers
			--|complain when there are no instructions after the label.
		do
			buffer.exdent
			buffer.putstring ("body:;")
			buffer.new_line
			buffer.indent
		end

	print_body_label is
			-- Print label "body"
		do
			buffer.putstring ("body")
		end

	generate_current_label is
			-- Generate current label `label'.
		do
			generate_label (label)
		end

	generate_label (l: INTEGER) is
			-- Generate label number `l'
		require
			label_exists: l > 0
		do
			buffer.exdent
			print_label (l)
			buffer.putchar (':')
			buffer.new_line
			buffer.indent
		end

	print_current_label is
			-- Print label number `label'.
		do
			print_label (label)
		end

	print_label (l: INTEGER) is
			-- Print label number `l'
		require
			label_exists: l > 0
		do
			buffer.putstring ("label_")
			buffer.putint (l)
		end

	set_local_index (s: STRING; r: REGISTRABLE) is
			-- Record the instance `r' into the `associated_register_table'
			-- as register named `s'.
		local
			key: STRING
		do
			if need_gc_hooks and not local_index_table.has(s) then
				key := clone (s)
				local_index_table.put (local_index_counter, key)
				local_index_counter := local_index_counter + 1
				associated_register_table.put (r, key)
			end
		end

	local_index (s: STRING): INTEGER is
			-- Index in local variable array associated with string `s'.
		do
			Result := local_index_table.item (s)
		end

	need_gc_hook_computed: BOOLEAN
			-- Have we already computed that value ?

	need_gc_hook_saved: BOOLEAN
			-- Saved value of `need_gc_hooks'.

	force_gc_hooks is
			-- Force usage of GC hooks
		do
			need_gc_hook_computed := true
			need_gc_hook_saved := true
		end

	need_gc_hooks: BOOLEAN is
			-- Do we need any GC hooks for the current feature
		local
			assign: ASSIGN_BL
			call: CALL_B
			constant_b: CONSTANT_B
			compound: BYTE_LIST [BYTE_NODE]
			rassign: REVERSE_BL

			source_type: TYPE_I
			target_type: TYPE_I
		do
				-- We won't need any RTLI if the only statement is an expanded
				-- assignment in Result or a single call.
			if need_gc_hook_computed then
				Result := need_gc_hook_saved
			else
				need_gc_hook_computed := true
				Result := true
				if assertion_type /= In_invariant then
						-- Not in an invariant generation
					compound := byte_code.compound
					if compound /= Void and then compound.count = 1 then
						assign ?= compound.first
						call ?= compound.first
						rassign ?= assign
						if assign /= Void and then (rassign = Void) then
							if assign.expand_return then
									-- Assignment in Result is expanded in a
									-- return instruction
								Result := false
							else
								call ?= assign.source
								if call /= Void and then call.is_single then
										-- Simple assignment of a single call
									if has_invariant then
										Result := True
									else
										constant_b ?= call
										if (constant_b /= Void) then
												-- If it is a constant. we don't need registers
											Result := False
										elseif assign.target.is_result then
												-- If we can optimize result := call, no registers
												-- except if metamorphosis on Result
											target_type := real_type (assign.target.type)
											source_type := real_type (call.type)
											Result := not (target_type.is_basic or else
												(not source_type.is_basic))
										else
												-- If it is not an instruction result := call but the
												-- source is a predefined item (local, current, result
												-- or argument), we can still optimize. Xavier
											Result := not call.is_predefined
										end
									end
								end
							end
						elseif call /= Void and then call.is_single then
								-- A single call
							Result := has_invariant
						end
					end
						-- If there is a rescue clause, then we'll
						-- need an execution vector, hence GC hooks
						-- are really needed.
					Result := Result or has_rescue

						-- If some calls are inlined, we need to save Current, Result,
						-- the arguments and locals in registers
					Result := Result or byte_code.has_inlined_code
				end
				need_gc_hook_saved := Result
			end
		end

	clear_old_expressions is
			-- Clear old expressions.
		do
				--! Did this so it won't effect any old_expression
				--! referencing this object.
			!!old_expressions.make
		end

	clear_all is
			-- Reset internal data structures.
		do
			local_vars.clear_all
			local_index_table.clear_all
			associated_register_table.clear_all
			local_index_counter := 0
			exp_args := 0
			dt_current := 0
			inlined_dt_current := 0
			result_used := false
			current_used := false
			need_gc_hook_computed := false
			label := 0
			if System.has_separate then
				reservation_label :=0
			end
			is_prec_first_block := False
			non_gc_reg_vars := 0
			non_gc_tmp_vars := 0
			local_list.wipe_out
			breakable_points := Void
			debug_mode := false
				-- This should not be necessary but may limit the
				-- effect of bugs in register allocation (if any).
			register_server.clear_all
		end

	array_opt_clear is
			-- Clear during the array optimization
		do
			class_type := Void
			byte_code := Void
		end

	wipe_out is
			-- Clear the structure
		do
			clear_all
			local_vars := Void
			local_index_table := Void
			associated_register_table := Void
			class_type := Void
			original_class_type := Void
			byte_code := Void
		end

	make_from_context (other: like Current) is
			-- Save context for later restoration. This makes the
			-- use of unanalyze possible and meaningful.
		do
			copy (other)
			register_server := other.register_server.duplicate
			local_index_table := clone (other.local_index_table)
			associated_register_table := clone (other.associated_register_table)
		end

	restore (saved_context: like Current) is
			-- Restore the saved context after an analyze followed by an
			-- unanalyze, so that we may analyze again with different
			-- propagations (kind of feedback).
		do
			register_server := saved_context.register_server
			current_used := saved_context.current_used
			result_used := saved_context.result_used
			dt_current := saved_context.dt_current
			inlined_dt_current := saved_context.inlined_dt_current
			non_gc_reg_vars := saved_context.non_gc_reg_vars
			non_gc_tmp_vars := saved_context.non_gc_tmp_vars
			local_index_table := saved_context.local_index_table
			local_index_counter := saved_context.local_index_counter
			associated_register_table := saved_context.associated_register_table
			need_gc_hook_computed := saved_context.need_gc_hook_computed
			need_gc_hook_saved := saved_context.need_gc_hook_saved
		end

	Local_var: LOCAL_B is
			-- Instance used to generate local variable name
			-- (In case GC hooks are needed, we might need to refer to the
			-- variable via the local l[] array.)
		once
			!!Result
		end

	Result_var: RESULT_B is
			-- Instance used to generate Result variable name
			-- (In case GC hooks are needed, we might need to refer to the
			-- variable via the local l[] array.)
		once
			!!Result
		end

	Arg_var: ARGUMENT_B is
			-- Instance used to generate Result variable name
			-- (In case GC hooks are needed, we might need to refer to the
			-- variable via the local l[] array.)
		once
				-- FIXME???? -- at least the comment part
			!!Result
		end

	generate_current_dtype is
			-- Generate the dynamic type of `Current'
		do
			if inlined_dt_current > 1 then
				buffer.putstring ("inlined_dtype")
			elseif dt_current > 1 then
				buffer.putstring (gc_dtype)
			else
				buffer.putstring (gc_upper_dtype_lparan)
				Current_register.print_register_by_name
				buffer.putchar (')')
			end
		end

	generate_temporary_ref_variables is
			-- Generate temporary variables under the control of the
			-- garbage collector.
		local
			i, j, nb_vars: INTEGER
		do
			from
				i := 1
			until
				i > C_nb_types
			loop
				from
					j := 1
					nb_vars := register_server.needed_registers_by_clevel (i)
				until
					j > nb_vars
				loop
					if i = C_ref then
						if not need_gc_hooks then
							generate_tmp_var (i, j)
						end
					else
						generate_tmp_var (i, j)
					end
					j := j + 1
				end
				i := i + 1
			end
		end

	generate_temporary_nonref_variables is
			-- Generate temporary variables not under the control of the
			-- garbage collector.
		local
			i, j: INTEGER
		do
			j := non_gc_tmp_vars
			if j >= 1 then
				from
					i := 1
				until
					i > j
				loop
					buffer.putstring ("char *xp")
					buffer.putint (i)
					buffer.putchar (';')
					buffer.new_line
					i := i + 1
				end
			end
		end

	generate_tmp_var (ctype, num: INTEGER) is
			-- Generate declaration for temporary variable `num'
			-- whose C type is `ctype'.
		do
			inspect
				ctype
			when C_long then
				buffer.putstring ("EIF_INTEGER ti")
			when C_ref then
				buffer.putstring ("EIF_REFERENCE tp")
			when C_float then
				buffer.putstring ("EIF_REAL tf")
			when C_char then
				buffer.putstring ("EIF_CHARACTER tc")
			when C_double then
				buffer.putstring ("EIF_DOUBLE td")
			when C_pointer then
				buffer.putstring ("EIF_POINTER ta")
			end
			buffer.putint (num)
			buffer.putchar (';')
			buffer.new_line
		end

	generate_gc_hooks (compound_or_post: BOOLEAN) is
			-- In case there are some local reference variables,
			-- generate the hooks for the GC by filling the local variable
			-- array. Unfortunately, I cannot use bzero() on the array, in
			-- case it would be a function call--RAM.
			--| `compound_or_post' indicate the generation of hooks
			--| for the compound or post- pre- or invariant routine. -- FREDD
		local
			nb_refs: INTEGER;	-- Total number of references to be pushed
			nb_exp: INTEGER;	-- Expanded argument number for cloning
			hash_table: EXTEND_TABLE [INTEGER, STRING]
			associated: HASH_TABLE [REGISTRABLE, STRING]
			rname: STRING
			position: INTEGER
			reg: REGISTRABLE
			argument_b: ARGUMENT_B
			bit_i: BIT_I
		do
			-- if more than, say, 20 local variables are to be initialized,
			-- then it might be worthy to call bzero() instead of manually
			-- setting the entries (beneficial both in code size and execution
			-- time
				-- Current is needed only if used
			if system.has_separate then
				nb_refs := 2 * ref_var_used 
			else
				nb_refs := ref_var_used
			end
				-- The hooks are only needed if there is at least one reference
			if nb_refs > 0 then
				if compound_or_post or else byte_code.rescue_clause = Void then
					buffer.putstring ("RTLI(")
				else
					buffer.putstring ("RTXI(")
				end
				buffer.putint (nb_refs)
				buffer.putstring (gc_rparan_comma)
				buffer.new_line
				if system.has_separate then
					reset_added_gc_hooks
				end
				from
					hash_table := local_index_table
					associated := associated_register_table
					hash_table.start
				until
					hash_table.after
				loop
					rname := hash_table.key_for_iteration
					position := hash_table.item_for_iteration
					reg := associated.item (rname)
					argument_b ?= reg
					if argument_b /= Void and then
						real_type (argument_b.type).is_expanded and exp_args > 1
					then
						-- Expanded cloning protocol
						buffer.putstring ("if (RTIE(")
						buffer.putstring (rname)
						buffer.putstring (")) {")
						buffer.new_line
						buffer.indent
						nb_exp := expanded_number (argument_b.position) - 1
						buffer.putstring ("idx[")
						buffer.putint (nb_exp)
						buffer.putstring ("] = RTOF(arg")
						buffer.putint (argument_b.position)
						buffer.putstring (gc_rparan_comma)
						buffer.new_line
						buffer.putstring ("l[")
						buffer.putint (position)
						buffer.putstring ("] = RTEO(arg")
						buffer.putint (argument_b.position)
						buffer.putstring (gc_rparan_comma)
						buffer.new_line
						buffer.exdent
						buffer.putstring (gc_lacc_else_r_acc)
						buffer.new_line
						buffer.indent
						buffer.putstring ("l[")
						buffer.putint (position)
						buffer.putstring ("] = ")
						buffer.putstring (rname)
						buffer.putchar (';')
						buffer.new_line
						buffer.putstring ("idx[")
						buffer.putint (nb_exp)
						buffer.putstring ("] = -1;")
						buffer.new_line
						buffer.exdent
						buffer.putchar ('}')
					else
						buffer.putstring ("l[")
						buffer.putint (position)
						buffer.putstring ("] = ")
						if 	((reg.is_predefined or reg.is_temporary)
							and not (reg.is_current or reg.is_argument)
							and not (reg.is_result and compound_or_post))
						then
							buffer.putstring ("(char *) 0")
						else
							if (reg.c_type.is_bit) and (reg.is_argument) then
								-- Clone argument if it is bit
								buffer.putstring ("RTCB(")
								buffer.putstring (rname)
								buffer.putchar (')')
							else
								buffer.putstring (rname)
							end
						end
						buffer.putchar (';')
					end
					buffer.new_line
					hash_table.forth
				end
				buffer.new_line
			end
		end

	expanded_number (arg_pos: INTEGER): INTEGER is
			-- Compute the argument's ordinal position within the expanded
			-- subset of arguments.
		local
			arg_array: ARRAY [TYPE_I]
			i, count: INTEGER
			nb_exp: INTEGER
		do
			arg_array := byte_code.arguments
			from
				i := arg_array.lower
				count := arg_array.count
			until
				Result /= 0 or i > count or i > arg_pos
			loop
				if real_type (arg_array.item (i)).is_expanded then
					nb_exp := nb_exp + 1
				end
				if i = arg_pos then
					Result := nb_exp
				end
				i := i + 1
			end
		end

	remove_gc_hooks is
			-- Pop off pushed addresses on local stack
		local
			vars: INTEGER
		do
			vars := ref_var_used
			if vars > 0 then
				if byte_code.rescue_clause /= Void then
					buffer.putstring ("RTXE;")
					buffer.new_line
				else
					buffer.putstring ("RTLE;")
					buffer.new_line
				end
			end
		end

	ref_var_used: INTEGER is
			-- Number of reference variable needed for GC hooks
		do
			Result := local_index_table.count
			if not need_gc_hooks then
				Result := 0
			end
		end

	local_list: LINKED_LIST [TYPE_I]
			-- Local type list for byte code: it includes Eiffel local
			-- variables types, variant local integer and hector
			-- temporary varaibles

	add_local (t: TYPE_I) is
			-- Add local type to `local_list'.
		require
			good_argument: t /= Void
		do
			local_list.finish
			local_list.put_right (t)
		end

feature -- Debugger

	debug_mode: BOOLEAN
			-- True when generating byte code with debugging hooks.

	instruction_line: LINE [AST_EIFFEL]
			-- List of breakable instructions on which a breakpoint may be set.

	breakable_points: SORTED_TWO_WAY_LIST [AST_POSITION]
			-- Mapping of AST nodes with breakable position in byte array

	set_debug_mode (d: like debug_mode) is
			-- Assign `d' to `debug_mode'.
		do
			debug_mode := d
		end

	set_instruction_line (l: like instruction_line) is
			-- Assign `l' to `instruction_line' and position FIFO stack at the
			-- beginning as a side effect, ready for usage by byte code classes.
		do
			instruction_line := l
			l.start
			!!breakable_points.make
		end

	record_breakable (ba: BYTE_ARRAY) is
			-- Record breakable point (in debug mode only)
		local
			ast_node: AST_EIFFEL
			ast_pos: AST_POSITION
		do
			if debug_mode then
				ba.mark_breakable
					-- NB. The way lines are implemented
					-- the ast_nodes are stored starting from
					-- the second position of the line, hence
					-- the `forth' instruction before `item'.
				instruction_line.forth
				ast_node := instruction_line.item
					-- N.B. The way byte array is implemented
					-- the position in the byte array is incremented after
					-- insertion of a new byte code.
					-- Therefore the offset of the breakable byte code
					-- is equal to the position in the byte array
					-- minus 1.
				!! ast_pos.make (ba.position - 1, ast_node)
				breakable_points.extend (ast_pos)
			end
		end

	byte_prepend (ba, array: BYTE_ARRAY) is
			-- Prepend `array' to byte array `ba' and update positions in the
			-- breakable point list (provided we are in debug mode).
		local
			amount: INTEGER
		do
			ba.prepend (array)
			if debug_mode then
					-- N.B. The number of elements in
					-- `array' is `array.position - 1'.
				amount := array.position - 1
				from
					breakable_points.start
				until
					breakable_points.after
				loop
					breakable_points.item.shift (amount)
					breakable_points.forth
				end
			end
		end

feature -- Inlining

	in_inlined_code: BOOLEAN is
			-- Are we dealing with inlined code?
		do
			Result := inlined_current_register /= Void
		end

	inlined_current_register: REGISTRABLE
			-- pseudo Current register for inlined code

	set_inlined_current_register (r: REGISTRABLE) is
		do
			inlined_current_register := r
		end

feature -- Concurrent Eiffel
	
	print_concurrent_label is
			-- Print label number `cur_label'.
		do
			buffer.putstring ("cur_label_")
			buffer.putint (label)
		end

	reset_added_gc_hooks is 
		local
			i: INTEGER
		do
			from 
				i := ref_var_used - 1
			until
				i < 0
			loop
				buffer.putstring ("l[")
				buffer.putint (ref_var_used + i)
				buffer.putstring ("] = ")
				buffer.putstring ("(char *) 0;")
				buffer.new_line
				i := i - 1
			end
		end

	reservation_label: INTEGER

	inc_reservation_label is
		do
			reservation_label := reservation_label + 1
		end

	print_reservation_label is
		do
			buffer.putstring ("res_label_")
			buffer.putint (reservation_label)
		end

end

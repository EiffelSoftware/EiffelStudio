-- Context variables for code generation and utilities.

class BYTE_CONTEXT 

inherit

	SHARED_C_LEVEL
		export
			{NONE} all
		end;
	ASSERT_TYPE;
	SHARED_ARRAY_BYTE


creation

	make

	
feature

	generation_mode: BOOLEAN;
			-- Mode of generation: if set to True, generation of C code
			-- for the workbench otherwise generation of C code in final
			-- mode

	set_workbench_mode is
			-- Set `generation_mode' to True.
		do
			generation_mode := True;
		end;

	set_final_mode is
			-- Set `generation_mode' to False.
		do
			generation_mode := False;
		end;

	workbench_mode: BOOLEAN is
			-- Is `generation_mode' set to True ?
		do
			Result := generation_mode;
		end;

	final_mode: BOOLEAN is
			-- Is `generation_mode' set to False ?
		do
			Result := not generation_mode;
		end;

	current_type: CL_TYPE_I is
			-- Current class type in which byte code is processed
		do
			Result := type_stack.item;
		end;

	class_type: CLASS_TYPE;
			-- The class type which we are generating

	generated_file: INDENT_FILE;
			-- File used for code generation

	byte_code: BYTE_CODE is
			-- Current root of processed byte code
		do
			Result := byte_stack.item;
		end;

	type_stack: EXTEND_STACK [CL_TYPE_I];
			-- Used to record type levels when generating assertions

	byte_stack: EXTEND_STACK [BYTE_CODE];
			-- Used to record successive byte code informations for assertions

	old_expressions: LINKED_LIST [UN_OLD_B];
			-- Used to record old expressions in Pass 3.

	c_old_expressions: LINKED_LIST [UN_OLD_BL];
			-- Used to record old expressions for C generation.

	make is
			-- Initialization
		do
			!!register_server.make (true);
			!!local_vars.make (1, 100);
			!!local_index_table.make (10);
			!!associated_register_table.make (10);
			!!type_stack.make;
			!!byte_stack.make;
			!!local_list.make;
			!!old_expressions.make;
			!!c_old_expressions.make;
		end;

	set_class_type (c: CLASS_TYPE) is
			-- Assign `c' to `class_type'
		do
			class_type := c;
		end;

	set_current_type (t: like current_type) is
			-- Assign `t' to `current_type'.
		require
			t /= Void or else t.has_formal
		do
			type_stack.put (t);
		end;

	set_byte_code (bt: BYTE_CODE) is
			-- Assign `bt' to `byte_code'.
		do
			byte_stack.put (bt);
		end;

	set_generated_file (f: like generated_file) is
			-- Assign `f' to `generated_file'.
		do
			generated_file := f;
		end;

	restore_type is
			-- Restore previous type
		do
			type_stack.remove;
		end;

	restore_byte_code is
			-- Restore previous byte code
		do
			byte_stack.remove;
		end;

	non_gc_tmp_vars: INTEGER;
			-- Total number of registers for references variables needed.

	non_gc_reg_vars: INTEGER;
			-- Currently used registers for reference variables which do not
			-- need to be under GC control (e.g. Hector references).

	exp_args: INTEGER;
			-- Number of (declared) expanded arguments.

	local_vars: ARRAY [BOOLEAN];
			-- Local variables used have their flag set to true.

	local_index_table: EXTEND_TABLE [INTEGER, STRING];
			-- Index in local variable array (C code) for a given register

	associated_register_table: HASH_TABLE [REGISTRABLE, STRING];
			-- Indexed by the same keys as `local_index_table', this associative
			-- array maps a name into a registrable instance.

	propagated: BOOLEAN;
			-- Was the propagated value caught ?

	current_used: BOOLEAN;
			-- Is Current used (apart from dtype computation) ?

	result_used: BOOLEAN;
			-- Is Result used (apart from very last assignment) ?

	label: INTEGER;
			-- For label generation

	dt_current: INTEGER;
			-- Number of time we need to compute Current's type

	local_index_counter: INTEGER;
			-- Index for local reference variables

	assertion_type: INTEGER;
			-- Type of assertion being generated

	Current_register: CURRENT_B is
			-- An instance of Current register for local var index computation
		once
			!! Result;
		end;
	
	Result_register: RESULT_B is
			-- An instace of Result register for local var index computation
		local
			dummy: NONE_I;
		once
				-- This hack is needed because of the special treatment of
				-- the Result register in once functions. The Result is always
				-- recorded in the GC by RTOC, so there is no need to get an
				-- l[] variable from the GC hooks. Here we are going to call
				-- the print_register_by_name function on Result_register,
				-- and this has been carefully patched in RESULT_BL to handle
				-- the once cases.
			!! dummy;
			!RESULT_BL! Result.make (dummy);
		end;

	register_server: REGISTER_SERVER;
			-- Register number server

	set_assertion_type (a: INTEGER) is
			-- Assign `a' to `assertion_type'
		do
			assertion_type := a;
		end;

	has_rescue: BOOLEAN is
			-- Feature has a rescue clause ?
		do
			Result := byte_code.rescue_clause /= Void
		end;

	has_postcondition: BOOLEAN is
			-- Do we have to generate any postcondition ?
		do
			Result := 	workbench_mode
						or else
						(	assertion_level.check_postcond
							and
							byte_code.postcondition /= Void
						)
		end;
	
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
		end;
	
	has_invariant: BOOLEAN is
			-- Do we have to generate invariant checks ?
		do
			Result := workbench_mode or assertion_level.check_invariant;
		end;

	assertion_level: ASSERTION_I is
			-- Assertion level description
		do
			Result := associated_class.assertion_level;
		end;

	associated_class: CLASS_C is
			-- Class associated with current type
		do
			Result := current_type.base_class;
		end;

	instantiation_of (type: TYPE_I): TYPE_I is
			-- Instantiation of `type' in `curent_type'.
		require
			current_type_exists: current_type /= Void
		local
			gen_type: GEN_TYPE_I;
		do
			if type.has_formal then
				gen_type ?= current_type;
				Result := type.instantiation_in (gen_type);
			else
				Result := type;
			end;
		end;

	constrained_type (type: TYPE_I): TYPE_I is
			-- Constrained type
		require
			curent_type_exists: current_type /= Void
		local
			formal: FORMAL_I;
			formal_position: INTEGER;
			reference_i: REFERENCE_I;
		do
			Result := type;
			if Result.is_formal then
				formal ?= Result;
				check
					current_type.meta_generic /= Void
				end;
				formal_position := formal.position;
				Result := current_type.meta_generic.item (formal_position);
				reference_i ?= Result;
				if reference_i /= Void then
					Result := current_type.base_class.constraint
													(formal_position).type_i;
				end;
			end;
		ensure
			not_formal: not Result.is_formal;
		end;

	real_type (type: TYPE_I): TYPE_I is
			-- Convenience
		require
			good_argument: type /= Void
		do
			Result := constrained_type (type);
			Result := instantiation_of (Result);
		ensure
			not Result.is_formal
		end;

	init (t: CL_TYPE_I) is
			-- Initialization
		require
			good_argument: t /= Void
		do
			set_current_type (t);
		end;

	add_non_gc_vars is
			-- Add a temporary reference variable not to be placed under GC.
		do
			non_gc_reg_vars := non_gc_reg_vars + 1;
			if non_gc_tmp_vars < non_gc_reg_vars then
				non_gc_tmp_vars := non_gc_reg_vars;
			end;
		end;

	free_non_gc_vars is
			-- Free a temporary reference not under GC control.
		require
			good_context: non_gc_reg_vars >= 1;
		do
			non_gc_reg_vars := non_gc_reg_vars - 1;
		end;

	inc_exp_args is
			-- One more expanded parameter found
		do
			exp_args := exp_args + 1;
		end;

	init_propagation is
			-- Reset `propagated' to false.
		do
			propagated := false;
		end;

	set_propagated is
			-- Signals register has been caught.
		do
			propagated := true;
		end;

	propagate_no_register: BOOLEAN is
			-- Is the propagation of `No_register' allowed ?
		do
			Result := not (	workbench_mode
							or else
							assertion_level.check_precond);
		end;
						
	add_dt_current is
			-- One more time we need to compute Current's type
		do
			dt_current := dt_current + 1;
		end;
	
	mark_current_used is
			-- Signals that a reference is made to Current (apart
			-- from computing a DT) and thus needs to be pushed on
			-- the local stack in case it'd be moved by the GC.
			-- As a side effect, compute an index for Current in the
			-- local variable array
		do
			if not current_used then
				set_local_index ("Current", Current_register);
			end;
			current_used := true;
		end;

	mark_result_used is
			-- Signals that an assignment in Result is made
			-- As a side effect, compute an index for Result in the local
			-- variable array, if the type is a pointer one and we are not
			-- inside a once function.
		do
			if not result_used and
				real_type (byte_code.result_type).c_type.is_pointer and
				not byte_code.is_once
			then
				set_local_index ("Result", Result_register);
			end;
			result_used := true;
		end;
	
	mark_local_used (l: INTEGER) is
			-- Signals that local variable `l' is used
		do
			local_vars.force(true, l);
		end;

	inc_label is
			-- Increment `label'
		do
			label := label + 1;
		end;

	generate_label (l: INTEGER) is
			-- Generate label number `l'
		require
			label_exists: l > 0;
		do
			generated_file.exdent;
			print_label (l);
			generated_file.putchar (':');
			generated_file.new_line;
			generated_file.indent;
		end;

	print_label (l: INTEGER) is
			-- Print label number `l'
		require
			label_exists: l > 0;
		do
			generated_file.putstring ("label_");
			generated_file.putint (l);
		end;

	set_local_index (s: STRING; r: REGISTRABLE) is
			-- Record the instance `r' into the `associated_register_table'
			-- as register named `s'.
		local
			key: STRING;
		do
			if need_gc_hooks and not local_index_table.has(s) then
				key := s.twin;
				local_index_table.put (local_index_counter, key);
				local_index_counter := local_index_counter + 1;
				associated_register_table.put (r, key);
			end;
		end;

	local_index (s: STRING): INTEGER is
			-- Index in local variable array associated with string `s'.
		do
			Result := local_index_table.item (s);
		end;

	need_gc_hook_computed: BOOLEAN;
			-- Have we already computed that value ?

	need_gc_hook_saved: BOOLEAN;
			-- Saved value of `need_gc_hooks'.

	force_gc_hooks is
			-- Force usage of GC hooks
		do
			need_gc_hook_computed := true;
			need_gc_hook_saved := true;
		end;

	need_gc_hooks: BOOLEAN is
			-- Do we need any GC hooks for the current feature
		local
			assign: ASSIGN_BL;
			call: CALL_B;
			compound: BYTE_LIST [BYTE_NODE];
		do
				-- We won't need any RTLI if the only statement is an expanded
				-- assignment in Result or a single call.
			if need_gc_hook_computed then
				Result := need_gc_hook_saved;
			else
				need_gc_hook_computed := true;
				Result := true;
				if assertion_type /= In_invariant then
						-- Not in an invariant generation
					compound := byte_code.compound;
					if compound /= Void and then compound.count = 1 then
						assign ?= compound.first;
						call ?= compound.first;
						if assign /= Void then
							if assign.expand_return then
									-- Assignment in Result is expanded in a
									-- return instruction
								Result := false;
							else
								call ?= assign.source;
								if call /= Void and then call.is_single then
										-- Simple assignment of a single call
									Result := workbench_mode;
								end;
							end;
						elseif call /= Void and then call.is_single then
								-- A single call
							Result := workbench_mode;
						end;
					end;
						-- If there is a rescue clause, then we'll
						-- need an execution vector, hence GC hooks
						-- are really needed.
					Result := Result or has_rescue;
				end;
				need_gc_hook_saved := Result;
			end;
		end;

	clear_old_expressions is
			-- Clear old expressions.
		do
				--! Did this so it won't effect any old_expression 
				--! referencing this object.
			!!old_expressions.make;
		end;

	clear_all is
			-- Reset internal data structures.
		do
			local_vars.clear_all;
			local_index_table.clear_all;
			associated_register_table.clear_all;
			local_index_counter := 0;
			exp_args := 0;
			dt_current := 0;
			result_used := false;
			current_used := false;
			need_gc_hook_computed := false;
			label := 0;
			byte_stack.wipe_out;
			non_gc_reg_vars := 0;
			non_gc_tmp_vars := 0;
			local_list.wipe_out;
			breakable_points := Void;
			debug_mode := false;
				-- This should not be necessary but may limit the
				-- effect of bugs in register allocation (if any).
			register_server.clear_all;
			c_old_expressions.wipe_out;
		end;

	wipe_out is
			-- Clear the structure
		do
			clear_all;
			local_vars := Void;
			local_index_table := Void;
			associated_register_table := Void;
			type_stack := Void;
			byte_stack := Void;
			class_type := Void;
		end;

	saved_current_used: BOOLEAN;
			-- Saved value of `current_used'

	saved_result_used: BOOLEAN;
			-- Saved value of `result_used'

	saved_dt_current: INTEGER;
			-- Saved value of `dt_current'

	saved_non_gc_reg_vars: INTEGER;
			-- Saved value of `non_gc_reg_vars'

	saved_non_gc_tmp_vars: INTEGER;
			-- Saved value of `non_gc_tmp_vars'

	saved_local_index_table: EXTEND_TABLE [INTEGER, STRING];
			-- Saved `local_index_table'

	saved_associated_register_table: HASH_TABLE [REGISTRABLE, STRING];
			-- Saved value of `associated_register_table'

	saved_register_server: REGISTER_SERVER;
			-- Saved value of `register_server'

	saved_local_index_counter: INTEGER;
			-- Saved value of `local_index_counter'

	saved_need_gc_hook_computed: BOOLEAN;
			-- Saved value of `need_gc_hook_computed'.

	saved_need_gc_hook_saved: BOOLEAN;
			-- Saved value of `need_gc_hook_saved'.

	save is
			-- Save context for later restoration. This makes the
			-- use of unanalyze possible and meaningful.
		local
			i, count: INTEGER;
		do
			saved_register_server := register_server.duplicate;
			saved_current_used := current_used;
			saved_result_used := result_used;
			saved_dt_current := dt_current;
			saved_non_gc_reg_vars := non_gc_reg_vars;
			saved_non_gc_tmp_vars := non_gc_tmp_vars;
			saved_local_index_table := local_index_table.twin;
			saved_local_index_counter := local_index_counter;
			saved_need_gc_hook_computed := need_gc_hook_computed;
			saved_need_gc_hook_saved := need_gc_hook_saved;
			saved_associated_register_table := associated_register_table.twin;
		end;

	restore is
			-- Restore the saved context after an analyze followed by an
			-- unanalyze, so that we may analyze again with different
			-- propagations (kind of feedback).
		local
			i, count: INTEGER;
		do
			register_server := saved_register_server;
			current_used := saved_current_used;
			result_used := saved_result_used;
			dt_current := saved_dt_current;
			non_gc_reg_vars := saved_non_gc_reg_vars;
			non_gc_tmp_vars := saved_non_gc_tmp_vars;
			local_index_table := saved_local_index_table;
			local_index_counter := saved_local_index_counter;
			associated_register_table := saved_associated_register_table;
			need_gc_hook_computed := saved_need_gc_hook_computed;
			need_gc_hook_saved := saved_need_gc_hook_saved;
		end;

	Local_var: LOCAL_B is
			-- Instance used to generate local variable name
			-- (In case GC hooks are needed, we might need to refer to the
			-- variable via the local l[] array.)
		once
			!!Result;
		end;

	Result_var: RESULT_B is
			-- Instance used to generate Result variable name
			-- (In case GC hooks are needed, we might need to refer to the
			-- variable via the local l[] array.)
		once
			!!Result;
		end;

	Arg_var: ARGUMENT_B is
			-- Instance used to generate Result variable name
			-- (In case GC hooks are needed, we might need to refer to the
			-- variable via the local l[] array.)
		once
			!!Result;
		end;

	generate_temporary_ref_variables is
			-- Generate temporary variables under the control of the
			-- garbage collector.
		local
			i, j, nb_vars: INTEGER;
		do
			from
				i := 1;
			until
				i > C_nb_types
			loop
				from
					j := 1;
					nb_vars := register_server.needed_registers_by_clevel (i);
				until
					j > nb_vars
				loop
					if i = C_ref then
						if not need_gc_hooks then
							generate_tmp_var (i, j);
						end;
					else
						generate_tmp_var (i, j);
					end;
					j := j + 1;
				end;
				i := i + 1;
			end;
		end;

	generate_temporary_nonref_variables is
			-- Generate temporary variables not under the control of the
			-- garbage collector.
		local
			i, j: INTEGER;
		do
			j := non_gc_tmp_vars;
			if j >= 1 then
				from
					i := 1;
				until
					i > j
				loop
					generated_file.putstring("char *xp");
					generated_file.putint (i);
					generated_file.putchar (';');
					generated_file.new_line;
					i := i + 1;
				end;
			end;
		end;

	generate_tmp_var (ctype, num: INTEGER) is
			-- Generate declaration for temporary variable `num'
			-- whose C type is `ctype'.
		do
			inspect
				ctype
			when C_long then
				generated_file.putstring("long ti");
			when C_ref then
				generated_file.putstring("char *tp");
			when C_float then
				generated_file.putstring("float tf");
			when C_char then
				generated_file.putstring("char tc");
			when C_double then
				generated_file.putstring("double td");
			when C_pointer then
				generated_file.putstring ("fnptr ta");
			end;
			generated_file.putint (num);
			generated_file.putchar (';');
			generated_file.new_line;
		end;

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
			hash_table: EXTEND_TABLE [INTEGER, STRING];
			associated: HASH_TABLE [REGISTRABLE, STRING];
			rname: STRING;
			position: INTEGER;
			reg: REGISTRABLE;
			argument_b: ARGUMENT_B;
			bit_i: BIT_I
		do
			-- if more than, say, 20 local variables are to be initialized,
			-- then it might be worthy to call bzero() instead of manually
			-- setting the entries (beneficial both in code size and execution
			-- time
				-- Current is needed only if used
			nb_refs := ref_var_used;
				-- The hooks are only needed if there is at least one reference
			if nb_refs > 0 then
				if compound_or_post or else byte_code.rescue_clause = Void then
					generated_file.putstring ("RTLI(");
				else
					generated_file.putstring ("RTXI(");
				end;
				generated_file.putint (nb_refs);
				generated_file.putstring (");");
				generated_file.new_line;
				from
					hash_table := local_index_table;
					associated := associated_register_table;
					hash_table.start;
				until
					hash_table.offright
				loop
					rname := hash_table.key_for_iteration;
					position := hash_table.item_for_iteration;
					reg := associated.item (rname);
					argument_b ?= reg;
					if argument_b /= Void and then
						real_type (argument_b.type).is_expanded and exp_args > 1
					then
						-- Expanded cloning protocol
						generated_file.putstring ("if (RTIE(");
						generated_file.putstring (rname);
						generated_file.putstring (")) {");
						generated_file.new_line;
						generated_file.indent;
						nb_exp := expanded_number (argument_b.position);
						generated_file.putstring ("idx[");
						generated_file.putint (nb_exp);
						generated_file.putstring ("] = RTOF(arg");
						generated_file.putint (argument_b.position);
						generated_file.putstring (");");
						generated_file.new_line;
						generated_file.putstring ("l[");
						generated_file.putint (position);
						generated_file.putstring ("] = RTEO(arg");
						generated_file.putint (argument_b.position);
						generated_file.putstring (");");
						generated_file.new_line;
						generated_file.exdent;
						generated_file.putstring ("} else {");
						generated_file.new_line;
						generated_file.indent;
						generated_file.putstring ("l[");
						generated_file.putint (position);
						generated_file.putstring ("] = ");
						generated_file.putstring (rname);
						generated_file.putchar (';');
						generated_file.new_line;
						generated_file.putstring ("idx[");
						generated_file.putint (nb_exp);
						generated_file.putstring ("] = -1;");
						generated_file.new_line;
						generated_file.exdent;
						generated_file.putchar ('}');
					else
						generated_file.putstring ("l[");
						generated_file.putint (position);
						generated_file.putstring ("] = ");
						if 	((reg.is_predefined or reg.is_temporary)
							and not (reg.is_current or reg.is_argument)
							and not (reg.is_result and compound_or_post))
						then
							reg.c_type.generate_initial_value (generated_file);
						else
							if (reg.c_type.is_bit) and (reg.is_argument) then
								-- Clone argument if it is bit
								generated_file.putstring ("RTCB(");	
								generated_file.putstring (rname);
								generated_file.putchar (')');	
							else
								generated_file.putstring (rname);
							end;
						end;
						generated_file.putchar (';');
					end;
					generated_file.new_line;
					hash_table.forth;
				end;
				generated_file.new_line;
			end;
		end;

	expanded_number (arg_pos: INTEGER): INTEGER is
			-- Compute the argument's ordinal position within the expanded
			-- subset of arguments.
		local
			arg_array: ARRAY [TYPE_I];
			i, count: INTEGER;
			nb_exp: INTEGER;
		do
			arg_array := byte_code.arguments;
			from
				i := arg_array.lower;
				count := arg_array.count;
			until
				Result /= 0 or i > count or i > arg_pos
			loop
				if real_type (arg_array.item (i)).is_expanded then
					nb_exp := nb_exp + 1;
				end;
				if i = arg_pos then
					Result := nb_exp;
				end;
				i := i + 1;
			end;
		end;

	remove_gc_hooks is
			-- Pop off pushed addresses on local stack
		local
			vars: INTEGER;
		do
			vars := ref_var_used;
			if vars > 0 then
				if byte_code.rescue_clause /= Void then
					generated_file.putstring ("RTXE;");
					generated_file.new_line;
				else
					generated_file.putstring ("RTLE;");
					generated_file.new_line;
				end;
			end;
		end;

	ref_var_used: INTEGER is
			-- Number of reference variable needed for GC hooks
		do
			Result := local_index_table.count;
			if not need_gc_hooks then
				Result := 0;
			end;
		end;

	local_list: LINKED_LIST [TYPE_I];
			-- Local type list for byte code: it includes Eiffel local
			-- variables types, variant local integer and hector
			-- temporary varaibles

	add_local (t: TYPE_I) is
			-- Add local type to `local_list'.
		require
			good_argument: t /= Void
		do
			local_list.finish;
			local_list.put_right (t);
		end;

feature -- Debugger

	debug_mode: BOOLEAN;
			-- True when generating byte code with debugging hooks.

	instruction_line: LINE [AST_EIFFEL];
			-- List of breakable instructions on which a breakpoint may be set.

	breakable_points: SORTED_TWO_WAY_LIST [AST_POSITION];
			-- Mapping of AST nodes with breakable position in byte array

	set_debug_mode (d: like debug_mode) is
			-- Assign `d' to `debug_mode'.
		do
			debug_mode := d;
		end;

	set_instruction_line (l: like instruction_line) is
			-- Assign `l' to `instruction_line' and position FIFO stack at the
			-- beginning as a side effect, ready for usage by byte code classes.
		do
			instruction_line := l;
			l.start;
			!!breakable_points.make
		end;

	record_breakable (ba: BYTE_ARRAY) is
			-- Record breakable point (in debug mode only)
		local
			ast_node: AST_EIFFEL;
			ast_pos: AST_POSITION;
		do
			if debug_mode then
				ba.mark_breakable;
				ast_node := instruction_line.item;
				instruction_line.forth;
					-- N.B. The way byte array is implemented
					-- the position in the byte array is incremented after 
					-- insertion of a new byte code.
					-- Therefore the offset of the breakable byte code
					-- is equal to the position in the byte array 
					-- minus 1.
				!! ast_pos.make (ba.position - 1, ast_node);
				breakable_points.add (ast_pos);
			end;
		end;

	byte_prepend (ba, array: BYTE_ARRAY) is
			-- Prepend `array' to byte array `ba' and update positions in the
			-- breakable point list (provided we are in debug mode).
		local
			amount: INTEGER;
		do
			ba.prepend (array);
			if debug_mode then
					-- N.B. The number of elements in
					-- `array' is `array.position - 1'.
				amount := array.position - 1;
				from
					breakable_points.start;
				until
					breakable_points.after
				loop
					breakable_points.item.shift (amount);
					breakable_points.forth;
				end;
			end;
		end;

end

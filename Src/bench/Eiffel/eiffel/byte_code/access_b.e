-- Abstract class for access: Current, Result, local, argument, feature

deferred class ACCESS_B 

inherit

	CALL_B
		rename
			print_register as old_print_register,
			free_register as old_free_register
		redefine
			has_gcable_variable, propagate, generate, unanalyze
		end;
	CALL_B
		redefine
			free_register, print_register,
			has_gcable_variable, propagate, generate, unanalyze
		select
			print_register, free_register
		end;
	
feature 

	parameters: BYTE_LIST [BYTE_NODE] is
		do
			-- no parameters
		end;

	set_parameters (p: like parameters) is
		do
			-- Do nothing
		end;

	read_only: BOOLEAN is
			-- Is the access a read-only one ?
		do
			Result := True;
		end;

	target: ACCESS_B is
			-- Ourselves as part of a message applied to a target
		do
			Result := Current;
		end;

	creation_access (t: TYPE_I): ACCESS_B is
			-- Creation access
		require
			creatable: is_creatable
		do
			Result := Current;
		end;

	current_needed_for_access: BOOLEAN is
			-- Is current needed for a true access ?
		do
			Result := is_predefined implies is_current;
		end;

	has_hector_variables: BOOLEAN is
			-- Do we have any hector variables in use ?
		do
		end;

	has_gcable_variable: BOOLEAN is
			-- Is the access using a GCable variable ?
		local
			expr_b: EXPR_B;
			is_in_register: BOOLEAN;
			pos: INTEGER;
		do
			is_in_register := register /= Void and register /= No_register;
			if is_in_register and register.c_type.is_pointer then
					-- Access is stored in a pointer register
				Result := true;
			else
				if parent = Void or else parent.target.is_current then
						-- True access: we may need Current.
					Result :=
						(current_needed_for_access and not is_in_register)
						or
						(is_result and c_type.is_pointer);
				end;
					-- Check the parameters if needed, i.e. if there are
					-- any and if the access is not already stored in a
					-- register (which can't be a pointer, otherwise it would
					-- have been handled by the first "if").
				if not is_in_register and parameters /= Void then
					pos := parameters.position;
					from
						parameters.start;
					until
						parameters.offright or Result
					loop
						expr_b ?= parameters.item;
						Result := expr_b.has_gcable_variable;
						parameters.forth;
					end;
					parameters.go (pos);
				end;
			end;
		end;

	used (r: REGISTRABLE): BOOLEAN is
			-- Is register `r' used in local access ?
		local
			expr: EXPR_B;
			pos: INTEGER;
		do
			if parameters /= Void then
				pos := parameters.position;
				from
					parameters.start;
				until
					parameters.offright or Result
				loop
					expr ?= parameters.item;	-- Cannot fail
					Result := expr.used(r);
					parameters.forth;
				end;
				parameters.go (pos);
			end;
		end;
	
	is_single: BOOLEAN is
			-- Is access a single one ?
		local
			expr_b: EXPR_B;
			pos: INTEGER;
		do
				-- If it is predefined, then it is single.
			Result := is_predefined;
			if not Result then
				Result := true;
					-- It is not predefined. If it has parameters, then none
					-- of them may have a call.
				if parameters /= Void then
					pos := parameters.position;
					from
						parameters.start;
					until
						parameters.offright or not Result
					loop
						expr_b ?= parameters.item;
						Result := not expr_b.has_call;
						parameters.forth;
					end;
					parameters.go (pos);
				end;
			end;
		end;

	is_polymorphic: BOOLEAN is
			-- Is the access polymorphic ?
		do
			Result := false;
		end;

	propagate (r: REGISTRABLE) is
			-- Propagate register accross access
		do
			if (register = Void) and not context_type.is_basic then
				if 	(real_type (type).c_type.same_type (r.c_type)
					or
					(	r = No_register
						and
						(	(parent = Void or else parent.target.is_current)
							or parameters = Void))
					)
					and
					(r = No_register implies not has_hector_variables)
					and
					(r = No_register implies context.propagate_no_register)
				then
					set_register (r);
					context.set_propagated;
				end;
			end;
		end;

	forth_used (r: REGISTRABLE): BOOLEAN is
			-- Is register `r' used in local access ?
		do
			Result := used (r);
		end;

	context_type: TYPE_I is
			-- Context type of the access (properly instantiated)
		local
			a_parent: NESTED_B;
		do
			if parent = Void then
				Result := context.current_type;
			elseif is_message then
				Result := parent.target.type;
			else 
				a_parent := parent.parent;
				if a_parent = Void then
					Result := context.current_type;
				else
					Result := a_parent.target.type;
				end;
			end;
			Result := Context.real_type (Result);
		end;

	sub_enlarged (p: NESTED_BL): ACCESS_B is
			-- Enlarge node and set parent to `p'
		do
			Result := enlarged;
			Result.set_parent (p);
		end;

	print_register is
			-- Print register or generate if there are no register.
		do
			if register /= No_register then
				old_print_register;
			else
				generate_access;
			end;
		end;

	free_register is
			-- Free register used by last call expression. If No_register was
			-- propagated, also frees the registers used by target and
			-- last message.
		do
			old_free_register;
				-- Free those registers which where kept because No_register
				-- was propagated, hence call was meant to be expanded in-line.
			if perused then
				free_param_registers;
			end;
		end;

	perused: BOOLEAN is
			-- See if the expression we are computing is going to be expanded
			-- on-line for later perusal: for instance, when computing the
			-- expression f(g(y), h(x)), the register used by the parameters
			-- must NOT be freed if the call is expanded, i.e. if register is
			-- No_register for f() as soon as the call is analyzed. If f() is
			-- indeed part of the parameters of another function, it would be
			-- a disaster...
		do
			Result := register = No_register or else
				(parent /= Void and then parent.register = No_register);
		end;

	unanalyze_parameters is
			-- Undo the analysis on parameters
		local
			expr_b: EXPR_B;
		do
			if parameters /= Void then
				from
					parameters.start;
				until
					parameters.offright
				loop
					expr_b ?= parameters.item;	-- Cannot fail
					expr_b.unanalyze;
					parameters.forth;
				end;
			end;
		end;

	free_param_registers is
			-- Free registers used by parameters
		local
			expr_b: EXPR_B;
		do
			if parameters /= Void then
				from
					parameters.start;
				until
					parameters.offright
				loop
					expr_b ?= parameters.item;	-- Cannot fail
					expr_b.free_register;
					parameters.forth;
				end;
			end;
		end;

	unanalyze is
			-- Undo the analysis
		local
			void_register: REGISTER;
		do
			set_register (void_register);
			unanalyze_parameters;
		end;

	
	Current_register: CURRENT_BL is
			-- The "Current" entity
		once
			!!Result;
		end;

	analyze_on (reg: REGISTRABLE) is
			-- Analyze access on `reg'
		do
				-- This will be redefined where needed. By default, run
				-- a simple analyze and forget about the parameter.
			analyze;
		end;

	generate is
			-- Generate C code for the access.
		do
			generate_parameters;
			if register /= No_register then
						-- Procedures have a void return type
				if register /= Void then
					old_print_register;
					generated_file.putstring (" = ");
				end;
				generate_access;
				generated_file.putchar (';');
				generated_file.new_line;
			end;
		end;

	generate_on (reg: REGISTRABLE) is
			-- Generate access using `reg' as "Current"
		do
		end;

	generate_access is
			-- Generation of the C code for access
		do
		end;
	
	generate_parameters is
			-- Generate code for parameters computation.
		do
			if parameters /= Void then
				parameters.generate;
			end;
		end;

feature -- Conveniences

	same (other: ACCESS_B): BOOLEAN is
			-- Is `other' the same access as Current ?
		deferred
		end;

	is_target: BOOLEAN is
			-- Is the access a target ?
		require
			parent_exists: parent /= Void;
		do
			Result := parent.target = Current;
		end;

	is_message: BOOLEAN is
			-- is the access a message ?
		require
			parent_exists: parent /= Void
		local
			canonical_call: CALL_B
		do
			canonical_call := Current;
			Result := parent.message.canonical = canonical_call;
		end;

	is_attribute: BOOLEAN is
			-- Is Current an access to an attribute ?
		do
		end;

	is_feature: BOOLEAN is
			-- Is Current an access to an Eiffel feature ?
		do
		end;

	is_creatable: BOOLEAN is
			-- Can the access be a target of a creation ?
		do
		end;

	is_external: BOOLEAN is
			-- Is access an external call
		do
		end;

	is_void_entity: BOOLEAN is
			-- Is access the 'Void' entity?
		do
			Result := context.real_type (type).is_none and
				(is_attribute or is_local);
		end;

feature -- Byte code generation

	make_assignment_code (ba: BYTE_ARRAY; source_type: TYPE_I) is
			-- Generate source assignment byte code
		require
			is_creatable;
			good_argument: source_type /= Void;
			consistency: not source_type.is_void;
		local
			basic_type: BASIC_I;
			assignment: BOOLEAN;
			target_type: TYPE_I;
		do
			target_type := Context.real_type (type);
			if target_type.is_none then
				ba.append (Bc_none_assign);
			elseif target_type.is_expanded then
					-- Target is expanded: copy with possible exeception
				ba.append (expanded_assign_code);
				assignment := True;
			elseif target_type.is_basic then
					-- Target is basic: simple attachment if source type
					-- is not none
				if source_type.is_none then
					ba.append (Bc_exp_excep);
				else
					ba.append (assign_code);
					assignment := True;
				end;
			else
					-- Target is a reference
				if source_type.is_basic then
						-- Source is basic and target is a reference:
						-- metamorphose and simple attachment
					basic_type ?= source_type;
					ba.append (Bc_metamorphose);
				elseif source_type.is_expanded then
						-- Source is expanded and target is a reference: clone
						-- and simple attachment
					ba.append (Bc_clone);
				end;
				ba.append (assign_code);
				assignment := True;
			end;

			if assignment then
				make_end_assignment (ba);
			end;
		end; -- make_assignment_code
	
	make_end_assignment (ba: BYTE_ARRAY) is
			-- Finish the assignment to the current access
		require
			is_creatable
		do
			-- Do nothing
		end;

	assign_code: CHARACTER is
			-- Simple assignment byte code
		do
			-- Do nothing
		end;

	expanded_assign_code: CHARACTER is
			-- Expanded assignment byte code
		do
			-- Do nothing
		end;
	
	make_reverse_code (ba: BYTE_ARRAY; source_type: TYPE_I) is
			-- Generate source reverse assignment byte code
		require
			is_creatable;
			good_argument: source_type /= Void;
			consistency: not source_type.is_void;
		local
			basic_type: BASIC_I;
			target_type: TYPE_I;
			cl_type: CL_TYPE_I;
		do
			target_type := Context.real_type (type);
			check
				not_expanded: not target_type.is_expanded;
				not_basic: not target_type.is_basic;
			end;
			if target_type.is_none then
				ba.append (Bc_none_assign);
			else
					-- Target is a reference
				if source_type.is_basic then
						-- Source is basic and target is a reference:
						-- metamorphose and simple attachment
					basic_type ?= source_type;
					ba.append (Bc_metamorphose);
				elseif source_type.is_expanded then
						-- Source is expanded and target is a reference: clone
						-- and simple attachment
					ba.append (Bc_clone);
				end;
				ba.append (reverse_code);
				make_end_reverse_assignment (ba);
					-- Append the target static type
				cl_type ?= target_type;
				ba.append_short_integer (cl_type.type_id - 1);
			end;
		end;

	
	make_end_reverse_assignment (ba: BYTE_ARRAY) is
			-- Finish the reverse assignment byte code on the 
			-- current access
		require
			is_creatable
		do
			-- Do nothing
		end;

	reverse_code: CHARACTER is
			-- Reverse assignment byte code	
		do
			-- Do nothing
		end;

	is_first: BOOLEAN is
			-- Is the access the first one in a multi-dot expression ?
		do
			Result := 	parent = Void
						or else
						(	parent.target = Current
							and then
							(parent.parent = Void)
						)
		end;

end

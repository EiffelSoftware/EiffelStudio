-- Abstract class for access: Current, Result, local, argument, feature

deferred class ACCESS_B 

inherit
	CALL_B
		redefine
			free_register, print_register,
			has_gcable_variable, propagate, generate, unanalyze,
			optimized_byte_node, inlined_byte_code,
			has_separate_call, generate_il
		end
		
	SHARED_NAMES_HEAP
		export
			{NONE} all
		end
	
feature -- Access

	parameters: BYTE_LIST [EXPR_B] is
		do
			-- no parameters
		end

	target: ACCESS_B is
			-- Ourselves as part of a message applied to a target
		do
			Result := Current
		end

	creation_access (t: TYPE_I): ACCESS_B is
			-- Creation access
		require
			creatable: is_creatable
		do
			Result := Current
		end

	context_type: TYPE_I is
			-- Context type of the access (properly instantiated)
		local
			a_parent: NESTED_B
		do
			if parent = Void then
				Result := context.current_type
			elseif is_message then
				Result := parent.target.type
			else 
				a_parent := parent.parent
				if a_parent = Void then
					Result := context.current_type
				else
					Result := a_parent.target.type
				end
			end
			Result := Context.real_type (Result)
		end

	sub_enlarged (p: NESTED_BL): ACCESS_B is
			-- Enlarge node and set parent to `p'
		do
			Result := enlarged
			Result.set_parent (p)
		end

feature -- Status

	read_only: BOOLEAN is
			-- Is the access a read-only one ?
		do
			Result := True
		end

	current_needed_for_access: BOOLEAN is
			-- Is current needed for a true access ?
		do
			Result := is_predefined implies is_current
		end

	has_hector_variables: BOOLEAN is
			-- Do we have any hector variables in use ?
		do
		end

	has_gcable_variable: BOOLEAN is
			-- Is the access using a GCable variable ?
		local
			expr_b: EXPR_B
			is_in_register: BOOLEAN
			i, nb: INTEGER
			l_parameters: BYTE_LIST [EXPR_B]
			l_area: SPECIAL [EXPR_B]
		do
			is_in_register := register /= Void and register /= No_register
			if is_in_register and register.c_type.is_pointer then
					-- Access is stored in a pointer register
				Result := true
			else
				if parent = Void or else parent.target.is_current then
						-- True access: we may need Current.
					Result := (current_needed_for_access and not is_in_register)
						or (is_result and c_type.is_pointer)
				end
					-- Check the parameters if needed, i.e. if there are
					-- any and if the access is not already stored in a
					-- register (which can't be a pointer, otherwise it would
					-- have been handled by the first "if").
				l_parameters := parameters
				if not is_in_register and l_parameters /= Void then
					from
						l_area := l_parameters.area
						nb := l_parameters.count
					until
						i = nb or Result
					loop
						expr_b := l_area.item (i)
						Result := expr_b.has_gcable_variable
						i := i + 1
					end
				end
			end
		end

	used (r: REGISTRABLE): BOOLEAN is
			-- Is register `r' used in local access ?
		local
			expr: EXPR_B
			i, nb: INTEGER
			l_area: SPECIAL [EXPR_B]
			l_parameters: BYTE_LIST [EXPR_B]
		do
			l_parameters := parameters
			if l_parameters /= Void then
				from
					l_area := l_parameters.area
					nb := l_parameters.count
				until
					i = nb or Result
				loop
					expr := l_area.item (i)
					Result := expr.used(r)
					i := i + 1
				end
			end
		end
	
	is_single: BOOLEAN is
			-- Is access a single one ?
		local
			i, nb: INTEGER
			l_area: SPECIAL [EXPR_B]
			l_parameters: BYTE_LIST [EXPR_B]
			expr_b: EXPR_B
		do
				-- If it is predefined, then it is single.
			Result := is_predefined
			if not Result then
				Result := true
					-- It is not predefined. If it has parameters, then none
					-- of them may have a call or allocate memory (manifest arrays,
					-- strings, ...).
				l_parameters := parameters
				if l_parameters /= Void then
					from
						l_area := l_parameters.area
						nb := l_parameters.count
					until
						i = nb or not Result
					loop
						expr_b := l_area.item (i)
						Result := not (expr_b.has_call or else expr_b.allocates_memory)
						i := i + 1
					end
				end
			end
		end

	is_polymorphic: BOOLEAN is
			-- Is the access polymorphic ?
		do
			Result := false
		end

feature -- Element change

	propagate (r: REGISTRABLE) is
			-- Propagate register across access
		do
			if (register = Void) and not context_type.is_basic then
				if 	(real_type (type).c_type.same_class_type (r.c_type)
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
					set_register (r)
					context.set_propagated
				end
			end
		end

feature -- Setting

	set_parameters (p: like parameters) is
		do
			-- Do nothing
		end

feature -- C generation

	print_register is
			-- Print register or generate if there are no register.
		do
			if register /= No_register then
				{CALL_B} Precursor
			else
				generate_access
			end
		end

	free_register is
			-- Free register used by last call expression. If No_register was
			-- propagated, also frees the registers used by target and
			-- last message.
		do
			{CALL_B} Precursor
				-- Free those registers which where kept because No_register
				-- was propagated, hence call was meant to be expanded in-line.
			if perused then
				free_param_registers
			end
		end

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
				(parent /= Void and then parent.register = No_register)
		end

	unanalyze_parameters is
			-- Undo the analysis on parameters
		local
			l_parameters: BYTE_LIST [EXPR_B]
			l_area: SPECIAL [EXPR_B]
			i, nb: INTEGER
			expr_b: EXPR_B
		do
			l_parameters := parameters
			if l_parameters /= Void then
				from
					l_area := l_parameters.area
					nb := l_parameters.count
				until
					i = nb
				loop
					expr_b := l_area.item (i)
					expr_b.unanalyze
					i := i + 1
				end
			end
		end

	free_param_registers is
			-- Free registers used by parameters
		local
			l_parameters: BYTE_LIST [EXPR_B]
			l_area: SPECIAL [EXPR_B]
			i, nb: INTEGER
			expr_b: EXPR_B
		do
			l_parameters := parameters
			if l_parameters /= Void then
				from
					l_area := l_parameters.area
					nb := l_parameters.count
				until
					i = nb
				loop
					expr_b := l_area.item (i)
					expr_b.free_register
					i := i + 1
				end
			end
		end

	unanalyze is
			-- Undo the analysis
		do
			set_register (Void)
			unanalyze_parameters
		end
	
	Current_register: REGISTRABLE is
			-- The "Current" entity
		do
			Result := Context.Current_register
		end

	analyze_on (reg: REGISTRABLE) is
			-- Analyze access on `reg'
		do
				-- This will be redefined where needed. By default, run
				-- a simple analyze and forget about the parameter.
			analyze
		end

	generate is
			-- Generate C code for the access.
		local
			buf: GENERATION_BUFFER
		do
			generate_parameters (current_register)
			if register /= No_register then
				buf := buffer
						-- Procedures have a void return type
				if register /= Void then
					register.print_register
					buf.putstring (" = ")
					if register.is_separate and then
						not context.real_type(type).is_separate then
						buf.putstring ("CURLTS(")
					end
				end
				generate_access
				if  register /= Void and then register.is_separate and then
					not context.real_type(type).is_separate then
					buf.putstring (")")
				end
				buf.putchar (';')
				buf.new_line
				if System.has_separate then
					reset_added_gc_hooks
				end
			end
		end

	generate_on (reg: REGISTRABLE) is
			-- Generate access using `reg' as "Current"
		do
		end

	generate_access is
			-- Generation of the C code for access
		do
		end
	
	generate_parameters (reg: REGISTRABLE) is
			-- Generate code for parameters computation.
			-- `reg' ("Current") is not used except for
			-- inlining
		do
			if parameters /= Void then
				parameters.generate
			end
		end

feature -- Conveniences

	same (other: ACCESS_B): BOOLEAN is
			-- Is `other' the same access as Current ?
		deferred
		end

	is_target: BOOLEAN is
			-- Is the access a target ?
		require
			parent_exists: parent /= Void
		do
			Result := parent.target = Current
		end

	is_message: BOOLEAN is
			-- is the access a message ?
		require
			parent_exists: parent /= Void
		local
			canonical_call: CALL_B
		do
			canonical_call := Current
			Result := parent.message.canonical = canonical_call
		end

	is_attribute: BOOLEAN is
			-- Is Current an access to an attribute ?
		do
		end

	is_feature: BOOLEAN is
			-- Is Current an access to an Eiffel feature ?
		do
		end

	is_creatable: BOOLEAN is
			-- Can the access be a target of a creation ?
		do
		end

	is_void_entity: BOOLEAN is
			-- Is access the 'Void' entity?
		do
			Result := context.real_type (type).is_none and
				(is_attribute or is_local)
		end

feature -- Code generation

	argument_types: ARRAY [STRING] is
			-- Array of C types for the arguments
		local
			p: like parameters
			i, j, nb: INTEGER
			expr: EXPR_B
			param: PARAMETER_B
			protect: PROTECT_B
			type_c: TYPE_C
		do
			p := parameters
			if p = Void then
				if is_external then
					Result := <<>>
				else
					Result := <<"EIF_REFERENCE">>
				end
			else
				from
					i := 1
					nb := p.count
					if is_external then
						!! Result.make (1, nb)
						j := 1
					else
						!! Result.make (1, nb + 1)
						Result.put ("EIF_REFERENCE", 1)
						j := 2
					end
				until
					i > nb
				loop
					expr := p @ i
					param ?= expr
					if param = Void then
							-- PROTECT_B
						protect ?= expr
						if protect /= Void then
							param ?= protect.expr
						else
								-- Shouldn't happen
							check
								False
							end
						end
					end
						-- FIXME
					if param = Void then
						type_c := real_type (expr.type).c_type
					else
						type_c := real_type (param.attachment_type).c_type
					end

					Result.put (type_c.c_string, j)
					i := i +1
					j := j +1
				end
			end
		end

feature -- IL code generation

	generate_il_call_access (is_target_of_call: BOOLEAN) is
			-- Generate `Current' which `is_predefined'.
			-- If `is_target_of_call' we might need to do some
			-- special transformation if Current type is expanded.
		require
			il_generation: System.il_generation
		do
				-- Mutual recursive call in ACCESS_B, but
				-- `is_predefined' descendants will stop
				-- recursion when it occurs because current
				-- feature is redefined.
			generate_il
		end

	generate_il is
			-- Generate IL for Current.
		do
				-- Mutual recursive call in ACCESS_B, but
				-- not `is_predefined' descendants will stop
				-- recursion when it occurs because current
				-- feature is redefined.
			generate_il_call_access (False)	
		end

	need_address (is_target_of_call: BOOLEAN): BOOLEAN is
			-- Does current access need its address loaded in memory?
		local
			cl_type: CL_TYPE_I
			call_access: CALL_ACCESS_B
			l_nested: NESTED_B
		do
			cl_type ?= real_type (type)
			Result := is_target_of_call and then cl_type.is_expanded
			
			if Result then
				call_access ?= parent.message

				if call_access = Void then
						-- Find out if it is a nested call.
					l_nested ?= parent.message
					call_access ?= l_nested.target
				end

					-- We do not load the address if it is an optimized call of the compiler.
				Result := not call_access.is_il_feature_special (cl_type)
				if Result and then call_access /= Void and then cl_type.is_basic then
					if call_access.written_in > 0 then
							-- Find location of feature to find out if the address needs
							-- to be loaded. True when written in the same class, False
							-- otherwise.
						Result := cl_type.same_as (il_generator.implemented_type (call_access.written_in, cl_type))
					end
				end
			end
		end

	generate_il_start_assignment is
			-- Generate location of assignment if needed.
		do
			if is_attribute then
				il_generator.generate_current
			end
		end

	generate_il_assignment (source_type: TYPE_I)  is
			-- Generate source assignment IL code.
		require
			is_creatable
		local
			attr: ATTRIBUTE_B
			loc: LOCAL_B
			res: RESULT_B
			target_type, l_type: TYPE_I
			cl_type: CL_TYPE_I
			feat_tbl: FEATURE_TABLE
			feat: FEATURE_I
		do
			target_type := Context.real_type (type)
			if target_type.is_reference and then source_type.is_expanded then
				generate_il_metamorphose (source_type, target_type, True)
			elseif target_type.is_numeric then
				if not source_type.same_type (target_type) then
					l_type := target_type.heaviest (source_type)
					if l_type = target_type then
						il_generator.convert_to (l_type)
					end
				end
			end

					-- Generate cast if we have to generate verifiable code
					-- since access might have been redefined and in this
					-- case its type for IL generation is the one from the
					-- parent not the redefined one. Doing the cast enable
					-- the verifier to find out that what we are doing is
					-- correct. Cast is not needed for expanded type since
					-- they cannot be redefined.
			if
				System.il_verifiable and then not target_type.is_expanded
				and then not target_type.is_none
			then
				il_generator.generate_check_cast (source_type, target_type)
			end

			if is_attribute then
				attr ?= Current
					-- FIXME: Manu 10/24/2001. This could be improved.
					-- I'm not even sure if we really need to look at the
					-- feature table here.
				feat_tbl := System.class_of_id (attr.written_in).feature_table
				feat := feat_tbl.item_id (attr.attribute_name_id)
				cl_type ?= attr.context_type
				il_generator.generate_attribute_assignment (
					il_generator.implemented_type (attr.written_in, cl_type), feat.feature_id)
			elseif is_local then
				loc ?= Current
				il_generator.generate_local_assignment (loc.position)
			elseif is_result then
				res ?= Current
				il_generator.generate_result_assignment
			end
		end

feature -- Byte code generation

	make_assignment_code (ba: BYTE_ARRAY; source_type: TYPE_I) is
			-- Generate source assignment byte code
		require
			is_creatable
			good_argument: source_type /= Void
			consistency: not source_type.is_void
		local
			basic_type: BASIC_I
			assignment: BOOLEAN
			target_type: TYPE_I
			basic_target, basic_source: BASIC_I
		do
			target_type := Context.real_type (type)
			if target_type.is_none then
				ba.append (Bc_none_assign)
			elseif target_type.is_true_expanded then
					-- Target is expanded: copy with possible exeception
				ba.append (expanded_assign_code)
				assignment := True
			elseif target_type.is_bit then
				ba.append (bit_assign_code);	
				assignment := True
			elseif target_type.is_basic then
					-- Target is basic: simple attachment if source type
					-- is not none
				if source_type.is_none then
					ba.append (Bc_exp_excep)
				else
					if target_type.is_numeric and then source_type.is_numeric then
						basic_target ?= target_type
						basic_source ?= source_type
						if basic_target.level /= basic_source.level then
							basic_target.generate_byte_code_cast (ba)
						end
					end
					ba.append (assign_code)
					assignment := True
				end
			else
					-- Target is a reference
				if source_type.is_basic then
						-- Source is basic and target is a reference:
						-- metamorphose and simple attachment
					basic_type ?= source_type
					ba.append (Bc_metamorphose)
				elseif source_type.is_true_expanded then
						-- Source is expanded and target is a reference: clone
						-- and simple attachment
					ba.append (Bc_clone)
				end
				ba.append (assign_code)
				assignment := True
			end

			if assignment then
				make_end_assignment (ba)
			end
		end
	
	make_end_assignment (ba: BYTE_ARRAY) is
			-- Finish the assignment to the current access
		require
			is_creatable
		do
			-- Do nothing
		end

	bit_assign_code: CHARACTER is
			-- Bits assignment byte code
			-- (By default it is the assign_code)
		do
			Result := assign_code	
		end

	assign_code: CHARACTER is
			-- Simple assignment byte code
		do
			-- Do nothing
		end

	expanded_assign_code: CHARACTER is
			-- Expanded assignment byte code
		do
			-- Do nothing
		end
	
	make_reverse_code (ba: BYTE_ARRAY; source_type: TYPE_I) is
			-- Generate source reverse assignment byte code
		require
			is_creatable
			good_argument: source_type /= Void
			consistency: not source_type.is_void
		local
			basic_type: BASIC_I
			target_type: TYPE_I
			cl_type: CL_TYPE_I
			gen_type: GEN_TYPE_I
		do
			target_type := Context.creation_type (type)
			check
				not_expanded: not target_type.is_true_expanded
				not_basic: not target_type.is_basic
			end
			if target_type.is_none then
				ba.append (Bc_none_assign)
			else
					-- Target is a reference
				if source_type.is_basic then
						-- Source is basic and target is a reference:
						-- metamorphose and simple attachment
					basic_type ?= source_type
					ba.append (Bc_metamorphose)
				elseif source_type.is_true_expanded then
						-- Source is expanded and target is a reference: clone
						-- and simple attachment
					ba.append (Bc_clone)
				end
				ba.append (reverse_code)
				make_end_reverse_assignment (ba)
					-- Append the target static type
				cl_type ?= target_type
				ba.append_short_integer (cl_type.type_id - 1)

				gen_type ?= cl_type
				if gen_type /= Void then
					ba.append_short_integer (context.current_type.generated_id (False))
					gen_type.make_gen_type_byte_code (ba, true)
				else
					if not cl_type.is_explicit then
						-- Anchored
						ba.append_short_integer (context.current_type.generated_id (False))
						cl_type.cr_info.make_reverse_byte_code (ba)
					end
				end
				ba.append_short_integer (-1)
			end
		end

	
	make_end_reverse_assignment (ba: BYTE_ARRAY) is
			-- Finish the reverse assignment byte code on the 
			-- current access
		require
			is_creatable
		do
			-- Do nothing
		end

	reverse_code: CHARACTER is
			-- Reverse assignment byte code	
		do
			-- Do nothing
		end

	is_first: BOOLEAN is
			-- Is the access the first one in a multi-dot expression ?
		local
			p: like parent
			p_target: ACCESS_B
			constant_b: CONSTANT_B
		do
			p := parent
			if p = Void then
				Result := True
			else
				p_target := p.target
				if (p_target = Current and then p.parent = Void) then
					Result := True
				else
						-- Bug fix: CONSTANT_B has a special construct
						-- for nested calls
					constant_b ?= p_target
					Result := constant_b /= Void and then
						constant_b.access = Current and then p.parent = Void
				end
			end
		end

feature -- Array optimization

	optimized_byte_node: like Current is
			-- Redefined for type check
		do
			Result := Current
		end

	conforms_to_array_opt: BOOLEAN is
		do
			Result := (is_argument or else is_local or else is_result)
				and then type.conforms_to_array
		end

	array_descriptor: INTEGER is
			-- Array description
			-- argument:<0; Result:0; local:>0
		do
		end

feature -- Inlining

	inlined_byte_code: ACCESS_B is
			-- Redefined for type check
		do
			Result := Current
		end

feature -- concurrent Eiffel

	has_separate_call: BOOLEAN is
		-- Is there separate feature call in the assertion?
		do
			Result := context_type.is_separate
		end
	
feature -- Concurrent Eiffel

	reset_added_gc_hooks is
		do
		end

end

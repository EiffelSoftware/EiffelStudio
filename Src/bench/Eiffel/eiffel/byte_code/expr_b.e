-- An Eiffel expression.

deferred class EXPR_B

inherit
	REGISTRABLE
		redefine
			get_register, free_register, print_register
		end

	BYTE_NODE
		redefine
			need_enlarging, enlarged, optimized_byte_node,
			pre_inlined_code, inlined_byte_code
		end
	SHARED_C_LEVEL

feature -- Access

	type: TYPE_I is
			-- Expression type
		deferred
		end

	c_type: TYPE_C is
			-- C type of the expression
		do
			Result := real_type (type).c_type
		end

	used (r: REGISTRABLE): BOOLEAN is
			-- Is register `r' used in local or forthcomming dot calls ?
		deferred
		end

feature -- Evaluation

	evaluate: VALUE_I is
			-- Evaluate current expression, if possible.
		once
			create {NO_VALUE_I} Result
		ensure
			evaluate_not_void: Result /= Void
		end
		
feature -- Il code generation

	is_fast_as_local: BOOLEAN is
			-- Is expression calculation as fast as loading a local?
			-- In other words: does it make sense to store a result of the expression
			-- in a temporary local variable for multiple uses or is it equivalent 
			-- in performance to "recalculating" the expression every time?
			-- (In the latter case it's better to avoid creating a temporary
			-- variable to reduce stack memory footprint and register pressure.)
		do
		end

	generate_il_metamorphose (a_type, target_type: TYPE_I; real_metamorphose: BOOLEAN) is
			-- Generate a metamorphose of target object.
			-- If `real_metamorphose' is set to True, target is an
			-- expanded type and feature is defined  in a non-expanded class.
			-- If False, feature is defined in an expanded
			-- class we simply need to load address of target.
		local
			local_number: INTEGER
		do
			if target_type = Void then
				if real_metamorphose then
					il_generator.generate_metamorphose (a_type)
				else
					context.add_local (a_type)
					local_number := context.local_list.count
					il_generator.put_dummy_local_info (a_type, local_number)
					il_generator.generate_local_assignment (local_number)
					il_generator.generate_local_address (local_number)			
				end
			else
				if a_type.is_basic and then not target_type.is_external then
					generate_il_eiffel_metamorphose (a_type)
				else
					if a_type.is_expanded and a_type.same_as (target_type) then
						context.add_local (a_type)
						local_number := context.local_list.count
						il_generator.put_dummy_local_info (a_type, local_number)
						il_generator.generate_local_assignment (local_number)
						il_generator.generate_local_address (local_number)	
					else
						il_generator.generate_metamorphose (a_type)
					end
				end
			end
		end

	generate_il_eiffel_metamorphose (a_type: TYPE_I) is
			-- Generate a metamorphose of `a_type' into a _REF type.
		require
			a_type_is_basic: a_type.is_basic
		local
			local_number: INTEGER
			l_cl_type: BASIC_I
			feat: FEATURE_I
			ref_class: CLASS_C
			l_decl_type: CL_TYPE_I
			l_is_basic: BOOLEAN
		do
				-- FIXME: We only half support metamorphose of basic types
				-- through the `set_item' routine.

			l_cl_type ?= a_type
			l_is_basic := l_cl_type.is_basic and not l_cl_type.is_bit

			if l_is_basic then
					-- Assign value to a temporary local variable.
				context.add_local (a_type)
				local_number := context.local_list.count
				il_generator.put_dummy_local_info (a_type, local_number)
				il_generator.generate_local_assignment (local_number)
			else
				il_generator.pop
			end
			
				-- Create reference class
			(create {CREATE_TYPE}.make (l_cl_type.reference_type)).generate_il

			if l_is_basic then
				il_generator.duplicate_top
				
					-- Call `set_item' from the _REF class
				ref_class := l_cl_type.reference_type.base_class
				feat := ref_class.feature_table.item_id (feature {PREDEFINED_NAMES}.set_item_name_id)

				l_decl_type := il_generator.implemented_type (feat.origin_class_id,
					l_cl_type.reference_type)
				
				il_generator.generate_local (local_number)
				il_generator.generate_feature_access (l_decl_type,
					feat.origin_feature_id, feat.argument_count, feat.has_return_value, False)
			end
		end

feature -- C generation

	get_register is
			-- Get a temporary register to hold result of expr. If a register
			-- has already been propagated, then `register' is not void and
			-- nothing has to be done.
		local
			tmp_register: REGISTER
			ctype: TYPE_C
		do
			if register = Void then
				ctype := c_type
				if not ctype.is_void then
					create tmp_register.make (ctype)
					set_register (tmp_register)
				end
			end
		ensure then
			register_exists: register = Void implies type.is_void
		end

	free_register is
			-- Free register used by expr, if necessary
		do
			if register /= Void then
				register.free_register
			end
		end

	print_register is
			-- Print register.
		do
			register.print_register
		end

	is_simple_expr: BOOLEAN is
			-- Is the current expression a simple one ?
			-- Definition: an expression <E> is simple if the assignment
			-- target := <E> is generated as such in C when "target" is a
			-- predefined entity propagated in <E>.
			-- Currently, the only simple expressions are the calls
			-- the manifest strings and the constants.
		do
		end

	is_hector: BOOLEAN is
			-- Is the current expression an hector one ?
			-- Definition: an expression <E> is hector if it is a parameter
			-- of an external function call, <E> is of the form $<A> and <A>
			-- is an attribute or a local variable.
		do
		end

	has_gcable_variable: BOOLEAN is
			-- Does the expression have a GCable variable ?
			-- Definition: a GCable variable is a variable which is placed
			-- under the control of the garbage collector, directly or
			-- indirectly via the hooks.
		do
		end

	has_call: BOOLEAN is
			-- Does the expression have a call ?
		do
		end

	allocates_memory: BOOLEAN is
			-- Does the expression allocates memory ?
		do
		end

	unanalyze is
			-- Undo the effect of analyze.
		do
		end

	stored_register: REGISTRABLE is
			-- The register in which the expression is stored
		do
			Result := register
			if Result = Void then
				Result := Current
			end
		end

	need_enlarging: BOOLEAN is true
			-- All the expressions need enlarging

	enlarged: EXPR_B is
			-- Redefined for type check
		do
			Result := Current
		end

	register_name: STRING is
			-- Do nothing
		do
		end

feature  -- Array optimization

	optimized_byte_node: EXPR_B is
			-- Redefined for type check
		do
			Result := Current
		end

feature -- Inlining

	pre_inlined_code: EXPR_B is
			-- Redefined for type check
		do
			Result := Current
		end

	inlined_byte_code: EXPR_B is
			-- Redefined for type check
		do
			Result := Current
		end

end

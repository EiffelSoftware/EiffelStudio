-- Enlarged access to an Eiffel feature

class FEATURE_BL 

inherit
	FEATURE_B
		redefine
			free_register,
			is_feature_call, basic_register, generate_parameters_list,
			generate_access_on_type, is_polymorphic, has_call,
			set_register, register, set_parent, parent, generate_access,
			generate_on, analyze_on, analyze, generate_special_feature,
			allocates_memory, generate_end
		end

	SHARED_DECLARATIONS

feature 

	parent: NESTED_BL
			-- Parent of access

	register: REGISTRABLE
			-- In which register the expression is stored

	basic_register: REGISTRABLE
			-- Register used to store the metamorphosed simple type

	set_register (r: REGISTRABLE) is
			-- Set current register to `r'
		do
			register := r
		end

	set_parent (p: NESTED_BL) is
			-- Assign `p' to `parent'
		do
			parent := p
		end

	is_feature_call: BOOLEAN is True
			-- Access is a feature call

	free_register is
			-- Free registers
		do
			{FEATURE_B} Precursor
			if basic_register /= Void then
				basic_register.free_register
			end
		end

	analyze is
			-- Build a proper context for code generation.
		do
debug
io.error.putstring ("In feature_bl%N")
end
			analyze_on (Current_register)
				-- Get a register if none were already propagated
			get_register
debug
io.error.putstring ("Out feature_bl%N")
end
		end
	
	analyze_on (reg: REGISTRABLE) is
			-- Analyze feature call on `reg'
		local
			tmp_register: REGISTER
			access_b: ACCESS_B
		do
debug
io.error.putstring ("In feature_bl [analyze_on]: ")
io.error.putstring (feature_name)
io.error.new_line
end
			if context_type.is_basic then
					-- Get a register to store the metamorphosed basic type,
					-- on which the attribute access is made. The lifetime of
					-- this temporary is really short: just the time to make
					-- the call...
				!!tmp_register.make (Reference_c_type)
				basic_register := tmp_register
			end
			if parameters /= Void then
				-- If we have only one parameter and it is a single access to
				-- an attribute, then expand it in-line.
				if parameters.count = 1 then
					access_b ?= parameters.first
					if access_b /= Void and then access_b.is_attribute then
						context.init_propagation
						access_b.propagate (No_register)
					end
				end
				parameters.analyze
				check_dt_current (reg)
					-- If No_register has been propagated, then this call will
					-- be expanded in line. It might be part of a more complex
					-- expression, hence temporary registers used by the
					-- parameters may not be released now.
				if not perused then
					free_param_registers
				end
			else
				check_dt_current (reg)
			end
			if reg.is_current then
				context.mark_current_used
			end
debug
io.error.putstring ("Out feature_bl [analyze_on]: ")
io.error.putstring (feature_name)
io.error.new_line
end
		end

	generate_special_feature (reg: REGISTRABLE; basic_type: BASIC_I) is
			-- Generate code for special routines (is_equal, copy ...).
		do
			special_routines.generate (buffer, basic_type, reg, parameters)
		end

	generate_access is
			-- Generate access call of feature in current on `current_register'
		do
			do_generate (Current_register)
		end

	generate_on (reg: REGISTRABLE) is
			-- Generate access call of feature in current on `current_register'
		do
			do_generate (reg)
		end

	check_dt_current (reg: REGISTRABLE) is
			-- Check whether we need to compute the dynamic type of current
			-- and call context.add_dt_current accordingly. The parameter
			-- `reg' is the entity on which the access is made.
		local
			type_i: TYPE_I
			class_type: CL_TYPE_I
			access: ACCESS_B
			void_register: REGISTER
			is_polymorphic_access: BOOLEAN
		do
			type_i := context_type
			class_type ?= type_i
			is_polymorphic_access := not type_i.is_basic and then
					class_type /= Void and then
					Eiffel_table.is_polymorphic (routine_id, class_type.type_id, True) >= 0
			if reg.is_current and is_polymorphic_access then
				context.add_dt_current
			end
			if not reg.is_predefined and is_polymorphic_access then
					-- BEWARE!! The function call is polymorphic hence we'll
					-- need to evaluate `reg' twice: once to get its dynamic
					-- type and once as a parameter for Current. Hence we
					-- must make sure it is not held in a No_register--RAM.
				access ?= reg;		-- Cannot fail
				if access.register = No_register then
					access.set_register (void_register)
					access.get_register
				end
			end
		end

	is_polymorphic: BOOLEAN is
			-- Is access polymorphic ?
		local
			class_type: CL_TYPE_I
			type_i: TYPE_I
		do
			type_i := context_type
			if not type_i.is_basic then
				class_type ?= type_i;	-- Cannot fail
				Result := Eiffel_table.is_polymorphic (routine_id, class_type.type_id, True) >= 0
			end
		end

	generate_end (gen_reg: REGISTRABLE; class_type: CL_TYPE_I; is_class_separate: BOOLEAN) is
			-- Generate final portion of C code.
		local
			buf: GENERATION_BUFFER
		do
			is_polymorphic_once.set_item (True)
			generate_access_on_type (gen_reg, class_type);
			buf := buffer;
			if
				is_once and then
				not System.has_multithreaded and then
				not is_polymorphic_once.item
			then
				buf.putchar (',')
				buf.putchar ('(')
				gen_reg.print_register
				if parameters /= Void then
					generate_parameters_list
				end
				buf.putchar (')')
			else
				buf.putchar ('(')
				gen_reg.print_register
				if parameters /= Void then
					generate_parameters_list
				end;
			end
			buf.putchar (')')
		end
		
	generate_access_on_type (reg: REGISTRABLE; typ: CL_TYPE_I) is
			-- Generate feature call in a `typ' context
		local
			internal_name		: STRING
			table_name			: STRING
			rout_table			: ROUT_TABLE
			type_c				: TYPE_C
			buf					: GENERATION_BUFFER
			array_index			: INTEGER
			local_argument_types: ARRAY [STRING]
		do
			array_index := Eiffel_table.is_polymorphic (routine_id, typ.type_id, True)
			buf := buffer
			is_deferred := False
			if array_index = -2 then
					-- Call to a deferred feature without implementation
				is_deferred := True
				buf.putchar ('(')
				real_type (type).c_type.generate_function_cast (buf, <<"EIF_REFERENCE">>)
				buf.putstring (" RTNR)")
			elseif precursor_type = Void and then array_index >= 0 then
					-- The call is polymorphic, so generate access to the
					-- routine table. The dereferenced function pointer has
					-- to be enclosed in parenthesis.
				table_name := Encoder.table_name (routine_id)
				buf.putchar ('(')
				real_type (type).c_type.generate_function_cast (buf, argument_types)
				buf.putchar ('(')
				buf.putstring (table_name)
				buf.putchar ('-')
				buf.putint (array_index)
				buf.putstring (")[")
				if reg.is_current then
					context.generate_current_dtype
				else
					buf.putstring (gc_upper_dtype_lparan)
					reg.print_register
					buf.putchar (')')
				end
				buf.putstring ("])")
					-- Mark routine id used
				Eiffel_table.mark_used (routine_id)
					-- Remember extern declaration
				Extern_declarations.add_routine_table (table_name)
			else
					-- The call is not polymorphic in the given context,
					-- so the name can be hardwired, unless we access a
					-- deferred feature in which case we have to be careful
					-- and get the routine name of the first entry in the
					-- routine table.
				rout_table ?= Eiffel_table.poly_table (routine_id)
				rout_table.goto_implemented (typ.type_id)

				if rout_table.is_implemented then
					internal_name := rout_table.feature_name
					type_c := real_type (type).c_type

					if is_once then
						is_polymorphic_once.set_item (False)
						if not System.has_multithreaded then
							if type_c.is_void then
									-- It is a once procedure
								buf.putstring ("RTOVP(")
							else
									-- It is a once function
								buf.putstring ("RTOVF(")
							end
							buf.putstring (internal_name)
							buf.putchar (',')
						end
					end

					local_argument_types := argument_types
					if
						not (rout_table.item.written_type_id = Context.original_class_type.type_id)
					then
							-- Remember extern routine declaration
						Extern_declarations.add_routine_with_signature (type_c,
								internal_name, local_argument_types)
						if is_once and then not System.has_multithreaded then
							Extern_declarations.add_once (type_c, internal_name)
						end
					end

					buf.putchar ('(')
					type_c.generate_function_cast (buf, local_argument_types)
					buf.putstring (internal_name)
					buf.putchar (')')
				else
						-- Call to a deferred feature without implementation
					is_deferred := True
					buf.putchar ('(')
					real_type (type).c_type.generate_function_cast (buf, <<"EIF_REFERENCE">>)
					buf.putstring (" RTNR)")
				end
			end
		end
		
	generate_parameters_list is
			-- Generate the parameters list for C function call
		local
			expr: EXPR_B
			para: PARAMETER_B
			para_type: TYPE_I
			loc_idx: INTEGER
			buf: GENERATION_BUFFER
			l_area: SPECIAL [EXPR_B]
			i, nb: INTEGER
			p: like parameters
		do
			if not is_deferred then
				p := parameters
				if p /= Void then
					buf := buffer
					l_area := p.area
					nb := p.count
					p := Void
					if system.has_separate then
						from
						until
							i = nb
						loop
							expr := l_area.item (i);	-- Cannot fail
							para ?= expr
							buf.putstring (gc_comma)
							if para /= Void and then para.stored_register.register_name /= Void then
								loc_idx := context.local_index (para.stored_register.register_name)
								para_type := real_type(para.attachment_type)
								if para_type /= Void and then para_type.is_separate then
									buf.put_protected_local_set (context.ref_var_used + loc_idx)
								else
									expr.print_register
								end
							else
								expr.print_register
							end
							i := i + 1
						end
					else
						from
						until
							i = nb
						loop
							buf.putstring (gc_comma)
							expr := l_area.item (i);	-- Cannot fail
							expr.print_register
							i := i + 1
						end
					end
				end
			end
		end

	fill_from (f: FEATURE_B) is
			-- Fill in node with feature `f'
		do
			feature_name_id := f.feature_name_id
			feature_id := f.feature_id
			type := f.type
			parameters := f.parameters
			precursor_type := f.precursor_type
			routine_id := f.routine_id
			is_once := f.is_once
			enlarge_parameters
		end

	enlarge_parameters is
		local
			i, nb: INTEGER
			l_area: SPECIAL [EXPR_B]
			p: like parameters
		do
			p := parameters
			if p /= Void then
				from
					l_area := p.area
					nb := p.count
					p := Void
				until
					i = nb
				loop
					l_area.put (l_area.item (i).enlarged, i)
					i := i + 1
				end
			end
		end

	has_call: BOOLEAN is True
			-- The expression has at least one call

	allocates_memory: BOOLEAN is True

feature -- Concurrent Eiffel

		-- We put the feature here because we don't want FEATURE_BWS to inherit
		-- FEATURE_BLS, which will require us to undefine a lot of features.
	put_parameters_into_array is
		local
			expr: PARAMETER_B
			para_type: TYPE_I
			i: INTEGER
			loc_idx: INTEGER
			buf: GENERATION_BUFFER
		do
			if parameters /= Void then
				buf := buffer
				from
					parameters.start
					i := 0
				until
					parameters.after
				loop
					expr ?= parameters.item;    -- Cannot fail
					para_type := real_type(expr.attachment_type)
					if para_type.is_boolean then
						buf.putstring ("CURPB(")
						expr.print_register
						buf.putstring (", ")
						buf.putint (i)
						buf.putstring (");")
						buf.new_line
					elseif para_type.is_long then
						buf.putstring ("CURPI(")
						expr.print_register
						buf.putstring (", ")
						buf.putint (i)
						buf.putstring (");")
						buf.new_line
					elseif para_type.is_feature_pointer then
						buf.putstring ("CURPP(")
						expr.print_register
						buf.putstring (", ")
						buf.putint (i)
						buf.putstring (");")
						buf.new_line
					elseif para_type.is_char then
						buf.putstring ("CURPC(")
						expr.print_register
						buf.putstring (", ")
						buf.putint (i)
						buf.putstring (");")
						buf.new_line
					elseif para_type.is_double then
						buf.putstring ("CURPD(")
						expr.print_register
						buf.putstring (", ")
						buf.putint (i)
						buf.putstring (");")
						buf.new_line
					elseif para_type.is_float then
						buf.putstring ("CURPR(")
						expr.print_register
						buf.putstring (", ")
						buf.putint (i)
						buf.putstring (");")
						buf.new_line
					elseif para_type.is_reference and not para_type.is_separate then
						buf.putstring ("CURPO(")
						expr.print_register
						buf.putstring (", ")
						buf.putint (i)
						buf.putstring (");")
						buf.new_line
					elseif para_type.is_separate then
						buf.putstring ("CURPSO(")
--                    expr.print_register
						if expr.stored_register.register_name /= Void then
							loc_idx := context.local_index (expr.stored_register.register_name)
						else
							loc_idx := -1
						end
						if loc_idx /= -1 then
							buf.put_protected_local_set (context.ref_var_used + loc_idx)
						else
							-- It'll be the case when the value is "Void"
							expr.print_register
						end
						buf.putstring (", ")
						buf.putint (i)
						buf.putstring (");")
						buf.new_line
					end
					i := i + 1
					parameters.forth
				end
			end
		end

feature {NONE} -- Implementation

	is_deferred: BOOLEAN
			-- Is current feature call a deferred feature without implementation?

	is_polymorphic_once: BOOLEAN_REF is
			-- Is current call a call on a once which is not a polymorphic call?
		once
			create Result
		end

end

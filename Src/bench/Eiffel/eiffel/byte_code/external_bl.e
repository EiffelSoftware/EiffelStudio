-- Enlarged access to a C external

class EXTERNAL_BL 

inherit

	EXTERNAL_B
		rename
			free_register as access_free_register
		redefine
			generate_parameters_list, generate_access_on_type,
			release_hector_protection, basic_register, has_hector_variables,
			has_call, current_needed_for_access, set_parent, parent,
			set_register, register, generate_access, generate_on,
			analyze_on, analyze, generate_end, allocates_memory
		end;
	EXTERNAL_B
		redefine
			free_register,
			generate_parameters_list, generate_access_on_type,
			release_hector_protection, basic_register, has_hector_variables,
			has_call, current_needed_for_access, set_parent, parent,
			set_register, register, generate_access, generate_on,
			analyze_on, analyze, generate_end, allocates_memory
		select
			free_register
		end;
	SHARED_TABLE;
	SHARED_DECLARATIONS;
	EXTERNAL_CONSTANTS;

feature 

	parent: NESTED_BL;
			-- Parent of access
	
	register: REGISTRABLE;
			-- In which register the expression is stored

	basic_register: REGISTRABLE;
			-- Register used to store the metamorphosed simple type

	set_parent (p: NESTED_BL) is
			-- Assign `p' to `parent'
		do
			parent := p;
		end;

	set_register (r: REGISTRABLE) is
			-- Set current register to `r'
		do
			register := r;
		end;

	current_needed_for_access: BOOLEAN is false;
			-- Current is not needed to call an external

	free_register is
			-- Free registers
		do
			access_free_register;
			if basic_register /= Void then
				basic_register.free_register;
			end;
		end;

	analyze is
			-- Build a proper context for code generation.
		do
			analyze_on (Current_register);
			get_register;
		end;

	analyze_on (reg: REGISTRABLE) is
			-- Analyze call on an entity held in `reg'.
		local
			tmp_register: REGISTER;
		do
			if context_type.is_basic then
					-- Get a register to store the metamorphosed basic type,
					-- on which the attribute access is made. The lifetime of
					-- this temporary is really short: just the time to make
					-- the call...
				!!tmp_register.make (Ref_type);
				basic_register := tmp_register;
			end;
			if parameters /= Void then
				parameters.analyze;
					-- If No_register has been propagated, then this call will
					-- be expanded in line. It might be part of a more complex
					-- expression, hence temporary registers used by the
					-- parameters may not be released now.
				check_dt_current (reg);
				if not perused then
					free_param_registers;
				end;
			else
				check_dt_current (reg);
			end;
		end;

	check_dt_current (reg: REGISTRABLE) is
			-- Check whether we need to compute the dynamic type of current
			-- and call context.add_dt_current accordingly. The parameter
			-- `reg' is the entity on which the access is made.
		local
			entry: POLY_TABLE [ENTRY];
			type_i: TYPE_I;
			class_type: CL_TYPE_I;
			access: ACCESS_B;
			void_register: REGISTER;
			is_polymorphic_access: BOOLEAN;
		do
			entry := Eiffel_table.poly_table (rout_id);
			type_i := context_type;
			class_type ?= type_i;
			is_polymorphic_access := not type_i.is_basic and then
					class_type /= Void and then
					entry.is_polymorphic (class_type.type_id);
			if reg.is_current and is_polymorphic_access then
				context.add_dt_current;
			end;
			if not reg.is_predefined and is_polymorphic_access then
					-- BEWARE!! The function call is polymorphic hence we'll
					-- need to evaluate `reg' twice: once to get its dynamic
					-- type and once as a parameter for Current. Hence we
					-- must make sure it is not held in a No_register--RAM.
				access ?= reg;		-- Cannot fail
				if access.register = No_register then
					access.set_register (void_register);
					access.get_register;
				end;
			end;
		end;

	generate_access is
			-- Generate the external C call
		do
			generate_on (Current_register);
		end;

	generate_on (reg: REGISTRABLE) is
			-- Generate call of feature on `reg'
		do
			do_generate (reg);
		end;
	
	generate_access_on_type (reg: REGISTRABLE; typ: CL_TYPE_I) is
			-- Generate external call in a `typ' context
		local
			rout_table: ROUT_TABLE;
			entry: POLY_TABLE [ENTRY];
			internal_name, table_name: STRING;
			i: INTEGER;
			is_boolean: BOOLEAN
		do
			check
				final_mode: context.final_mode
			end;
			is_boolean :=  type.is_boolean;
			entry := Eiffel_table.poly_table (rout_id);
			if entry.is_polymorphic (typ.type_id) then
					-- The call is polymorphic, so generate access to the
					-- routine table. The dereferenced function pointer has
					-- to be enclosed in parenthesis.
				table_name := rout_id.table_name;

				if is_boolean then
					generated_file.putstring ("EIF_TEST((");
				else
					generated_file.putchar ('(');
					real_type (type).c_type.generate_function_cast (generated_file);
				end;
				generated_file.putchar ('(');
				generated_file.putstring (table_name);
				generated_file.putchar ('-');
				generated_file.putint (entry.min_used - 1);
				generated_file.putchar (')');
				generated_file.putchar ('[');
				if reg.is_current then
					context.generate_current_dtype;
				else
					generated_file.putstring (gc_upper_dtype_lparan);
					reg.print_register;
					generated_file.putchar (')');
				end;
				generated_file.putchar (']');
				generated_file.putchar (')');
					-- Mark routine table used.
				Eiffel_table.mark_used (rout_id);
					-- Remember external routine table declaration
				Extern_declarations.add_routine_table (table_name);
			else
				if is_boolean then
					generated_file.putstring ("EIF_TEST(");
				else
					context.real_type (type).c_type.generate_cast (generated_file);
				end;
					-- The call is not polymorphic in the given context,
					-- so the name can be hardwired.
				if encapsulated then
						-- Let's see if there's some include file to add to the .h file
						-- for the final mode only.
						-- We don't need to test if an include file is already in the
						-- shared_include_set of the current class because this
						-- shared set is a set and every item appears only once
					if (is_special_ext or has_include_list) then
						if is_special_ext and not ((special_id = dll16_id) or (special_id = dll32_id)) then
							shared_include_set.extend (special_file_name);
						end;
						if has_include_list then
							from
								i := include_list.lower
							until
								i > include_list.upper
							loop
								shared_include_set.extend (include_list.item (i));
								i := i + 1;
							end;
						end;
					end;
						-- Now generate the right name to call the external
						-- In the case of a signature or a macro, the call will be direct
						-- In the case of a dll, the encapsulation will be called (encoded name)
					if (special_id = dll16_id) or (special_id = dll32_id) then
						rout_table ?= entry;
						internal_name := clone (rout_table.feature_name (typ.type_id));
						generated_file.putstring (internal_name);
					else
						if special_id = macro_id then
								--| External procedure will be generated as:
								--| (void) (c_proc (args));
								--| The extra parenthesis are necessary if c_proc is
								--| an affectation e.g. c_proc(arg1, arg2) arg1 = arg2
								--| Without the parenthesis, the cast is done only on the first
								--| argument, not the entire expression (affectation)
							generated_file.putchar ('(');
						end;
						internal_name := external_name;
						generated_file.putstring (internal_name);
					end;
						-- To avoid problems, the prototype of the function has to be added
						-- to the .h file.
						-- A prototype is added only if it's a dll, or if it's an external
						-- for which there's no include file defining it.
					if
						(special_id = dll16_id
					or
						 special_id = dll32_id
					or
						 (has_signature and not has_include_list and not is_special_ext))
					then
						Extern_declarations.add_routine (real_type (type).c_type, internal_name);
					end;
				else
					internal_name := external_name;
					generated_file.putstring (internal_name);
					if has_include_list then
							-- The external uses some include files
							-- We assume the declaration of the function is
							-- done in one of these include files
						from
							i := include_list.lower
						until
							i > include_list.upper
						loop
							shared_include_set.extend (include_list.item (i));
							i := i + 1
						end;
					else
							-- Remember external routine declaration
						Extern_declarations.add_routine
							(real_type (type).c_type, internal_name);
					end;
				end;
			end;
		end;

	generate_end (gen_reg: REGISTRABLE; class_type: CL_TYPE_I; meta: BOOLEAN) is
			-- Generate final portion of C code.
		local
			generate_parenthesis: BOOLEAN
		do
			generate_access_on_type (gen_reg, class_type);
				-- Now generate the parameters of the call, if needed.
			generate_parenthesis := not (is_attribute or
					(context.final_mode and special_id = macro_id and parameters = Void));
			if generate_parenthesis then
				generated_file.putchar ('(');
			end;
			if is_feature_call then
				gen_reg.print_register;
			end;
			if parameters /= Void then
				generate_parameters_list;
			end;
			if generate_parenthesis then
				generated_file.putchar (')');
			end;
			if
				context.final_mode and then
				not Eiffel_table.poly_table (rout_id).is_polymorphic (class_type.type_id) and then
				special_id = macro_id and encapsulated
			then
					--| See comments in `generate_access_on_type'
				generated_file.putchar (')');
			end
			if meta then
					-- Close parenthesis opened by metamorphosis code
				generated_file.putchar (')');
			end;
			if type.is_boolean then
					-- macro EIF_TEST was generated
				generated_file.putchar (')');
			end
			release_hector_protection;
		end;
		
	generate_parameters_list is
			-- Generate the parameters list for C function call
		local
			expr: EXPR_B;
			i: INTEGER;
		do
			if parameters /= Void then
				from
					parameters.start;
					if has_arg_list then
						i := arg_list.lower;
					end;
				until
					parameters.after
				loop
					expr ?= parameters.item;	-- Cannot fail
						-- add cast before parameter
					if context.final_mode
						and then has_arg_list
						and then (special_id /= dll16_id) and (special_id /= dll32_id) then
						generated_file.putchar ('(');
						generated_file.putstring (arg_list.item (i));
						generated_file.putstring (") ");
					end;
					expr.print_register;
					if not parameters.islast then
						generated_file.putstring (gc_comma);
					end;
					parameters.forth;
					i := i + 1;
				end;
			end;
		end;

	release_hector_protection is
			-- Release all the hector variables
		local
			protect_b: PROTECT_B;
			nb_hector: INTEGER;
		do
			if parameters /= Void then
				from
					parameters.start;
				until
					parameters.after
				loop
					protect_b ?= parameters.item;
					if protect_b /= Void then
						nb_hector := nb_hector + 1;
					end;
					parameters.forth;
				end;
					-- Here is the trick: we have to release hector-protected
					-- variables. Hence the 'has_hector_variables' predicate
					-- is true, and no No_register propagation could occur.
					-- That means the generate part HAS to be a C expression,
					-- which make it possible to generate a ';' at the end
					-- followed by the hector removal instructions--RAM.
				if nb_hector > 0 then
					generated_file.putchar (';');
					generated_file.new_line;
					generated_file.putstring ("RTHF(");
					generated_file.putint (nb_hector);
					generated_file.putchar (')');
				end;
			end;
		end;

	fill_from (e: EXTERNAL_B) is
			-- Fill current from `e'
		local
			expr_b: EXPR_B;
			protect_b: PROTECT_B;
		do
			external_name := e.external_name;
			type := e.type;
			parameters := e.parameters;
			encapsulated := e.encapsulated;
			feature_id := e.feature_id;
			feature_name := e.feature_name;
			special_id := e.special_id;
			special_file_name := e.special_file_name;
			include_list := e.include_list;
			arg_list := e.arg_list;
			return_type := e.return_type;
			if parameters /= Void then
				from parameters.start;
				until parameters.after
				loop
					expr_b ?= parameters.item;	-- Cannot fail
						-- Ensure run-time protection for references which are
						-- not to be passed as 'raw', but protected via Hector.
						-- Unfortunately, the class which represents the '$'
						-- operator is named hector_b, hence the confusion.
					if expr_b.is_hector or not
						 real_type (expr_b.type).c_type.is_pointer
					then
						parameters.replace (expr_b.enlarged);
					else
						!!protect_b;
						protect_b.set_expr (expr_b.enlarged);
						parameters.replace (protect_b);
					end;
					parameters.forth;
				end;
			end;
		end;

	has_call: BOOLEAN is True;
			-- The expression has at least one call

	allocates_memory: BOOLEAN is True;

	has_hector_variables: BOOLEAN is
			-- Does the current external call make use of Hector ?
		local
			protect_b: PROTECT_B;
		do
			if parameters /= Void then
				from
					parameters.start;
				until
					Result or parameters.after
				loop
					protect_b ?= parameters.item;
					Result := protect_b /= Void;
					parameters.forth;
				end;
			end;
		end;

end

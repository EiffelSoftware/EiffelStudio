-- Enlarged access to an Eiffel feature

class FEATURE_BL 

inherit

	FEATURE_B
		rename
			free_register as access_free_register
		redefine
			is_feature_call, basic_register, generate_parameters_list,
			generate_access_on_type, is_polymorphic, has_call,
			set_register, register, set_parent, parent, generate_access,
			generate_on, analyze_on, analyze, generate_special_feature
		end;
	FEATURE_B
		redefine
			free_register,
			is_feature_call, basic_register, generate_parameters_list,
			generate_access_on_type, is_polymorphic, has_call,
			set_register, register, set_parent, parent, generate_access,
			generate_on, analyze_on, analyze, generate_special_feature
		select
			free_register
		end;
	SHARED_TABLE;
	SHARED_ENCODER;
	SHARED_DECLARATIONS;

feature 

	parent: NESTED_BL;
			-- Parent of access

	register: REGISTRABLE;
			-- In which register the expression is stored

	basic_register: REGISTRABLE;
			-- Register used to store the metamorphosed simple type

	set_register (r: REGISTRABLE) is
			-- Set current register to `r'
		do
			register := r;
		end;

	set_parent (p: NESTED_BL) is
			-- Assign `p' to `parent'
		do
			parent := p;
		end;

	is_feature_call: BOOLEAN is true;
			-- Access is a feature call

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
debug
io.error.putstring ("In feature_bl%N");
end;
			analyze_on (Current_register);
				-- Get a register if none were already propagated
			get_register;
debug
io.error.putstring ("Out feature_bl%N");
end;
		end;
	
	analyze_on (reg: REGISTRABLE) is
			-- Analyze feature call on `reg'
		local
			tmp_register: REGISTER;
			access_b: ACCESS_B;
		do
debug
io.error.putstring ("In feature_bl [analyze_on]: ");
io.error.putstring (feature_name);
io.error.new_line;
end;
			if context_type.is_basic then
					-- Get a register to store the metamorphosed basic type,
					-- on which the attribute access is made. The lifetime of
					-- this temporary is really short: just the time to make
					-- the call...
				!!tmp_register.make (Ref_type);
				basic_register := tmp_register;
			end;
			if parameters /= Void then
				-- If we have only one parameter and it is a single access to
				-- an attribute, then expand it in-line.
				if parameters.count = 1 then
					access_b ?= parameters.first;
					if access_b /= Void and then access_b.is_attribute then
						context.init_propagation;
						access_b.propagate (No_register);
					end;
				end;
				parameters.analyze;
				check_dt_current (reg);
					-- If No_register has been propagated, then this call will
					-- be expanded in line. It might be part of a more complex
					-- expression, hence temporary registers used by the
					-- parameters may not be released now.
				if not perused then
					free_param_registers;
				end;
			else
				check_dt_current (reg);
			end;
			if reg.is_current then
				context.mark_current_used;
			end;
debug
io.error.putstring ("Out feature_bl [analyze_on]: ");
io.error.putstring (feature_name);
io.error.new_line;
end;
		end;

	generate_special_feature (reg: REGISTRABLE) is
			-- Generate code for special routines (is_equal, copy ...).
		require else
			Valid_parameters: (parameters /= Void);
			One_parameter: parameters.count = 1;
			Special_rout_found: special_routines.found;
		local
			expr: EXPR_B;
		do
			reg.print_register;
			generated_file.putstring (" ");
			generated_file.putstring (special_routines.c_operation);
			generated_file.putstring (" ");
			expr ?= parameters.first; -- Cannot fail
			expr.print_register;
		end;

	generate_access is
			-- Generate access for a feature in current
		do
			generate_on (Current_register);
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
			type_i := context_type;
			class_type ?= type_i;
			entry := Eiffel_table.item_id (rout_id);
			is_polymorphic_access := not type_i.is_basic and then
					class_type /= Void and then
					entry /= Void and then
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

	is_polymorphic: BOOLEAN is
			-- Is access polymorphic ?
		local
			entry: POLY_TABLE [ENTRY];
			class_type: CL_TYPE_I;
			type_i: TYPE_I;
		do
			entry := Eiffel_table.item_id (rout_id);
			type_i := context_type;
			if not (type_i.is_basic or entry = Void) then
				class_type ?= type_i;	-- Cannot fail
				Result := entry.is_polymorphic (class_type.type_id);
			end;
		end;

	generate_on (reg: REGISTRABLE) is
			-- Generate call of feature on `reg'
		do
			do_generate (reg);
		end;

	generate_access_on_type (reg: REGISTRABLE; typ: CL_TYPE_I) is
			-- Generate feature call in a `typ' context
		local
			internal_name, table_name: STRING;
			entry: POLY_TABLE [ENTRY];
			rout_table: ROUT_TABLE;
		do
			entry := Eiffel_table.item_id (rout_id);
			if entry = Void then
					-- Call to a deferred feature without implementation
				generated_file.putchar ('(');
				real_type (type).c_type.generate_function_cast (generated_file);
				generated_file.putstring (" RTNR)");
			elseif entry.is_polymorphic (typ.type_id) then
					-- The call is polymorphic, so generate access to the
					-- routine table. The dereferenced function pointer has
					-- to be enclosed in parenthesis.
				table_name := Encoder.table_name (rout_id).twin;
				generated_file.putchar ('(');
				real_type (type).c_type.generate_function_cast (generated_file);
				generated_file.putchar ('(');
				generated_file.putstring (table_name);
				generated_file.putchar ('-');
				generated_file.putint (entry.min_used - 1);
				generated_file.putchar (')');
				if reg.is_current then
					if context.dt_current > 1 then
						generated_file.putstring ("[dtype])");
					else
						generated_file.putstring ("[Dtype(");
						context.Current_register.print_register_by_name;
						generated_file.putstring (")])");
					end;
				else
					generated_file.putstring ("[Dtype(");
					reg.print_register;
					generated_file.putstring (")])");
				end;
					-- Mark routine id used
				Eiffel_table.mark_used (rout_id);
					-- Remember extern declaration
				Extern_declarations.add_routine_table (table_name);
			else
					-- The call is not polymorphic in the given context,
					-- so the name can be hardwired, unless we access a
					-- deferred feature in which case we have to be careful
					-- and get the routine name of the first entry in the
					-- routine table.
				rout_table ?= entry;
				internal_name := rout_table.feature_name (typ.type_id).twin;
				generated_file.putstring (internal_name);
					-- Remember extern routine declaration
				Extern_declarations.add_routine
							(real_type (type).c_type, internal_name);
			end;
		end;
		
	generate_parameters_list is
			-- Generate the parameters list for C function call
		local
			expr: EXPR_B;
		do
			if parameters /= Void then
				from
					parameters.start;
				until
					parameters.after
				loop
					expr ?= parameters.item;	-- Cannot fail
					generated_file.putstring (", ");
					expr.print_register;
					parameters.forth;
				end;
			end;
		end;

	fill_from (f: FEATURE_B) is
			-- Fill in node with feature `f'
		do
			feature_name := f.feature_name;
			feature_id := f.feature_id;
			type := f.type;
			parameters := f.parameters;
			if parameters /= Void then
				from
					parameters.start;
				until
					parameters.after
				loop
					parameters.put (parameters.item.enlarged);
					parameters.forth;
				end;
			end;
		end;

	has_call: BOOLEAN is true;
			-- The expression as at least one call

end

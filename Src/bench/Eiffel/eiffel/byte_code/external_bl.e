-- Enlarged access to a C external

class EXTERNAL_BL

inherit
	EXTERNAL_B
		redefine
			free_register,
			generate_parameters_list, generate_access_on_type,
			release_hector_protection, basic_register, has_hector_variables,
			has_call, current_needed_for_access, set_parent, parent,
			set_register, register, generate_access, generate_on,
			analyze_on, analyze, generate_end, allocates_memory,
			generate_metamorphose_end
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
			{EXTERNAL_B} Precursor;
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
				!!tmp_register.make (Reference_c_type);
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
			type_i: TYPE_I;
			class_type: CL_TYPE_I;
			access: ACCESS_B;
			void_register: REGISTER;
			is_polymorphic_access: BOOLEAN;
		do
			type_i := context_type;
			class_type ?= type_i;
			is_polymorphic_access := not type_i.is_basic and then
					class_type /= Void and then
					Eiffel_table.is_polymorphic (routine_id, class_type.type_id, True) >= 0;
			if reg.is_current and is_polymorphic_access then
				context.add_dt_current;
				context.mark_current_used
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
			do_generate (Current_register);
		end;

	generate_on (reg: REGISTRABLE) is
			-- Generate call of feature on `reg'
		do
			do_generate (reg);
		end;

	generate_access_on_type (reg: REGISTRABLE; typ: CL_TYPE_I) is
			-- Generate external call in a `typ' context
		local
			table_name: STRING;
			is_boolean: BOOLEAN;
			type_c: TYPE_C
			buf: GENERATION_BUFFER
			array_index: INTEGER
			local_argument_types: ARRAY [STRING]
		do
			check
				final_mode: context.final_mode
				extension_not_void: encapsulated implies extension /= Void
			end;
			is_boolean := type.is_boolean;

			type_c := real_type (type).c_type;
			buf := buffer

			array_index := Eiffel_table.is_polymorphic (routine_id, typ.type_id, True)
			if array_index >= 0 then
					-- The call is polymorphic, so generate access to the
					-- routine table. The dereferenced function pointer has
					-- to be enclosed in parenthesis.
				table_name := Encoder.table_name (routine_id)

				if is_boolean then
					buf.putstring ("EIF_TEST((");
				else
					buf.putchar ('(');
				end;
				if
					not encapsulated and then
					extension /= Void and then
					extension.has_arg_list
				then
					type_c.generate_external_function_cast (buf, extension)
					extension.generate_header_files
				else
					type_c.generate_function_cast (buf, argument_types)
				end
				buf.putchar ('(');
				buf.putstring (table_name);
				buf.putchar ('-');
				buf.putint (array_index);
				buf.putchar (')');
				buf.putchar ('[');
				if reg.is_current then
					context.generate_current_dtype;
				else
					buf.putstring (gc_upper_dtype_lparan);
					reg.print_register;
					buf.putchar (')');
				end;
				buf.putchar (']');
				buf.putchar (')');
					-- Mark routine table used.
				Eiffel_table.mark_used (routine_id);
					-- Remember external routine table declaration
				Extern_declarations.add_routine_table (table_name);
			else
					-- The call is not polymorphic in the given context,
					-- so the name can be hardwired.
				if encapsulated then
					if is_boolean then
						buf.putstring ("EIF_TEST(");
					else
						if extension.has_return_type then
							type_c.generate_cast (buf);
						end
					end;
					extension.generate_header_files

						-- Generate the right name to call the external
						-- In the case of a signature or a macro, the call will be direct
						-- In the case of a dll, the encapsulation will be called (encoded name)
					extension.generate_external_name (buf, external_name, typ, type_c);
				else
					if is_boolean then
						buf.putstring ("EIF_TEST(");
					end
					if
						extension /= Void and then
						extension.has_include_list
					then
						extension.generate_header_files
						if extension.has_return_type then
							type_c.generate_cast (buf);
						end
						buf.putstring (external_name);
					else
						if extension /= Void and then extension.has_signature then
							if extension.has_return_type then
								type_c.generate_cast (buf);
							end

								-- Generate the right name to call the external
								-- In the case of a signature or a macro, the call will be direct
								-- In the case of a dll, the encapsulation will be called (encoded name)
							extension.generate_external_name (buf, external_name, typ, type_c);
						else
							local_argument_types := argument_types
							buf.putchar ('(')
							type_c.generate_function_cast (buf, local_argument_types);
							buf.putstring (external_name);
							buf.putchar (')')
								-- Remember external routine declaration
							Extern_declarations.add_routine_with_signature (type_c,
															external_name, local_argument_types);
						end
					end;
				end;
			end;
		end;

	generate_end (gen_reg: REGISTRABLE; class_type: CL_TYPE_I; is_class_separate: BOOLEAN) is
			-- Generate final portion of C code.
		local
			is_macro_extension: BOOLEAN
			is_struct_extension: BOOLEAN
			is_cpp_extension: BOOLEAN
			final_mode: BOOLEAN
			not_polymorphic: BOOLEAN
			cpp_ext: CPP_EXTENSION_I
			struct_ext: STRUCT_EXTENSION_I
			buf: GENERATION_BUFFER
		do
			if encapsulated then
				is_struct_extension := extension.is_struct
				is_macro_extension := extension.is_macro
				is_cpp_extension := extension.is_cpp
			end
			final_mode := context.final_mode

			generate_access_on_type (gen_reg, class_type);
				-- Now generate the parameters of the call, if needed.
			buf := buffer
			if final_mode then
				not_polymorphic := Eiffel_table.is_polymorphic (routine_id, class_type.type_id, True) < 0

				if is_macro_extension then
					if not not_polymorphic or else parameters /= Void then
						buf.putchar ('(')
						if parameters /= Void then
							extension.generate_parameter_list (parameters)
						end
						buf.putchar (')')
					end
					if not_polymorphic and extension.has_return_type then
							-- Opening `(' is generated from MACRO_EXTENSION_I in
							-- generate_external_name.
						buf.putchar (')');
					end
				elseif is_struct_extension and then not_polymorphic then
					struct_ext ?= extension
					struct_ext.generate_struct_access (buf, external_name, parameters)
				elseif is_cpp_extension and then not_polymorphic then
					cpp_ext ?= extension
					cpp_ext.generate (external_name, parameters)
				else
					buf.putchar ('(')
					generate_parameters_list;
					buf.putchar (')')
				end
			else
				buf.putchar ('(')
				generate_parameters_list;
				buf.putchar (')')
					
			end

			if type.is_boolean then
					-- macro EIF_TEST was generated
				buf.putchar (')');
			end
		end;

	generate_metamorphose_end (gen_reg, meta_reg: REGISTRABLE; class_type: CL_TYPE_I;
		basic_type: BASIC_I; buf: GENERATION_BUFFER) is
			-- Generate final portion of C code.
		local
			is_class_separate: BOOLEAN
		do
			is_class_separate := class_type.is_separate

			generate_end (gen_reg, class_type, is_class_separate)

				-- Now generate the parameters of the call, if needed.
			if not is_class_separate then
				buf.putchar (')');
				basic_type.end_of_metamorphose (basic_register, meta_reg, buf)
			end

			if type.is_boolean then
					-- macro EIF_TEST was generated
				buf.putchar (')');
			end
		end

	generate_parameters_list is
			-- Generate the parameters list for C function call
		local
			expr: EXPR_B;
			ext: like extension
			buf: GENERATION_BUFFER
		do
			ext := extension

			if ext /= Void and then not encapsulated then
				ext.generate_parameter_list (parameters)
			elseif parameters /= Void then
				from
					buf := buffer
					parameters.start;
				until
					parameters.after
				loop
					expr := parameters.item;	-- Cannot fail
					expr.print_register;
					if not parameters.islast then
						buf.putstring (gc_comma);
					end;
					parameters.forth;
				end;
			end;
		end;

	release_hector_protection is
			-- Release all the hector variables
		local
			protect_b: PROTECT_B;
			nb_hector: INTEGER;
			buf: GENERATION_BUFFER
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
					buf := buffer
					buf.putchar (';');
					buf.new_line;
					buf.putstring ("RTHF(");
					buf.putint (nb_hector);
					buf.putchar (')');
				end;
			end;
		end;

	fill_from (e: EXTERNAL_B) is
			-- Fill current from `e'
		local
			expr_b: PARAMETER_B;
			protect_b: PROTECT_B;
		do
			external_name_id := e.external_name_id;
			type := e.type;
			parameters := e.parameters;
			encapsulated := e.encapsulated;
			extension := e.extension;
			feature_id := e.feature_id;
			feature_name_id := e.feature_name_id;
			routine_id := e.routine_id
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

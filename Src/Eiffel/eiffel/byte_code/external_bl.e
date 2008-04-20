indexing
	description: "Enlarged access to a C external"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class EXTERNAL_BL

inherit
	EXTERNAL_B
		redefine
			free_register,
			generate_parameters_list, generate_access_on_type,
			basic_register,
			has_call, current_needed_for_access, set_parent, parent,
			set_register, register, generate_access, generate_on,
			analyze_on, analyze, generate_end, allocates_memory,
			is_polymorphic, has_one_signature
		end;

	SHARED_TABLE;

	SHARED_DECLARATIONS;

	EXTERNAL_CONSTANTS;

	SHARED_TYPE_I
		export
			{NONE} all
		end

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

	current_needed_for_access: BOOLEAN is False;
			-- Current is not needed to call an external

	free_register is
			-- Free registers
		do
			Precursor {EXTERNAL_B};
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
				create tmp_register.make (Reference_c_type);
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
			if reg.is_current and then (encapsulated or not extension.is_static) then
				context.mark_current_used
			end
		end;

	check_dt_current (reg: REGISTRABLE) is
			-- Check whether we need to compute the dynamic type of current
			-- and call context.add_dt_current accordingly. The parameter
			-- `reg' is the entity on which the access is made.
		local
			type_i: TYPE_A;
			class_type: CL_TYPE_A;
			access: ACCESS_B;
			void_register: REGISTER;
			is_polymorphic_access: BOOLEAN;
		do
			type_i := context_type;
			class_type ?= type_i;
			is_polymorphic_access := not is_static_call and then
					not type_i.is_basic and then
					class_type /= Void and then
					Eiffel_table.is_polymorphic (routine_id, class_type,  context.context_class_type,True) >= 0;
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

	is_polymorphic: BOOLEAN is
			-- Is access polymorphic ?
		local
			class_type: CL_TYPE_A
			type_i: TYPE_A
		do
			type_i := context_type
			if not type_i.is_basic and then static_class_type = Void then
				class_type ?= type_i -- Cannot fail
				Result := Eiffel_table.is_polymorphic (routine_id, class_type, context.context_class_type, True) >= 0
			end
		end

	has_one_signature: BOOLEAN is
			-- <Precursor>
		do
			Result := Eiffel_table.poly_table (routine_id).has_one_signature
		end

	generate_access_on_type (reg: REGISTRABLE; typ: CL_TYPE_A) is
			-- Generate external call in a `typ' context
		local
			table_name: STRING;
			type_c: TYPE_C
			l_type_i: TYPE_A
			l_typ: CL_TYPE_A
			buf: GENERATION_BUFFER
			array_index: INTEGER
			local_argument_types, real_arg_types: like argument_types
			rout_table: ROUT_TABLE
			internal_name: STRING
			inline_ext: INLINE_EXTENSION_I
			return_type_string: STRING
		do
			check
				final_mode: context.final_mode
			end

			l_type_i := real_type (type)
			type_c := l_type_i.c_type;
			buf := buffer

			if is_static_call then
					-- No polymorphic here, set `array_index' to not go to the
					-- polymorphic call handling.
				array_index := -1
			else
				array_index := Eiffel_table.is_polymorphic (routine_id, typ, context.context_class_type, True)
			end
			if array_index >= 0 then
					-- The call is polymorphic, so generate access to the
					-- routine table. The dereferenced function pointer has
					-- to be enclosed in parenthesis.
				table_name := Encoder.routine_table_name (routine_id)

					-- It is pretty important that we use `actual_type.is_formal' and not
					-- just `is_formal' because otherwise if you have `like x' and `x: G'
					-- then we would fail to detect that.
				if
					system.seed_of_routine_id (routine_id).type.actual_type.is_formal and then
					l_type_i.is_basic and then not has_one_signature
				then
						-- Feature returns a reference that need to be used as a basic one.
					buf.put_character ('*')
					type_c.generate_access_cast (buf)
					type_c := reference_c_type
				end

				buf.put_character ('(');
				type_c.generate_function_cast (buf, argument_types, False)

					-- Generate following dispatch:
					-- table [Actual_offset - base_offset]
				buf.put_string (table_name);
				buf.put_character ('[');
				if reg.is_current then
					context.generate_current_dtype;
				else
					buf.put_string (gc_upper_dtype_lparan);
					reg.print_register;
					buf.put_character (')');
				end;
				buf.put_character ('-');
				buf.put_integer (array_index);
				buf.put_character (']');

				buf.put_character (')');

					-- Mark routine table used.
				Eiffel_table.mark_used (routine_id);
					-- Remember external routine table declaration
				Extern_declarations.add_routine_table (table_name);
			else
					-- The call is not polymorphic in the given context,
					-- so the name can be hardwired. If we check assertions, we need
					-- to call associated encapsulation.

					-- In the case of encapsulated externals, we call the associated
					-- encapsulation.
				if encapsulated or else system.keep_assertions or else extension.is_inline then
					rout_table ?= Eiffel_table.poly_table (routine_id)
					if is_static_call then
						l_typ ?= real_type (static_class_type)
						check
							l_typ_not_void: l_typ /= Void
						end
						rout_table.goto_implemented (l_typ, context.context_class_type)
					else
						rout_table.goto_implemented (typ, context.context_class_type)
					end
					check
						is_valid_routine: rout_table.is_implemented
					end
					internal_name := rout_table.feature_name

					local_argument_types := argument_types

					if inline_needed (typ) then
						inline_ext ?= extension
						create real_arg_types.make (local_argument_types.lower, local_argument_types.upper-1)
						if real_arg_types.count > 0 then
							real_arg_types.subcopy (local_argument_types, 2, local_argument_types.upper, 1)
						end

						inline_ext.force_inline_def (l_type_i, internal_name, real_arg_types)
					else
						real_arg_types := local_argument_types
					end

					if
						not (rout_table.item.written_type_id = Context.original_class_type.type_id) and
						inline_ext = Void
					then
							-- Remember extern routine declaration if not written in same class. But no need
							-- doing this for an inline C/C++ since the code of the inline routine will be
							-- generated again.
						if context.workbench_mode then
							return_type_string := "EIF_TYPED_VALUE"
						else
							return_type_string := type_c.c_string
						end
						Extern_declarations.add_routine_with_signature (return_type_string,
								internal_name, local_argument_types)
					end

					if inline_ext /= Void then
							-- No need for a function cast since the inline routine is defined
							-- prior to the call.
						buf.put_string (inline_ext.inline_name (internal_name))
					else
						buf.put_string (internal_name)
					end
				else
					if not l_type_i.is_void then
						type_c.generate_cast (buf);
					end
						 -- Nothing to be done now. Remaining of code generation will be done
						 -- in `generate_end'.
				end
			end
		end

	inline_needed (typ: CL_TYPE_A): BOOLEAN is
		do
			Result := context.final_mode and
				not (encapsulated or else system.keep_assertions) and (is_static_call or
				Eiffel_table.is_polymorphic (routine_id, typ, context.context_class_type, True) < 0)
		end

	generate_end (gen_reg: REGISTRABLE; class_type: CL_TYPE_A) is
			-- Generate final portion of C code.
		local
			cpp_ext: CPP_EXTENSION_I
			macro_ext: MACRO_EXTENSION_I
			struct_ext: STRUCT_EXTENSION_I
			c_ext: C_EXTENSION_I
			l_built_in: BUILT_IN_EXTENSION_I
			buf: GENERATION_BUFFER
			l_type: TYPE_A
			l_args: like argument_types
			put_eif_test: BOOLEAN
		do
			buf := buffer
			l_type := real_type (type)
			put_eif_test := extension.is_inline and l_type.is_boolean
			if put_eif_test then
				buf.put_string ("EIF_TEST (")
			end
			generate_access_on_type (gen_reg, class_type)
				-- Now generate the parameters of the call, if needed.
			if inline_needed (class_type) then
				check
					not_dll: not extension.is_dll
				end
				if extension.is_macro then
					macro_ext ?= extension
					macro_ext.generate_access (external_name, parameters, l_type)
				elseif extension.is_struct then
					struct_ext ?= extension
					struct_ext.generate_access (external_name, parameters, l_type)
				elseif extension.is_inline then
					buf.put_character ('(')
					generate_parameters_list
					buf.put_character (')')
				elseif extension.is_cpp then
					cpp_ext ?= extension
					cpp_ext.generate_access (external_name, parameters, l_type)
				elseif extension.is_built_in then
					l_built_in ?= extension
					l_built_in.generate_access (external_name, written_in, gen_reg, parameters, l_type)
				else
					c_ext ?= extension
					check
						is_c_extension: c_ext /= Void
					end
						-- Remove `Current' from argument types.
					l_args := argument_types
					if argument_types.count > 1 then
						l_args := l_args.subarray (l_args.lower + 1, l_args.upper)
					else
						create l_args.make (1, 0)
					end
					c_ext.generate_access (external_name, parameters, l_args, l_type)
				end
			else
					-- Call is done like a normal Eiffel routine call.
				generate_parameters_part (gen_reg)
			end

			if put_eif_test then
				buf.put_string (")")
			end
		end

	generate_parameters_part (gen_reg: REGISTRABLE) is
		local
			buf: GENERATION_BUFFER
		do
			buf := buffer
			buf.put_character ('(')
			gen_reg.print_register
			if parameters /= Void and parameters.count > 0 then
				buf.put_string (gc_comma)
				generate_parameters_list
			end
			buf.put_character (')')
		end

	generate_parameters_list is
			-- Generate the parameters list for C function call
		local
			buf: GENERATION_BUFFER
			first: BOOLEAN
		do
			if parameters /= Void then
				from
					buf := buffer
					parameters.start
					first := True
				until
					parameters.after
				loop
					if not first then
						buf.put_string (gc_comma)
					else
						first := False
					end
					parameters.item.print_register
					parameters.forth
				end
			end
		end

	fill_from (e: EXTERNAL_B) is
			-- Fill current from `e'
		local
			expr_b: PARAMETER_B;
			l_encapsulated: BOOLEAN
		do
			multi_constraint_static := e.multi_constraint_static
			is_static_call := e.is_static_call
			static_class_type := e.static_class_type
			written_in := e.written_in
			external_name_id := e.external_name_id;
			type := e.type;
			set_parameters (e.parameters)
			l_encapsulated := e.encapsulated
			extension := e.extension;
			feature_id := e.feature_id;
			feature_name_id := e.feature_name_id;
			routine_id := e.routine_id
			if parameters /= Void then
				from
					parameters.start
				until
					parameters.after
				loop
					expr_b ?= parameters.item
					parameters.replace (expr_b.enlarged);
					if
						not l_encapsulated and then
						(not expr_b.is_hector and real_type (expr_b.type).c_type.is_pointer)
					then
							-- We are handling an external whose parameter's type is not an
							-- Eiffel basic type. We will need to call the encapsulated version as
							-- this is the one that will perform the protection of Eiffel
							-- references.
						l_encapsulated := True
					end
					parameters.forth;
				end
			end
			encapsulated := l_encapsulated
		end;

	has_call: BOOLEAN is True;
			-- The expression has at least one call

	allocates_memory: BOOLEAN is True;

indexing
	copyright:	"Copyright (c) 1984-2007, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end

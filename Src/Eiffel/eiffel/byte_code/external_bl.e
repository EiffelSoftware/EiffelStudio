note
	description: "Enlarged access to a C external"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class EXTERNAL_BL

inherit
	EXTERNAL_B
		undefine
			analyze,
			basic_register,
			free_register,
			generate_access,
			generate_on,
			generate_parameters,
			has_one_signature,
			is_polymorphic,
			register,
			set_parent,
			set_register
		redefine
			analyze_on,
			current_needed_for_access,
			generate_access_on_type,
			generate_parameters_list,
			generate_end,
			parent
		end

	ROUTINE_BL
		rename
			precursor_type as static_class_type,
			set_precursor_type as set_static_class_type
		redefine
			parent
		end

	SHARED_TABLE

	SHARED_DECLARATIONS

	EXTERNAL_CONSTANTS

	SHARED_TYPE_I
		export
			{NONE} all
		end

feature -- Access

	parent: NESTED_BL
			-- <Precursor>

feature

	current_needed_for_access: BOOLEAN = False
			-- Current is not needed to call an external.

	analyze_on (reg: REGISTRABLE)
			-- Analyze call on an entity held in `reg`.
		do
			if context_type.is_basic and then
				attached {BASIC_A} context_type as basic_i and then
				not is_feature_special (True, basic_i)
			then
					-- Get a register to store the metamorphosed basic type,
					-- on which the attribute access is made. The lifetime of
					-- this temporary is really short: just the time to make
					-- the call...
				create {REGISTER} basic_register.make (Reference_c_type)
			end
			if parameters /= Void then
				parameters.analyze
					-- If No_register has been propagated, then this call will
					-- be expanded in line. It might be part of a more complex
					-- expression, hence temporary registers used by the
					-- parameters may not be released now.
				check_dt_current (reg)
				if not perused then
					free_param_registers
				end
			else
				check_dt_current (reg)
			end
			if reg.is_current and then (encapsulated or not extension.is_static) then
				context.mark_current_used
			end
		end

	check_dt_current (reg: REGISTRABLE)
			-- Check whether we need to compute the dynamic type of current
			-- and call context.add_dt_current accordingly. The parameter
			-- `reg' is the entity on which the access is made.
		local
			type_i: TYPE_A
			is_polymorphic_access: BOOLEAN
		do
			type_i := context_type
			is_polymorphic_access :=
				not is_static_call and then
				not type_i.is_basic and then
				Eiffel_table.is_polymorphic_for_body (routine_id, type_i, context.context_class_type) >= 0
			if reg.is_current and is_polymorphic_access then
				context.add_dt_current
				context.mark_current_used
			end
			if
				not reg.is_predefined and
				is_polymorphic_access and then
				attached {ACCESS_B} reg as access and then
				access.register = No_register
			then
					-- BEWARE!! The function call is polymorphic hence we'll
					-- need to evaluate `reg' twice: once to get its dynamic
					-- type and once as a parameter for Current. Hence we
					-- must make sure it is not held in a No_register--RAM.
				access.set_register (Void)
				access.get_register
			end
		end

	generate_access_on_type (reg: REGISTRABLE; typ: CL_TYPE_A)
			-- Generate external call in a `typ' context
		local
			internal_name: STRING
			table_name: STRING
			type_i: TYPE_A
			type_c: TYPE_C
			buf: GENERATION_BUFFER
			array_index: INTEGER
			context_entry: ROUT_ENTRY
			local_argument_types: like argument_types
			real_arg_types: like argument_types
			is_trampoline: BOOLEAN
			context_type_id: INTEGER
		do
			check
				final_mode: context.final_mode
			end
			buf := buffer
			type_i := real_type (type)
			type_c := type_i.c_type
			array_index :=
				if is_static_call then
					-1
				else
					Eiffel_table.is_polymorphic_for_body (routine_id, typ, context.context_class_type)
				end
			if array_index = -2 then
					-- There is no feature to call.
				generate_no_call
			elseif array_index >= 0 then
					-- The call is polymorphic, so generate access to the
					-- routine table. The dereferenced function pointer has
					-- to be enclosed in parenthesis.
				generate_nested_flag (not is_static_call)
				table_name := Encoder.routine_table_name (routine_id)
					-- It is pretty important that we use `actual_type.is_formal' and not
					-- just `is_formal' because otherwise if you have `like x' and `x: G'
					-- then we would fail to detect that.
				if
					system.seed_of_routine_id (routine_id).type.actual_type.is_formal and then
					type_i.is_basic and then not has_one_signature
				then
						-- Feature returns a reference that needs to be used as a basic one.
					buf.put_character ('*')
					type_c.generate_access_cast (buf)
					type_c := reference_c_type
				end

				buf.put_character ('(')
				type_c.generate_function_cast (buf, argument_types, False)

					-- Generate following dispatch:
					-- table [Actual_offset - base_offset]
				buf.put_string (table_name)
				buf.put_character ('[')
				if reg.is_current then
					context.generate_current_dtype
				else
					buf.put_string ({C_CONST}.dtype)
					buf.put_character ('(')
					reg.print_register
					buf.put_character (')')
				end
				buf.put_character ('-')
				buf.put_integer (array_index)
				buf.put_two_character (']', ')')

					-- Mark routine id used.
				Eiffel_table.mark_used (routine_id)
					-- Remember routine table declaration.
				Extern_declarations.add_routine_table (table_name)
			elseif
				attached {ROUT_TABLE} Eiffel_table.poly_table (routine_id) as rout_table and then
				(is_encapsulation_required or else extension.is_inline)
			then
					-- The call is not polymorphic in the given context,
					-- so the name can be hardwired. If we check assertions, we need
					-- to call associated encapsulation.
					-- In the case of encapsulated externals, we call the associated
					-- encapsulation.
				context_type_id := typ.type_id (context.context_cl_type.generic_derivation)
				if attached effective_entry (typ, context_type_id, rout_table) as entry then
					context_entry := rout_table.context_item
					if entry.pattern_id /= context_entry.pattern_id then
							-- A trampoline is required to adapt argument and/or result type.
						is_trampoline := True
						internal_name := rout_table.trampoline_name (entry, context_entry)
						system.request_trampoline (entry, context_entry, rout_table)
					else
						internal_name := entry.routine_name
					end

					local_argument_types := argument_types

					if
						inline_needed (typ) and then
							-- Obtain the extension of the found entry, not of the original feature
						attached system.class_of_id (entry.class_id) as c and then
						attached c.feature_of_feature_id (entry.feature_id) as f and then
						attached {INLINE_EXTENSION_I} f.extension as inline_ext
					then
						if local_argument_types.count > 1 then
							real_arg_types := local_argument_types.subarray (local_argument_types.lower + 1, local_argument_types.upper)
							real_arg_types.rebase (1)
						else
							create real_arg_types.make_empty
						end
						inline_ext.force_inline_def (type_i, internal_name, real_arg_types)
							-- No need for a function cast since the inline routine is defined
							-- prior to the call.
						internal_name := inline_ext.inline_name (internal_name)
					elseif entry.access_type_id /= Context.original_class_type.type_id or else is_trampoline then
							-- Remember extern routine declaration if not written in the same class or if a trampoline is used.
							-- No need doing this for an inline C/C++ since the code of the inline routine will be generated again.
						Extern_declarations.add_routine_with_signature
							(type_c.c_string, internal_name, local_argument_types)
					end
					generate_nested_flag (not is_static_call)
					buf.put_string (internal_name)
				else
						-- There is no feature to call.
					generate_no_call
				end
			elseif not type_i.is_void then
				type_c.generate_cast (buf)
					 -- Nothing to be done now. Remaining of code generation will be done
					 -- in `generate_end'.
			end
		end

	inline_needed (typ: CL_TYPE_A): BOOLEAN
		do
			Result := context.final_mode and
				not is_encapsulation_required and (is_static_call or
				Eiffel_table.is_polymorphic_for_body (routine_id, typ, context.context_class_type) < 0)
		end

	generate_end (gen_reg: REGISTRABLE; class_type: CL_TYPE_A)
			-- Generate final portion of C code.
		local
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
			if not is_deferred.item then
				if inline_needed (class_type) then
					check
						not_dll: not extension.is_dll
					end
					if attached {MACRO_EXTENSION_I} extension as macro_ext then
						macro_ext.generate_access (external_name, parameters, l_type)
					elseif attached {STRUCT_EXTENSION_I} extension as struct_ext then
						struct_ext.generate_access (external_name, parameters, l_type)
					elseif extension.is_inline then
						buf.put_character ('(')
						generate_parameters_list
						buf.put_character (')')
					elseif attached {CPP_EXTENSION_I} extension as cpp_ext then
						cpp_ext.generate_access (external_name, parameters, l_type)
					elseif attached {BUILT_IN_EXTENSION_I} extension as built_in_ext then
						built_in_ext.generate_access (external_name, written_in, gen_reg, parameters, l_type)
					elseif attached {C_EXTENSION_I} extension as c_ext then
							-- Remove `Current' from argument types.
						l_args := argument_types
						if argument_types.count > 1 then
							l_args := l_args.subarray (l_args.lower + 1, l_args.upper)
						else
							create l_args.make_empty
						end
						c_ext.generate_access (external_name, parameters, l_args, l_type)
					else
						check
							is_expected_extension: False
						end
					end
				else
						-- Call is done like a normal Eiffel routine call.
					generate_parameters_part (gen_reg)
				end
			end
			if put_eif_test then
				buf.put_character (')')
			end
			if is_right_parenthesis_needed.item then
				buf.put_character (')')
			end
		end

	generate_parameters_part (gen_reg: REGISTRABLE)
		local
			buf: GENERATION_BUFFER
		do
			buf := buffer
			buf.put_character ('(')
			gen_reg.print_register
			if parameters /= Void and parameters.count > 0 then
				buf.put_string ({C_CONST}.comma_space)
				generate_parameters_list
			end
			buf.put_character (')')
		end

	generate_parameters_list
			-- Generate the parameters list for C function call.
		local
			buf: GENERATION_BUFFER
			l_area: SPECIAL [EXPR_B]
			i, nb: INTEGER
			has_delimiter: BOOLEAN
		do
			if
				not is_deferred.item and then
				attached parameters as p
			then
				buf := buffer
				l_area := p.area
				nb := p.count
				from
				until
					i = nb
				loop
					if has_delimiter then
						buf.put_string ({C_CONST}.comma_space)
					else
						has_delimiter := True
					end
					l_area [i].print_register
					i := i + 1
				end
			end
		end

	fill_from (e: EXTERNAL_B)
			-- Fill current from `e'
		local
			expr_b: PARAMETER_B
			l_encapsulated: BOOLEAN
			l_is_built_in: BOOLEAN
		do
			multi_constraint_static := e.multi_constraint_static
			is_static_call := e.is_static_call
			static_class_type := e.static_class_type
			written_in := e.written_in
			external_name_id := e.external_name_id
			type := e.type
			set_parameters (e.parameters)
			l_encapsulated := e.encapsulated
			extension := e.extension
			l_is_built_in := extension.is_built_in
			feature_id := e.feature_id
			feature_name_id := e.feature_name_id
			routine_id := e.routine_id
			if parameters /= Void then
				from
					parameters.start
				until
					parameters.after
				loop
					expr_b := parameters.item
					parameters.replace (expr_b.enlarged)
					if
						(not l_is_built_in and not l_encapsulated) and then
						(not expr_b.is_hector and real_type (expr_b.type).c_type.is_reference)
					then
							-- We are handling an external whose parameter's type is not an
							-- Eiffel basic type. We will need to call the encapsulated version as
							-- this is the one that will perform the protection of Eiffel
							-- references.
						l_encapsulated := True
					end
					parameters.forth
				end
			end
			encapsulated := l_encapsulated
		end

feature {NONE} -- Status report

	is_encapsulation_required: BOOLEAN
			-- Shall an encapsulation be called rather than an inlined version?
		local
			t: TYPE_A
		do
			if encapsulated or else system.keep_assertions then
				Result := True
			else
				t := type.instantiated_in (context.current_type)
				if
					t.is_true_expanded or else
					(not t.is_expanded and then
					(t.is_attached or else
					t.is_formal or else
					t.is_like and then not t.is_like_current and then not t.is_like_argument))
				then
						-- The external routine requires a check that the result is attached.
					Result := True
				end
			end
		end

note
	copyright:	"Copyright (c) 1984-2019, Eiffel Software"
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
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end

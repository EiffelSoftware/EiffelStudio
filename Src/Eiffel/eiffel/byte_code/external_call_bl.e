note
	description: "A finalized node for a monomorphic external feature call."

class EXTERNAL_CALL_BL

inherit
	EXTERNAL_B
		undefine
			analyze,
			basic_register,
			call_kind,
			free_register,
			generate_access,
			generate_on,
			generate_parameters,
			has_one_signature,
			is_polymorphic,
			is_temporary,
			register,
			set_call_kind,
			set_parent,
			set_register
		redefine
			analyze_on,
			current_needed_for_access,
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

	EXTERNAL_CONSTANTS

	SHARED_TYPE_I
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Creation

	make (other: EXTERNAL_B; e: like routine_entry)
			-- Initialize from `other` with a direct feature call entry `e`.
		require
			context.final_mode
		local
			expr_b: PARAMETER_B
			l_encapsulated: BOOLEAN
			l_is_built_in: BOOLEAN
		do
			if attached other.static_class_type as s then
				static_class_type := s
				call_kind := call_kind_unqualified
			else
				call_kind := call_kind_qualified
			end
			multi_constraint_static := other.multi_constraint_static
			static_class_type := other.static_class_type
			written_in := other.written_in
			external_name_id := other.external_name_id
			type := other.type
			set_parameters (other.parameters)
			l_encapsulated := other.encapsulated
			extension := other.extension
			l_is_built_in := extension.is_built_in
			feature_id := other.feature_id
			feature_name_id := other.feature_name_id
			routine_id := other.routine_id
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
			routine_entry := e
		ensure
			routine_entry = e
		end

feature -- Access

	parent: NESTED_BL
			-- <Precursor>

feature {NONE} -- Access

	routine_entry: ROUT_ENTRY
			-- A routine entry associated with the feature to be called.

feature

	current_needed_for_access: BOOLEAN
			-- Current is not needed to call an external unless it is wrapped.
		do
			Result := not extension.is_static
		end

	analyze_on (r: REGISTRABLE)
			-- Analyze call on an entity held in `r`.
		do
			analyze_non_object_call_target
			analyze_basic_type
			if parameters /= Void then
				parameters.analyze
					-- If No_register has been propagated, then this call will
					-- be expanded in line. It might be part of a more complex
					-- expression, hence temporary registers used by the
					-- parameters may not be released now.
				if not perused then
					free_param_registers
				end
			end
			if target_register (r).is_current and then (is_encapsulation_required or else not extension.is_static) then
				context.mark_current_used
			end
		end

	generate_end (reg: REGISTRABLE; typ: CL_TYPE_A)
			-- Generate final portion of C code.
		local
			buf: GENERATION_BUFFER
			result_type: TYPE_A
			l_args: like argument_types
			has_eif_test: BOOLEAN
			internal_name: STRING
			type_c: TYPE_C
			local_argument_types: like argument_types
			real_arg_types: like argument_types
		do
			buf := buffer
			result_type := real_type (type)
			type_c := result_type.c_type
			if extension.is_inline and result_type.is_boolean then
				has_eif_test := True
				buf.put_string ("EIF_TEST (")
			end
			if is_encapsulation_required or else extension.is_inline then
					-- The call is not polymorphic in the given context,
					-- so the name can be hardwired. If we check assertions, we need
					-- to call associated encapsulation.
					-- In the case of encapsulated externals, we call the associated
					-- encapsulation.
				internal_name := routine_entry.routine_name
				local_argument_types := argument_types
				if
					not is_encapsulation_required and then
						-- Obtain the extension of the found entry, not of the original feature
					attached system.class_of_id (routine_entry.class_id) as c and then
					attached c.feature_of_feature_id (routine_entry.feature_id) as f and then
					attached {INLINE_EXTENSION_I} f.extension as inline_ext
				then
					if local_argument_types.count > 1 then
						real_arg_types := local_argument_types.subarray (local_argument_types.lower + 1, local_argument_types.upper)
						real_arg_types.rebase (1)
					else
						create real_arg_types.make_empty
					end
					inline_ext.force_inline_def (result_type, internal_name, real_arg_types)
						-- No need for a function cast since the inline routine is defined
						-- prior to the call.
					internal_name := inline_ext.inline_name (internal_name)
				elseif routine_entry.access_type_id /= Context.original_class_type.type_id then
						-- Remember extern routine declaration if not written in the same class.
						-- No need doing this for an inline C/C++ since the code of the inline routine will be generated again.
					Extern_declarations.add_routine_with_signature
						(type_c.c_string, internal_name, local_argument_types)
				end
				generate_nested_flag (not is_static_call)
				buf.put_string (internal_name)
			elseif not result_type.is_void then
				type_c.generate_cast (buf)
					 -- Nothing to be done now. Remaining of code generation will be done below.
			end
				-- Now generate the parameters of the call, if needed.
			if not is_encapsulation_required then
				check
					not_dll: not extension.is_dll
				end
				if attached {MACRO_EXTENSION_I} extension as macro_ext then
					macro_ext.generate_access (external_name, parameters, result_type)
				elseif attached {STRUCT_EXTENSION_I} extension as struct_ext then
					struct_ext.generate_access (external_name, parameters, result_type)
				elseif extension.is_inline then
					buf.put_character ('(')
					generate_parameters_list
					buf.put_character (')')
				elseif attached {CPP_EXTENSION_I} extension as cpp_ext then
					cpp_ext.generate_access (external_name, parameters, result_type)
				elseif attached {BUILT_IN_EXTENSION_I} extension as built_in_ext then
						-- Pass original feature to generate signature if needed.
					built_in_ext.generate_access (external_name, written_in, reg, parameters, result_type,
						routine_entry.written_class.feature_of_body_index (routine_entry.body_index), routine_entry.access_class_type)
				elseif attached {C_EXTENSION_I} extension as c_ext then
						-- Remove `Current' from argument types.
					l_args := argument_types
					if argument_types.count > 1 then
						l_args := l_args.subarray (l_args.lower + 1, l_args.upper)
					else
						create l_args.make_empty
					end
					c_ext.generate_access (external_name, parameters, l_args, result_type)
				else
					check
						is_expected_extension: False
					end
				end
			else
					-- Call is done like a normal Eiffel routine call.
				generate_parameters_part (reg)
			end
			if has_eif_test then
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
			if attached parameters as p then
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
	date: "$Date$"
	revision: "$Revision$"
	copyright:	"Copyright (c) 1984-2020, Eiffel Software"
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

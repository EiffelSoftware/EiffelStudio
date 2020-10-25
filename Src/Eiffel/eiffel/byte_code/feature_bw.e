note
	description: "Enlarged node for Eiffel feature call in workbench mode."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class FEATURE_BW

inherit

	FEATURE_BL
		redefine
			analyze_on,
			check_dt_current,
			free_register,
			generate_end,
			is_polymorphic,
			has_one_signature,
			unanalyze
		end

create
	fill_from

feature -- Status Report

	is_polymorphic: BOOLEAN = True
			-- <Precursor>

	has_one_signature: BOOLEAN = False
			-- <Precursor>

feature -- C code generation

	analyze_on (r: REGISTRABLE)
			-- Analyze feature call on `reg`.
		do
			Precursor (r)
			if is_once_creation or else c_type.is_reference then
					-- Do not use reference type because this register should not be tracked by GC.
				result_register := context.get_argument_register (pointer_type.c_type)
			end
		end

	free_register
			-- Free registers.
		do
			Precursor
			if result_register /= Void then
				result_register.free_register
			end
		end

	unanalyze
			-- Undo the analysis
		do
			Precursor
			result_register := Void
		end

	check_dt_current (reg: REGISTRABLE)
			-- Check whether we need to compute the dynamic type of current
			-- and call context.add_dt_current accordingly. The parameter
			-- `reg' is the entity on which the access is made.
		do
			if
				not (attached precursor_type as p and then is_target_type_fixed) and then
				not context_type.is_basic
			then
				if reg.is_current then
					context.add_dt_current
				end
				if
					not reg.is_predefined and then
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
		end

	generate_end (reg: REGISTRABLE; class_type: CL_TYPE_A)
			-- Generate final portion of C code.
		local
			buf: like buffer
			return_type: TYPE_C
			l_context: like context
		do
			check
				result_register_attached: (c_type.is_reference or is_once_creation) implies result_register /= Void
			end
			buf := buffer
			return_type := if is_once_creation then reference_c_type else c_type end
			if not return_type.is_void then
				buf.put_two_character ('(', '(')
				if return_type.is_reference then
					context.print_argument_register (result_register, buf)
					buf.put_string (" = ")
				end
			end
			buf.put_character ('(')
			return_type.generate_function_cast (buf, argument_types, True)
			generate_workbench_address (reg, class_type)
			buf.put_character (')')
			generate_arguments (reg, not is_polymorphic)
			if not return_type.is_void then
					-- This is a query. The result value may need conversion.
				buf.put_character (')')
					-- Retrieve return value.
				l_context := context
				if return_type.is_reference then
						-- Return value might be unboxed.
						-- It should be boxed now.
						-- The type of the result register has to be preserved.
					check
						result_register_attached: attached result_register
					end
					buf.put_string (", (((")
					l_context.print_argument_register (result_register, buf)
					buf.put_string (".type & SK_HEAD) == SK_REF)? (EIF_REFERENCE) 0: (")
					l_context.print_argument_register (result_register, buf)
					buf.put_character ('.')
					return_type.generate_typed_field (buf)
					buf.put_string (" = RTBU(")
					l_context.print_argument_register (result_register, buf)
					buf.put_string ("))), (")
					l_context.print_argument_register (result_register, buf)
					buf.put_string (".type = SK_POINTER), ")
					l_context.print_argument_register (result_register, buf)
				end
				buf.put_character ('.')
				return_type.generate_typed_field (buf)
				buf.put_character (')')
			end
		end

feature {NONE} -- C code generation

	routine_macro: TUPLE [unqualified_call, qualified_call, creation_call: STRING]
			-- Macros that compute address of a routine to be called.
			-- `Result.unqualified_call' denotes an unqualified call.
			-- `Result.qualified_call' denotes a qualified call.
			-- `Result.creation_call' denotes a call to a creation procedure.
		once
			Result := ["RTWF", "RTVF", "RTWC"]
		end

	generate_workbench_address (t: REGISTRABLE; c: CL_TYPE_A)
			-- Generate workbench address of a routine that is called on target `t` of type `c`.
		require
			t_attached: attached t
			c_attached: attached c
		local
			is_nested: BOOLEAN
			buf: GENERATION_BUFFER
			cl_type_i: CL_TYPE_A
			l_type: TYPE_A
			macro: STRING
		do
			is_nested := not is_first
			buf := buffer
			if
				attached precursor_type as p and then
				is_target_type_fixed
			then
				l_type := context.real_type (p)
				if l_type.is_multi_constrained then
					check
						has_multi_constraint_static: has_multi_constraint_static
					end
					l_type := context.real_type (multi_constraint_static)
				end
				check attached {CL_TYPE_A} l_type as ct then
					cl_type_i := ct
				end
			else
				cl_type_i := c
			end
			if is_nested then
				inspect call_kind
				when call_kind_creation then
					macro := routine_macro.creation_call
				when call_kind_qualified then
					macro := routine_macro.qualified_call
				else
					macro := routine_macro.unqualified_call
				end
			else
				macro := routine_macro.unqualified_call
			end
			buf.put_string (macro)
			buf.put_character ('(')
			buf.put_integer (routine_id)
			buf.put_two_character (',', ' ')
			if not is_nested then
				if not attached precursor_type then
					context.generate_current_dtype
				elseif is_target_type_fixed then
						-- Use dynamic type of parent instead
						-- of dynamic type of Current.
					buf.put_static_type_id (cl_type_i.static_type_id (context.context_class_type.type))
				else
					buf.put_string ({C_CONST}.dtype)
					buf.put_character ('(')
					t.print_register
					buf.put_character (')')
				end
			elseif call_kind = call_kind_qualified then
					-- Feature name is used to report a call on a void target.
					-- This cannot happen with an unqualified call or a creation procedure call.
				buf.put_string_literal (feature_name)
				buf.put_two_character (',', ' ')
				t.print_register
			else
				buf.put_string ({C_CONST}.dtype)
				buf.put_character ('(')
				t.print_register
				buf.put_character (')')
			end
			buf.put_character (')')
		end

	result_register: REGISTER
			-- A register to hold return value
			-- to be normalized before use.

;note
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

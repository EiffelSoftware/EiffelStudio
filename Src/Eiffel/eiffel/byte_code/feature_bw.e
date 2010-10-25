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
			generate_access_on_type,
			generate_end,
			generate_separate_call,
			is_polymorphic,
			has_one_signature,
			unanalyze
		end

create
	fill_from

feature -- Status Report

	is_polymorphic: BOOLEAN
			-- <Precursor>
		do
			Result := True
		end

	has_one_signature: BOOLEAN
			-- <Precursor>
		do
			Result := False
		end

feature -- C code generation

	analyze_on (reg: REGISTRABLE)
			-- Analyze feature call on `reg'.
		local
			return_type: like c_type
		do
			Precursor (reg)
			return_type := c_type
			if return_type.is_reference then
					-- Do not use reference type because this register should not be tracked by GC.
				result_register := context.get_argument_register (pointer_type.c_type)
			elseif not return_type.is_void and then context_type.is_separate then
					-- The register is used to store result of a separate feature call.
				result_register := context.get_argument_register (return_type)
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
		local
			class_type: CL_TYPE_A;
			type_i: TYPE_A;
			access: ACCESS_B;
			void_register: REGISTER;
		do
			type_i := context_type;
			class_type ?= type_i;
			if not (type_i.is_basic or else class_type = Void) then
				if reg.is_current then
					context.add_dt_current;
				end;
				if not reg.is_predefined then
						-- BEWARE!! The function call is polymorphic hence we'll
						-- need to evaluate `reg' twice: once to get its dynamic
						-- type and once as a parameter for Current. Hence we
						-- must make sure it is not held in a No_register--RAM.
				 	access ?= reg;	  -- Cannot fail
					if access.register = No_register then
						access.set_register (void_register);
						access.get_register;
					end;
				end
			end;
		end;

	generate_access_on_type (reg: REGISTRABLE; typ: CL_TYPE_A)
			-- Generate feature call in a `typ' context.
		do
			generate_workbench_access_on_type (reg, typ, result_register)
		end

	generate_end (gen_reg: REGISTRABLE; class_type: CL_TYPE_A)
			-- Generate final portion of C code.
		do
			Precursor (gen_reg, class_type)
			generate_workbench_end (result_register)
		end

feature {NONE} -- Separate call

	separate_function_macro: TUPLE [routine, routine_with_invariant, precompiled, precompiled_with_invariant: STRING]
			-- Name of a macro to make a call to a function depending on the kind of a call:
			-- See `routine_macro' for details.
		once
			Result := ["RTS_CF", "RTS_CF", "RTS_CFP", "RTS_CFP"]
		end

	separate_procedure_macro: TUPLE [routine, routine_with_invariant, precompiled, precompiled_with_invariant: STRING]
			-- Name of a macro to make a call to a procedure depending on the kind of a call.
			-- See `routine_macro' for details.
		once
				-- Procedure call without an invariant check is a creation procedure call.
			Result := ["RTS_CC", "RTS_CP", "RTS_CCP", "RTS_CPP"]
		end

	generate_separate_call (s: detachable REGISTER; r: detachable REGISTRABLE; t: REGISTRABLE)
			-- <Precursor>
		local
			buf: like buffer
		do
			check attached {CL_TYPE_A} context_type as c then
				buf := buffer
				buf.put_new_line
				if attached r then
						-- Call to a function.
					generate_call_macro (separate_function_macro, t, c, s, result_register)
					buf.put_character (';')
					buf.put_new_line
					r.print_register
					buf.put_three_character (' ', '=', ' ')
					context.print_argument_register (result_register, buf)
					generate_return_value_conversion (result_register)
				else
						-- Call to a procedure.
					generate_call_macro (separate_procedure_macro, t, c, s, Void)
				end
				buf.put_character (';')
			end
		end

feature {NONE} -- Implementation

	result_register: REGISTER;
			-- A register to hold return value
			-- to be normalized before use.

note
	copyright:	"Copyright (c) 1984-2010, Eiffel Software"
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

indexing
	description: "Enlarged node for external feature call in workbench mode."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EXTERNAL_BW

inherit
	EXTERNAL_BL
		redefine
			analyze_on,
			check_dt_current,
			free_register,
			generate_access_on_type,
			generate_end,
			need_invariant,
			set_need_invariant,
			unanalyze
		end

create
	make

feature -- Initialization

	make is
		do
			need_invariant := True
		end

feature -- Access

	need_invariant: BOOLEAN
			-- Does the call need an invariant check ?

feature -- Settings

	set_need_invariant (b: BOOLEAN) is
			-- Assign `b' to `need_invariant'.
		do
			need_invariant := b
		end

feature -- Checking

	analyze_on (reg: REGISTRABLE) is
			-- Analyze feature call on `reg'.
		local
			return_type: like c_type
		do
			Precursor (reg)
			return_type := c_type
			if return_type.is_pointer then
					-- Do not use reference type because this register should not be tracked by GC.
				result_register := context.get_argument_register (pointer_type.c_type)
			end
		end

	free_register is
			-- Free registers.
		do
			Precursor
			if result_register /= Void then
				result_register.free_register
			end
		end

	unanalyze is
			-- Undo the analysis
		do
			Precursor
			result_register := Void
		end

	check_dt_current (reg: REGISTRABLE) is
			-- Check whether we need to compute the dynamic type of current
			-- and call context.add_dt_current accordingly. The parameter
			-- `reg' is the entity on which the access is made.
		local
			class_type: CL_TYPE_A
			type_i: TYPE_A
			cond: BOOLEAN
			access: ACCESS_B
			void_register: REGISTER
		do
			if not is_static_call then
				type_i := context_type
				class_type ?= type_i
				cond := not (type_i.is_basic or else class_type = Void)
				if reg.is_current and cond then
					context.add_dt_current
				end
				if not reg.is_predefined and cond then
						-- BEWARE!! The function call is polymorphic hence we'll
						-- need to evaluate `reg' twice: once to get its dynamic
						-- type and once as a parameter for Current. Hence we
						-- must make sure it is not held in a No_register--RAM.
				 	access ?= reg;	  -- Cannot fail
					if access.register = No_register then
						access.set_register (void_register)
						access.get_register
					end
				end
			end
		end

feature -- Code generation

	generate_access_on_type (reg: REGISTRABLE; typ: CL_TYPE_A) is
			-- Generate external call in a `typ' context.
		do
			generate_workbench_access_on_type (reg, typ, result_register)
		end

	generate_end (gen_reg: REGISTRABLE; class_type: CL_TYPE_A) is
			-- Generate final portion of C code.
		do
			Precursor (gen_reg, class_type)
			generate_workbench_end (result_register)
		end

feature {NONE} -- Implementation

	result_register: REGISTER;
			-- A register to hold return value
			-- to be normalized before use.

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

end -- class EXTERNAL_BW

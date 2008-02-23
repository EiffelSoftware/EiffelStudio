indexing
	description: "Descritpion of an actual native array type. Only used for IL code generation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	NATIVE_ARRAY_TYPE_A

inherit
	GEN_TYPE_A
		redefine
			process, il_type_name, generic_il_type_name
		end

create
	make

feature -- Visitor

	process (v: TYPE_A_VISITOR) is
			-- Process current element.
		do
			v.process_native_array_type_a (Current)
		end

feature -- IL code generation

	il_type_name (a_prefix: STRING; a_context_type: TYPE_A): STRING is
			-- Name of current class
		do
			Result := generics.item (1).il_type_name (a_prefix, a_context_type).twin
			Result.append ("[]")
		end

	generic_il_type_name (a_context_type: TYPE_A): STRING is
			-- Name of current class
		do
			Result := generics.item (1).generic_il_type_name (a_context_type).twin
			Result.append ("[]")
		end

	deep_il_element_type: CL_TYPE_A is
			-- Find type of array element.
			-- I.e. if you have NATIVE_ARRAY [NATIVE_ARRAY [INTEGER]], it
			-- will return INTEGER.
		require
			true_generics_not_void: generics /= Void
		local
			l_native: NATIVE_ARRAY_TYPE_A
		do
			Result ?= generics.item (1)
			if Result = Void then
				Result := object_type
			else
				l_native ?= Result
				if l_native /= Void then
					Result := l_native.deep_il_element_type
				end
			end
		ensure
			deep_il_element_type_not_void: Result /= Void
		end

feature {NONE} -- Implementation

	object_type: CL_TYPE_A is
			-- Type of SYSTEM_OBJECT.
		require
			in_il_generation: system.il_generation
			system_not_void: system /= Void
			object_class_not_void: system.system_object_class /= Void
			object_class_compiled: system.system_object_class.is_compiled
		once
			Result := system.system_object_class.compiled_class.actual_type
		ensure
			object_type_not_void: Result /= Void
		end


invariant
	il_generation: System.il_generation
	count_set: generics.count = 1

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
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

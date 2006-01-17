indexing
	description: "Description of an actual Native array type for IL code generation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	NATIVE_ARRAY_TYPE_I

inherit
	ONE_GEN_TYPE_I

create
	make

feature -- Access

	il_type_name (a_prefix: STRING): STRING is
			-- Name of current class
		do
			Result := true_generics.item (1).il_type_name (a_prefix).twin
			Result.append ("[]")
		end

	deep_il_element_type: CL_TYPE_I is
			-- Find type of array element.
			-- I.e. if you have NATIVE_ARRAY [NATIVE_ARRAY [INTEGER]], it
			-- will return INTEGER.
		require
			true_generics_not_void: true_generics /= Void
		local
			l_native: NATIVE_ARRAY_TYPE_I
		do
			Result ?= true_generics.item (1)
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

	type_a: NATIVE_ARRAY_TYPE_A is
		local
			i: INTEGER
			array: ARRAY [TYPE_A]
			l_meta: like meta_generic
		do
			from
				l_meta := meta_generic
				i := l_meta.count
				create array.make (1, i)
			until
				i = 0
			loop
				array.put (l_meta.item (i).type_a, i)
				i := i - 1
			end
			create Result.make (class_id, array)
			Result.set_mark (declaration_mark)
		end

invariant
	il_generation: System.il_generation

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
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

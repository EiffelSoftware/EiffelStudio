indexing
	description: "Objects that ..."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

class
	SHARED_ABSTRACT_DEBUG_VALUE_SORTER

feature {NONE} -- Implementation

	Abstract_debug_value_sorter: DS_SORTER [ABSTRACT_DEBUG_VALUE] is
			-- Attributes sorter.
		local
			l_comp: KL_COMPARABLE_COMPARATOR [ABSTRACT_DEBUG_VALUE]
		once
			create l_comp.make
			create {DS_QUICK_SORTER [ABSTRACT_DEBUG_VALUE]} Result.make (l_comp)
		end

	sort_debug_values (lst: DS_LIST [ABSTRACT_DEBUG_VALUE]) is
			-- sort `children' and return it.
		require
			lst_not_void: lst /= Void
		do
			if
				not lst.sorted (abstract_debug_value_sorter)
			then
				lst.sort (abstract_debug_value_sorter)
			end
		ensure
			lst_sorted: lst.sorted (abstract_debug_value_sorter)
		end

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

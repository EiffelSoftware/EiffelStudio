indexing
	description: "Object that represents a list of ancestor classes of a certain class"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EQL_CLASS_ANCESTORS

inherit
	EQL_CLASS_HIERARCHY

feature -- Access

	classes (a_class: CLASS_C) : LIST [CLASS_C] is
			-- Ancestor classes of `a_class'
		local
			l_parents: FIXED_LIST [CL_TYPE_A]
			i: INTEGER
		do
			l_parents := a_class.parents
			if l_parents /= Void then
				create {ARRAYED_LIST [CLASS_C]}Result.make (l_parents.count)
				from
					i := 1
				until
					i > l_parents.count
				loop
					Result.extend (l_parents.i_th (i).associated_class)
					i := i + 1
				end
			else
				create {ARRAYED_LIST [CLASS_C]}Result.make (0)
			end
		end

	recursive_classes (a_class: CLASS_C): LIST [CLASS_C] is
			-- Recursive class hierarchy of ancestors of `a_class'
		local
			l_qry: EQL_CLASS_ANCESTOR_QUERY
			l_itr: EQL_ITERATOR [EQL_CLASS]
		do
			create l_qry
			l_qry.execute (create{EQL_CLASS}.make_with_class_c (a_class))
			create {LINKED_LIST [CLASS_C]}Result.make
			l_itr := l_qry.last_result.distinct_itr
			from
				l_itr.start
			until
				l_itr.after
			loop
				Result.extend (l_itr.item.class_c)
				l_itr.forth
			end
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

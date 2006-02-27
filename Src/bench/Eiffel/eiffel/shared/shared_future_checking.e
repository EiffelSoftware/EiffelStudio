indexing
	description: "Object that store all the needed information for the report of generic%N%
			%constraint validity errors when there are some. It also handles the checking%N%
			%that cannot be done before degree 3"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "Emmanuel STAPF"
	date: "$Date$"
	revision: "$Revision$"

class
	SHARED_FUTURE_CHECKING

feature -- Delayed validity checking

	remaining_validity_checking_list: LINKED_LIST [FUTURE_CHECKING_INFO] is
			-- List of the remaining checks that need to be done after
			-- the degree 4 of the compilation.
		do
			Result := remaining_validity_checking_list_cell.item
		ensure
			remaining_validity_checking_list_not_void: Result /= Void
		end

	add_future_checking(context_class: CLASS_C; p: PROCEDURE [ANY, TUPLE]) is
				-- Gather all information which will enable to check that
				-- all the declaration of generic classes conforms to the
				-- generic creation constraint of the generic class.
		local
			t: FUTURE_CHECKING_INFO
		do
			create t.make (context_class, p)
			remaining_validity_checking_list.extend (t)
		end

	reset_remaining_validity_checking_list is
		do
			remaining_validity_checking_list_cell.put (create {LINKED_LIST [FUTURE_CHECKING_INFO]} .make)
		end

feature {NONE} -- Shared object implementation

	remaining_validity_checking_list_cell: CELL [LINKED_LIST [FUTURE_CHECKING_INFO]] is
			-- Shared object which contains the `remaining_validity_checking_list'.
		local
			t: like remaining_validity_checking_list
		once
			create t.make
			create Result.put (t)
		ensure
			remaining_validity_checking_list_cell_not_void: result /= Void
		end

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

end -- class SHARED_GENERIC_CONSTRAINT

note
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

	remaining_validity_checking_list: LINKED_LIST [FUTURE_CHECKING_INFO]
			-- List of the remaining checks that need to be done after
			-- the degree 4 of the compilation.
		do
			Result := remaining_validity_checking_list_cell.item
		ensure
			remaining_validity_checking_list_not_void: Result /= Void
		end

	add_future_checking (context_class: CLASS_C; p: PROCEDURE [ANY, TUPLE])
				-- Gather all information which will enable to check that
				-- all the declaration of generic classes conforms to the
				-- generic creation constraint of the generic class.
		local
			t: FUTURE_CHECKING_INFO
		do
			create t.make (context_class, p)
			temp_remaining_validity_checking_list.extend (t)
		end

	merge_remaining_validity_checks_into_global_list
			-- Merges the recently added validity checks into the global list.
			--| One does this if the class will not be checked again, i.e. it did not produce any errors.
		require
			remaining_validity_checking_list: remaining_validity_checking_list /= Void
		local
			l_list: like temp_remaining_validity_checking_list
		do
			l_list := temp_remaining_validity_checking_list
			if not l_list.is_empty then
				remaining_validity_checking_list.append (temp_remaining_validity_checking_list)
				temp_remaining_validity_checking_list.wipe_out
			end

			check
				temp_list_emptied: temp_remaining_validity_checking_list.is_empty
			end

		ensure
			global_validity_check_count_not_decreased: old remaining_validity_checking_list.count <= remaining_validity_checking_list.count
		end

	reset_remaining_validity_checking_list
			-- Resets the remaining_validity_list
		do
			temp_remaining_validity_checking_list_cell.put (create {LINKED_LIST [FUTURE_CHECKING_INFO]} .make)
			remaining_validity_checking_list_cell.put (create {LINKED_LIST [FUTURE_CHECKING_INFO]} .make)
			check
				temp_remaining_validity_checking_list_is_empty: temp_remaining_validity_checking_list.is_empty
			end
		ensure
			remaining_validity_checking_list_is_empty: remaining_validity_checking_list.is_empty
		end

	empty_temp_remaining_validity_checking_list
			-- Empties the temporary delayed validity checking list
		do
			temp_remaining_validity_checking_list.wipe_out
			check
				temp_remaining_validity_checking_list_is_empty: temp_remaining_validity_checking_list.is_empty
			end
		end

	remove_remaining_validity_checks_for_class (a_class: CLASS_C)
			-- Removes all remaining validity checks for a class
			--
			-- `a_class' is the class for which we remove all delayed checks.
			--| Call this feature if a class is removed from the system.
		require
			a_class_not_void: a_class /= Void
		local
			l_class_id: INTEGER
		do
			l_class_id := a_class.class_id
			from remaining_validity_checking_list.start
			until
				remaining_validity_checking_list.after
			loop
				if remaining_validity_checking_list.item.context_class.class_id =  l_class_id then
					remaining_validity_checking_list.remove
				else
					remaining_validity_checking_list.forth
				end
			end
		ensure
			all_occurences_removed: not remaining_validity_checking_list.there_exists (
				agent (g_class: CLASS_C; g_item: FUTURE_CHECKING_INFO): BOOLEAN
						-- Is this a future checking for `a_class'?
					require
						g_class_not_void: g_class /= Void
						g_item_not_void: g_item /= Void
					do
						Result := g_class.class_id = g_item.context_class.class_id
					end (a_class, ?))
		end

feature {NONE} -- Shared object implementation

	remaining_validity_checking_list_cell: CELL [LINKED_LIST [FUTURE_CHECKING_INFO]]
			-- Shared object which contains the `remaining_validity_checking_list'.
		local
			t: like remaining_validity_checking_list
		once
			create t.make
			create Result.put (t)
		ensure
			remaining_validity_checking_list_cell_not_void: result /= Void
		end

	temp_remaining_validity_checking_list_cell:CELL [LINKED_LIST [FUTURE_CHECKING_INFO]]
			-- Holds the temporary remaining_validity_checking list.
		local
			t: like remaining_validity_checking_list
		once
			create t.make
			create Result.put (t)
		end

	temp_remaining_validity_checking_list: like remaining_validity_checking_list
			-- Holds the temporary remaining_validity_checking list.
		do
			Result := temp_remaining_validity_checking_list_cell.item
		end

note
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

end -- class SHARED_GENERIC_CONSTRAINT

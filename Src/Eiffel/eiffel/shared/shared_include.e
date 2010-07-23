note
	description: "[
		Holds the list of include files to be generated for a given class
		It prevents from generating twice the same #include in the C code
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."

class
	SHARED_INCLUDE

feature -- Access

	shared_include_queue: SEARCH_TABLE [INCLUDE_LIST]
			-- Access to includes
		once
			create Result.make (10)
		ensure
			shared_include_queue_not_void: Result /= Void
		end

feature -- Element change

	shared_include_queue_put (an_id: INTEGER)
			-- Add `an_id' to `shared_include_queue'.
		local
			l_arrayed_list: INCLUDE_LIST
		do
			l_arrayed_list := shared_include_queue_list
			l_arrayed_list.extend (an_id)
			shared_include_queue.put (l_arrayed_list)
		end

	shared_include_queue_wipe_out
			-- Wipe out `shared_include_queue' and adds unused ARRAYED_LIST to `shared_free_include_queue_entries'.
		do
			from
				shared_include_queue.start
			until
				shared_include_queue.after
			loop
				shared_free_include_queue_entries.extend (shared_include_queue.item_for_iteration)
				shared_include_queue.forth
			end
			shared_include_queue.wipe_out
		ensure
			shared_include_queue_empty: shared_include_queue.is_empty
		end

feature {NONE} -- Implementation

	shared_include_queue_list: INCLUDE_LIST
			-- Retrieve a list that can then be used for insertion in `shared_include_queue' directly
		do
			if shared_free_include_queue_entries.is_empty then
				create Result.make (1)
			else
				Result := shared_free_include_queue_entries.item
				shared_free_include_queue_entries.remove
				Result.wipe_out
			end
		ensure
			shared_include_queue_list_not_void: Result /= Void
			shared_include_queue_list_empty: Result.is_empty
		end

	shared_free_include_queue_entries: ARRAYED_STACK [INCLUDE_LIST]
			-- List of available ARRAYED_LIST to avoid creating new ones all the time.
		once
			create Result.make (10)
		ensure
			shared_free_include_queue_entries_not_void: Result /= Void
		end

	shared_unicity_of_includes: SEARCH_TABLE [INTEGER]
			-- When generating the list of includes, we want to make sure that the items
			-- of the `shared_include_queue' appear only once.
		once
			create Result.make (10)
		ensure
			shared_unicity_of_includes_not_void: Result /= Void
		end

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

indexing
	description: "[

		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	HISTORY_CONTAINER_I

inherit
	HISTORY_OWNER_I

feature -- Access

	undo_items: !DS_STACK [!HISTORY_STACK_ITEM_I]
			-- A stack of current undoable history items.
		require
			is_interface_usable: is_interface_usable
		deferred
		ensure
			result_not_cached: Result /~ undo_items
		end

	redo_items: !DS_STACK [!HISTORY_STACK_ITEM_I]
			-- A stack of current redoable history items.
		require
			is_interface_usable: is_interface_usable
		deferred
		ensure
			result_not_cached: Result /~ redo_items
		end

feature -- Status report

	can_undo: BOOLEAN
			-- Indicates if the current history will permit an undo operation.
		require
			is_interface_usable: is_interface_usable
		deferred
		ensure
			not_undo_items_is_empty: Result implies not undo_items.is_empty
			top_undo_items_is_interface_usable: Result implies undo_items.item.is_interface_usable
		end

	can_redo: BOOLEAN
			-- Indicates if the current history will permit an redo operation.
		require
			is_interface_usable: is_interface_usable
		deferred
		ensure
			not_redo_items_is_empty: Result implies not redo_items.is_empty
			top_redo_items_is_interface_usable: Result implies redo_items.item.is_interface_usable
		end

feature -- Query

	top_undo_items (a_count: NATURAL): !DS_LINEAR [!HISTORY_STACK_ITEM_I]
			-- Retrieves the top undo stack items based on a maximum number of items to retrieve.
			-- The items will be ordered top-most first.
			--
			-- `a_count': Maximum number of stack items to retrieve.
			-- `Result' : Top stack items, ordered highest element first.
		require
			is_interface_usable: is_interface_usable
			a_count_positive: a_count > 0
			can_undo: can_undo
		deferred
		ensure
			result_count_small_enough: Result.count <= a_count.to_integer_32
		end

	top_redo_items (a_count: NATURAL): !DS_LINEAR [!HISTORY_STACK_ITEM_I]
			-- Retrieves the top redo stack items based on a maximum number of items to retrieve.
			-- The items will be ordered top-most first.
			--
			-- `a_count': Maximum number of stack items to retrieve.
			-- `Result' : Top stack items, ordered highest element first.
		require
			is_interface_usable: is_interface_usable
			a_count_positive: a_count > 0
			can_redo: can_redo
		deferred
		ensure
			result_count_small_enough: Result.count <= a_count.to_integer_32
		end

feature -- Extension

	put (a_item: !HISTORY_STACK_ITEM_I)
			-- Extends the history stack
		require
			is_interface_usable: is_interface_usable
			a_item_is_interface_usable: a_item.is_interface_usable
			not_has_a_item: not has (a_item)
		deferred
		ensure
			has_a_item: has (a_item)
			undo_items_has_a_item: undo_items.has (a_item)
		end

feature -- Basic operations

	undo
			-- Processing an undo.
		require
			is_interface_usable: is_interface_usable
			can_undo: can_undo
		deferred
		end

	undo_to (a_item: !HISTORY_STACK_ITEM_I)
			-- Processes an undo up to and including the given history item.
			--
			-- `a_item': Item in the undo history to process undos up to.
		require
			is_interface_usable: is_interface_usable
			can_undo: can_undo
			undo_items_has_a_item: undo_items.has (a_item)
		do

		end

	redo
			-- Processing an redo
		require
			is_interface_usable: is_interface_usable
			can_redo: can_redo
		deferred
		end


	clear
			-- <Precursor>
		require
			is_interface_usable: is_interface_usable
		deferred
		ensure
			not_can_undo: not can_undo
			not_can_redo: not can_redo
		end

;indexing
	copyright: "Copyright (c) 1984-2008, Eiffel Software"
	license:   "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
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

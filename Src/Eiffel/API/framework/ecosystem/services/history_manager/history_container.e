indexing
	description: "[

		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	HISTORY_CONTAINER

inherit
	HISTORY_CONTAINER_I

feature -- Access

	undo_items: !DS_STACK [!HISTORY_STACK_ITEM_I]
			-- <Precursor>
		local
			l_result: !DS_ARRAYED_STACK [!HISTORY_STACK_ITEM_I]
		do
			create l_result.make_default
			l_result.copy (undo_stack)
			Result := l_result
		ensure then
			result_not_cached: Result /~ undo_items
		end

	redo_items: !DS_STACK [!HISTORY_STACK_ITEM_I]
			-- <Precursor>
		local
			l_result: !DS_ARRAYED_STACK [!HISTORY_STACK_ITEM_I]
		do
			create l_result.make_default
			l_result.copy (redo_stack)
			Result := l_result
		ensure then
			result_not_cached: Result /~ redo_items
		end

feature {NONE} -- Access

	undo_stack: !DS_ARRAYED_STACK [!HISTORY_STACK_ITEM_I]
			-- The actual stack used to maintain undoable history items
		do
			if {l_result: DS_ARRAYED_STACK [!HISTORY_STACK_ITEM_I]} internal_undo_stack then
				Result := l_result
			else
				create Result.make_default
				internal_undo_stack := Result
			end
		ensure
			result_consistent: Result = undo_stack
		end

	redo_stack: !DS_ARRAYED_STACK [!HISTORY_STACK_ITEM_I]
			-- The paired redo stack used to maintain redoable history items
		do
			if {l_result: DS_ARRAYED_STACK [!HISTORY_STACK_ITEM_I]} internal_redo_stack then
				Result := l_result
			else
				create Result.make_default
				internal_redo_stack := Result
			end
		ensure
			result_consistent: Result = redo_stack
		end

feature -- Status report

	is_interface_usable: BOOLEAN
			-- Determines if the interface is usable
		do
			Result := True
		end

	has (a_item: !HISTORY_STACK_ITEM_I): BOOLEAN
			-- <Precursor>
		local
			l_undo: like internal_undo_stack
			l_redo: like internal_redo_stack
		do
			l_undo := internal_undo_stack
			if l_undo /= Void then
				Result := l_undo.has (a_item)
			end
			if not Result then
				l_redo := internal_redo_stack
				if l_redo /= Void then
					Result := l_redo.has (a_item)
				end
			end
		end

	can_undo: BOOLEAN
			-- <Precursor>
		local
			l_undo: like internal_undo_stack
		do
			l_undo := internal_undo_stack
			if l_undo /= Void then
				Result := not l_undo.is_empty
			end
		ensure then
			not_internal_undo_stack_is_empty: Result implies (internal_undo_stack /= Void and then not internal_undo_stack.is_empty)
		end

	can_redo: BOOLEAN
			-- <Precursor>
		local
			l_redo: like internal_redo_stack
		do
			l_redo := internal_redo_stack
			if l_redo /= Void then
				Result := not l_redo.is_empty
			end
		ensure then
			not_internal_redo_stack_is_empty: Result implies (internal_redo_stack /= Void and then not internal_redo_stack.is_empty)
		end

feature -- Query

	top_undo_items (a_count: NATURAL): !DS_LINEAR [!HISTORY_STACK_ITEM_I]
			-- <Precursor>
		local
			l_result: DS_ARRAYED_LIST [!HISTORY_STACK_ITEM_I]
			l_undo: like internal_undo_stack
			l_undo_copy: DS_ARRAYED_STACK [!HISTORY_STACK_ITEM_I]
			i: INTEGER
		do
			l_undo := internal_undo_stack
			if l_undo /= Void then
				if a_count = 1 then
					create l_result.make (1)
					l_result.put_last (l_undo.item)
				else
					l_undo_copy := l_undo.cloned_object
					i := a_count.as_integer_32.min (l_undo_copy.count)
					create l_result.make (i)
					from until i = 0 or l_undo_copy.is_empty loop
						l_result.put_last (l_undo_copy.item)
						l_undo_copy.remove
						i := i - 1
					end
				end
			else
				create l_result.make (0)
			end
			Result := l_result
		end

	top_redo_items (a_count: NATURAL): !DS_LINEAR [!HISTORY_STACK_ITEM_I]
			-- <Precursor>
		local
			l_result: DS_ARRAYED_LIST [!HISTORY_STACK_ITEM_I]
			l_redo: like internal_redo_stack
			l_redo_copy: DS_ARRAYED_STACK [!HISTORY_STACK_ITEM_I]
			i: INTEGER
		do
			l_redo := internal_redo_stack
			if l_redo /= Void then
				if a_count = 1 then
					create l_result.make (1)
					l_result.put_last (l_redo.item)
				else
					l_redo_copy := l_redo.cloned_object
					i := a_count.as_integer_32.min (l_redo_copy.count)
					create l_result.make (i.as_integer_32)
					from  until i = 0 or l_redo_copy.is_empty loop
						l_result.put_last (l_redo_copy.item)
						l_redo_copy.remove
						i := i - 1
					end
				end
			else
				create l_result.make (0)
			end
			Result := l_result
		end

feature -- Extension

	put (a_item: !HISTORY_STACK_ITEM_I)
			-- <Precursor>
		local
			l_redo: !like redo_stack
		do
			a_item.set_owner (Current)
			undo_stack.force (a_item)

				-- Unwind and clean up the history items
			l_redo := redo_stack
			from until l_redo.is_empty loop
				clean_item (l_redo.item)
				l_redo.remove
			end
			l_redo.wipe_out
		ensure then
			redo_stack_is_empty: redo_stack.is_empty
		end

feature -- Basic operations

	clear
			-- <Precursor>
		local
			l_stack: !DS_ARRAYED_STACK [!HISTORY_STACK_ITEM_I]
			l_undo: !like undo_stack
			l_redo: !like redo_stack
		do
			l_undo := undo_stack
			l_redo := redo_stack

				-- Duplicate the stack
			create l_stack.make_default
			l_stack.copy (l_undo)
			from until l_redo.is_empty loop
				l_stack.put (l_redo.item)
				l_redo.remove
			end

				-- Unwind and clean up the history items
			from until l_stack.is_empty loop
				clean_item (l_stack.item)
				l_stack.remove
			end

			l_undo.wipe_out
			l_redo.wipe_out
		ensure then
			undo_stack_is_empty: undo_stack.is_empty
			redo_stack_is_empty: redo_stack.is_empty
		end

	undo
			-- <Precursor>
		local
			l_undo: !like undo_stack
			l_redo: !like redo_stack
			l_item: ?HISTORY_STACK_ITEM_I
			l_undone: BOOLEAN
			retried: BOOLEAN
		do
			if not retried then
				l_undo := undo_stack

					-- Remove item from the undo stack and add to the redo
				l_item := l_undo.item
				l_undo.remove

				l_undone := True
				l_item.undo
			end

			if l_undone and then l_item /= Void then
				l_redo := redo_stack
				if l_item.is_interface_usable then
						-- Add redo item
					l_redo.force (l_item)
				else
						-- The interface is no usable so we cannot perform redos, as such any redo stack elements
						-- need to be wiped out.
					from until l_redo.is_empty loop
						clean_item (l_item)
						l_item := l_redo.item
						l_redo.remove
					end
				end
			end
		ensure then
			undo_stack_decremented: undo_stack.count = old undo_stack.count - 1
			redo_stack_incremented: old undo_stack.item.is_interface_usable implies (redo_stack.count = old redo_stack.count + 1)
			redo_stack_stack_item_added: old undo_stack.item.is_interface_usable implies (redo_stack.item = old undo_stack.item)
			redo_stack_wiped_out: not old undo_stack.item.is_interface_usable implies (redo_stack.is_empty)
		end

	redo
			-- <Precursor>
		local
			l_undo: !like undo_stack
			l_redo: !like redo_stack
			l_item: ?HISTORY_STACK_ITEM_I
			l_redone: BOOLEAN
			retried: BOOLEAN
		do
			if not retried then
				l_redo := redo_stack

					-- Remove item from the undo stack and add to the redo
				l_item := l_redo.item
				l_redo.remove

				l_redone := True
				l_item.redo
			end

			if l_redone and then l_item /= Void then
				l_undo := undo_stack
				if l_item.is_interface_usable then
						-- Add undo item
					l_undo.force (l_item)
				else
						-- The redo->undo item has become unusable so wipe out the history
					clear
				end
			end
		ensure then
			redo_stack_decremented: old undo_stack.item.is_interface_usable implies (redo_stack.count = old redo_stack.count - 1)
			undo_stack_incremented: old undo_stack.item.is_interface_usable implies (undo_stack.count = old undo_stack.count + 1)
			undo_stack_stack_item_added: old redo_stack.item.is_interface_usable implies (undo_stack.item = old redo_stack.item)
			stack_cleared_wiped_out: not old redo_stack.item.is_interface_usable implies (undo_stack.is_empty and redo_stack.is_empty)
		end

feature {NONE} -- Basic operations

	clean_item (a_item: !HISTORY_STACK_ITEM_I)
			-- Cleans a history item to ensure it is disposed of correctly.
			--
			-- `a_item': A history item to clean up.
		local
			retried: BOOLEAN
		do
			if retried then
				if {l_disposable: DISPOSABLE} a_item then
					l_disposable.dispose
				end
			end
			a_item.set_owner (Void)
		ensure
			not_a_item_is_owned: not a_item.is_owned
		rescue
			retried := True
			retry
		end

feature {NONE} -- Implementation: Internal cache

	internal_undo_stack: ?like undo_stack
			-- Cached version of `undo_stack'.
			-- Note: Do not use directly!

	internal_redo_stack: ?like redo_stack
			-- Cached version of `redo_stack'.
			-- Note: Do not use directly!

;indexing
	copyright: "Copyright (c) 1984-2009, Eiffel Software"
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

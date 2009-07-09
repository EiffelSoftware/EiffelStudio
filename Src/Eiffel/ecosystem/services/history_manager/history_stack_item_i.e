indexing
	description: "[
		Abstract inferface for tools/UI where stones can set and synchronized.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

deferred class
	HISTORY_STACK_ITEM_I

inherit
	SITE [HISTORY_OWNER_I]
		rename
			is_sited as is_owned,
			is_valid_site as is_valid_owner,
			set_site as set_owner,
			site as owner,
			on_sited as on_owned
		export
			{NONE} all
			{ANY} is_owned, owner
			{HISTORY_OWNER_I} is_valid_owner, set_owner
		end

	USABLE_I

feature -- Access

	description: !READABLE_STRING_32
			-- Friendly description of the stack item.
		require
			is_interface_usable: is_interface_usable
		deferred
		end

	data: !ANY
			-- Stack item data.
		require
			is_interface_usable: is_interface_usable
		deferred
		ensure
			result_is_valid_data: is_valid_data (Result)
		end

feature -- Status report

	is_applied: BOOLEAN
			-- Indicates if the history item has been applied to any context
		require
			is_interface_usable: is_interface_usable
		deferred
		end

	is_valid_data (a_data: !ANY): BOOLEAN
			-- Determines if the supplied data is valid for the Current stack frame.
		require
			is_interface_usable: is_interface_usable
		deferred
		end

feature {HISTORY_OWNER_I} -- Status report

	is_skippable: BOOLEAN
			-- Indicates if the histroy item can be skipped for multiple undo or redo actions.
			-- Note: This is required when undoing or redoing to a point in history.
		require
			is_interface_usable: is_interface_usable
		deferred
		end

feature {HISTORY_OWNER_I} -- Basic operations

	undo
			-- Perform an undo action.
		require
			is_interface_usable: is_interface_usable
			is_applied: is_applied
		deferred
		ensure
			not_is_applied: not is_applied
		end

	redo
			-- Perform an redo action.
		require
			is_interface_usable: is_interface_usable
			not_is_applied: not is_applied
		deferred
		ensure
			is_applied: is_applied
		end

feature {HISTORY_OWNER_I} -- Basic operations

	apply: detachable HISTORY_STACK_ITEM_I
			-- Perform an action to revert to a previous state.
			--
			-- `Result': A redo item or Void
		require
			is_interface_usable: is_interface_usable
			not_is_applied: not is_applied
		deferred
		ensure
			is_applied: is_applied
			result_is_interface_usable: Result /= Void implies Result.is_interface_usable
			not_result_is_applied: Result /= Void implies not Result.is_applied
		end

invariant
	data_is_valid_data: is_valid_data (data)

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

note
	description: "[
		Interface to support non-threaded locking, merely for status reporting and reaction.
		See {LOCKABLE} for the default implementation.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	LOCKABLE_I

inherit
	USABLE_I

--inherit {NONE}
	EVENT_CONNECTION_POINT_I [LOCKABLE_OBSERVER, LOCKABLE_I]
		rename
			connection as lockable_connection
		end

feature -- Status report

	is_locked: BOOLEAN
			-- Indicates if Current is locked
		require
			is_interface_usable: is_interface_usable
		deferred
		end

feature -- Basic operations

	lock
			-- Perform a lock on Current.
		require
			is_interface_usable: is_interface_usable
		deferred
		ensure
			is_locked: is_locked
		end

	unlock
			-- Perform an unlock on Current.
		require
			is_interface_usable: is_interface_usable
			is_locked: is_locked
		deferred
		end

feature -- Events

	locked_event: !EVENT_TYPE [TUPLE [sender: !LOCKABLE_I]]
			-- Events called when a lock has been placed on Current.
			--
			-- 'sender': Object locked.
		require
			is_interface_usable: is_interface_usable
		deferred
		ensure
			result_is_interface_usable: Result.is_interface_usable
			result_consistent: Result = locked_event
		end

	unlocked_event: !EVENT_TYPE [TUPLE [sender: !LOCKABLE_I]]
			-- Events called when a lock has been placed on Current.
			--
			-- 'sender': Object unlocked.
		require
			is_interface_usable: is_interface_usable
		deferred
		ensure
			result_is_interface_usable: Result.is_interface_usable
			result_consistent: Result = unlocked_event
		end

;note
	copyright:	"Copyright (c) 1984-2009, Eiffel Software"
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

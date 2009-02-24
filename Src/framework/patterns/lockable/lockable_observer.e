note
	description: "[
		An observer for events implemented on a LOCKABLE_I} interface.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	LOCKABLE_OBSERVER

inherit
	EVENT_OBSERVER_I

feature {LOCKABLE_I} -- Event handlers

	on_locked (a_lock: !LOCKABLE_I)
			-- Called when a lockable interface is locked.
			--
			-- `a_lock': The locked interface.
		require
			is_interface_usable: attached {USABLE_I} Current as l_usable implies l_usable.is_interface_usable
			a_lock_is_interface_usable: attached {USABLE_I} Current as l_usable_lock implies l_usable_lock.is_interface_usable
			a_lock_is_locked: a_lock.is_locked
		do
		end

	on_unlocked (a_lock: !LOCKABLE_I)
			-- Called when a lockable interface is unlocked.
			--
			-- `a_lock': The unlocked interface.
		require
			is_interface_usable: attached {USABLE_I} Current as l_usable implies l_usable.is_interface_usable
			a_lock_is_interface_usable: attached {USABLE_I} Current as l_usable_lock implies l_usable_lock.is_interface_usable
			not_a_lock_is_locked: not a_lock.is_locked
		do
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

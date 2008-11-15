indexing
	description: "[
		An ESF default implementation for {ES_MODIFIABLE_I} to exhibit "dirty" state preservation on objects.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

deferred class
	ES_MODIFIABLE

inherit
	ES_MODIFIABLE_I

	EB_RECYCLABLE

feature {NONE} -- Clean up

	internal_recycle
			-- <Precursor>
		do
			if internal_dirty_state_change_event /= Void then
				internal_dirty_state_change_event.dispose
			end
		ensure then
			internal_dirty_state_change_event_disposed: (old internal_dirty_state_change_event /= Void) implies (old internal_dirty_state_change_event).is_zombie
		end

feature -- Status report

	is_dirty: BOOLEAN
			-- <Precursor>

feature {NONE} -- Status setting

	set_is_dirty (a_dirty: like is_dirty)
			-- <Precursor>
		local
			l_old_is_dirty: like is_dirty
		do
			l_old_is_dirty := is_dirty
			if l_old_is_dirty /= a_dirty then
				is_dirty := a_dirty
				on_dirty_state_changed
				if internal_dirty_state_change_event /= Void then
					internal_dirty_state_change_event.publish ([a_dirty])
				end
			end
		end

feature -- Events

	dirty_state_change_event: !EVENT_TYPE [TUPLE [is_dirty: BOOLEAN]]
			-- <Precursor>
		do
			if {l_event: like dirty_state_change_event} internal_dirty_state_change_event then
				Result := l_event
			else
				create Result
				internal_dirty_state_change_event := Result
			end
		end

feature {NONE} -- Event handlers

	on_dirty_state_changed
			-- Called when the dirty state changes
		require
			is_interface_usable: is_interface_usable
		do
		end

feature {NONE} -- Internal implementation cache

	internal_dirty_state_change_event: ?like dirty_state_change_event
			-- Cached version of `dirty_state_change_event'
			-- Note: Do not use directly!

;indexing
	copyright:	"Copyright (c) 1984-2007, Eiffel Software"
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

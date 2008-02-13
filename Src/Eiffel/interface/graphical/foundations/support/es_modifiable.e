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
			-- To be called when the button has became useless.
			-- Note: It's recommended that you do not detach objects here.
		do
			if internal_dirty_events /= Void then
				internal_dirty_events.wipe_out
			end
		ensure then
			internal_dirty_events_disposed: (old internal_dirty_events /= Void) implies not (old internal_dirty_events).is_empty
		end

feature -- Events

	dirty_actions: !EV_LITE_ACTION_SEQUENCE [TUPLE [is_dirty: BOOLEAN]]
			-- Actions called when the dirty state chages
		do
			if internal_dirty_events = Void then
				create Result
				internal_dirty_events := Result
			else
				Result ?= internal_dirty_events
			end
		end

feature {NONE} -- Internal implementation cache

	internal_dirty_events: EV_LITE_ACTION_SEQUENCE [TUPLE [is_dirty: BOOLEAN]]
			-- Cached version of `dirty_events'
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

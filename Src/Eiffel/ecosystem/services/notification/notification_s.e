note
	description: "Notification service."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	NOTIFICATION_S

inherit
	SERVICE_I

	EVENT_CONNECTION_POINT_I [NOTIFICATION_OBSERVER, NOTIFICATION_S]
		rename
			connection as notification_connection
		end

feature -- Status report

	is_available: BOOLEAN
			-- Is account service available?
		deferred
		end

feature -- Execution

	notify (m: NOTIFICATION_MESSAGE)
			-- Sent message `m` as notification.
		deferred
		end

	notify_message (a_text: READABLE_STRING_GENERAL; a_category: READABLE_STRING_GENERAL)
			-- Sent message text `a_text` with `a_category` as notification.
		local
			msg: NOTIFICATION_MESSAGE
		do
			create msg.make (a_text, a_category)
			notify (msg)
		end

feature -- Observer

	register_observer (obs: NOTIFICATION_OBSERVER)
			-- Register `obs` as an observer on notification events.
		local
			lst: like observers
		do
			lst := observers
			if lst = Void then
				create lst.make (1)
				observers := lst
			end
			lst.extend (obs)
		end

	unregister_observer (obs: NOTIFICATION_OBSERVER)
			-- Unregister `obs` from being an observer on notification events.	
		local
			lst: like observers
		do
			lst := observers
			if lst /= Void then
				lst.prune_all (obs)
				if lst.is_empty then
					observers := Void
				end
			end
		end

feature {NONE} -- Implementation

	observers: detachable ARRAYED_LIST [NOTIFICATION_OBSERVER]

invariant

note
	copyright: "Copyright (c) 1984-2019, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
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

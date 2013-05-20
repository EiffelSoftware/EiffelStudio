note
	description: "Summary description for {WSF_SESSION_MANAGER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	WSF_SESSION_MANAGER

feature -- Access

	session_exists (a_uuid: like {WSF_SESSION}.uuid): BOOLEAN
		deferred
		end

	session_data (a_uuid: like {WSF_SESSION}.uuid): detachable like {WSF_SESSION}.data
		deferred
		end

feature -- Persistence

	save_session (a_session: WSF_SESSION)
		deferred
		end

	delete_session (a_session: WSF_SESSION)
		deferred
		end

note
	copyright: "2011-2013, Jocelyn Fiat, Javier Velilla, Olivier Ligot, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end

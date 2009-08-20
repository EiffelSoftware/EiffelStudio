note
	description: "[
		Manages a hash_table of sessions.
	]"
	legal: "See notice at end of class."
	status: "Pre-release"
	date: "$Date$"
	revision: "$Revision$"

class
	XWA_SESSION_MANAGER

inherit
	XWA_SHARED_CONFIG

create
	make

feature {NONE} -- Initialzation

	make
			-- Initialization for `Current'.
		do
			create sessions.make (16)
		ensure
			sessions_attached: sessions /= Void
		end

feature -- Access

	sessions: HASH_TABLE [XH_SESSION, STRING]
		-- The table of sessions

feature -- Basic operations

	current_session (a_request: XH_REQUEST): XH_SESSION
			-- Returns the session that belongs to the request.
			-- If the sessions does not exist or has expired, a new session is created
			-- Removes expired sessions
		require
			a_request_attached: a_request /= Void
		do
			remove_expired_sessions

			if attached a_request.cookies [{XU_CONSTANTS}.Cookie_uuid] as l_cookie then
				if attached sessions.item (l_cookie.value) as l_old_session then
					Result := l_old_session
				else
					Result := new_session
				end
			else
				Result := new_session
			end

		ensure
			Result_attached: Result /= Void
		end

	remove_expired_sessions
			-- Removed all expired sessions from the table
		local
			l_keys: ARRAY [STRING]
			i: INTEGER
		do
			l_keys := sessions.current_keys
			from
				i := 1
			until
				i > l_keys.count
			loop
				if attached sessions.at (l_keys [i]) as l_session then
					if l_session.has_expired then
						sessions.remove (l_keys [i])
					end
				end
				i := i +1
			end
		end

	place_cookie_order (a_session: XH_SESSION ; a_response: XH_RESPONSE)
			-- Places a cookie order into the response
		require
			a_session_attached: a_session /= Void
			a_response_attached: a_response /= Void
		local
			l_cookie_order: XH_COOKIE_ORDER
		do
			create l_cookie_order.make ({XU_CONSTANTS}.Cookie_uuid, a_session.uuid, a_session.max_age)
			l_cookie_order.set_path ("/" + config.name.value)
			a_response.put_cookie_order (l_cookie_order)
		end

	new_session: XH_SESSION
			-- Startes a new session and adds it to the table
		local
			l_session: XH_SESSION
		do
			create l_session.make
			l_session.max_age := {XU_CONSTANTS}.Initial_session_length
			sessions.force (l_session, l_session.uuid)

			Result := l_session
		ensure
			Result_attached: Result /= Void
		end

invariant
	sessions_attached: sessions /= Void

end

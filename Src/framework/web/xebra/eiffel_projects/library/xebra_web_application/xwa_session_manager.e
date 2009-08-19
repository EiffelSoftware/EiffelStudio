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

	get_current_session (a_request: XH_REQUEST): XH_SESSION
			-- Returns the session that belongs to the request.
			-- XXXX
			-- XXXX
		require
			a_request_attached: a_request /= Void
		local
			l_session: detachable like get_current_session
		do
			if attached a_request.cookies [{XU_CONSTANTS}.Cookie_uuid] as l_cookie then
				l_session := sessions.item (l_cookie.value)
				if l_session /= Void and then not l_session.has_expired then
					l_session.set_needs_cookie_order (True)
				end
			end
			if l_session /= Void then
				Result := l_session
			else
				Result := new_session
			end
		ensure
			Result_attached: Result /= Void
		end

	place_cookie_order (a_session: XH_SESSION ; a_response: XH_RESPONSE)
			-- Places a cookie order into the response
		require
			a_session_attached: a_session /= Void
			a_response_attached: a_response /= Void
		local
			l_cookie_order: XH_COOKIE_ORDER
		do
			if a_session.needs_cookie_order then
				create l_cookie_order.make ({XU_CONSTANTS}.Cookie_uuid, a_session.uuid, a_session.max_age)
				a_response.put_cookie_order (l_cookie_order)
				a_session.set_needs_cookie_order (False)
			end

		end

	new_session: XH_SESSION
			-- Startes a new session and adds it to the table
		local
			l_session: XH_SESSION
		do
			create l_session.make
			l_session.max_age := {XU_CONSTANTS}.Initial_session_length
			sessions.put (l_session, l_session.uuid)
			l_session.set_needs_cookie_order (True)
			Result := l_session
		ensure
			Result_attached: Result /= Void
		end

invariant
	sessions_attached: sessions /= Void

end

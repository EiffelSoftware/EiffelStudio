note
	description: "Summary description for {WSF_SESSION}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	WSF_SESSION

feature -- Access

	id: READABLE_STRING_8
			-- Session identifier.
		deferred
		end

	uuid: READABLE_STRING_8
		obsolete
			"Use `id' which is more general [2014-03]"
		deferred
		end

	data: WSF_SESSION_DATA
			-- Data associated with current session.
		deferred
		end

	expiration: detachable DATE_TIME
			-- Expiration date for current session, if any.
		deferred
		end

	expired: BOOLEAN
			-- Is current session expired now?
		do
			Result := expired_at (create {DATE_TIME}.make_now_utc)
		end

	expired_at (dt: DATE_TIME): BOOLEAN
			-- Is current session expired at date and time `dt'?
		do
			if attached expiration as e then
				Result := e < (dt)
			end
		end

feature -- status

	is_pending: BOOLEAN
			-- New session pending to be applied?
			-- i.e: sent back to the client
		deferred
		end

	is_destroyed: BOOLEAN
			-- Is current session in destroyed state?
		deferred
		end

feature -- Entries

	table: TABLE_ITERABLE [detachable ANY, READABLE_STRING_GENERAL]
			-- Table of session data indexed by key
		do
			Result := data
		end

	item alias "[]" (k: READABLE_STRING_GENERAL): detachable ANY assign remember
			-- Session value associated with key `k'.
		do
			Result := data.item (table_key (k))
		end

	remember (v: detachable ANY; k: READABLE_STRING_GENERAL)
			-- Remember value `v' in association with key `k'.
		do
			data.force (v, table_key (k))
		end

	forget (k: READABLE_STRING_GENERAL)
			-- Forget about value associated with key `k'.
		do
			data.remove (table_key (k))
		end

feature {NONE} -- Implementation

	table_key (k: READABLE_STRING_GENERAL): STRING_32
		do
			Result := k.as_string_32
		end

feature -- Control

	destroy
			-- Destroy current session.
		deferred
		end

	commit
			-- Commit current session, including data associated.
		deferred
		end

	apply_to (h: HTTP_HEADER_MODIFIER; req: WSF_REQUEST; a_path: detachable READABLE_STRING_8)
			-- Apply current session to header `h' for request `req' and optional path `a_path'.
			-- note: either use `apply_to' or `apply', not both.
		deferred
		end

	apply (req: WSF_REQUEST; res: WSF_RESPONSE; a_path: detachable READABLE_STRING_8)
			-- Apply current session to response `res' for request `req' and optional path `a_path'.
			-- note: either use `apply' or `apply_to', not both.
		do
			apply_to (res.header, req, a_path)
		end

note
	copyright: "2011-2014, Jocelyn Fiat, Javier Velilla, Olivier Ligot, Colin Adams, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end


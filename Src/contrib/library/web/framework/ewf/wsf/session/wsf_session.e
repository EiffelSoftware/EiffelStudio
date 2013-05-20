note
	description: "Summary description for {WSF_SESSION}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	WSF_SESSION

feature -- Access		

	uuid: READABLE_STRING_8
		deferred
		end

	data: WSF_SESSION_DATA
		deferred
		end

	expiration: detachable DATE_TIME
		deferred
		end

	expired: BOOLEAN
		do
			if attached expiration as e then
				Result := e < (create {DATE_TIME}.make_now_utc)
			end
		end
feature -- status

	is_pending: BOOLEAN
			-- New session pending to be applied?
			-- i.e: sent back to the client
		deferred
		end

	is_destroyed: BOOLEAN
		deferred
		end

feature -- Entries

	table: TABLE_ITERABLE [detachable ANY, READABLE_STRING_32]
		do
			Result := data
		end

	item (k: READABLE_STRING_GENERAL): detachable ANY
		do
			Result := data.item (table_key (k))
		end

	remember (v: detachable ANY; k: READABLE_STRING_GENERAL)
		do
			data.force (v, table_key (k))
		end

	forget (k: READABLE_STRING_GENERAL)
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
		deferred
		end

	commit
		deferred
		end

	apply_to (h: HTTP_HEADER; req: WSF_REQUEST; a_path: detachable READABLE_STRING_8)
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


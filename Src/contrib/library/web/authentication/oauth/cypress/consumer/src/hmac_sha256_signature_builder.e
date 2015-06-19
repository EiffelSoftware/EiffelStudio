note
	description : "Objects that ..."
	author      : "$Author$"
	date        : "$Date$"
	revision    : "$Revision$"

class
	HMAC_SHA256_SIGNATURE_BUILDER

inherit
	SIGNATURE_BUILDER

create
	make

feature -- Access

	signed_string (s: STRING_8; a_signing_key: READABLE_STRING_8): STRING_8
		local
			h: HMAC_SHA256
		do
			create h.make_ascii_key (a_signing_key)
			h.update_from_string (s)
			Result := h.digest_as_string
		end

	signature_method: STRING_8 = "HMAC-SHA256"


note
	copyright: "2013-2013, Javier Velilla, Jocelyn Fiat, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end

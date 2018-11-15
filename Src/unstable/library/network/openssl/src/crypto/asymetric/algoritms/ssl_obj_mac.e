note
	description: "Constants from obj_mac header"
	date: "$Date$"
	revision: "$Revision$"
	EIS: "name=obj_mac.h", "src=https://github.com/openssl/openssl/blob/master/include/openssl/obj_mac.h", "protocol=uri"

class
	SSL_OBJ_MAC

feature -- Access

	NID_secp192k1: INTEGER
		external "C inline use %"eif_openssl.h%""
		alias
			"NID_secp192k1"
		end

note
	copyright: "Copyright (c) 1984-2018, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end

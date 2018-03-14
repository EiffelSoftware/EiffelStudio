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
end

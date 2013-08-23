note
	description: "Summary description for {HMAC_MD5}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	HMAC_MD5

inherit
	HMAC [MD5_HASH]

create
	make,
	make_ascii_key

feature {NONE} -- Implementation

	new_message_hash: like message_hash
			-- New message hash object.
		do
			create Result.make
		end

end -- class HMAC_MD5

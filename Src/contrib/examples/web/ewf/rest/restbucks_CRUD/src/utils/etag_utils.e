note
	description: "Summary description for {ETAG_UTILS}."
	date: "$Date$"
	revision: "$Revision$"

class
	ETAG_UTILS

feature -- Access

	md5_digest (a_string: STRING): STRING
			-- Cryptographic hash function that produces a 128-bit (16-byte) hash value, based on `a_string'
		local
			md5: MD5
		do
			create md5.make
			md5.update_from_string (a_string)
			Result := md5.digest_as_string
		end

note
	copyright: "2011-2014, Javier Velilla and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end

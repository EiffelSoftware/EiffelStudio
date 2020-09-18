note
	description: "Summary description for {STRIPE_SIGNATURE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	STRIPE_SIGNATURE

create
	make

feature {NONE} -- Initialization

	make (a_signature: detachable READABLE_STRING_32)
		local
			i,j: INTEGER
		do
			source := a_signature
			if a_signature = Void then
				is_valid := False
			else
				i := 1
				i := a_signature.substring_index ("t=", i)
				if i > 0 then
					j := a_signature.index_of (',', i + 1)
					if j > 0 then
						timestamp := a_signature.substring (i + 2, j - 1).to_integer
					else
						timestamp := a_signature.substring (i + 2, a_signature.count).to_integer
					end
					i := j + 1
				end
				if i <= a_signature.count then
					i := a_signature.substring_index ("v1=", i)
					if i > 0 then
						j := a_signature.index_of (',', i + 1)
						if j > 0 then
							v1 := a_signature.substring (i + 3, j - 1).to_string_8
						else
							v1 := a_signature.substring (i + 3, a_signature.count).to_string_8
						end
						i := j + 1
					end
				end
				if i <= a_signature.count then
					i := a_signature.substring_index ("v0=", i)
					if i > 0 then
						j := a_signature.index_of (',', i + 1)
						if j > 0 then
							v0 := a_signature.substring (i + 3, j - 1).to_string_8
						else
							v0 := a_signature.substring (i + 3, a_signature.count).to_string_8
						end
						i := j + 1
					end
				end
				is_valid := timestamp > 0 and (v1 /= Void or v0 /= Void)
			end
		end

feature -- Access

	source: detachable READABLE_STRING_32

	timestamp: INTEGER

	v1: detachable READABLE_STRING_8

	v0: detachable READABLE_STRING_8

feature	-- Status report

	is_valid: BOOLEAN

	is_content_verified (a_content: READABLE_STRING_8; a_signing_secret: detachable READABLE_STRING_8): BOOLEAN
		local
			hs256: HMAC_SHA256
			msg: STRING
		do
			if a_signing_secret = Void then
				Result := False -- Could not verify!
			elseif is_valid and then attached v1 as l_v1 then
				create msg.make (10 + a_content.count)
				msg.append (timestamp.out)
				msg.append_character ('.')
				msg.append (a_content)
				msg.prune_all ('%R')
				create hs256.make_ascii_key (a_signing_secret)
				hs256.update_from_string (msg)
				Result := hs256.lowercase_hexadecimal_string_digest.is_case_insensitive_equal (l_v1)
			end
		end

end

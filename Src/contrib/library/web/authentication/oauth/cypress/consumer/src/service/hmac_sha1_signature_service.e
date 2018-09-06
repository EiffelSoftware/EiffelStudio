note
	description: "Summary description for {HMAC_SHA1_SIGNATURE_SERVICE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	HMAC_SHA1_SIGNATURE_SERVICE

inherit
	SIGNATURE_SERVICE

	OAUTH_SHARED_ENCODER

feature -- Access

	signature (base_string: READABLE_STRING_8; api_secret: READABLE_STRING_GENERAL; token_secret: READABLE_STRING_GENERAL): STRING_8
			-- Return a signature
			-- `base_string' url-encoded string to sign
			-- `api_secret' api secret for your app
			-- `token_secret' token secret (empty string for the request token step)
		local
			l_encoder: OAUTH_ENCODER
		do
			l_encoder := oauth_encoder
			Result := do_sign (base_string, l_encoder.encoded_string (api_secret) + "&" + l_encoder.encoded_string (token_secret))
		end

  	signature_method: STRING = "HMAC-SHA1"
			-- Algorithm used for the signature.

feature {NONE} --Implementation

 	Empty_string: STRING = "";

  	Carriage_return: STRING = "%R"

  	Utf8: STRING = "UTF-8"

	do_sign (to_sign: READABLE_STRING_8; key: READABLE_STRING_8): STRING
		local
			l_hmac_sha1: HMAC_SHA1
		do
			create l_hmac_sha1.make_ascii_key (key)
			l_hmac_sha1.update_from_string (to_sign)
			Result := encode_base_64(byte_array (l_hmac_sha1.digest))
			Result.replace_substring_all (Carriage_return, Empty_string)
		end

feature {NONE} -- Encoding Byte Array Implementation		

	byte_array (a_bytes: SPECIAL [NATURAL_8]) : SPECIAL [INTEGER_8]
		local
			i: INTEGER
		do
			create Result.make_filled (0,a_bytes.count)
			across a_bytes as c
				loop
   					Result.put(to_byte(c.item.as_integer_8), i)
					i := i + 1
				end
		end

	to_byte (a_val: INTEGER) : INTEGER_8
			-- takes a value between 0 and 255
			-- Result :-128 to 127
		do
			if a_val >= 128 then
				Result := (-256 + a_val).to_integer_8
			else
				Result := a_val.to_integer_8
			end
		ensure
			result_value :  127 >= Result and Result >= -128
		end

	encode_base_64 (bytes: SPECIAL [INTEGER_8]): STRING_8
			-- Encodes a byte array into a STRING doing base64 encoding.
		local
			l_output : SPECIAL [INTEGER_8]
			l_remaining : INTEGER
			i,ptr: INTEGER
			char : CHARACTER
		do
			create l_output.make_filled (0, ((bytes.count + 2)//3)*4)
			l_remaining := bytes.count
			from
				i := 0
				ptr := 0
			until
				l_remaining <= 3
			loop
				l_output[ptr] := encode_value (bytes[i] |>> 2)
				ptr := ptr + 1
				l_output[ptr] := encode_value (((bytes[i] & 0x3) |<< 4 ) | ((bytes[i + 1] |>> 4) & 0xF))
				ptr := ptr + 1
			    l_output[ptr] := encode_value (((bytes[i + 1] & 0xF) |<< 2) | ((bytes[i + 2] |>> 6) & 0x3))
			    ptr := ptr + 1
		        l_output[ptr] := encode_value (bytes[i + 2] & 0x3F)
				ptr := ptr + 1
				l_remaining := l_remaining -3
				i := i + 3
			end
			 -- encode when exactly 1 element (left) to encode
	        char := '='
	        if l_remaining = 1 then
	            l_output[ptr] := encode_value (bytes[i] |>> 2)
	            ptr := ptr + 1
	            l_output[ptr] := encode_value (((bytes[i]) & 0x3) |<< 4)
	            ptr := ptr + 1
	            l_output[ptr] := char.code.as_integer_8
	            ptr := ptr + 1
	            l_output[ptr] := char.code.as_integer_8
	        	ptr := ptr + 1
	        end

	         -- encode when exactly 2 elements (left) to encode
	        if l_remaining = 2 then
	            l_output[ptr] := encode_value (bytes[i] |>> 2)
	            ptr := ptr + 1
	            l_output[ptr] := encode_value (((bytes[i] & 0x3) |<< 4)| ((bytes[i + 1] |>> 4) & 0xF));
	            ptr := ptr + 1
	            l_output[ptr] := encode_value ((bytes[i + 1] & 0xF) |<< 2);
	            ptr := ptr + 1
	            l_output[ptr] := char.code.as_integer_8
	            ptr := ptr + 1
	     	end
	     	Result := ""
	     	across l_output as elem
	     		loop
	     			Result.append_character (elem.item.to_character_8)
	     		end
		end

	base64_map: SPECIAL [CHARACTER_8]
			-- Table for Base64 encoding
		once
			Result := ("ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/").area
		end

	encode_value (i: INTEGER_8): INTEGER_8
		do
			Result := base64_map[i & 0x3F].code.as_integer_8
		end

note
	copyright: "2013-2015, Javier Velilla, Jocelyn Fiat, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end

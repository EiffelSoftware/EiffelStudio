note
	description: "Summary description for {STRING_HELPER}."
	date: "$Date$"
	revision: "$Revision$"

class
	STRING_HELPER

feature -- Access

	is_blank (s: detachable READABLE_STRING_32): BOOLEAN
		local
			i,n: INTEGER
		do
			Result := True
			if s /= Void then
				from
					i := 1
					n := s.count
				until
					i > n or not Result
				loop
					Result := s[i].is_space
					i := i + 1
				end
			end
		end

	indented_text (pre: READABLE_STRING_8; t: READABLE_STRING_8): READABLE_STRING_8
			-- Indendted text.
		local
			s8: STRING_8
		do
			s8 := t.string
			s8.prepend (pre)
			s8.replace_substring_all ("%N", "%N" + pre)
			Result := s8
		end


	json_encode (a_string: READABLE_STRING_GENERAL): STRING
			-- json encode `a_string'.
		local
			encode: SHARED_JSON_ENCODER
		do
			create encode
			Result := encode.json_encoder.encoded_string (a_string)
			debug
				print ("%NResult" + Result)
			end
		end

end

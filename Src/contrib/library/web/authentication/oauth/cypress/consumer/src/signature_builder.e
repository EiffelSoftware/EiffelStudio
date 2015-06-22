note
	description: "Summary description for {SIGNATURE_BUILDER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	SIGNATURE_BUILDER

feature {NONE} -- Initialization

	make
		do
		end

feature -- Factory

	signature (a_prefix: detachable ARRAY [READABLE_STRING_32]; tb: HASH_TABLE [STRING_32, STRING_32]; a_signing_key: READABLE_STRING_8): STRING_8
			-- Generate a unique token
		local
			s: STRING_8
			l_keys: ARRAYED_LIST [STRING_32]
			l_sort: QUICK_SORTER [STRING_32]
			l_comp: COMPARABLE_COMPARATOR [STRING_32]
		do
			create l_keys.make (tb.count)
			across
				tb as c
			loop
				l_keys.force (c.key)
			end

			create l_comp
			create l_sort.make (l_comp)
			l_sort.sort (l_keys)

			if a_prefix /= Void and then not a_prefix.is_empty then
				create Result.make (128)
				across
					a_prefix as p
				loop
					if not Result.is_empty then
						Result.append_character ('&')
					end
					Result.append (url_encoded_string (p.item))
				end
			else
				create Result.make_empty
			end

			create s.make (128)
			across
				l_keys as k
			loop
				if attached tb.item (k.item) as v then
					if not s.is_empty then
						s.append_character ('&')
					end
					s.append (url_encoded_string (k.item))
					s.append_character ('=')
					s.append (url_encoded_string (v))
				end
			end
			s := url_encoded_string (s)
			if not Result.is_empty then
				Result.append_character ('&')
			end
			Result.append (s)
			if attached signed_string ("", "") as r then
				print (r)
			end
			if attached signed_string ("The quick brown fox jumps over the lazy dog", "key") as r then
				print (r)
			end


			Result := base64.encoded_string (signed_string (Result, a_signing_key))

		end

	signed_string (s: STRING_8; a_signing_key: READABLE_STRING_8): STRING_8
		deferred
		end

	signature_method: STRING_8
		deferred
		end

feature {NONE} -- Implementation

	url_encoded_string (s: READABLE_STRING_GENERAL): STRING_8
		do
			Result := url_encoder.general_encoded_string (s)
		end

	url_encoder: URL_ENCODER
		once
			create Result
		end

	base64: BASE64
		once
			create Result
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

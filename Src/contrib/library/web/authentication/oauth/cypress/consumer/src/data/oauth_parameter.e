note
	description: "Objects that represent an OAuth Parameter"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	OAUTH_PARAMETER

inherit

	COMPARABLE

create
	make

feature {NONE} --Initialization

	make (a_key: READABLE_STRING_8; a_value: READABLE_STRING_8)
		do
			key := a_key
			value := a_value
		end

feature -- Access

	key: READABLE_STRING_8

	value: READABLE_STRING_8

feature -- Conversion

	as_url_encoded: STRING_8
		local
			l_outh_encoder: OAUTH_ENCODER
		do
			create l_outh_encoder
			Result := l_outh_encoder.encoded_string (key)
			Result.append ("=")
			Result.append (l_outh_encoder.encoded_string (value))
		end

feature -- Comparision

	is_less alias "<" (other: like Current): BOOLEAN
			-- Is current object less than `other'?
		do
			if key.is_less (other.key) then
				Result := True
			elseif key.is_equal (other.key) and then value.is_less (other.value) then
				Result := True
			end
		end

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

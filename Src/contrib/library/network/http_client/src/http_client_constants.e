note
	date: "$Date$"
	revision: "$Revision$"

class
	HTTP_CLIENT_CONSTANTS

feature -- Auth type

	auth_type_id (a_auth_type_string: READABLE_STRING_8): INTEGER
		do
			if a_auth_type_string.is_case_insensitive_equal ("basic") then
				Result := Auth_type_basic
			elseif a_auth_type_string.is_case_insensitive_equal ("digest") then
				Result := Auth_type_digest
			elseif a_auth_type_string.is_case_insensitive_equal ("any") then
				Result := Auth_type_any
			elseif a_auth_type_string.is_case_insensitive_equal ("anysafe") then
				Result := Auth_type_anysafe
			elseif a_auth_type_string.is_case_insensitive_equal ("none") then
				Result := Auth_type_none
			end
		end	

	Auth_type_none: INTEGER = 0
	Auth_type_basic: INTEGER = 1
	Auth_type_digest: INTEGER = 2
	Auth_type_any: INTEGER = 3
	Auth_type_anysafe: INTEGER = 4

note
	copyright: "2011-2020, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	revised_by: "Alexander Kogtenkov"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end

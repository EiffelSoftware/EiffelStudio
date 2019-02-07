note
	description: "Object Represent a Mock JWT Algorithm with Name RS512 and Digital Signature Algorithm"
	date: "$Date$"
	revision: "$Revision$"

class
	JWT_ALG_RS512
inherit

	JWT_ALG

feature -- Access

	name: STRING = "RS512"

	encoded_string (a_message: READABLE_STRING_8; a_secret: READABLE_STRING_8): STRING
		do
			Result := ""
		end
note
	copyright: "2013-2018, Javier Velilla, Jocelyn Fiat, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
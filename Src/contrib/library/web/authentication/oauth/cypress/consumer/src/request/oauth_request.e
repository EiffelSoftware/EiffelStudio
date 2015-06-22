note
	description: "Objects that represent an OAUTH REQUEST"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	OAUTH_REQUEST

inherit
	BASE_REQUEST
		rename
			make as make_request
		end

create
	make

feature {NONE} -- Initialization

	make (a_http_method: READABLE_STRING_8; a_url: READABLE_STRING_8)
		do
			make_request (a_http_method, a_url)
			create oauth_parameters.make (0)
		ensure
			parameters_set: oauth_parameters.is_empty
		end

feature -- Access

	oauth_parameters: HASH_TABLE [STRING_8, STRING_8]
			-- Oauth oauth_parameters

	is_valid_key (key: READABLE_STRING_GENERAL): BOOLEAN
			-- is the key a valid OAuth key parameter?
		do
			if key.starts_with (oauth_prefix) or else key.same_string (({OAUTH_CONSTANTS}.scope)) then
				Result := True
			else
					--OAuth oauth_parameters must start with `oauth' or it should be `scope'
					--| we need logging or report this as an ERROR
			end
		end

feature -- Add Parameters

	add_parameter (key: READABLE_STRING_8; value: READABLE_STRING_8)
			-- Add an OAuth parameter with value `value' and key `key'
		require
			-- valid_key
		do
			oauth_parameters.force (value, key)
		ensure
			parameter_added: oauth_parameters.has (key)
		end

feature {NONE} -- Implementation

	Oauth_prefix: STRING = "oauth_"

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

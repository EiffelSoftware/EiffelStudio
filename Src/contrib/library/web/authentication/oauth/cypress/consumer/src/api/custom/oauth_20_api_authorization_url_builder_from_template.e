note
	description : "Objects to build authorization_url from template and config"
	author      : "$Author$"
	date        : "$Date$"
	revision    : "$Revision$"

class
	OAUTH_20_API_AUTHORIZATION_URL_BUILDER_FROM_TEMPLATE

inherit
	OAUTH_SHARED_ENCODER

create
	make

feature {NONE} -- Initialization

	make (tpl: like template)
			-- Initialize `Current'.
		do
			template := tpl
		end

feature -- Access

	template: STRING
			-- Template used to compute `authorization_url'

	authorization_url (config: OAUTH_CONFIG): detachable STRING_8
		local
			tpl: like template
		do
			tpl := template
			create Result.make_from_string (template)
			Result.replace_substring_all ("$CLIENT_ID", config.api_key)
			if attached config.callback as l_callback then
				Result.replace_substring_all ("$REDIRECT_URI", oauth_encoder.encoded_string (l_callback))
			end
			if attached config.scope as l_scope then
				Result.replace_substring_all ("$SCOPE", oauth_encoder.encoded_string (l_scope))
			end
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

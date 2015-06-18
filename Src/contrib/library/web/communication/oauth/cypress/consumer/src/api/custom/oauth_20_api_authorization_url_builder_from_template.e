note
	description : "Objects to build authorization_url from template and config"
	author      : "$Author$"
	date        : "$Date$"
	revision    : "$Revision$"

class
	OAUTH_20_API_AUTHORIZATION_URL_BUILDER_FROM_TEMPLATE

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

	authorization_url (config: OAUTH_CONFIG): detachable READABLE_STRING_GENERAL
		local
			tpl: like template
			l_result: STRING_8
		do
			tpl := template
			create l_result.make_from_string (template)
			l_result.replace_substring_all ("$CLIENT_ID", config.api_key.as_string_8)
			if attached config.callback as l_callback then
				l_result.replace_substring_all ("$REDIRECT_URI", (create {OAUTH_ENCODER}).encoded_string (l_callback.as_string_32))
			end
			if attached config.scope as l_scope then
				l_result.replace_substring_all ("$SCOPE", (create {OAUTH_ENCODER}).encoded_string (l_scope.as_string_32))
			end
			Result := l_result
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

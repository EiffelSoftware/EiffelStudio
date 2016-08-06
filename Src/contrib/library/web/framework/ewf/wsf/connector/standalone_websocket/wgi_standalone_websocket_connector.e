note
	description: "Summary description for {WGI_STANDALONE_WEBSOCKET_CONNECTOR}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	WGI_STANDALONE_WEBSOCKET_CONNECTOR [G -> WGI_EXECUTION create make end]

inherit
	WGI_STANDALONE_CONNECTOR [G]
		redefine
			name, version
		end

create
	make,
	make_with_base

feature -- Access

	name: STRING_8
			-- Name of Current connector
		once
			Result := "ws_httpd"
		end

	version: STRING_8
			-- Version of Current connector
		once
			Result := "1.0"
		end

note
	copyright: "2011-2016, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end

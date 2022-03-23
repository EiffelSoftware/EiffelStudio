note
	description: "[
			Generic Web API Response.
		]"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	WEBAPI_RESPONSE

inherit
	CMS_RESPONSE_I

feature -- Status report

	is_root: BOOLEAN
			-- Is current response related to root api endpoint?
		local
			l_path_info: READABLE_STRING_8
		do
			l_path_info := request.percent_encoded_path_info
			if l_path_info.ends_with_general ("/") then
				l_path_info := l_path_info.substring (1, l_path_info.count - 1)
			end
			Result := l_path_info.same_string (api.webapi_base_url)
		end

feature -- Execution

	execute
		do
			api.hooks.invoke_webapi_response_alter (Current)
			process
		end

	process
			-- Execute Current webapi response.
		deferred
		end

note
	copyright: "2011-2022, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end

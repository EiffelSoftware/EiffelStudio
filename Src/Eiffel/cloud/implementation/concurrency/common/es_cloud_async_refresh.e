note
	description: "[
			Asynchronous call to refresh_token.
		]"
	status: "Under development, currently not used!"
	date: "$Date$"
	revision: "$Revision$"

class
	ES_CLOUD_ASYNC_REFRESH

inherit
	ES_CLOUD_ASYNC_JOB
		rename
			make as old_make
		end

create
	make

feature {NONE} -- Initialization

	make (a_service: ES_CLOUD_S; a_access_token: ES_ACCOUNT_ACCESS_TOKEN; cfg: ES_CLOUD_CONFIG)
		require
			has_refresh_key: a_access_token.has_refresh_key
		do
			old_make (a_service, cfg)
			access_token := a_access_token
		end

feature {NONE} -- Access

	access_token: ES_ACCOUNT_ACCESS_TOKEN

	server_url: IMMUTABLE_STRING_8
		do
			Result := config.server_url
		end

feature {NONE} -- Output

	refreshed_token: detachable ES_ACCOUNT_ACCESS_TOKEN

feature -- Access

	post_execute
		do
			if attached refreshed_token as tok then
			end
		end

	pre_execute
		do
			refreshed_token := Void
		end

	execute
		local
			wapi: ES_CLOUD_API
		do
			if attached access_token.refresh_key as k then
				wapi := web_api
				refreshed_token := wapi.refreshing_token (access_token.token, k)
			end
		end

note
	copyright: "Copyright (c) 1984-2020, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end

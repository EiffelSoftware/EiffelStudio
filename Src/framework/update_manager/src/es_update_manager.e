note
	description: "API to Manage the update of EiffelStudio releases"
	date: "$Date$"
	revision: "$Revision$"

class
	ES_UPDATE_MANAGER

create
	make

feature {NONE} -- Initialization

	make (a_config: ES_UPDATE_CLIENT_CONFIGURATION)
			-- Initialize `Current'.
		do
			config := a_config
			client := (create {DEFAULT_HTTP_CLIENT}).new_session (service_url)
			client.set_timeout (config.connection_timeout)
			client.set_is_insecure (True)
			client.set_ciphers_setting ("TLSv1")
			client.set_any_auth_type
			client.set_ciphers_setting ("TLSv1")
		end

	config: ES_UPDATE_CLIENT_CONFIGURATION
			-- client configuration.

feature -- Access

	last_error: detachable READABLE_STRING_32
			-- last error detail, if any.

	client: HTTP_CLIENT_SESSION
			-- Http client session.

feature -- API

	available_release_update_for_any_channel (a_platform: READABLE_STRING_8; a_major, a_minor: NATURAL_16; a_patch: NATURAL_32): detachable ES_UPDATE_RELEASE
			-- Verify if there is an available release update.
			-- Check the latest stable and beta releases for the given platform
			-- `platform` and if the version is newest than the current eiffel studio version
			-- it retuns the release update information in other case Void.
		local
			l_beta_release: ES_UPDATE_RELEASE
			l_stable_release: ES_UPDATE_RELEASE
			l_final: ES_UPDATE_RELEASE
		do
			l_beta_release := latest_release_by_platform ({ES_UPDATE_CONSTANTS}.beta_channel, a_platform)
			l_stable_release := latest_release_by_platform ({ES_UPDATE_CONSTANTS}.stable_channel, a_platform)
			if
				l_beta_release /= Void and then
				l_stable_release /= Void
			then
				l_final := l_beta_release.max (l_stable_release)
				if l_final.is_greater (a_major, a_minor, a_patch) then
					if l_beta_release.is_greater_than (l_stable_release) then
						Result := l_beta_release
					else
						Result := l_stable_release
					end
				end
			elseif l_beta_release /= Void then
				if l_beta_release.is_greater (a_major, a_minor, a_patch) then
					Result := l_beta_release
				end
			elseif l_stable_release /= Void then
				if l_stable_release.is_greater (a_major, a_minor, a_patch) then
					Result := l_stable_release
				end
			end
		end

	available_release_update_for_channel (a_channel: READABLE_STRING_8; a_platform: READABLE_STRING_8; a_major, a_minor: NATURAL_16; a_patch: NATURAL_32): detachable ES_UPDATE_RELEASE
			-- Verify if there is an available beta release update.
			-- Check the latest release for the given channel `a_channel` and platform
			-- `a_platform` and if the version is newest than the current eiffel studio version
			-- it retuns the release update information in other case Void.
		require
			valid_channel: is_valid_channel (a_channel)
		do
			Result := latest_release_by_platform (a_channel, a_platform)
			if
				Result /= Void and then
				not Result.is_greater (a_major, a_minor, a_patch)
			then
				Result := Void
			end
			if
				Result = Void and then
				not a_channel.is_case_insensitive_equal_general ({ES_UPDATE_CONSTANTS}.stable_channel)
			then
					-- Always check in `stable` channel
				Result := available_release_update_for_channel ({ES_UPDATE_CONSTANTS}.stable_channel, a_platform, a_major, a_minor, a_patch)
			end
		end

	is_valid_channel (a_channel: READABLE_STRING_8): BOOLEAN
				-- Is `a_channel` a valid channel?
			do
				Result := a_channel.is_case_insensitive_equal ({ES_UPDATE_CONSTANTS}.beta_channel)
						or else a_channel.is_case_insensitive_equal ({ES_UPDATE_CONSTANTS}.stable_channel)
			end

feature {NONE} -- Implementation

	latest_release_by_platform (a_channel: READABLE_STRING_8; a_platform: READABLE_STRING_8): detachable ES_UPDATE_RELEASE
		require
			valid_channel: is_valid_channel (a_channel)
		do
			if attached {JSON_OBJECT} json_response_for_get_request (config.channel_endpoint (a_channel), Void) as jo then
				Result := internal_release_by_platform (jo, a_platform, a_channel)
			end
		end

feature -- Status report

	is_update_service_accessible: BOOLEAN
			-- Indicates if access to the update service site is available
		do
			Result := client.is_available
		ensure
			support_accessible: Result implies client.is_available
		end

feature {NONE} -- Constants

	service_url: STRING = ""
			-- service url setup.

feature {NONE} -- Retrieve URL

	json_response_for_get_request (a_path: READABLE_STRING_GENERAL; ctx: detachable HTTP_CLIENT_REQUEST_CONTEXT): detachable JSON_VALUE
			-- Response for GET request based on Current, `a_path' and `ctx'.
		local
			l_http_response: STRING_8
			l_ctx: detachable HTTP_CLIENT_REQUEST_CONTEXT
			l_body: detachable READABLE_STRING_8
			l_url: READABLE_STRING_8
		do
			l_ctx := ctx
			if l_ctx = Void then
				create l_ctx.make
			end
			l_ctx.add_header ("Accept", config.media_type)
			l_url := a_path.to_string_8
			if attached client.get (l_url, l_ctx) as g_response then
				l_url := g_response.url
				l_body := g_response.body
				debug
					create l_http_response.make_empty
					l_http_response.append ("Status: " + g_response.status.out + "%N")
					l_http_response.append (g_response.raw_header)
					if attached g_response.error_message as l_message then
						l_http_response.append (" ")
						l_http_response.append (l_message)
					end
					if l_body /= Void then
						l_http_response.append ("%N%N")
						l_http_response.append (l_body)
					end
				end
				if
					l_body /= Void and then
					not l_body.is_empty and then
					attached json (l_body) as j
				then
					Result := j
				end
			end
		end

	internal_release_by_platform (a_json: JSON_OBJECT; a_platform: READABLE_STRING_8; a_channel: READABLE_STRING_8): detachable ES_UPDATE_RELEASE
			-- Given a JSON object, get a release filtered by platform `a_platform`.
		local
			l_revision: NATURAL_32
		do
			if
				attached a_json.string_item ("number") as j_number and then
				attached {JSON_ARRAY} a_json.item ("downloads") as j_downloads
			then
				if attached a_json.string_item ("build") as j_build then
					l_revision := j_build.unescaped_string_8.to_natural_32
				else
					l_revision := 0
				end
				across
					j_downloads as ic
				until
					Result /= Void
				loop
					if
						attached {JSON_OBJECT} ic as l_jo and then
						attached l_jo.string_item ("platform") as j_platform and then
						attached l_jo.string_item ("filename") as j_filename and then
						attached l_jo.string_item ("href") as j_link and then
						j_platform.same_caseless_string (a_platform)
					then
						create Result.make (a_channel, j_filename.unescaped_string_32, a_platform, j_link.unescaped_string_8, j_number.unescaped_string_8, l_revision)
					end
				end
			end
		end

	json (s: READABLE_STRING_8): detachable JSON_VALUE
			-- Parse the string `s` as JSON.
		local
			p: JSON_PARSER
		do
			create p.make_with_string (s)
			p.parse_content
			if p.is_valid then
				Result := p.parsed_json_value
			end
		end

note
	copyright: "Copyright (c) 1984-2023, Eiffel Software"
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

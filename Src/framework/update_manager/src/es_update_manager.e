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

	has_update_release_by_platform (a_platform: READABLE_STRING_8; a_current_version: READABLE_STRING_8): detachable ES_UPDATE_RELEASE
			-- Verify if there is an available release update.
			-- Check the latest stable and beta releases for the given platform
			-- `platform` and if the version is newest than the current eiffel studio version
			-- it retuns the release update information in other case Void.
		local
			cfg: ES_UPDATE_CLIENT_CONFIGURATION
			api: ES_UPDATE_MANAGER
			l_beta_release: ES_UPDATE_RELEASE
			l_stable_release: ES_UPDATE_RELEASE
			l_final: STRING
		do
			l_beta_release := latest_beta_release_by_platform (a_platform)
			l_stable_release := latest_stable_release_by_platform (a_platform)
			if attached l_beta_release and then attached l_stable_release then
				l_final := l_beta_release.number.max (l_stable_release.number)
				if l_final.is_greater (A_current_version) then
					Result := if l_beta_release.number > l_stable_release.number then l_beta_release else l_stable_release end
				end
			elseif attached l_beta_release then
				Result := if l_beta_release.number > a_current_version then l_beta_release else Void end
			elseif attached l_stable_release then
				Result := if l_stable_release.number > a_current_version then l_stable_release else Void end
			end

		end

	has_update_release_by_channel_and_platform (a_channel: READABLE_STRING_8; a_platform: READABLE_STRING_8; a_current_version: READABLE_STRING_8): detachable ES_UPDATE_RELEASE
			-- Verify if there is an available beta release update.
			-- Check the latest release for the given channel `a_channel` and platform
			-- `a_platform` and if the version is newest than the current eiffel studio version
			-- it retuns the release update information in other case Void.
		require
			valid_channel: is_valid_channel (a_channel)
		local
			cfg: ES_UPDATE_CLIENT_CONFIGURATION
			api: ES_UPDATE_MANAGER
			l_release: ES_UPDATE_RELEASE
			l_final: STRING
		do
			if a_channel.is_case_insensitive_equal ({ES_UPDATE_CONSTANTS}.beta_channel) then
				l_release := latest_beta_release_by_platform (a_platform)
			else
				l_release := latest_stable_release_by_platform (a_platform)
			end
			if attached l_release as ll_release and then ll_release.number.is_greater (a_current_version) then
				Result := ll_release
			end
		end


	is_valid_channel (a_channel: READABLE_STRING_8): BOOLEAN
				-- Is channel `a_channel` a valid one (stable|beta)?
			do
				Result := a_channel.is_case_insensitive_equal ({ES_UPDATE_CONSTANTS}.beta_channel) or else a_channel.is_case_insensitive_equal ({ES_UPDATE_CONSTANTS}.stable_channel)
			end

feature {NONE} -- Implementation

	latest_stable_release_by_platform (a_platform: READABLE_STRING_8): detachable ES_UPDATE_RELEASE
		do
			Result := internal_release_by_platform (latest_stable_release, a_platform, {ES_UPDATE_CONSTANTS}.stable_channel)
		end

	latest_beta_release_by_platform (a_platform: READABLE_STRING_8): detachable ES_UPDATE_RELEASE
		do
			Result := internal_release_by_platform (latest_beta_release, a_platform, {ES_UPDATE_CONSTANTS}.beta_channel)
		end

	latest_stable_release: JSON_VALUE
		local
			l_url: STRING
		do
			create l_url.make_from_string (config.service_root)
			l_url.append (stable_channel)
			Result := get (l_url, Void)
		end

	latest_beta_release: JSON_VALUE
		local
			l_url: STRING
		do
			create l_url.make_from_string (config.service_root)
			l_url.append (beta_channel)
			Result := get (l_url, Void)
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

	get (a_path: READABLE_STRING_GENERAL; ctx: detachable HTTP_CLIENT_REQUEST_CONTEXT): JSON_VALUE
			-- Response for GET request based on Current, `a_path' and `ctx'.
		local
			l_http_response: STRING_8
			l_ctx: detachable HTTP_CLIENT_REQUEST_CONTEXT
			l_url: STRING_8
			l_status: INTEGER
		do
			create {JSON_OBJECT} Result.make_empty

			create l_http_response.make_empty
			l_ctx := ctx
			if l_ctx = Void then
				create l_ctx.make
			end
			l_ctx.add_header ("Accept", config.media_type)
			l_url := a_path.to_string_8
			if attached client.get (l_url, l_ctx) as g_response then
				l_url := g_response.url
				debug
					l_http_response.append ("Status: " + g_response.status.out + "%N")
					l_http_response.append (g_response.raw_header)
					l_status := g_response.status
				end
				if attached g_response.error_message as l_message then
					debug
						l_http_response.append (" ")
						l_http_response.append (l_message)
					end
				end
				if attached g_response.body as l_body then
					debug
						l_http_response.append ("%N%N")
						l_http_response.append (l_body)
					end
					if not l_body.is_empty and then attached json (l_body) as j then
						Result := j
					end
				end
			end
		end

	internal_release_by_platform (a_json: JSON_VALUE; a_platform: READABLE_STRING_8; a_channel: READABLE_STRING_8): detachable ES_UPDATE_RELEASE
			--Given a JSON object, get a release filtered by platform `a_platform`.
		local
			found: BOOLEAN
		do
			if attached {JSON_OBJECT} a_json as jo and then attached {JSON_STRING} jo.item ("number") as l_number and then attached {JSON_ARRAY} jo.item ("downloads") as l_download then
				across
					l_download as ic
				loop
					if not found then
						if attached {JSON_OBJECT} ic.item as l_jo and then attached {JSON_STRING} l_jo.item ("platform") as l_platform and then attached {JSON_STRING} l_jo.item ("filename") as l_filename and then attached {JSON_STRING} l_jo.item ("href") as l_link and then l_platform.unescaped_string_8.is_case_insensitive_equal_general (a_platform) then
							found := True
							create Result.make (a_channel, l_filename.unescaped_string_8, a_platform, l_link.unescaped_string_8, l_number.unescaped_string_8)
						end
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
			if p.is_valid and then attached p.parsed_json_value as v then
				Result := v
			end
		end

	initialize_context_header (ctx: HTTP_CLIENT_REQUEST_CONTEXT)
			-- Intialize context `ctx`.
		do
		end

	stable_channel: STRING = "/api/downloads/channel/stable"
			-- path part of Stable URL.

	beta_channel: STRING = "/api/downloads/channel/beta"
			-- -- path part of Beta URL.
end

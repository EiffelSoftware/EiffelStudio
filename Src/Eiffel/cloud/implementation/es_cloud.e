note
	description: "Summary description for {ES_CLOUD}."
	date: "$Date$"
	revision: "$Revision$"

class
	ES_CLOUD

inherit
	ES_CLOUD_S
		redefine
			on_account_signed_in,
			view_account_website_url,
			on_cloud_available
		end

	DISPOSABLE_SAFE

	EIFFEL_LAYOUT

	SHARED_EIFFEL_PROJECT

create
	make,
	make_with_url

feature {NONE} -- Creation

	make
		do
			make_with_url (default_server_url)
		end

	make_with_url (a_server_url: READABLE_STRING_8)
		local
			cfg: ES_CLOUD_CONFIG
			env: ES_INSTALLATION_ENVIRONMENT
			i: INTEGER
			ua: STRING_8
		do
			create cfg.make (a_server_url)
			config := cfg

			if is_eiffel_layout_defined then
					-- On Windows: Computer\HKEY_CURRENT_USER\Software\ISE\Eiffel_MM.mm\installation\es_cloud\$variable_name
				create env.make (eiffel_layout)
				create ua.make_from_string ("EiffelStudio/" + eiffel_layout.version_name)
				ua.append (" (" + eiffel_layout.eiffel_platform + ")")
				cfg.set_user_agent (ua)

					-- preferred http client, to workaround some network or security issues.
				if
					is_eiffel_layout_defined and then
					attached eiffel_layout.get_environment_32 ("ES_CLOUD_PREFERRED_HTTP_CLIENT") as v and then
					not v.is_whitespace
				then
					cfg.set_preferred_http_client (v)
				elseif
					attached {READABLE_STRING_GENERAL} env.application_item ("preferred_http_client", "es_cloud", eiffel_layout.version_name) as v and then
					not v.is_whitespace
				then
					cfg.set_preferred_http_client (v)
				end
				if
					attached env.application_item ("timeout", "es_cloud", eiffel_layout.version_name) as v and then
					v.is_integer
				then
					i := v.to_integer
					if i >= 0 then
						cfg.set_timeout (i)
					end
				end
				if
					attached env.application_item ("connection_timeout", "es_cloud", eiffel_layout.version_name) as v and then
					v.is_integer
				then
					i := v.to_integer
					if i >= 0 then
						cfg.set_connection_timeout (i)
					end
				end
				if
					attached env.application_item ("verbose", "es_cloud", eiffel_layout.version_name) as v and then
					v.is_integer
				then
					i := v.to_integer
					if i >= 0 then
						cfg.set_verbose_level (i)
					end
				end
			end

			if is_eiffel_layout_defined then
				version := eiffel_layout.version_name
				get_local_installation (eiffel_layout)
				accounts_location := eiffel_layout.hidden_files_path.extended ("accounts")
				if eiffel_layout.is_workbench then
					accounts_location := accounts_location.extended ("workbench")
				end
			else
				version := "unknown"
				create installation.make_with_id ("")
			end
				-- Initialization
			session_heartbeat := cfg.default_session_heartbeat -- in minutes
			load
		end

feature {NONE} -- Default

	default_server_url: STRING
		do
			Result := "https://account.eiffel.com/api" -- Default
			debug ("es_cloud")
				-- On Windows: Computer\HKEY_CURRENT_USER\Software\ISE\Eiffel_MM.mm\installation\es_cloud\default_server_url
				if
					is_eiffel_layout_defined and then
					attached (create {ES_INSTALLATION_ENVIRONMENT}.make (eiffel_layout)).application_item ("default_server_url", "es_cloud", eiffel_layout.version_name) as v
					and then v.is_valid_as_string_8
				then
						-- For now, it is possible to change the server url this way.
					Result := v.to_string_8
				end
				if attached eiffel_layout.get_environment_8 ("ES_CLOUD_SERVER_URL") as l_env_url then
					Result := l_env_url
				end
				print ("Use cloud url: " + Result + "%N")
			end
		end

feature {NONE} -- Initialization

	get_local_installation (env: EIFFEL_ENV)
		local
			inst: ES_INSTALLATION_ENVIRONMENT
			s: detachable READABLE_STRING_32
			v: STRING
			l_id: STRING_32
			l_app_name: STRING
			i,n: INTEGER
			l_var_name: READABLE_STRING_8
			syscsts: SYSTEM_CONSTANTS
		do
			create inst.make (eiffel_layout)
			l_app_name := env.product_name
			l_var_name := env.eiffel_platform + "_installation_id"
			s := inst.application_item (l_var_name, l_app_name, env.version_name)
			if s /= Void and then s.has_substring (env.version_name) and then s.is_valid_as_string_8 then
				create installation.make_with_id (s.to_string_8)
			else
				create l_id.make_empty
				if eiffel_layout.is_workbench then
					l_id.append ("wb.")
				end
				l_id.append (env.product_name)
				l_id.append_character ('_')
				create syscsts
				l_id.append (syscsts.Compiler_version_number.version)

				l_id.append_character ('-')
				l_id.append (env.eiffel_platform)
				l_id.append_character ('-')
				l_id.append_character ('-')
				v := syscsts.version_type_name
				if not v.is_whitespace then
					from
						i := 1
						n := v.count
					until
						i > n
					loop
						if (v [i]).is_alpha_numeric then
							l_id.append_character (v [i])
						else
							l_id.append_character ('_')
						end
						i := i + 1
					end
					l_id.append_character ('-')
					l_id.append_character ('-')
				end
				l_id.append ((create {UUID_GENERATOR}).generate_uuid.out)
				create installation.make_with_id (l_id.to_string_8) -- TODO: check if Unicode id could work
				inst.set_application_item (l_var_name, l_app_name, env.version_name, installation.id)
			end
			installation.set_platform (env.eiffel_platform)
		end

feature -- Remember credentials

	kept_credential_from_file (fn: PATH): like kept_credential
		local
			retried: BOOLEAN
			f: RAW_FILE
			sed: SED_STORABLE_FACILITIES
			js: STRING
			jparser: JSON_PARSER
		do
			if not retried then
				create f.make_with_path (fn)
				if f.exists and then f.is_access_readable then
					create js.make (f.count)
					f.open_read
					from
						f.start
					until
						f.exhausted or f.end_of_file
					loop
						f.read_stream (1024)
						js.append (f.last_string)
					end
					f.close
					create jparser.make
					jparser.parse_string (js)
					if jparser.is_parsed and jparser.is_valid then
						if attached jparser.parsed_json_object as jo then
							if attached {JSON_OBJECT} jo [account_json_name] as jacc then
								if attached jacc.string_item (account_json_username) as u then
									if attached jacc.string_item (account_json_password) as pwd then
										Result := [u.unescaped_string_32, pwd.unescaped_string_32]
									else
										Result := [u.unescaped_string_32, Void]
									end
								end
							end
						end
					else
							-- Try storable
						create sed
						if attached {TUPLE [username: READABLE_STRING_GENERAL; password: detachable READABLE_STRING_GENERAL]} sed.retrieved_from_medium (f) as d then
							if attached d.password as pwd then
								Result := [d.username.to_string_32, pwd.to_string_32]
							else
								Result := [d.username.to_string_32, Void]
							end
						end
					end
				end
			end
		rescue
			retried := True
			retry
		end

	kept_credential: detachable TUPLE [username: READABLE_STRING_32; password: detachable READABLE_STRING_32]
		do
			if attached credential_storage_filename as p then
				Result := kept_credential_from_file (p)
			end
		end

	keep_credential (u,pwd: detachable READABLE_STRING_32)
		local
			p: PATH
			f: RAW_FILE
			retried: BOOLEAN
			jo,jcredential: JSON_OBJECT
		do
			if not retried then
				p := credential_storage_filename
				if p /= Void then
					create f.make_with_path (p)
					if u = Void then
						if f.exists then
							f.delete
						end
					elseif not f.exists or else f.is_access_writable then
						if ensure_parent_exists (p) then
							create jo.make_with_capacity (1)
							create jcredential.make_with_capacity (2)
							jcredential.put_string (u, account_json_username)
							jcredential.put_string (pwd, account_json_password)
							jo.put (jcredential, account_json_name)
							f.open_write
							f.put_string (jo.representation)
							f.close
						else
								-- FIXME ...
						end
					end
				end
			end
		rescue
			retried := True
			retry
		end

	credential_storage_filename: detachable PATH
		do
			Result := accounts_location
			if Result /= Void then
				Result := Result.extended (installation.id)
				Result := Result.appended ("-credential.dat")
			end
		end

feature {NONE} -- JSON names

	account_json_name: STRING = "acc"
	account_json_username: STRING = "u"
	account_json_password: STRING = "p"

feature {NONE} -- Clean up

	safe_dispose (a_explicit: BOOLEAN)
			-- <Precursor>
		do
			accounts_location := Void
			active_account := Void
			guest_mode_ending_date := Void
		end

feature {NONE} -- Access					

	accounts_location: detachable PATH
			-- Local storage for account related data.

feature -- Event

	on_project_closed
		do
			if attached active_session as sess then
				end_session (sess.account, sess)
			end
		end

	on_project_loaded
		local
			l_title: STRING_32
		do
			if attached active_session as sess then
				if
					eiffel_project.initialized and then
					attached eiffel_project.lace as l_ace
				then
					create l_title.make_empty
					if is_debug_enabled then
						if attached l_ace.target_name as tgt then
							l_title.append (tgt)
							l_title.append_character (' ')
						end
						l_title.append_character ('(')
						l_title.append (l_ace.project_location.location.name)
						l_title.append_character (')')
					end
					if
						attached eiffel_universe.conf_system as cfg and then
						not cfg.is_generated_uuid
					then
						if not l_title.is_empty then
							l_title.append_character (' ')
						end
						l_title.append ("UUID=")
						l_title.append (cfg.uuid.out)
					end
					sess.set_title (l_title)
				end
			end
		end

	on_cloud_available (a_is_available: BOOLEAN)
		do
			set_is_available (a_is_available, Void)
			Precursor (a_is_available)
		end

feature -- Access: edition

	eiffel_edition: detachable EIFFEL_EDITION
			-- <precursor/>

	is_standard_edition: BOOLEAN
			-- Is associated with standard edition of EiffelStudio.
		do
			if attached eiffel_edition as ed then
				Result := ed.is_standard_edition
			else
				Result := True
			end
			Result := not (is_enterprise_edition or is_branded_edition)
		end

	is_enterprise_edition: BOOLEAN
		do
			if attached eiffel_edition as ed then
				Result := ed.is_enterprise_edition
			else
				Result := False
			end
		end

	is_branded_edition: BOOLEAN
		do
			if attached eiffel_edition as ed then
				Result := ed.is_branded_edition
			else
				Result := False
			end
		end

	edition_brand_name: detachable IMMUTABLE_STRING_8
		do
			if attached eiffel_edition as ed then
				Result := ed.edition_name
			end
		end

feature -- Access

	config: ES_CLOUD_CONFIG

	server_url: READABLE_STRING_8
			-- Web service url.
		do
			Result := config.server_url
		end

	associated_website_url: READABLE_STRING_8
			-- Web site associated to the cloud webapi.
		local
			uri: URI
			n: INTEGER
		do
			create uri.make_from_string (server_url)
			if attached uri.path_segments as lst then
				uri.set_path ("")
				n := lst.count
				if n > 1 then
					across
						lst as ic
					until
						n = 1
					loop
						uri.add_unencoded_path_segment (ic.item)
						n := n - 1
					end
				end
			end
			Result := uri.string
		end

	view_account_website_url: READABLE_STRING_8
		do
			if
				attached active_account as acc and then
				attached web_api.account_magic_login_link (acc.access_token.token) as lnk
			then
				Result := lnk
			else
				Result := Precursor
			end
		end

	version: READABLE_STRING_8

	installation: ES_ACCOUNT_INSTALLATION
			-- <Precursor>

	active_account: detachable ES_ACCOUNT
			-- Active account if signed in, otherwise Void.

	active_session: detachable ES_ACCOUNT_SESSION
			-- Active session.

	guest_mode_ending_date: detachable DATE_TIME

	guest_mode_signed_in_count: INTEGER

	remaining_days_for_guest: INTEGER
			-- Remaining days for guest mode.

	session_heartbeat: NATURAL
			-- <Precursor>	

	is_verbose (a_level: INTEGER): BOOLEAN
			-- has Verbose output for level `a_level` ?
			-- (mostly for debugging).
		do
			Result := config.is_verbose (a_level)
		end

feature -- Settings

	set_connection_timeout (a_secs: INTEGER)
		do
			config.set_connection_timeout (a_secs)
		end

	set_timeout (a_secs: INTEGER)
		do
			config.set_timeout (a_secs)
		end

	set_verbose_level (a_level: INTEGER)
		do
			config.set_verbose_level (a_level)
		end

feature {NONE} -- API

	web_api: ES_CLOUD_API
		do
			Result := internal_web_api
			if Result = Void then
				create Result.make (config)
				internal_web_api := Result
			end
		ensure
			Result /= Void and then Result = internal_web_api
		end

	set_config (cfg: like config)
		do
			config := cfg
			internal_web_api := Void
		end

	internal_web_api: detachable like web_api

feature -- Status report

	is_guest: BOOLEAN
			-- Is guest?

	has_error: BOOLEAN
		do
			Result := web_api.has_error
		end

	last_error_message: detachable READABLE_STRING_32
		do
			if attached web_api.last_error as err then
				Result := err.message
			end
		end

	is_available: BOOLEAN
			-- Is account service available?
		local
			cl: like cell_is_available
			b: BOOLEAN
			dt: DATE_TIME
		do
			cl := cell_is_available
			create dt.make_now_utc
			if cl = Void then
				Result := web_api.is_available
				set_is_available (Result, dt)
			else
				Result := cl.item.available
				if not Result and then can_check_is_available (dt) then
					web_api.get_is_available
					b := web_api.is_available
					if Result then
						set_is_available (Result, dt)
					else
						cl.item.available := Result
						cl.item.last_time := dt
						cl.item.try_count := cl.item.try_count + 1
					end
				else
					b := web_api.is_available
					if Result /= b then
						Result := b
						set_is_available (b, dt)
					end
				end
			end
		end

feature {NONE} -- Status report implementation

	can_check_is_available (dt: DATE_TIME): BOOLEAN
		local
			cl: like cell_is_available
			ref: DATE_TIME
			nb: INTEGER
		do
			cl := cell_is_available
			if cl = Void then
				Result := True
			else
				nb := cl.item.try_count.max (1)
				ref := cl.item.last_time
				Result := ref = Void
					or else dt.relative_duration (ref).seconds_count > ((nb * nb) * 10).min (640) -- 10 seconds, then 20, 40, 80, 160, 320, 640 ... but max delay is 640sec (~10 minutes)
			end
		end

	set_is_available (b: BOOLEAN; a_date: detachable DATE_TIME)
		local
			dt: DATE_TIME
			cl: like cell_is_available
		do
			dt := a_date
			if dt = Void then
				create dt.make_now_utc
			end
			cl := cell_is_available
			if cl = Void then
				create cell_is_available.put ([b, dt, {NATURAL_8} 1])
			else
				if cl.item.available /= b then
					cl.item.available := b
					cl.item.try_count := {NATURAL_8} 1
				else
					cl.item.try_count := cl.item.try_count + 1
				end
				cl.item.last_time := dt
			end
		ensure
			is_available: is_available
		end

feature -- Element change

	set_eiffel_edition (ed: EIFFEL_EDITION)
		do
			eiffel_edition := ed
		end

	set_server_url (a_server_url: READABLE_STRING_8)
		local
			cfg: ES_CLOUD_CONFIG
		do
			create cfg.make (a_server_url)
			if attached web_api as w then
				cfg.import_settings (w.config)
			end
			set_config (cfg)
		end

feature -- Settings

	is_offline_allowed: BOOLEAN
		do
			if attached eiffel_layout.get_environment_8 ("ES_CLOUD_OFFLINE_ALLOWED") as v then
				Result := v.is_case_insensitive_equal_general ("yes")
			end
		end

	is_debug_enabled: BOOLEAN
		do
			if attached eiffel_layout.get_environment_8 ("ES_CLOUD_DEBUG_ENABLED") as v then
				Result := v.is_case_insensitive_equal_general ("yes")
			end
		end

feature {NONE} -- Status report

	cell_is_available: detachable CELL [TUPLE [available: BOOLEAN; last_time: detachable DATE_TIME; try_count: NATURAL_8]]

feature -- Get status

	get_remaining_days_for_guest
		local
			dt: DATE_TIME
			l_end: detachable DATE_TIME
		do
			create dt.make_now_utc
			l_end := guest_mode_ending_date
			if l_end = Void then
				create l_end.make_now_utc
				l_end.day_add (config.guest_period_in_days)
				guest_mode_ending_date := l_end
			end
			if dt > l_end then
				remaining_days_for_guest := 0
			else
				remaining_days_for_guest := l_end.relative_duration (dt).day
			end
		end

feature -- Sign

	continue_as_guest
			-- Sign as guest with limitation.
		local
			dt: detachable DATE_TIME
			acc: like active_account
		do
			acc := active_account
			active_account := Void
			dt := guest_mode_ending_date
			if dt = Void then
				create dt.make_now_utc
				dt.day_add (15)
				guest_mode_ending_date := dt
			end
			guest_mode_signed_in_count := guest_mode_signed_in_count + 1
			is_guest := True
			store
			on_account_signed_out (acc)
		end

	sign_in_with_credential_as_client (a_username: READABLE_STRING_GENERAL; a_password: READABLE_STRING_GENERAL)
			-- <Precursor>
		do
			if attached web_api.account_using_basic_authorization (a_username, a_password) as acc then
				reset_guest_session
				active_account := acc
--				update_account (acc)
--				store
				on_account_signed_in (acc)
			else
				active_account := Void
				active_session := Void
					-- If guest, remains guest.
				if web_api.has_error then
					check_cloud_availability
				end
			end
		end

	sign_in_with_credential (a_username: READABLE_STRING_GENERAL; a_password: READABLE_STRING_GENERAL)
			-- <Precursor>
		do
			if attached web_api.account_using_basic_authorization (a_username, a_password) as acc then
				reset_guest_session
				active_account := acc
				update_account (acc)
				store
				on_account_signed_in (acc)
			else
				active_account := Void
				active_session := Void
					-- If guest, remains guest.
				if web_api.has_error then
					check_cloud_availability
				end
			end
		end

	sign_in_with_access_token (a_username: READABLE_STRING_GENERAL; tok: READABLE_STRING_8)
			-- <Precursor>
		do
				-- TODO
			if attached web_api.account (tok) as acc then
				active_account := acc
				reset_guest_session
				update_account (acc)
				store
				on_account_signed_in (acc)
			else
				active_account := Void
				active_session := Void
					-- If guest, remains guest.
			end
		end

	sign_out
		local
			acc: like active_account
			params: ES_CLOUD_API_SESSION_PARAMETERS
		do
			acc := active_account
			if
				acc /= Void and then
				attached acc.access_token as tok and then
				attached active_session as sess
			then
				create params.make (installation.id, sess.id)
				web_api.sign_out (tok.token, params)
				reset_guest_session
			end
			active_account := Void
			active_session := Void
			installation.set_associated_license (Void)
			is_guest := False
			get_remaining_days_for_guest
			store
			on_account_signed_out (acc)
		end

	quit
		do
			(create {EXCEPTIONS}).die (-123)
		end

feature -- Updating

	fill_product_information (params: ES_CLOUD_API_SESSION_PARAMETERS)
		do
			params["product"] := eiffel_layout.product_name
			params["product_version"] := eiffel_layout.version_name
		end

	async_worker: ES_CLOUD_ASYNC_WORKER
		do
			Result := internal_async_worker
			if Result = Void then
				create Result.make
				internal_async_worker := Result
			end
		end

	internal_async_worker: detachable like async_worker

	async_check_availability (a_force_operation: BOOLEAN)
		local
			dt: DATE_TIME
		do
			create dt.make_now_utc
			if a_force_operation or else can_check_is_available (dt) then
				debug ("es_cloud")
					print (generator + ".ASYNC_check_availability%N")
				end
				async_worker.add_job (create {ES_CLOUD_ASYNC_STATUS}.make (Current, config))
			else
				debug ("es_cloud")
					print (generator + ".ASYNC_check_availability WAIT BEFORE TRYING AGAIN!%N")
				end
			end
		end

	async_ping_installation (a_account: ES_ACCOUNT; a_session: ES_ACCOUNT_SESSION)
		local
			params: ES_CLOUD_API_SESSION_PARAMETERS
		do
			if
				attached a_account.access_token as tok
			then
				debug ("es_cloud")
					print (generator + ".ASYNC_ping_installation%N")
				end
				create params.make (installation.id, a_session.id)
				fill_product_information (params)

				async_worker.add_job (create {ES_CLOUD_ASYNC_PING}.make (Current, tok, a_session, params, config))
			end
		end

	ping_installation (a_account: ES_ACCOUNT; a_session: ES_ACCOUNT_SESSION)
		local
			params: ES_CLOUD_API_SESSION_PARAMETERS
			d: ES_CLOUD_PING_DATA
			l_issue: ES_ACCOUNT_LICENSE_ISSUE
		do
			if attached a_account.access_token as tok then
				create params.make (installation.id, a_session.id)
				fill_product_information (params)
				if attached a_session.title as l_title then
					params["session_title"] := create {IMMUTABLE_STRING_32}.make_from_string_general (l_title)
				end
				create d
				web_api.ping_installation (tok.token, params, d)
				if d.session_state_changed then
					on_session_state_changed (a_session)
				end
				if d.heartbeat > 0 then
					on_session_heartbeat_updated (d.heartbeat)
				end
				if d.license_expired then
					create l_issue.make (a_account)
					l_issue.set_license_expired
					if attached d.error_message as errmsg then
						l_issue.set_reason (errmsg)
					end
					on_account_license_issue (l_issue)
				elseif attached d.error_message as errmsg then
					create l_issue.make (a_account)
					l_issue.set_reason (errmsg)
					on_account_license_issue (l_issue)
				end
			end
		end

	end_session (a_account: ES_ACCOUNT; a_session: ES_ACCOUNT_SESSION)
		local
			params: ES_CLOUD_API_SESSION_PARAMETERS
		do
			if
				attached a_account.access_token as tok
			then
				create params.make (installation.id, a_session.id)
				web_api.end_session (tok.token, params)
			end
		end

	pause_session (a_account: ES_ACCOUNT; a_session: ES_ACCOUNT_SESSION)
		local
			params: ES_CLOUD_API_SESSION_PARAMETERS
		do
			if
				attached a_account.access_token as tok
			then
				create params.make (installation.id, a_session.id)
				web_api.pause_session (tok.token, params)
			end
		end

	resume_session (a_account: ES_ACCOUNT; a_session: ES_ACCOUNT_SESSION)
		local
			params: ES_CLOUD_API_SESSION_PARAMETERS
		do
			if
				attached a_account.access_token as tok
			then
				create params.make (installation.id, a_session.id)
				web_api.resume_session (tok.token, params)
				update_session (a_session)
			end
		end

	update_account (a_account: ES_ACCOUNT)
		local
			l_issue: ES_ACCOUNT_LICENSE_ISSUE
		do
			if
				attached a_account.access_token as tok and then
				attached web_api.account (tok.token) as acc
			then
				if attached acc.access_token as acc_tok then
					if tok.has_refresh_key and not acc_tok.has_refresh_key then
						acc_tok.set_refresh_key (tok.refresh_key)
					end
					a_account.set_access_token (acc_tok)
				else
					a_account.set_access_token (Void)
				end
				if attached web_api.installation (tok.token, installation.id) as inst then
						-- Ok good.
					installation := inst
				elseif attached	web_api.register_installation (tok.token, installation) as inst then
					installation := inst
				elseif not web_api.has_error then
					installation.mark_inactive
				end
				store
				if a_account.is_expired then
					on_account_signed_out (a_account)
				elseif
					attached installation as l_installation and then
					attached l_installation.associated_license as lic
				then
					if
						l_installation.is_active and then
						lic.is_active
					then
						on_account_updated (a_account)
					else
						create l_issue.make (acc)
						l_issue.set_license (lic)
						on_account_license_issue (l_issue)
					end
				else
					create l_issue.make (acc)
					on_account_license_issue (l_issue)
				end
			elseif is_available then
				sign_out
			else
				on_cloud_available (False)
			end
		end

	update_session (a_session: ES_ACCOUNT_SESSION)
		do
			if attached web_api.session (a_session.account, installation, a_session.id) as sess then
				a_session.set_is_paused (sess.is_paused)
			elseif not web_api.has_error then
				end_session (a_session.account, a_session)
			end
		end

	refresh_token (a_token: ES_ACCOUNT_ACCESS_TOKEN; acc: ES_ACCOUNT)
		do
			if attached a_token.refresh_key as k then
				if attached web_api.refreshing_token (a_token.token, k) as tok then
					acc.set_access_token (tok)
					store
					on_account_updated (acc)
				elseif is_available then
					sign_out
				else
					on_cloud_available (False)
				end
			end
		end

	account_licenses (acc: ES_ACCOUNT): LIST [ES_ACCOUNT_LICENSE]
		do
			Result := web_api.account_licenses (acc.access_token.token)
		end

	account_installations (acc: ES_ACCOUNT): LIST [ES_ACCOUNT_INSTALLATION]
		do
			Result := web_api.account_installations (acc.access_token.token)
		end

feature -- Installation

	account_installation (acc: ES_ACCOUNT; a_installation_id: READABLE_STRING_GENERAL): detachable ES_ACCOUNT_INSTALLATION
		do
			Result := web_api.installation (acc.access_token.token, a_installation_id)
		end

	update_installation_license (acc: ES_ACCOUNT; a_installation: ES_ACCOUNT_INSTALLATION; a_lic: ES_ACCOUNT_LICENSE)
		local
			inst: ES_ACCOUNT_INSTALLATION
		do
			inst := web_api.update_installation (acc.access_token.token, a_installation, a_lic)
		end

feature -- Events

	on_account_signed_in (acc: ES_ACCOUNT)
		do
			debug ("es_cloud")
				print (generator + ".on_account_signed_in (" + acc.username + ")%N")
			end
			create active_session.make_new (acc)
			if attached eiffel_project.manager as m then
				m.load_agents.extend (agent	on_project_loaded)
--				m.compile_stop_agents.extend (agent on_project_loaded)
				m.close_agents.extend (agent on_project_closed)
			else
				check has_eiffel_project_manager: False end
			end
			Precursor (acc)
		end

feature -- Connection checking

	check_cloud_availability
		local
			l_was_available,
			b: BOOLEAN
		do
			l_was_available := is_available
			if l_was_available then
				on_cloud_available (b)
			else
				if attached cell_is_available as cl then
					cl.item.last_time := Void -- Force new check
					cl.item.try_count := 0
				end
				b := is_available
				if l_was_available /= b then
					on_cloud_available (b)
				end
			end
		end

feature -- Account Registration	

	register_account (a_username: READABLE_STRING_GENERAL; a_password: READABLE_STRING_GENERAL; a_email: READABLE_STRING_8; a_additional_values: detachable TABLE_ITERABLE [READABLE_STRING_GENERAL, READABLE_STRING_GENERAL])
			-- <Precursor>.
		do
			if attached web_api.register (a_username, a_password, a_email, a_additional_values) as acc then
				is_guest := False
				active_account := acc
				guest_mode_ending_date := Void
				remaining_days_for_guest := 0
				store
				on_account_signed_in (acc)
			end
			store
		end

feature -- Product

	product_version_name: STRING_8
			-- Version string.
			-- I.e. MM.mm
		local
			csts: EIFFEL_CONSTANTS
		once
			create Result.make (5)
			create csts
			Result.append_string (csts.Two_digit_minimum_major_version)
			Result.append_character ('.')
			Result.append_string (csts.Two_digit_minimum_minor_version)
		ensure
			not_result_is_empty: not Result.is_empty
		end

feature -- Storage

	storage_filename: detachable PATH
		do
			Result := accounts_location
			if Result /= Void then
				Result := Result.extended (installation.id)
				Result := Result.appended ("-local.dat")
			end
		end

	load
		local
			retried: BOOLEAN
			p: PATH
			f: RAW_FILE
			sed: SED_STORABLE_FACILITIES
			l_found_data: BOOLEAN
		do
			if not retried then
				p := storage_filename
				if p /= Void then
					create f.make_with_path (p)
					if f.exists and then f.is_access_readable then
						f.open_read
						create sed
						if attached {ES_CLOUD_DATA} sed.retrieved_from_medium (f) as d then
							l_found_data := True
							if attached d.active_account as l_active_account and then not l_active_account.is_expired then
								active_account := l_active_account
							else
								active_account := Void
							end
							if attached d.installation as l_installation and then l_installation.is_active then
								installation := l_installation
							else
								-- Keep current installation !
							end

							guest_mode_ending_date := d.guest_mode_ending_date
							guest_mode_signed_in_count := d.guest_mode_signed_in_count
							if d.session_heartbeat > 0 then
								session_heartbeat := d.session_heartbeat
							end
						end
					else
							-- FIXME: should be created at installation... and presence may be mandatory
							-- to avoid user to delete it ...
							-- for now, create the file!
					end
				end
				get_remaining_days_for_guest
				if not l_found_data then
					store -- create new file!
				end
			end
		rescue
			retried := True
			retry
		end

	store
		local
			p: PATH
			sed: SED_STORABLE_FACILITIES
			d: ES_CLOUD_DATA
			f: RAW_FILE
		do
			-- FIXME: use json or xml storage!
			p := storage_filename
			if p /= Void then
				create f.make_with_path (p)
				if not f.exists or else f.is_access_writable then
					if ensure_parent_exists (p) then
						create d
						d.active_account := active_account
						d.installation := installation
						d.guest_mode_ending_date := guest_mode_ending_date
						d.guest_mode_signed_in_count := guest_mode_signed_in_count
						f.open_write
						create sed
						sed.store_in_medium (d, f)
						f.close
					else
							-- FIXME ...
					end
				end
			end
		end

	reset_guest_session
			-- Reset guest session in memory.
		do
			guest_mode_ending_date := Void
			remaining_days_for_guest := 0
			is_guest := False
		end

	ensure_parent_exists (p: PATH): BOOLEAN
		local
			d: DIRECTORY
			retried: BOOLEAN
		do
			if not retried then
				create d.make_with_path (p.parent)
				if not d.exists then
					d.recursive_create_dir
				end
				Result := d.exists
			end
		rescue
			retried := True
			retry
		end

feature -- Events: Connection point

	es_cloud_connection: EVENT_CONNECTION_I [ES_CLOUD_OBSERVER, ES_CLOUD_S]
			-- <Precursor>
		do
			Result := internal_connection
			if not attached Result then
				create {EVENT_CONNECTION [ES_CLOUD_OBSERVER, ES_CLOUD_S]} Result.make (
					agent (o: ES_CLOUD_OBSERVER):
						ARRAY [TUPLE
							[event: EVENT_TYPE [TUPLE];
							action: PROCEDURE]
						]
						do
							Result :=
								<<
									[account_signed_in_event, agent o.on_account_signed_in],
									[account_signed_out_event, agent o.on_account_signed_out]
								>>
						end)
				automation.auto_dispose (Result)
				internal_connection := Result
			end
		end

feature -- Events

	account_signed_in_event: EVENT_TYPE [TUPLE [acc: detachable ES_ACCOUNT]]
			-- <Precursor>
		do
			Result := internal_account_signed_in_event
			if Result = Void then
				create Result
				internal_account_signed_in_event := Result
				auto_dispose (Result)
			end
		end

	account_signed_out_event: EVENT_TYPE [TUPLE [acc: detachable ES_ACCOUNT]]
			-- <Precursor>
		do
			Result := internal_account_signed_out_event
			if Result = Void then
				create Result
				internal_account_signed_out_event := Result
				auto_dispose (Result)
			end
		end

feature {NONE} -- Implementation: Internal cache

	internal_connection: detachable like es_cloud_connection
			-- Cached version of `es_cloud_connection`.
			-- Note: Do not use directly!	

	internal_account_signed_in_event: detachable like account_signed_in_event
			-- Cached version of `account_signed_in_event`.
			-- Note: Do not use directly!

	internal_account_signed_out_event: detachable like account_signed_out_event
			-- Cached version of `account_signed_out_event`.
			-- Note: Do not use directly!

invariant

note
	copyright: "Copyright (c) 1984-2024, Eiffel Software"
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

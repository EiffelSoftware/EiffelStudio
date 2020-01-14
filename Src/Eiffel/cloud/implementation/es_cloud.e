note
	description: "Summary description for {ES_CLOUD}."
	date: "$Date$"
	revision: "$Revision$"

class
	ES_CLOUD

inherit
	ES_CLOUD_S
		redefine
			on_account_logged_in
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
		do
			create cfg.make (a_server_url)
			create web_api.make (cfg)

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
			session_heartbeat := 900 -- 15 * 60 s = 15 minutes
			load
		end

feature {NONE} -- Default

	default_server_url: STRING
		do
				-- On Windows: Computer\HKEY_CURRENT_USER\Software\ISE\Eiffel_19.09\installation\es_cloud\default_server_url
			if
				is_eiffel_layout_defined and then
				attached (create {ES_INSTALLATION_ENVIRONMENT}.make (eiffel_layout)).application_item ("default_server_url", "es_cloud", eiffel_layout.version_name) as v
				and then v.is_valid_as_string_8
			then
					-- For now, it is possible to change the server url this way.
				Result := v.to_string_8
			else
				Result := "https://cloud.eiffel.com/api" -- Default
			end
			debug ("es_cloud")
				if attached eiffel_layout.get_environment_8 ("ES_CLOUD_SERVER_URL") as l_env_url then
					Result := l_env_url
				end
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
			l_var_name := "installation_id"
			s := inst.application_item (l_var_name, l_app_name, env.version_name)
			if s /= Void and then s.has_substring (env.version_name) and then s.is_valid_as_string_8 then
				create installation.make_with_id (s.to_string_8)
			else
				create l_id.make_empty
				l_id.append (env.product_name)
				l_id.append_character ('_')
				create syscsts
				l_id.append (syscsts.Compiler_version_number.version)

				l_id.append_character ('-')
				l_id.append (env.eiffel_platform)
				l_id.append_character ('-')
				l_id.append_character ('-')
				v := syscsts.version_type_name
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
				l_id.append ((create {UUID_GENERATOR}).generate_uuid.out)
				create installation.make_with_id (l_id)
				inst.set_application_item (l_var_name, l_app_name, env.version_name, installation.id)
			end
			installation.set_platform (env.eiffel_platform)
		end

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

	web_api: ES_CLOUD_API

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
			sh: SHARED_WORKBENCH
		do
			if attached active_session as sess then
				if
					eiffel_project.initialized and then
					attached eiffel_project.lace as l_ace
				then
					create l_title.make_empty
					if attached l_ace.target_name as tgt then
						l_title.append (tgt)
						l_title.append_character (' ')
					end
					l_title.append_character ('(')
					l_title.append (l_ace.project_location.location.name)
					l_title.append_character (')')
					if
						attached eiffel_universe.conf_system as cfg and then
						not cfg.is_generated_uuid
					then
						l_title.append_character (' ')
						l_title.append ("UUID=")
						l_title.append (cfg.uuid.out)
					end
					sess.set_title (l_title)
				end
			end
		end

feature -- Access

	is_enterprise_edition: BOOLEAN
			-- <Precursor>

	config: ES_CLOUD_CONFIG
		do
			Result := web_api.config
		end

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

	version: READABLE_STRING_8

	installation: ES_ACCOUNT_INSTALLATION
			-- <Precursor>

	active_account: detachable ES_ACCOUNT
			-- Active account if logged in, otherwise Void.

	active_session: detachable ES_ACCOUNT_SESSION
			-- Active session.

	guest_mode_ending_date: detachable DATE_TIME

	guest_mode_loging_count: INTEGER

	remaining_days_for_guest: INTEGER
			-- Remaining days for guest mode.

	session_heartbeat: NATURAL
			-- <Precursor>			

feature -- Status report

	is_available: BOOLEAN
			-- Is account service available?
		local
			cl: like cell_is_available
			b: BOOLEAN
			dt: DATE_TIME
		do
			create dt.make_now_utc
			cl := cell_is_available
			if cl = Void then
				web_api.get_is_available
				Result := web_api.is_available
				create cl.put ([Result, dt])
			else
				Result := cl.item.available
				if
					cl.item.last_time = Void
					or else attached cl.item.last_time as l_last_time and then
							l_last_time.relative_duration (dt).seconds_count > 60
				then
					web_api.get_is_available
					b := web_api.is_available
					if b /= Result then
						Result := b
						create cl.put ([Result, dt])
					end
				end
			end
		end

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

feature -- Element change

	set_is_enterprise_edition (b: BOOLEAN)
		do
			is_enterprise_edition := b
		end

	set_server_url (a_server_url: READABLE_STRING_8)
		local
			cfg: ES_CLOUD_CONFIG
		do
			create cfg.make (a_server_url)
			if attached web_api as w then
				cfg.import_settings (w.config)
			end
			create web_api.make (cfg)
		end

feature -- Debug purpose

	is_debug_enabled: BOOLEAN
		do
			if attached eiffel_layout.get_environment_8 ("ES_CLOUD_DEBUG_ENABLED") as v then
				Result := v.is_case_insensitive_equal_general ("yes")
			end
		end

feature {NONE} -- Status report

	cell_is_available: detachable CELL [TUPLE [available: BOOLEAN; last_time: detachable DATE_TIME]]

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
				l_end.day_add (15)
				guest_mode_ending_date := l_end
			end
			if dt > l_end then
				remaining_days_for_guest := 0
			else
				remaining_days_for_guest := l_end.relative_duration (dt).day
			end
		end

feature -- Sign

	login_as_guest
			-- Sign as guest with limitation.
		local
			dt: detachable DATE_TIME
		do
			active_account := Void
			dt := guest_mode_ending_date
			if dt = Void then
				create dt.make_now_utc
				dt.day_add (15)
				guest_mode_ending_date := dt
			end
			guest_mode_loging_count := guest_mode_loging_count + 1
			is_guest := True
			store
			on_account_logged_out
		end

	login_with_credential (a_username: READABLE_STRING_GENERAL; a_password: READABLE_STRING_GENERAL)
			-- <Precursor>
		do
				-- TODO
			if attached web_api.account_using_basic_authorization (a_username, a_password) as acc then
				is_guest := False
				active_account := acc
				guest_mode_ending_date := Void
				remaining_days_for_guest := 0
				update_account (acc)
				store
				on_account_logged_in (acc)
			else
				active_account := Void
					-- If guest, remains guest.
			end
		end

	login_with_access_token (a_username: READABLE_STRING_GENERAL; tok: READABLE_STRING_8)
			-- <Precursor>
		do
				-- TODO
			if attached web_api.account (tok) as acc then
				is_guest := False
				active_account := acc
				guest_mode_ending_date := Void
				remaining_days_for_guest := 0
				update_account (acc)
				store
				on_account_logged_in (acc)
			else
				active_account := Void
				active_session := Void
					-- If guest, remains guest.
			end
		end

	logout
		local
			acc: like active_account
		do
			acc := active_account
			if
				acc /= Void and then
				attached acc.access_token as tok and then
				attached active_session as sess
			then
				web_api.logout (tok.token, installation.id, sess.id)
			end
			active_account := Void
			active_session := Void
			is_guest := False
			store
			on_account_logged_out
		end

	quit
		do
			(create {EXCEPTIONS}).die (-123)
		end

feature -- Updating

	async_ping_installation (a_account: ES_ACCOUNT; a_session: ES_ACCOUNT_SESSION)
		local
			p: ES_CLOUD_ASYNC_PING
		do
			if
				attached a_account.access_token as tok
			then
				create p.make (Current, tok, installation, a_session, web_api.config)
				p.execute
			end
		end

	ping_installation (a_account: ES_ACCOUNT; a_session: ES_ACCOUNT_SESSION)
		local
			opts: STRING_TABLE [READABLE_STRING_GENERAL]
			d: ES_CLOUD_PING_DATA
		do
			if attached a_account.access_token as tok then
				if attached a_session.title as l_title then
					create opts.make (1)
					opts["session_title"] := create {IMMUTABLE_STRING_32}.make_from_string_general (l_title)
				end
				create d
				web_api.ping_installation (tok.token, installation.id, a_session.id, opts, d)
				if d.session_state_changed then
					on_session_state_changed (a_session)
				end
				if d.heartbeat > 0 then
					on_session_heartbeat_updated (d.heartbeat)
				end
			end
		end

	end_session (a_account: ES_ACCOUNT; a_session: ES_ACCOUNT_SESSION)
		do
			if
				attached a_account.access_token as tok
			then
				web_api.end_session (tok.token, installation.id, a_session.id)
			end
		end

	pause_session (a_account: ES_ACCOUNT; a_session: ES_ACCOUNT_SESSION)
		do
			if
				attached a_account.access_token as tok
			then
				web_api.pause_session (tok.token, installation.id, a_session.id)
			end
		end

	resume_session (a_account: ES_ACCOUNT; a_session: ES_ACCOUNT_SESSION)
		do
			if
				attached a_account.access_token as tok
			then
				web_api.resume_session (tok.token, installation.id, a_session.id)
				update_session (a_session)
			end
		end

	update_account (a_account: ES_ACCOUNT)
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
				a_account.set_plan (acc.plan)
				if attached web_api.installation (tok.token, installation.id) as inst then
						-- Ok good.
					installation := inst
				elseif attached	web_api.register_installation (tok.token, installation) as inst then
					installation := inst
				else
						-- Error!
						-- Keep the same
				end
				store

				on_account_updated (a_account)
			elseif is_available then
				logout
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
		local
			r: ES_CLOUD_ASYNC_REFRESH
		do
			if attached a_token.refresh_key as k then
				if attached web_api.refreshing_token (a_token.token, k) as tok then
					acc.set_access_token (tok)
					store
					on_account_updated (acc)
				elseif is_available then
					logout
				else
					on_cloud_available (False)
				end
			end
		end

feature -- Events

	on_account_logged_in (acc: ES_ACCOUNT)
		do
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
			if attached cell_is_available as cl then
				cl.item.last_time := Void -- Force new check
			end
			b := is_available
--			if l_was_available /= b then
				on_cloud_available (b)
--			end
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
				on_account_logged_in (acc)
			end
			store
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
							guest_mode_ending_date := d.guest_mode_ending_date
							guest_mode_loging_count := d.guest_mode_loging_count
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
						d.guest_mode_ending_date := guest_mode_ending_date
						d.guest_mode_loging_count := guest_mode_loging_count
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

note
	description: "Summary description for {ES_CLOUD}."
	date: "$Date$"
	revision: "$Revision$"

class
	ES_CLOUD

inherit
	ES_CLOUD_S

	DISPOSABLE_SAFE

	EIFFEL_LAYOUT

create
	make,
	make_with_url

feature {NONE} -- Creation

	make
		do
			make_with_url (default_server_url)
		end

	make_with_url (a_server_url: READABLE_STRING_8)
		do
			set_server_url (a_server_url)
			if is_eiffel_layout_defined then
				version := eiffel_layout.version_name
				get_local_installation (eiffel_layout)
				accounts_location := eiffel_layout.hidden_files_path.extended ("accounts")
			else
				version := "unknown"
				create installation.make_with_id ("")
			end
			load
		end

feature {NONE} -- Default

	default_server_url: STRING
		do
			if
				is_eiffel_layout_defined and then
				attached (create {ES_INSTALLATION_ENVIRONMENT}.make (eiffel_layout)).application_item ("default_server_url", "es_cloud", eiffel_layout.version_name) as v
				and then v.is_valid_as_string_8
			then
					-- For now, it is possible to change the server url this way.
				Result := v.to_string_8
			else
				Result := "https://api.eiffel.com/es"
			end
		end

feature -- Element change

	set_server_url (a_server_url: READABLE_STRING_8)
		do
			server_url := a_server_url
			create web_api.make (server_url)
		end

feature {NONE} -- Initialization

	get_local_installation (env: EIFFEL_ENV)
		local
			inst: ES_INSTALLATION_ENVIRONMENT
		do
			create inst.make (eiffel_layout)
			if attached inst.application_item ("installation_id", env.product_name, env.version_name) as v then
				create installation.make_with_id (v)
			else
				create installation.make_with_id (env.product_name + "--" + env.eiffel_platform + "--" + (create {UUID_GENERATOR}).generate_uuid.out)
				inst.set_application_item ("installation_id", env.product_name, env.version_name, installation.id)
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

feature -- Access

	server_url: READABLE_STRING_8
			-- Web service url.

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

	license_accepted: BOOLEAN
			-- License accepted by user?

	active_account: detachable ES_ACCOUNT
			-- Active account if logged in, otherwise Void.

	guest_mode_ending_date: detachable DATE_TIME

	guest_mode_loging_count: INTEGER

	remaining_days_for_guest: INTEGER
			-- Remaining days for guest mode.

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

feature -- Element change

	accept_license
			-- Set `license_accepted` to `True`.
		do
			license_accepted := True
			store
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
				update_account_subscription (acc)
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
				update_account_subscription (acc)
				store
				on_account_logged_in (acc)
			else
				active_account := Void
					-- If guest, remains guest.
			end
		end

	logout
		do
			active_account := Void
			is_guest := False
			store
			on_account_logged_out
		end

feature -- Updating		

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
					a_account.set_installation (inst)
				elseif attached	web_api.register_installation (tok.token, installation) as inst then
					a_account.set_installation (inst)
				else
						-- Error!
					a_account.set_installation (Void)
				end
				store

				on_account_updated (a_account)
			else
				logout
			end
		end

	refresh_token (a_token: ES_ACCOUNT_ACCESS_TOKEN; acc: ES_ACCOUNT)
		do
			if attached a_token.refresh_key as k then
				web_api.refresh_token (a_token.token, k, acc)
				if not web_api.has_error then
					store
					on_account_updated (acc)
				end
			end
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
			if l_was_available /= b then
				on_cloud_available (b)
			end
		end

feature -- Updating

	update_account_subscription (acc: ES_ACCOUNT)
		do
			if
				attached acc.access_token as tok and then
				attached web_api.plan (tok.token) as l_plan
			then
				acc.set_plan (l_plan)
			end
		end

feature -- Account Registration	

	register_account (a_username: READABLE_STRING_GENERAL; a_password: READABLE_STRING_GENERAL; a_email: READABLE_STRING_8)
			-- <Precursor>.
		do
			if attached web_api.register (a_username, a_password, a_email) as acc then
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

	load
		local
			retried: BOOLEAN
			p: PATH
			f: RAW_FILE
			sed: SED_STORABLE_FACILITIES
			l_found_data: BOOLEAN
		do
			if not retried then
				p := accounts_location
				if p /= Void then
					p := p.extended (installation.id).appended ("-local.dat")
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
							license_accepted := d.license_accepted
							guest_mode_ending_date := d.guest_mode_ending_date
							guest_mode_loging_count := d.guest_mode_loging_count
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
			p := accounts_location
			if p /= Void then
				p := p.extended (installation.id).appended ("-local.dat")
				create f.make_with_path (p)
				if not f.exists or else f.is_access_writable then
					if ensure_parent_exists (p) then
						create d
						d.active_account := active_account
						d.license_accepted := license_accepted
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
	copyright: "Copyright (c) 1984-2017, Eiffel Software"
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

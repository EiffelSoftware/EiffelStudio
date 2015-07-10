note
	description: "[
		Generic OpenID Module supporting authentication using different providers.
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_OPENID_MODULE

inherit
	CMS_MODULE
		rename
			module_api as user_openid_api
		redefine
			filters,
			register_hooks,
			initialize,
			install,
			user_openid_api
		end


	CMS_HOOK_BLOCK

	CMS_HOOK_AUTO_REGISTER

	CMS_HOOK_MENU_SYSTEM_ALTER

	CMS_HOOK_VALUE_TABLE_ALTER

	SHARED_EXECUTION_ENVIRONMENT
		export
			{NONE} all
		end

	REFACTORING_HELPER

	SHARED_LOGGER

	CMS_REQUEST_UTIL


create
	make

feature {NONE} -- Initialization

	make
			-- Create current module
		do
			version := "1.0"
			description := "Openid module"
			package := "authentication"
			add_dependency ({CMS_AUTHENTICATION_MODULE})

			create root_dir.make_current
			cache_duration := 0
		end

feature -- Access

	name: STRING = "openid"
			-- <Precursor>

feature {CMS_API} -- Module Initialization			

	initialize (a_api: CMS_API)
			-- <Precursor>
		local
			l_openid_api: like user_openid_api
			l_openid_storage: CMS_OPENID_STORAGE_I
		do
			Precursor (a_api)

				-- Storage initialization
			if attached {CMS_STORAGE_SQL_I} a_api.storage as l_storage_sql then
				create {CMS_OPENID_STORAGE_SQL} l_openid_storage.make (l_storage_sql)
			else
				-- FIXME: in case of NULL storage, should Current be disabled?
				create {CMS_OPENID_STORAGE_NULL} l_openid_storage
			end

				-- API initialization
			create l_openid_api.make_with_storage (a_api, l_openid_storage)
			user_openid_api := l_openid_api
		ensure then
			user_opend_api_set: user_openid_api /= Void
		end

feature {CMS_API} -- Module management

	install (api: CMS_API)
		do
				-- Schema
			if attached {CMS_STORAGE_SQL_I} api.storage as l_sql_storage then
				if not l_sql_storage.sql_table_exists ("openid_consumers") then
					--| Schema
					l_sql_storage.sql_execute_file_script (api.module_resource_location (Current, (create {PATH}.make_from_string ("scripts")).extended ("openid_consumers.sql")), Void)

					if l_sql_storage.has_error then
						api.logger.put_error ("Could not initialize database for openid module", generating_type)
					end
						-- TODO workaround.
					l_sql_storage.sql_execute_file_script (api.module_resource_location (Current, (create {PATH}.make_from_string ("scripts")).extended ("openid_consumers_initialize.sql")), Void)
				end

					-- TODO workaround, until we have an admin module
				if l_sql_storage.has_error then
					api.logger.put_error ("Could not initialize database for different consumers", generating_type)
				else
					l_sql_storage.sql_execute_file_script (api.module_resource_location (Current, (create {PATH}.make_from_string ("scripts")).extended ("openid_items.sql")),Void)
				end
				Precursor {CMS_MODULE}(api)
			end
		end

feature {CMS_API} -- Access: API

	user_openid_api: detachable CMS_OPENID_API
			-- <Precursor>		

feature -- Filters

	filters (a_api: CMS_API): detachable LIST [WSF_FILTER]
			-- Possibly list of Filter's module.
		do
			if attached user_openid_api as l_user_openid_api then
				create {ARRAYED_LIST [WSF_FILTER]} Result.make (1)
				Result.extend (create {CMS_OPENID_FILTER}.make (a_api, l_user_openid_api))
			end
		end

feature -- Access: docs

	root_dir: PATH

	cache_duration: INTEGER
			-- Caching duration
			--|  0: disable
			--| -1: cache always valie
			--| nb: cache expires after nb seconds.

	cache_disabled: BOOLEAN
		do
			Result := cache_duration = 0
		end

feature -- Router

	setup_router (a_router: WSF_ROUTER; a_api: CMS_API)
			-- <Precursor>
		do
			if attached user_openid_api as l_user_openid_api then
				configure_web (a_api, l_user_openid_api, a_router)
			end
		end

	configure_web (a_api: CMS_API; a_user_openid_api: CMS_OPENID_API; a_router: WSF_ROUTER)
		do
			a_router.handle ("/account/roc-openid-login", create {WSF_URI_AGENT_HANDLER}.make (agent handle_openid_login (a_api, ?, ?)), a_router.methods_get_post)
			a_router.handle ("/account/roc-openid-logout", create {WSF_URI_AGENT_HANDLER}.make (agent handle_logout (a_api, ?, ?)), a_router.methods_get_post)
			a_router.handle ("/account/login-with-openid/{consumer}", create {WSF_URI_TEMPLATE_AGENT_HANDLER}.make (agent handle_login_with_openid (a_api,a_user_openid_api, ?, ?)), a_router.methods_get_post)
			a_router.handle ("/account/openid-callback", create {WSF_URI_AGENT_HANDLER}.make (agent handle_callback_openid (a_api, a_user_openid_api, ?, ?)), a_router.methods_get_post)
		end

feature -- Hooks configuration

	register_hooks (a_response: CMS_RESPONSE)
			-- Module hooks configuration.
		do
			auto_subscribe_to_hooks (a_response)
			a_response.subscribe_to_block_hook (Current)
			a_response.subscribe_to_value_table_alter_hook (Current)
		end

feature -- Hooks

	value_table_alter (a_value: CMS_VALUE_TABLE; a_response: CMS_RESPONSE)
			-- <Precursor>
		do
			if attached current_user (a_response.request) as l_user then
				a_value.force (l_user, "user")
			end
		end

	menu_system_alter (a_menu_system: CMS_MENU_SYSTEM; a_response: CMS_RESPONSE)
			-- Hook execution on collection of menu contained by `a_menu_system'
			-- for related response `a_response'.
		local
			lnk: CMS_LOCAL_LINK
			lnk2: detachable CMS_LINK
		do
			if
				attached a_response.current_user (a_response.request) as u and then
				attached {WSF_STRING} a_response.request.cookie ({CMS_OPENID_CONSTANTS}.openid_session) as l_roc_auth_session_token
			then
				across
					a_menu_system.primary_menu.items as ic
				until
					lnk2 /= Void
				loop
					if ic.item.title.has_substring ("(Logout)") then
						lnk2 := ic.item
					end
				end
				if lnk2 /= Void then
					a_menu_system.primary_menu.remove (lnk2)
				end
				create lnk.make (u.name +  " (Logout)", "account/roc-openid-logout" )
				a_menu_system.primary_menu.extend (lnk)
			else
				if a_response.location.starts_with ("account/") then
					create lnk.make ("Openid", "account/roc-openid-login")
					a_response.add_to_primary_tabs (lnk)
				end
			end

		end

	block_list: ITERABLE [like {CMS_BLOCK}.name]
		local
			l_string: STRING
		do
			Result := <<"login">>
			debug ("roc")
				create l_string.make_empty
				across
					Result as ic
				loop
					l_string.append (ic.item)
					l_string.append_character (' ')
				end
				write_debug_log (generator + ".block_list:" + l_string )
			end
		end

	get_block_view (a_block_id: READABLE_STRING_8; a_response: CMS_RESPONSE)
		do
			if
				a_block_id.is_case_insensitive_equal_general ("login") and then
				a_response.location.starts_with ("account/roc-openid-login")
			then
				get_block_view_login (a_block_id, a_response)
			end
		end

	handle_openid_login (api: CMS_API; req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			r: CMS_RESPONSE
			o: OPENID_CONSUMER
			s: STRING
		do
			create {GENERIC_VIEW_CMS_RESPONSE} r.make (req, res, api)
			if req.is_get_request_method then
				r.set_value ("Login", "optional_content_type")
				r.execute
			elseif req.is_post_request_method then
				create s.make_empty
				if attached req.string_item ("openid") as p_openid then
					s.append ("Check openID: " + p_openid)
					create o.make (req.absolute_script_url ("/account/login-with-openid"))
					o.ask_email (True)
					o.ask_all_info (False)
					if attached o.auth_url (p_openid) as l_url then
						r.set_redirection (l_url)
					else
						s.append (" Failure")
						r.set_status_code ({HTTP_CONSTANTS}.bad_request)
						r.values.force (s, "error")
						r.execute
					end
				end
			end
		end

	handle_logout (api: CMS_API; req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			r: CMS_RESPONSE
			l_cookie: WSF_COOKIE
		do
			if
				attached {WSF_STRING} req.cookie ({CMS_OPENID_CONSTANTS}.openid_session) as l_cookie_token and then
				attached {CMS_USER} current_user (req) as l_user
			then
					-- Logout OAuth
				create l_cookie.make ({CMS_OPENID_CONSTANTS}.openid_session, l_cookie_token.value)
				l_cookie.set_path ("/")
				l_cookie.set_max_age (-1)
				res.add_cookie (l_cookie)
				unset_current_user (req)
				create {GENERIC_VIEW_CMS_RESPONSE} r.make (req, res, api)
				r.set_status_code ({HTTP_CONSTANTS}.found)
				r.set_redirection (req.absolute_script_url (""))
				r.execute
			end
		end

feature {NONE} -- Helpers

	template_block (a_block_id: READABLE_STRING_8; a_response: CMS_RESPONSE): detachable CMS_SMARTY_TEMPLATE_BLOCK
			-- Smarty content block for `a_block_id'
		local
			p: detachable PATH
		do
			create p.make_from_string ("templates")
			p := p.extended ("block_").appended (a_block_id).appended_with_extension ("tpl")
			p := a_response.api.module_theme_resource_location (Current, p)
			if p /= Void then
				if attached p.entry as e then
					create Result.make (a_block_id, Void, p.parent, e)
				else
					create Result.make (a_block_id, Void, p.parent, p)
				end
			end
		end

feature {NONE} -- Block views

	get_block_view_login (a_block_id: READABLE_STRING_8; a_response: CMS_RESPONSE)
		local
			vals: CMS_VALUE_TABLE
		do
			if attached template_block (a_block_id, a_response) as l_tpl_block then
				create vals.make (1)
					-- add the variable to the block
				value_table_alter (vals, a_response)
				across
					vals as ic
				loop
					l_tpl_block.set_value (ic.item, ic.key)
				end
				if
					attached user_openid_api as l_openid_api and then
					attached l_openid_api.openid_consumers as l_list
				then
					l_tpl_block.set_value (l_list, "openid_consumers")
				end

				a_response.add_block (l_tpl_block, "content")
			else
				debug ("cms")
					a_response.add_warning_message ("Error with block [" + a_block_id + "]")
				end
			end
		end


feature -- Openid Login

	handle_login_with_openid (api: CMS_API; a_oauth_api: CMS_OPENID_API; req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			r: CMS_RESPONSE
			b: STRING
			o: OPENID_CONSUMER
		do
			if attached {WSF_STRING} req.path_parameter ({CMS_OPENID_CONSTANTS}.consumer) as p_openid and then
				attached {CMS_OPENID_CONSUMER} a_oauth_api.openid_consumer_by_name (p_openid.value) as l_oc then
				create {GENERIC_VIEW_CMS_RESPONSE} r.make (req, res, api)
				create b.make_empty
				b.append ("Check openID: " + p_openid.value)
				create o.make (req.absolute_script_url ("/account/openid-callback"))
				o.ask_email (True)
				o.ask_all_info (False)
				if attached o.auth_url (l_oc.endpoint) as l_url then
					r.set_redirection (l_url)
				else
					b.append ("Failure")
				end
				r.execute
			else
				create {BAD_REQUEST_ERROR_CMS_RESPONSE} r.make (req, res, api)
				r.set_main_content ("Bad request")
				r.execute
			end
		end

	handle_callback_openid (api: CMS_API; a_user_openid_api: CMS_OPENID_API; req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			r: CMS_RESPONSE
			l_user_api: CMS_USER_API
			l_user: CMS_USER
			l_roles: LIST [CMS_USER_ROLE]
			l_cookie: WSF_COOKIE
			es: CMS_AUTHENTICATON_EMAIL_SERVICE
			b: STRING
			o: OPENID_CONSUMER
			v: OPENID_CONSUMER_VALIDATION
		do
			create {GENERIC_VIEW_CMS_RESPONSE} r.make (req, res, api)
			create b.make_empty
			if attached req.string_item ("openid.mode") as l_openid_mode then
				create o.make (req.absolute_script_url ("/"))
				o.ask_email (True)
				o.ask_nickname (False)
				create v.make_from_items (o, req.items_as_string_items)
				v.validate
				if v.is_valid then
					if attached v.identity as l_identity and then
					    attached v.email_attribute as l_email
					then
						l_user_api := api.user_api
						if attached l_user_api.user_by_email (l_email) as p_user then
								-- User with email exist
							if	attached a_user_openid_api.user_openid_by_userid_identity (p_user.id, l_identity)	then
									-- Update openid entry?
							else
									-- create a oauth entry
								a_user_openid_api.new_user_openid (l_identity,p_user)
							end
							create l_cookie.make ({CMS_OPENID_CONSTANTS}.openid_session, l_identity)
							l_cookie.set_max_age (3600)
							l_cookie.set_path ("/")
							res.add_cookie (l_cookie)
						else

							create {ARRAYED_LIST [CMS_USER_ROLE]} l_roles.make (1)
							l_roles.force (l_user_api.authenticated_user_role)

								-- Create a new user and oauth entry
							create l_user.make (l_email)
							l_user.set_email (l_email)
							l_user.set_password (new_token) -- generate a random password.
							l_user.set_roles (l_roles)
							l_user.mark_active
							l_user_api.new_user (l_user)

								-- Add oauth entry
							a_user_openid_api.new_user_openid (l_identity, l_user )
							create l_cookie.make ({CMS_OPENID_CONSTANTS}.openid_session, l_identity)
							l_cookie.set_max_age (3600)
							l_cookie.set_path ("/")
							res.add_cookie (l_cookie)

									-- Send Email
							create es.make (create {CMS_AUTHENTICATION_EMAIL_SERVICE_PARAMETERS}.make (api))
							write_debug_log (generator + ".handle_callback_openid: send_contact_welcome_email")
							es.send_contact_welcome_email (l_email, "")
						end
					end
					r.set_redirection (r.front_page_url)
					r.execute
				else
					b.append ("User authentication failed!!")
				end
			end
		end

feature {NONE} -- Token Generation

	new_token: STRING
			-- Generate a new token activation token
		local
			l_token: STRING
			l_security: SECURITY_PROVIDER
			l_encode: URL_ENCODER
		do
			create l_security
			l_token := l_security.token
			create l_encode
			from until l_token.same_string (l_encode.encoded_string (l_token)) loop
				-- Loop ensure that we have a security token that does not contain characters that need encoding.
			    -- We cannot simply to an encode-decode because the email sent to the user will contain an encoded token
				-- but the user will need to use an unencoded token if activation has to be done manually.
				l_token := l_security.token
			end
			Result := l_token
		end

feature {NONE} -- Implementation: date and time

	http_date_format_to_date (s: READABLE_STRING_8): detachable DATE_TIME
		local
			d: HTTP_DATE
		do
			create d.make_from_string (s)
			if not d.has_error then
				Result := d.date_time
			end
		end

	file_date (p: PATH): DATE_TIME
		require
			path_exists: (create {FILE_UTILITIES}).file_path_exists (p)
		local
			f: RAW_FILE
		do
			create f.make_with_path (p)
			Result := timestamp_to_date (f.date)
		end

	timestamp_to_date (n: INTEGER): DATE_TIME
		local
			d: HTTP_DATE
		do
			create d.make_from_timestamp (n)
			Result := d.date_time
		end


note
	copyright: "Copyright (c) 1984-2013, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end

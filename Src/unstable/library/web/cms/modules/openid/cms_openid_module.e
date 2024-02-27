note
	description: "[
		Generic OpenID Module supporting authentication using different providers.
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_OPENID_MODULE

inherit
	CMS_AUTH_MODULE_I
		rename
			module_api as openid_api
		redefine
			make,
			filters,
			setup_hooks,
			initialize,
			install,
			openid_api
		end

	CMS_HOOK_BLOCK

	SHARED_EXECUTION_ENVIRONMENT
		export
			{NONE} all
		end

	REFACTORING_HELPER

create
	make

feature {NONE} -- Initialization

	make
			-- Create current module
		do
			Precursor
			version := "1.0"
			description := "Openid module"

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
			l_openid_api: like openid_api
			l_openid_storage: CMS_OPENID_STORAGE_I
		do
			Precursor (a_api)

				-- Storage initialization
			if attached a_api.storage.as_sql_storage as l_storage_sql then
				create {CMS_OPENID_STORAGE_SQL} l_openid_storage.make (l_storage_sql)
			else
				-- FIXME: in case of NULL storage, should Current be disabled?
				create {CMS_OPENID_STORAGE_NULL} l_openid_storage
			end

				-- API initialization
			create l_openid_api.make_with_storage (a_api, l_openid_storage)
			openid_api := l_openid_api
		ensure then
			user_opend_api_set: openid_api /= Void
		end

feature {CMS_API} -- Module management

	install (api: CMS_API)
		do
				-- Schema
			if attached api.storage.as_sql_storage as l_sql_storage then
					--| Schema
				l_sql_storage.sql_execute_file_script (api.module_resource_location (Current, (create {PATH}.make_from_string ("scripts")).extended ("openid_consumers.sql")), Void)

				if l_sql_storage.has_error then
					api.report_error ("[" + name + "]: installation failed!", l_sql_storage.error_handler.as_string_representation)
				else
						-- TODO workaround.
					l_sql_storage.sql_execute_file_script (api.module_resource_location (Current, (create {PATH}.make_from_string ("scripts")).extended ("openid_consumers_initialize.sql")), Void)

						-- TODO workaround, until we have an admin module
					if l_sql_storage.has_error then
						api.report_error ("[" + name + "]: installation failed!", l_sql_storage.error_handler.as_string_representation)
					else
						l_sql_storage.sql_execute_file_script (api.module_resource_location (Current, (create {PATH}.make_from_string ("scripts")).extended ("openid_items.sql")),Void)
						if l_sql_storage.has_error then
							api.report_error ("[" + name + "]: installation failed!", l_sql_storage.error_handler.as_string_representation)
						else
							Precursor {CMS_AUTH_MODULE_I}(api) -- Mark it installed.
						end
					end
				end
			end
		end

feature {CMS_API} -- Access: API

	openid_api: detachable CMS_OPENID_API
			-- <Precursor>		

feature -- Filters

	filters (a_api: CMS_API): detachable LIST [WSF_FILTER]
			-- Possibly list of Filter's module.
		do
			if attached openid_api as l_openid_api then
				create {ARRAYED_LIST [WSF_FILTER]} Result.make (1)
				Result.extend (create {CMS_OPENID_FILTER}.make (a_api, l_openid_api))
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

feature -- Access: auth strategy

	login_title: STRING = "OpenID"
			-- Module specific login title.

	login_location: STRING = "account/auth/roc-openid-login"

	logout_location: STRING = "account/auth/roc-openid-logout"

	is_authenticating (a_response: CMS_RESPONSE): BOOLEAN
			-- <Precursor>
		do
			if
				a_response.is_authenticated and then
				attached openid_api as l_openid_api and then
				attached {WSF_STRING} a_response.request.cookie (l_openid_api.session_token)
			then
				Result := True
			end
		end

feature -- Router

	setup_router (a_router: WSF_ROUTER; a_api: CMS_API)
			-- <Precursor>
		do
			if attached openid_api as l_openid_api then
				a_router.handle ("/" + login_location,
						create {WSF_URI_AGENT_HANDLER}.make (agent handle_login (a_api, ?, ?)),
						a_router.methods_get_post)
				a_router.handle ("/" + logout_location,
						create {WSF_URI_AGENT_HANDLER}.make (agent handle_logout (a_api, l_openid_api, ?, ?)),
						a_router.methods_get_post)
				a_router.handle ("/account/auth/login-with-openid/{" + openid_consumer_path_parameter + "}",
						create {WSF_URI_TEMPLATE_AGENT_HANDLER}.make (agent handle_login_with_openid (a_api, l_openid_api, ?, ?)),
						a_router.methods_get_post)
				a_router.handle ("/account/auth/openid-callback",
						create {WSF_URI_AGENT_HANDLER}.make (agent handle_callback_openid (a_api, l_openid_api, ?, ?)),
						a_router.methods_get_post)
			end
		end

	openid_consumer_path_parameter: STRING = "consumer"
			-- Consumer path parameter name.

feature -- Hooks configuration

	setup_hooks (a_hooks: CMS_HOOK_CORE_MANAGER)
			-- Module hooks configuration.
		do
			Precursor (a_hooks)
			a_hooks.subscribe_to_block_hook (Current)
		end

feature -- Hooks

	block_list: ITERABLE [like {CMS_BLOCK}.name]
		do
			Result := <<"login">>
		end

	get_block_view (a_block_id: READABLE_STRING_8; a_response: CMS_RESPONSE)
		do
			if
				a_block_id.is_case_insensitive_equal_general ("login") and then
				a_response.location.starts_with (login_location)
			then
				get_block_view_login (a_block_id, a_response)
			end
		end

	handle_login (api: CMS_API; req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			r: CMS_RESPONSE
			o: OPENID_CONSUMER
			s: STRING
		do
			create {GENERIC_VIEW_CMS_RESPONSE} r.make (req, res, api)
			if api.user_is_authenticated then
				r.add_error_message ("You are already signed in!")
			elseif req.is_get_request_method then
				r.set_optional_content_type ("Login")
			elseif req.is_post_request_method then
				create s.make_empty
				if attached req.string_item ("openid") as p_openid then
					s.append ("Check openID: " + p_openid)
					create o.make (req.absolute_script_url ("/account/auth/login-with-openid"))
					o.ask_email (True)
					o.ask_all_info (False)
					if p_openid.is_valid_as_string_8 and then attached o.auth_url (p_openid.to_string_8) as l_url then
						r.set_redirection (l_url)
					else
						s.append (" Failure")
						r.set_status_code ({HTTP_CONSTANTS}.bad_request)
						r.values.force (s, "error")
					end
				end
			end
			r.execute
		end

	handle_logout (api: CMS_API; a_openid_api: CMS_OPENID_API; req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			r: CMS_RESPONSE
			l_cookie: WSF_COOKIE
		do
			if
				attached {CMS_USER} api.user as l_user and then
				attached {WSF_STRING} req.cookie (a_openid_api.session_token) as l_cookie_token
			then
					-- Logout OAuth
				create l_cookie.make (a_openid_api.session_token, l_cookie_token.url_encoded_value)
				l_cookie.set_path ("/")
				l_cookie.set_max_age (-1)
				res.add_cookie (l_cookie)
				api.unset_current_user (req)
				create {GENERIC_VIEW_CMS_RESPONSE} r.make (req, res, api)
				r.set_status_code ({HTTP_CONSTANTS}.found)
				r.set_redirection (req.absolute_script_url (""))
				r.execute
			else
				-- FIXME: missing implementation!
			end
		end

feature {NONE} -- Block views

	get_block_view_login (a_block_id: READABLE_STRING_8; a_response: CMS_RESPONSE)
		local
			vals: CMS_VALUE_TABLE
		do
			if attached smarty_template_block (Current, a_block_id, a_response.api) as l_tpl_block then
				create vals.make (1)
					-- add the variable to the block
				a_response.api.hooks.invoke_value_table_alter (vals, a_response)
				across
					vals as ic
				loop
					l_tpl_block.set_value (ic.item, ic.key)
				end
				if
					attached openid_api as l_openid_api and then
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

	handle_login_with_openid (api: CMS_API; a_openid_api: CMS_OPENID_API; req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			r: CMS_RESPONSE
			b: STRING
			o: OPENID_CONSUMER
		do
			if
				attached {WSF_STRING} req.path_parameter (openid_consumer_path_parameter) as p_openid and then
				attached {CMS_OPENID_CONSUMER} a_openid_api.openid_consumer_by_name (p_openid.value) as l_oc
			then
				create {GENERIC_VIEW_CMS_RESPONSE} r.make (req, res, api)
				create b.make_empty
				b.append ("Check openID: " + p_openid.value)
				create o.make (req.absolute_script_url ("/account/auth/openid-callback"))
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

	handle_callback_openid (api: CMS_API; a_openid_api: CMS_OPENID_API; req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			r: CMS_RESPONSE
			l_user_api: CMS_USER_API
			l_user: CMS_USER
			l_roles: LIST [CMS_USER_ROLE]
			l_cookie: WSF_COOKIE
			es: CMS_AUTHENTICATION_EMAIL_SERVICE
			b: STRING
			o: OPENID_CONSUMER
			v: OPENID_CONSUMER_VALIDATION
			l_email: STRING_8
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
					    attached v.email_attribute as l_email_attrib
					then
						l_email := api.utf_8_encoded (l_email_attrib)
						l_user_api := api.user_api
						if attached l_user_api.user_by_email (l_email) as p_user then
								-- User with email exist
							if attached a_openid_api.user_openid_by_userid_identity (p_user.id, l_identity)	then
									-- Update openid entry?
							else
									-- create a oauth entry
								a_openid_api.new_user_openid (l_identity, p_user)
							end
							create l_cookie.make (a_openid_api.session_token, l_identity)
							l_cookie.set_max_age (a_openid_api.session_max_age)
							l_cookie.set_path ("/")
							res.add_cookie (l_cookie)
							api.record_user_login (p_user)
						else

							create {ARRAYED_LIST [CMS_USER_ROLE]} l_roles.make (1)
							l_roles.force (l_user_api.authenticated_user_role)

								-- Create a new user and oauth entry
							create l_user.make (l_email_attrib)
							l_user.set_email (l_email)
							l_user.set_password (new_token) -- generate a random password.
							l_user.set_roles (l_roles)
							l_user.mark_active
							l_user_api.new_user (l_user)

								-- Add oauth entry
							a_openid_api.new_user_openid (l_identity, l_user )
							create l_cookie.make (a_openid_api.session_token, l_identity)
							l_cookie.set_max_age (a_openid_api.session_max_age)
							l_cookie.set_path ("/")
							res.add_cookie (l_cookie)

									-- Send Email
							create es.make (create {CMS_AUTHENTICATION_EMAIL_SERVICE_PARAMETERS}.make (api))
							es.send_contact_welcome_email (l_email, l_user, req.absolute_script_url (""))
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

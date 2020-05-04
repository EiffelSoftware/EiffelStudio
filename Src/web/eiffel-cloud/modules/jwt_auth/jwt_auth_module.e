note
	description: "Summary description for {JWT_AUTH_MODULE}."
	date: "$Date$"
	revision: "$Revision$"

class
	JWT_AUTH_MODULE

inherit
	CMS_MODULE
		rename
			module_api as jwt_auth_api
		redefine
			initialize,
			install,
			setup_hooks,
			jwt_auth_api
		end

	CMS_WITH_WEBAPI

	CMS_HOOK_AUTO_REGISTER

	CMS_HOOK_FORM_ALTER

create
	make

feature {NONE} -- Initialization

	make
		do
			version := "1.0"
			description := "JWT authentication"
			package := "jwt_auth"
		end

feature -- Access

	name: STRING = "jwt_auth"

feature {CMS_API} -- Module Initialization			

	initialize (api: CMS_API)
			-- <Precursor>
		do
			Precursor (api)
			create jwt_auth_api.make (api)
		end

feature {CMS_API} -- Module management

	install (api: CMS_API)
		do
				-- Schema
			if attached api.storage.as_sql_storage as l_sql_storage then
				l_sql_storage.sql_execute_file_script (api.module_resource_location (Current, (create {PATH}.make_from_string ("scripts")).extended ("install.sql")), Void)

				if l_sql_storage.has_error then
					api.logger.put_error ("Could not initialize database for module [" + name + "]", generating_type)
				else
					Precursor {CMS_MODULE} (api)
				end
			end
		end

feature {CMS_EXECUTION} -- Administration

	webapi: JWT_AUTH_MODULE_WEBAPI
		do
			create Result.make (Current)
		end

feature {CMS_API, JWT_AUTH_MODULE_WEBAPI} -- Access: API

	jwt_auth_api: detachable JWT_AUTH_API
			-- <Precursor>

feature -- Access: router

	setup_router (a_router: WSF_ROUTER; a_api: CMS_API)
			-- <Precursor>
		do
			if attached jwt_auth_api as l_jwt_auth_api then
				a_router.handle ("/user/{uid}/jwt_access_token", create {JWT_AUTH_TOKEN_USER_HANDLER}.make (l_jwt_auth_api), a_router.methods_get_post)
			end
		end

feature -- Hooks configuration

	setup_hooks (a_hooks: CMS_HOOK_CORE_MANAGER)
			-- Module hooks configuration.
		do
			a_hooks.subscribe_to_form_alter_hook (Current)
		end

feature -- Hook

	form_alter (a_form: CMS_FORM; a_form_data: detachable WSF_FORM_DATA; a_response: CMS_RESPONSE)
			-- Hook execution on form `a_form' and its associated data `a_form_data',
			-- for related response `a_response'.
		local
			fset: WSF_FORM_FIELD_SET
			tf: WSF_FORM_TEXT_INPUT
			inf: JWT_AUTH_TOKEN
		do
			if
				attached jwt_auth_api as l_jwt_auth_api and then
				attached a_form.id as fid
			then
				if
					fid.same_string ({CMS_AUTHENTICATION_MODULE}.view_account_form_id) and then
					attached a_response.user as u
				then
					a_form.extend_html_text ("<hr/><h4>Authentication with JWT token</h4><ul><li><a href=%"" + a_response.url ("/user/" + u.id.out + "/jwt_access_token", Void) + "%">manage your tokens.</a></li></ul>%N")
				end
			end
		end


end

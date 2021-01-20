note
	description: "Module for core functionalities"
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_CORE_MODULE

inherit
	CMS_MODULE
		redefine
			initialize,
			setup_hooks,
			install,
			permissions
		end

	CMS_WITH_WEBAPI

	CMS_HOOK_AUTO_REGISTER

	CMS_HOOK_FORM_ALTER

create
	make

feature {NONE} -- Initialization

	make
		do
			version := "1.0.0.1"
			description := "Core"
			package := "core"
		end

feature -- Access

	name: STRING = "core"

feature {CMS_API} -- Module Initialization			

	initialize (api: CMS_API)
			-- <Precursor>
		do
			cms_api := api
			Precursor (api)
		end

	cms_api: detachable CMS_API

feature {CMS_API} -- Module management

	install (a_api: CMS_API)
		local
			l_parent_loc: PATH
		do
				-- Schema
			if attached a_api.storage.as_sql_storage as l_sql_storage then
				l_parent_loc := a_api.module_resource_location (Current, create {PATH}.make_from_string ("scripts"))
				l_sql_storage.sql_execute_file_script (l_parent_loc.extended (name + ".sql"), Void)
				if not l_sql_storage.has_error then
					l_sql_storage.sql_execute_file_script (l_parent_loc.extended ("user_profile.sql"), Void)
				end

				if l_sql_storage.has_error then
					a_api.report_error ("[" + name + "]: installation failed!", l_sql_storage.error_handler.as_string_representation)
				else
					Precursor {CMS_MODULE} (a_api)
				end
			end

			install_core_data (a_api)
		end

	install_core_data (a_api: CMS_API)
		local
			u: CMS_USER
			l_anonymous_role, l_authenticated_role: CMS_USER_ROLE
		do
				--| Roles
			create l_anonymous_role.make ("anonymous")
			a_api.user_api.save_user_role (l_anonymous_role)

			create l_authenticated_role.make ("authenticated")
			a_api.user_api.save_user_role (l_authenticated_role)

				--| Users
			create u.make ("admin")
			u.set_password ("istrator#")
			u.set_email (a_api.setup.site_email)
			u.mark_active
			a_api.user_api.new_user (u)

				--| Node			
				-- FIXME: move that initialization to node module
				-- TODO: should we move the initialization to an
				--! external configuration file?
				--! at the moment we only have 1 admin to the whole site.
				--! is that ok?

			l_anonymous_role.add_permission ("view any page")
			a_api.user_api.save_user_role (l_anonymous_role)

			l_authenticated_role.add_permission ("create page")
			l_authenticated_role.add_permission ("view any page")
			l_authenticated_role.add_permission ("edit any page")
			l_authenticated_role.add_permission ("delete page")
			l_authenticated_role.add_permission ("trash page")
			l_authenticated_role.add_permission ("view own page")
			l_authenticated_role.add_permission ("edit own page")
			l_authenticated_role.add_permission ("delete own page")
			l_authenticated_role.add_permission ("trash own page")
			across
				a_api.formats as ic
			loop
				l_authenticated_role.add_permission (use_format_permission_name (ic.item))
			end
			a_api.user_api.save_user_role (l_authenticated_role)
		end

feature -- Router

	setup_router (a_router: WSF_ROUTER; a_api: CMS_API)
			-- <Precursor>
		do
			a_router.handle ("/user/{uid}", create {CMS_USER_HANDLER}.make (a_api), a_router.methods_get)
		end

feature -- Security

	permissions: LIST [READABLE_STRING_8]
			-- List of permission ids, used by this module, and declared.
		do
			Result := Precursor
			Result.force ("install modules")
			Result.force ("view logs")
			Result.force ("export core")
			Result.force ("import core")
			Result.force ("admin path_alias")
			Result.force ("edit path_alias")
			Result.force ("use access_token")
			Result.force (perm_view_users)
			if attached cms_api as l_cms_api then
				across
					l_cms_api.formats as ic
				loop
					Result.force (use_format_permission_name (ic.item))
				end
			end
		end

	perm_view_users: STRING = "view users"

	use_format_permission_name (a_format: CONTENT_FORMAT): STRING
		do
			Result := "use format " + a_format.name
		end

feature {CMS_EXECUTION} -- Administration

	webapi: CMS_CORE_MODULE_WEBAPI
		do
			create Result.make (Current)
		end

feature -- Hooks

	setup_hooks (a_hooks: CMS_HOOK_CORE_MANAGER)
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
		do
			if
				attached a_form.id as fid and then
				fid.same_string ("roccms-user-view") -- Check {CMS_AUTHENTICATION_MODULE}.view_account_form_id
			then
				if
					attached a_response.user as u and then
					attached a_response.api.user_api as l_user_profile_api and then
					attached l_user_profile_api.user_profile (u) as l_profile and then
					l_profile.has_visible_items
				then
					create fset.make
					fset.set_legend ("User-Profile")
					across
						l_profile as ic
					loop
						if not ic.key.starts_with (".") then
							create tf.make_with_text (ic.key.to_string_8, ic.item) -- TODO: the key should be basic string 8, check if this is true.
							tf.set_label (html_encoded (ic.key.to_string_32))
							a_form.extend (tf)
						end
					end
					if not fset.is_empty then
						a_form.extend (fset)
					end
				end
			end
		end

note
	copyright: "2011-2021, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end

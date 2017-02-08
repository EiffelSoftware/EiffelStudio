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
			install,
			permissions
		end

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
			Precursor (api)
		end

feature {CMS_API} -- Module management

	install (a_api: CMS_API)
		do
				-- Schema
			if attached a_api.storage.as_sql_storage as l_sql_storage then
				l_sql_storage.sql_execute_file_script (a_api.module_resource_location (Current, (create {PATH}.make_from_string ("scripts")).extended (name + ".sql")), Void)

				if l_sql_storage.has_error then
					a_api.logger.put_error ("Could not initialize database for module [" + name + "]", generating_type)
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
			u.set_status ({CMS_USER}.active)
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
			a_api.user_api.save_user_role (l_authenticated_role)
		end

feature -- Router

	setup_router (a_router: WSF_ROUTER; a_api: CMS_API)
			-- <Precursor>
		do
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
		end

note
	copyright: "2011-2017, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end

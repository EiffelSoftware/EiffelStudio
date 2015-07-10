note
	description: "[
			Common ancestor for builders responsible to instantiate storage based
			on SQL statement storage.
		]"
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CMS_STORAGE_SQL_BUILDER

inherit
	CMS_STORAGE_BUILDER

feature -- Initialization

	initialize (a_setup: CMS_SETUP; a_storage: CMS_STORAGE_SQL)
		local
			u: CMS_USER
			l_anonymous_role, l_authenticated_role: CMS_USER_ROLE
		do
				--| Schema
			a_storage.sql_execute_file_script (a_setup.environment.site_path.extended ("scripts").extended ("core.sql"), Void)
			a_storage.sql_execute_file_script (a_setup.environment.site_path.extended ("scripts").extended ("user.sql"), Void)

				--| Roles
			create l_anonymous_role.make ("anonymous")
			a_storage.save_user_role (l_anonymous_role)

			create l_authenticated_role.make ("authenticated")
			a_storage.save_user_role (l_authenticated_role)

				--| Users
			create u.make ("admin")
			u.set_password ("istrator#")
			u.set_email (a_setup.site_email)
			u.set_status ({CMS_USER}.active)
			a_storage.new_user (u)

				--| Node			
				-- FIXME: move that initialization to node module
				-- TODO: should we move the initialization to an
				--! external configuration file?
				--! at the moment we only have 1 admin to the whole site.
				--! is that ok?
			l_anonymous_role.add_permission ("view any page")
			a_storage.save_user_role (l_anonymous_role)

			l_authenticated_role.add_permission ("create page")
			l_authenticated_role.add_permission ("view any page")
			l_authenticated_role.add_permission ("edit any page")
			l_authenticated_role.add_permission ("delete page")
			l_authenticated_role.add_permission ("trash page")
			l_authenticated_role.add_permission ("view own page")
			l_authenticated_role.add_permission ("edit own page")
			l_authenticated_role.add_permission ("delete own page")
			l_authenticated_role.add_permission ("trash own page")
			a_storage.save_user_role (l_authenticated_role)
		end

note
	copyright: "2011-2015, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end

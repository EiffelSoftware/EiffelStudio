note
	description: "Summary description for {EIFFEL_COMMUNITY_SITE_SERVICE}."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EIFFEL_COMMUNITY_SITE_SERVICE

inherit
	SHARED_EXECUTION_ENVIRONMENT

feature -- Implementation: CMS

	initial_cms_setup: EIFFEL_COMMUNITY_SITE_CMS_SETUP
			-- CMS setup.
		do
			create Result.make (new_cms_environment)
		end

	new_cms_environment: CMS_ENVIRONMENT
		deferred
--			if attached execution_environment.arguments.separate_character_option_value ('d') as l_dir then
--				create Result.make_with_directory_name (l_dir)
--			else
--				create Result.make_default
--			end
		end

feature -- CMS setup

	setup_storage (a_setup: CMS_SETUP)
		do
			a_setup.storage_drivers.force (create {CMS_STORAGE_STORE_MYSQL_BUILDER}.make, "mysql")
--			a_setup.storage_drivers.force (create {CMS_STORAGE_STORE_ODBC_BUILDER}.make, "odbc")
		end

	setup_modules (a_setup: CMS_SETUP)
		local
			m: CMS_MODULE
			wdocs: WDOCS_MODULE
		do
			create {CMS_ADMIN_MODULE} m.make
			m.enable
			a_setup.register_module (m)

			create {CMS_AUTHENTICATION_MODULE} m.make
			m.enable
			a_setup.register_module (m)

			create {CMS_BASIC_AUTH_MODULE} m.make
			m.enable
			a_setup.register_module (m)

			create {EMBEDDED_VIDEO_MODULE} m.make
			m.enable
			a_setup.register_module (m)

			create {CONTACT_MODULE} m.make
			m.enable
			a_setup.register_module (m)

			create {CMS_NODE_MODULE} m.make (a_setup)
			m.enable
			a_setup.register_module (m)

			create {CMS_RECENT_CHANGES_MODULE} m.make
			m.enable
			a_setup.register_module (m)

--			create {EMBEDDED_VIDEO_MODULE} m.make
--			m.enable
--			a_setup.register_module (m)

--			create {CMS_BLOG_MODULE} m.make
--			m.enable
--			a_setup.register_module (m)

				-- Wiki docs
--			create {WDOCS_MODULE} m.make
			create wdocs.make
			m := wdocs
			m.enable
			a_setup.register_module (m)

			create {WDOCS_EDIT_MODULE} m.make (wdocs)
			m.enable
			a_setup.register_module (m)

				-- Custom community
			create {EIFFEL_COMMUNITY_MODULE} m.make
			m.enable
			a_setup.register_module (m)

				-- Eiffel download
			create {EIFFEL_DOWNLOAD_MODULE} m.make
			m.enable
			a_setup.register_module (m)

				-- Eiffel codeboard
			create {CODEBOARD_MODULE} m.make
			m.enable
			a_setup.register_module (m)

				-- Wish List
			create {CMS_WISH_LIST_MODULE} m.make
			m.enable
			a_setup.register_module (m)

				-- Others...
			debug
				create {CMS_DEBUG_MODULE} m.make
				m.enable
				a_setup.register_module (m)
			end
		end


end

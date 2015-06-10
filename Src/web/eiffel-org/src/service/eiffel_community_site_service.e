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
		local
			l_env: CMS_ENVIRONMENT
		do
			if attached execution_environment.arguments.separate_character_option_value ('d') as l_dir then
				create l_env.make_with_directory_name (l_dir)
			else
				create l_env.make_default
			end
			create Result.make (l_env)
		end

feature -- CMS setup

	setup_storage (a_setup: CMS_SETUP)
		do
--			a_setup.storage_drivers.force (create {CMS_STORAGE_MYSQL_BUILDER}.make, "mysql")
--			a_setup.storage_drivers.force (create {CMS_STORAGE_SQLITE_BUILDER}.make, "sqlite")
		end

	setup_modules (a_setup: CMS_SETUP)
		local
			m: CMS_MODULE
		do
			create {CONTACT_MODULE} m.make
			m.enable
			a_setup.register_module (m)

			create {WDOCS_MODULE} m.make
			m.enable
			a_setup.register_module (m)

			create {EIFFEL_COMMUNITY_MODULE} m.make
			m.enable
			a_setup.register_module (m)

			create {EIFFEL_DOWNLOAD_MODULE} m.make
			m.enable
			a_setup.register_module (m)

			create {CODEBOARD_MODULE} m.make
			m.enable
			a_setup.register_module (m)

			debug
				create {CMS_DEBUG_MODULE} m.make
				m.enable
				a_setup.register_module (m)
			end
		end


end

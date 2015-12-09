note
	description: "Summary description for {EIFFEL_COMMUNITY_WEB_EXECUTION}."
	date: "$Date$"
	revision: "$Revision$"

class
	EIFFEL_COMMUNITY_WEB_EXECUTION

inherit
	CMS_EXECUTION
		redefine
			clean
		end

	EIFFEL_COMMUNITY_SITE_SERVICE

	REFACTORING_HELPER

	SHARED_LOGGER

create
	make

feature -- Cleaning

	clean
			-- Cleaning after request.
		do
			if attached api.storage as l_storage then
				l_storage.close
			end
			Precursor
		end

feature -- CMS setup

	setup_storage (a_setup: CMS_SETUP)
		do
			a_setup.storage_drivers.force (create {CMS_STORAGE_STORE_MYSQL_BUILDER}.make, "mysql")
--			a_setup.storage_drivers.force (create {CMS_STORAGE_STORE_ODBC_BUILDER}.make, "odbc")
--			a_setup.storage_drivers.force (create {CMS_STORAGE_SQLITE3_BUILDER}.make, "sqlite3")
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

			create {CMS_TAXONOMY_MODULE} m.make
			m.enable
			a_setup.register_module (m)

			create {CMS_RECENT_CHANGES_MODULE} m.make
			m.enable
			a_setup.register_module (m)

			create {FEED_AGGREGATOR_MODULE} m.make
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

				-- Google Custom Search Engine
			create {GOOGLE_CUSTOM_SEARCH_MODULE} m.make
			m.enable
			a_setup.register_module (m)

				-- Task List
			create {CMS_TASK_LIST_MODULE} m.make
			m.enable
			a_setup.register_module (m)


				-- Others...
			debug
				create {CMS_DEBUG_MODULE} m.make
				m.enable
				a_setup.register_module (m)
			end
		end

feature {NONE} -- Implementation

	new_cms_environment: CMS_ENVIRONMENT
		do
			if attached execution_environment.arguments.separate_character_option_value ('d') as l_dir then
				create Result.make_with_directory_name (l_dir)
			else
				create Result.make_default
			end
			Result.set_name ("eiffel_org")
		end

end


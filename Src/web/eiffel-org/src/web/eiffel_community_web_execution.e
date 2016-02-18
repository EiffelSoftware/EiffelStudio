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
			a_setup.storage_drivers.force (create {CMS_STORAGE_SQLITE3_BUILDER}.make, "sqlite3")
		end

	setup_modules (a_setup: CMS_SETUP)
		local
			m: CMS_MODULE
			wdocs: WDOCS_MODULE
		do
			a_setup.register_module (create {CMS_ADMIN_MODULE}.make)
				-- Auth
			a_setup.register_module (create {CMS_AUTHENTICATION_MODULE}.make)
			a_setup.register_module (create {CMS_BASIC_AUTH_MODULE}.make)
			a_setup.register_module (create {CMS_SESSION_AUTH_MODULE}.make)


				-- Content
			a_setup.register_module (create {CMS_NODE_MODULE}.make (a_setup))
			a_setup.register_module (create {EMBEDDED_VIDEO_MODULE}.make)
			a_setup.register_module (create {CMS_BLOG_MODULE}.make)

				-- Files
			a_setup.register_module (create {CMS_FILES_MODULE}.make)

				-- Misc
			a_setup.register_module (create {CMS_CONTACT_MODULE}.make)
			a_setup.register_module (create {CMS_TAXONOMY_MODULE}.make)
			a_setup.register_module (create {CMS_RECENT_CHANGES_MODULE}.make)
			a_setup.register_module (create {FEED_AGGREGATOR_MODULE}.make)
			a_setup.register_module (create {CMS_SEO_MODULE}.make)
			a_setup.register_module (create {CMS_CUSTOM_BLOCK_MODULE}.make)

				-- Google Custom Search Engine
			a_setup.register_module (create {GOOGLE_CUSTOM_SEARCH_MODULE}.make)

				-- Wiki docs
			create wdocs.make
			a_setup.register_module (wdocs)
			create {WDOCS_EDIT_MODULE} m.make (wdocs)
			a_setup.register_module (m)

				-- Eiffel specific
			a_setup.register_module (create {EIFFEL_COMMUNITY_MODULE}.make)
			a_setup.register_module (create {EIFFEL_DOWNLOAD_MODULE}.make)
			a_setup.register_module (create {CODEBOARD_MODULE}.make)

				-- Task and Wish List
			a_setup.register_module (create {CMS_WISH_LIST_MODULE}.make)
			a_setup.register_module (create {CMS_TASK_LIST_MODULE}.make)

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


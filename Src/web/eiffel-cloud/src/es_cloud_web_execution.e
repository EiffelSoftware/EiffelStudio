note
	description: "[
			CMS Execution for the api server.
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	ES_CLOUD_WEB_EXECUTION

inherit
	CMS_EXECUTION

create
	make

feature {NONE} -- Initialization

	initial_cms_setup: CMS_DEFAULT_SETUP
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

feature -- CMS storage

	setup_storage (a_setup: CMS_SETUP)
		do
			a_setup.storage_drivers.force (create {CMS_STORAGE_SQLITE3_BUILDER}.make, "sqlite3")
			a_setup.storage_drivers.force (create {CMS_STORAGE_STORE_MYSQL_BUILDER}.make, "mysql")
--			a_setup.storage_drivers.force (create {CMS_STORAGE_STORE_ODBC_BUILDER}.make, "odbc")
		end

feature -- CMS modules

	setup_modules (a_setup: CMS_SETUP)
			-- Setup additional modules.
		do
				-- Admin
			a_setup.register_module (create {CMS_ADMIN_MODULE}.make)

				-- Auth
			a_setup.register_module (create {CMS_AUTHENTICATION_MODULE}.make)
			a_setup.register_module (create {CMS_BASIC_AUTH_MODULE}.make)
--			a_setup.register_module (create {CMS_OAUTH_20_MODULE}.make)
--			a_setup.register_module (create {CMS_OPENID_MODULE}.make)
			a_setup.register_module (create {CMS_SESSION_AUTH_MODULE}.make)

				-- Webapi Auth
			a_setup.register_module (create {LOGIN_WITH_ESA_MODULE}.make)
			a_setup.register_module (create {JWT_AUTH_MODULE}.make)

				-- EiffelStudio
			a_setup.register_module (create {ES_CLOUD_MODULE}.make)
			a_setup.register_module (create {STRIPE_MODULE}.make)


				-- User

				-- Nodes
			a_setup.register_module (create {CMS_NODE_MODULE}.make)
			a_setup.register_module (create {CMS_PAGE_MODULE}.make)
--			a_setup.register_module (create {CMS_BLOG_MODULE}.make)

				-- Files
--			a_setup.register_module (create {CMS_FILES_MODULE}.make)

				-- Contact
			a_setup.register_module (create {CMS_CONTACT_MODULE}.make)

				-- Misc
--			a_setup.register_module (create {CMS_SEO_MODULE}.make)
--			a_setup.register_module (create {CMS_SITEMAP_MODULE}.make)
--			a_setup.register_module (create {CMS_COMMENTS_MODULE}.make)

				-- Taxonomy
--			a_setup.register_module (create {CMS_TAXONOMY_MODULE}.make)

				-- Wiki
--			a_setup.register_module (create {WIKITEXT_MODULE}.make)
			a_setup.register_module (create {EMBEDDED_VIDEO_MODULE}.make)

				-- Recent changes
--			a_setup.register_module (create {CMS_RECENT_CHANGES_MODULE}.make)

				-- Feed aggregator
--			a_setup.register_module (create {FEED_AGGREGATOR_MODULE}.make)

				-- Miscellanious
			a_setup.register_module (create {CMS_MESSAGING_MODULE}.make)
--			a_setup.register_module (create {GOOGLE_CUSTOM_SEARCH_MODULE_20}.make)
			a_setup.register_module (create {CMS_CUSTOM_BLOCK_MODULE}.make)


				-- Dev
			a_setup.register_module (create {MASQUERADE_AUTH_MODULE}.make)
		end

end

note
	description: "[
			CMS Execution for the demo server.
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	DEMO_CMS_EXECUTION

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
			if attached {EXECUTION_ENVIRONMENT}.arguments.separate_character_option_value ('d') as l_dir then
				create l_env.make_with_directory_name (l_dir)
			else
				create l_env.make_default
			end
			create Result.make (l_env)
		end

feature -- CMS storage

	setup_storage (a_setup: CMS_SETUP)
		local
			s: DEMO_CMS_STORAGE_SETUP
		do
			create s
			s.execute (a_setup)
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
			a_setup.register_module (create {CMS_OAUTH_20_MODULE}.make)
			a_setup.register_module (create {CMS_OPENID_MODULE}.make)
			a_setup.register_module (create {CMS_SESSION_AUTH_MODULE}.make)

				-- User

				-- Nodes
			a_setup.register_module (create {CMS_NODE_MODULE}.make)
			a_setup.register_module (create {CMS_PAGE_MODULE}.make)
			a_setup.register_module (create {CMS_BLOG_MODULE}.make)

				-- Files
			a_setup.register_module (create {CMS_FILES_MODULE}.make)

				-- Contact
			a_setup.register_module (create {CMS_CONTACT_MODULE}.make)

				-- Misc
			a_setup.register_module (create {CMS_SEO_MODULE}.make)
			a_setup.register_module (create {CMS_SITEMAP_MODULE}.make)
			a_setup.register_module (create {CMS_COMMENTS_MODULE}.make)

				-- Taxonomy
			a_setup.register_module (create {CMS_TAXONOMY_MODULE}.make)

				-- Wiki
			a_setup.register_module (create {WIKITEXT_MODULE}.make)
			a_setup.register_module (create {EMBEDDED_VIDEO_MODULE}.make)

				-- Recent changes
			a_setup.register_module (create {CMS_RECENT_CHANGES_MODULE}.make)

				-- Feed aggregator
			a_setup.register_module (create {FEED_AGGREGATOR_MODULE}.make)

				-- Miscellanious
			a_setup.register_module (create {CMS_MESSAGING_MODULE}.make)
			a_setup.register_module (create {GOOGLE_CUSTOM_SEARCH_MODULE_20}.make)
			a_setup.register_module (create {CMS_CUSTOM_BLOCK_MODULE}.make)
			a_setup.register_module (create {CMS_DEBUG_MODULE}.make)
			a_setup.register_module (create {CMS_DEMO_MODULE}.make)

				-- Dev
			a_setup.register_module (create {MASQUERADE_AUTH_MODULE}.make)

		end

end

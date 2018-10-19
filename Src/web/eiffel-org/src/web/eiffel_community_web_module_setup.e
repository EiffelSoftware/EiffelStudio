note
	description: "Summary description for {EIFFEL_COMMUNITY_WEB_MODULE_SETUP}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EIFFEL_COMMUNITY_WEB_MODULE_SETUP

feature -- CMS setup

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
			a_setup.register_module (create {CMS_OAUTH_20_MODULE}.make)


				-- Content
			a_setup.register_module (create {CMS_NODE_MODULE}.make)
			a_setup.register_module (create {CMS_PAGE_MODULE}.make)
			a_setup.register_module (create {CMS_BLOG_MODULE}.make)
			a_setup.register_module (create {CMS_COMMENTS_MODULE}.make)

				-- Filter
			a_setup.register_module (create {WIKITEXT_MODULE}.make)
			a_setup.register_module (create {EMBEDDED_VIDEO_MODULE}.make)

				-- Files
			a_setup.register_module (create {CMS_FILES_MODULE}.make)

				-- Misc
			a_setup.register_module (create {CMS_CONTACT_MODULE}.make)
			a_setup.register_module (create {CMS_TAXONOMY_MODULE}.make)
			a_setup.register_module (create {CMS_RECENT_CHANGES_MODULE}.make)
			a_setup.register_module (create {FEED_AGGREGATOR_MODULE}.make)
			a_setup.register_module (create {CMS_SEO_MODULE}.make)
			a_setup.register_module (create {CMS_SITEMAP_MODULE}.make)
			a_setup.register_module (create {CMS_CUSTOM_BLOCK_MODULE}.make)

				-- Google Custom Search Engine
			a_setup.register_module (create {GOOGLE_CUSTOM_SEARCH_MODULE_20}.make)

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
			a_setup.register_module (create {CMS_MESSAGING_MODULE}.make)
			debug
				create {CMS_DEBUG_MODULE} m.make
				m.enable
				a_setup.register_module (m)
			end
		end

end

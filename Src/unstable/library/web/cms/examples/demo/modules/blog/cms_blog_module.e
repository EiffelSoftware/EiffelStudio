note
	description: "Displays all posts (pages with type blog). It's possible to list posts by user."
	author: "Dario Bösch <daboesch@student.ethz.ch>"
	date: "$Date$"
	revision: "$Revision 96616$"

class
	CMS_BLOG_MODULE

inherit
	CMS_MODULE
		rename
			module_api as blog_api
		redefine
			register_hooks,
			initialize,
			install,
			blog_api
		end

	CMS_HOOK_MENU_SYSTEM_ALTER

create
	make

feature {NONE} -- Initialization

	make
		do
			name := "Blog demo module"
			version := "1.0"
			description := "Service to demonstrate new node for blog"
			package := "demo"
		end

feature {CMS_API} -- Module Initialization			

	initialize (api: CMS_API)
			-- <Precursor>
		local
			ct: CMS_BLOG_NODE_TYPE
		do
			Precursor (api)

			if attached {CMS_NODE_API} api.module_api ({NODE_MODULE}) as l_node_api then
				create blog_api.make (api, l_node_api)

				node_api := l_node_api
					-- Depends on {NODE_MODULE}
				create ct
				l_node_api.add_content_type (ct)
				l_node_api.add_content_type_webform_manager (create {CMS_BLOG_NODE_TYPE_WEBFORM_MANAGER}.make (ct))
					-- Add support for CMS_BLOG, which requires a storage extension to store the optional "tags" value
					-- For now, we only have extension based on SQL statement.
				if attached {CMS_NODE_STORAGE_SQL} l_node_api.node_storage as l_sql_node_storage then
					l_sql_node_storage.register_node_storage_extension (create {CMS_NODE_STORAGE_SQL_BLOG_EXTENSION}.make (l_sql_node_storage))
				end
			end
		end

feature {CMS_API} -- Module management

	install (api: CMS_API)
		local
			sql: STRING
		do
				-- Schema
			if attached {CMS_STORAGE_SQL_I} api.storage as l_sql_storage then
				if not l_sql_storage.sql_table_exists ("blog_post_nodes") then
					sql := "[
CREATE TABLE blog_post_nodes(
  `nid` INTEGER PRIMARY KEY AUTO_INCREMENT NOT NULL CHECK("nid">=0),
  `revision` INTEGER,
  `tags` VARCHAR(255)
);
					]"
					l_sql_storage.sql_execute_script (sql, Void)
					if l_sql_storage.has_error then
						api.logger.put_error ("Could not initialize database for blog module", generating_type)
					end
				end
				Precursor (api)
			end
		end

feature {CMS_API} -- Access: API

	blog_api: detachable CMS_BLOG_API
			-- <Precursor>

	node_api: detachable CMS_NODE_API

feature -- Access: router

	setup_router (a_router: WSF_ROUTER; a_api: CMS_API)
			-- <Precursor>
		do
			if attached blog_api as l_blog_api then
				configure_web (a_api, l_blog_api, a_router)
			else
					-- Issue with api/dependencies,
					-- thus Current module should not be used!
					-- thus no url mapping
			end
		end

	configure_web (a_api: CMS_API; a_blog_api: CMS_BLOG_API; a_router: WSF_ROUTER)
			-- Configure router mapping for web interface.
		local
			l_blog_handler: BLOG_HANDLER
			l_blog_user_handler: BLOG_USER_HANDLER
			l_uri_mapping: WSF_URI_MAPPING
		do
				-- TODO: for now, focused only on web interface, add REST api later. [2015-May-18]
			create l_blog_handler.make (a_api, a_blog_api)
			create l_blog_user_handler.make (a_api, a_blog_api)

				-- Let the class BLOG_HANDLER handle the requests on "/blogs"
			create l_uri_mapping.make_trailing_slash_ignored ("/blogs", l_blog_handler)
			a_router.map (l_uri_mapping, a_router.methods_get)

				-- We can add a page number after /blogs/ to get older posts
			a_router.handle ("/blogs/page/{page}", l_blog_handler, a_router.methods_get)

				-- If a user id is given route with blog user handler
				--| FIXME: maybe /user/{user}/blogs/  would be better.
			a_router.handle ("/blogs/user/{user}", l_blog_user_handler, a_router.methods_get)

				-- If a user id is given we also want to allow different pages
				--| FIXME: what about /user/{user}/blogs/?page={page} ?
			a_router.handle ("/blogs/user/{user}/page/{page}", l_blog_user_handler, a_router.methods_get)

		end

feature -- Hooks

	register_hooks (a_response: CMS_RESPONSE)
		do
			a_response.subscribe_to_menu_system_alter_hook (Current)
		end

	menu_system_alter (a_menu_system: CMS_MENU_SYSTEM; a_response: CMS_RESPONSE)
		local
			lnk: CMS_LOCAL_LINK
		do
				-- Add the link to the blog to the main menu
			create lnk.make ("Blogs", "blogs/")
			a_menu_system.primary_menu.extend (lnk)
		end
end

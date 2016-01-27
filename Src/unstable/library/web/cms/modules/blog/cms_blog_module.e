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
			setup_hooks,
			initialize,
			install,
			blog_api
		end

	CMS_HOOK_MENU_SYSTEM_ALTER

	CMS_HOOK_RESPONSE_ALTER

	CMS_HOOK_EXPORT

	CMS_EXPORT_NODE_UTILITIES

create
	make

feature {NONE} -- Initialization

	make
		do
			version := "1.0"
			description := "Service to demonstrate new node for blog"
			package := "demo"
			add_dependency ({CMS_NODE_MODULE})
		end

feature -- Access

	name: STRING = "blog"

feature {CMS_API} -- Module Initialization			

	initialize (api: CMS_API)
			-- <Precursor>
		local
			ct: CMS_BLOG_NODE_TYPE
		do
			Precursor (api)

			if attached {CMS_NODE_API} api.module_api ({CMS_NODE_MODULE}) as l_node_api then
				create ct
				create blog_api.make (api, l_node_api)

				node_api := l_node_api
					-- Depends on {CMS_NODE_MODULE}

					--| For now, add all available formats to content type `ct'.
				across
					api.formats as ic
				loop
					ct.extend_format (ic.item)
				end
				l_node_api.add_node_type (ct)
				l_node_api.add_node_type_webform_manager (create {CMS_BLOG_NODE_TYPE_WEBFORM_MANAGER}.make (ct, l_node_api))

					-- Add support for CMS_BLOG, which requires a storage extension to store the optional "tags" value
					-- For now, we only have extension based on SQL statement.
				if attached {CMS_NODE_STORAGE_SQL} l_node_api.node_storage as l_sql_node_storage then
					l_sql_node_storage.register_node_storage_extension (create {CMS_NODE_STORAGE_SQL_BLOG_EXTENSION}.make (l_node_api, l_sql_node_storage))
				end
			end
		end

feature {CMS_API} -- Module management

	install (a_api: CMS_API)
		do
				-- Schema
			if attached a_api.storage.as_sql_storage as l_sql_storage then
				l_sql_storage.sql_execute_file_script (a_api.module_resource_location (Current, (create {PATH}.make_from_string ("scripts")).extended ("install.sql")), Void)

				if l_sql_storage.has_error then
					a_api.logger.put_error ("Could not initialize database for module [" + name + "]", generating_type)
				else
					Precursor {CMS_MODULE} (a_api)
				end
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

	setup_hooks (a_hooks: CMS_HOOK_CORE_MANAGER)
		do
			a_hooks.subscribe_to_menu_system_alter_hook (Current)
			a_hooks.subscribe_to_response_alter_hook (Current)
			a_hooks.subscribe_to_export_hook (Current)
		end

	response_alter (a_response: CMS_RESPONSE)
		do
			a_response.add_style (a_response.url ("/module/" + name + "/files/css/blog.css", Void), Void)
		end

	menu_system_alter (a_menu_system: CMS_MENU_SYSTEM; a_response: CMS_RESPONSE)
		local
			lnk: CMS_LOCAL_LINK
		do
				-- Add the link to the blog to the main menu
			create lnk.make ("Blogs", "blogs/")
			a_menu_system.primary_menu.extend (lnk)
		end

	export_to (a_export_id_list: detachable ITERABLE [READABLE_STRING_GENERAL]; a_export_parameters: CMS_EXPORT_PARAMETERS; a_response: CMS_RESPONSE)
			-- Export data identified by `a_export_id_list',
			-- or export all data if `a_export_id_list' is Void.
		local
			n: CMS_BLOG
			p: PATH
			d: DIRECTORY
			f: PLAIN_TEXT_FILE
			lst: LIST [CMS_BLOG]
		do
			if
				a_export_id_list = Void
				or else across a_export_id_list as ic some ic.item.same_string ("blog") end
			then
				if
					a_response.has_permissions (<<"export any node", "export blog">>) and then
					attached blog_api as l_blog_api
				then
					lst := l_blog_api.blogs_order_created_desc
					a_export_parameters.log ("Exporting " + lst.count.out + " blogs")
					across
						lst as ic
					loop
						n := l_blog_api.full_blog_node (ic.item)
						a_export_parameters.log (n.content_type + " #" + n.id.out)
						p := a_export_parameters.location.extended ("nodes").extended (n.content_type).extended (n.id.out)
						create d.make_with_path (p.parent)
						if not d.exists then
							d.recursive_create_dir
						end
						create f.make_with_path (p)
						if not f.exists or else f.is_access_writable then
							f.open_write
							f.put_string (json_to_string (blog_node_to_json (n)))
							f.close
						end
							-- Revisions.
						if
							attached node_api as l_node_api and then
							attached l_node_api.node_revisions (n) as l_revisions and then l_revisions.count > 1
						then
							a_export_parameters.log (n.content_type + " " + l_revisions.count.out + " revisions.")
							p := a_export_parameters.location.extended ("nodes").extended (n.content_type).extended (n.id.out)
							create d.make_with_path (p)
							if not d.exists then
								d.recursive_create_dir
							end
							across
								l_revisions as revs_ic
							loop
								if attached {CMS_BLOG} revs_ic.item as l_blog then
									create f.make_with_path (p.extended ("rev-" + n.revision.out).appended_with_extension ("json"))
									if not f.exists or else f.is_access_writable then
										f.open_write
										f.put_string (json_to_string (blog_node_to_json (l_blog)))
									end
									f.close
								end
							end
						end
					end
				end
			end
		end

	blog_node_to_json (a_blog: CMS_BLOG): JSON_OBJECT
		do
			Result := node_to_json (a_blog)
		end
end

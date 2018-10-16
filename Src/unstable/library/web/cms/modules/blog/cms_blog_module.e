note
	description: "Displays all posts (pages with type blog). It's possible to list posts by user."
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

	CMS_WITH_MODULE_ADMINISTRATION

	CMS_HOOK_MENU_SYSTEM_ALTER

	CMS_HOOK_RESPONSE_ALTER

	CMS_HOOK_EXPORT

	CMS_HOOK_IMPORT

	CMS_EXPORT_NODE_UTILITIES

	CMS_IMPORT_NODE_UTILITIES

create
	make

feature {NONE} -- Initialization

	make
		do
			version := "1.0"
			description := "Blogging service"
			package := "content"
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
				l_node_api.add_node_type (ct)
				l_node_api.add_node_type_webform_manager (create {CMS_BLOG_NODE_TYPE_WEBFORM_MANAGER}.make (ct, l_node_api))
			end
		end

feature {CMS_API} -- Module management

	install (a_api: CMS_API)
		do
				-- Schema
			if attached a_api.storage.as_sql_storage as l_sql_storage then
				l_sql_storage.sql_execute_file_script (a_api.module_resource_location (Current, (create {PATH}.make_from_string ("scripts")).extended ("install.sql")), Void)

				if l_sql_storage.has_error then
					a_api.report_error ("[" + name + "]: installation failed!", l_sql_storage.error_handler.as_string_representation)
				else
					Precursor {CMS_MODULE} (a_api)
				end
			end
		end

feature {CMS_API, CMS_MODULE} -- Access: API

	blog_api: detachable CMS_BLOG_API
			-- <Precursor>

	node_api: detachable CMS_NODE_API

feature {NONE} -- Administration

	administration: CMS_SELF_MODULE_ADMINISTRATION [CMS_BLOG_MODULE]
			-- Administration module.
		do
			create Result.make (Current)
		end

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
			create l_blog_handler.make (a_api, a_blog_api)
			create l_blog_user_handler.make (a_api, a_blog_api)

				-- Let the class BLOG_HANDLER handle the requests on "/blogs"
			create l_uri_mapping.make_trailing_slash_ignored ("/blogs", l_blog_handler)
			a_router.map (l_uri_mapping, a_router.methods_get)

				-- We can add a page number after /blogs/ to get older posts
			a_router.handle ("/blogs/page/{page}", l_blog_handler, a_router.methods_get)

				-- If a user id is given route with blog user handler
			a_router.handle ("/blog/{user}", l_blog_user_handler, a_router.methods_get)

				-- If a user id is given we also want to allow different pages
			a_router.handle ("/blog/{user}", l_blog_user_handler, a_router.methods_get)

		end

feature -- Hooks

	setup_hooks (a_hooks: CMS_HOOK_CORE_MANAGER)
		do
			a_hooks.subscribe_to_menu_system_alter_hook (Current)
			a_hooks.subscribe_to_response_alter_hook (Current)
			a_hooks.subscribe_to_export_hook (Current)
			a_hooks.subscribe_to_import_hook (Current)
		end

	response_alter (a_response: CMS_RESPONSE)
		do
			a_response.add_style (a_response.module_resource_url (Current, "/files/css/blog.css", Void), Void)
		end

	menu_system_alter (a_menu_system: CMS_MENU_SYSTEM; a_response: CMS_RESPONSE)
		local
			lnk: CMS_LOCAL_LINK
		do
				-- Add the link to the blog to the main menu
			create lnk.make ("Blogs", "blogs/")
			a_menu_system.primary_menu.extend (lnk)
		end

	export_to (a_export_id_list: detachable ITERABLE [READABLE_STRING_GENERAL]; a_export_ctx: CMS_EXPORT_CONTEXT; a_response: CMS_RESPONSE)
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
				attached node_api as l_node_api and then
				attached l_node_api.node_type ("blog") as l_node_type and then
				(	a_export_id_list = Void
					or else across a_export_id_list as ic some ic.item.same_string (l_node_type.name) end
				)
			then
				if
					a_response.has_permissions (<<"export any node", "export " + l_node_type.name>>) and then
					attached blog_api as l_blog_api
				then
					lst := l_blog_api.blogs_order_created_desc
					a_export_ctx.log ("Exporting " + lst.count.out + " [" + l_node_type.name + "] items...")
					create d.make_with_path (a_export_ctx.location.extended ("nodes").extended (l_node_type.name))
					if d.exists then
						d.recursive_delete
					end
					across
						lst as ic
					loop
						n := l_blog_api.full_blog_node (ic.item)
						a_export_ctx.log (n.content_type + " #" + n.id.out)
						p := a_export_ctx.location.extended ("nodes").extended (n.content_type).extended (n.id.out).appended_with_extension ("json")
						create d.make_with_path (p.parent)
						if not d.exists then
							d.recursive_create_dir
						end
						create f.make_with_path (p)
						if not f.exists or else f.is_access_writable then
							f.open_write
							f.put_string (json_to_string (blog_node_to_json (n, l_blog_api)))
							f.close
						end
							-- Revisions.
						if
							attached l_node_api.node_revisions (n) as l_revisions and then
							l_revisions.count > 1
						then
							a_export_ctx.log (n.content_type + " " + l_revisions.count.out + " revisions.")
							p := a_export_ctx.location.extended ("nodes").extended (n.content_type).extended (n.id.out)
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
										f.put_string (json_to_string (blog_node_to_json (l_blog, l_blog_api)))
									end
									f.close
								end
							end
						end
					end
				end
			end
		end

	blog_node_to_json (a_blog: CMS_BLOG; a_blog_api: CMS_BLOG_API): JSON_OBJECT
		do
			Result := node_to_json (a_blog, a_blog_api.node_api)
		end

	import_from (a_import_id_list: detachable ITERABLE [READABLE_STRING_GENERAL]; a_import_ctx: CMS_IMPORT_CONTEXT; a_response: CMS_RESPONSE)
			-- Import data identified by `a_import_id_list',
			-- or import all data if `a_import_id_list' is Void.
		local
			p,fp: PATH
			d: DIRECTORY
			loc: STRING
			l_id: STRING_32
			l_entity: detachable CMS_BLOG
		do
			if
				attached node_api as l_node_api and then
				attached {CMS_BLOG_NODE_TYPE} l_node_api.node_type ("blog") as l_node_type and then
				(	a_import_id_list = Void
					or else across a_import_id_list as ic some ic.item.same_string ({CMS_BLOG_NODE_TYPE}.name) end
				)
			then
				if
					a_response.has_permissions (<<"import any node", "import " + l_node_type.name>>) and then
					attached blog_api as l_blog_api
				then
					p := a_import_ctx.location.extended ("nodes").extended (l_node_type.name)
					create d.make_with_path (p)
					if d.exists and then d.is_readable then
						a_import_ctx.log ("Importing [" + l_node_type.name + "] items ..")
						across
							d.entries as ic
						loop
							if attached ic.item.extension as ext and then ext.same_string_general ("json") then
								l_id := ic.item.name
								l_id.remove_tail (ext.count + 1)
								fp := p.extended_path (ic.item)
								if attached json_object_from_location (fp) as j then
									if
										attached json_string_item (j, "type") as l_type and then
										l_type.same_string_general (l_node_type.name)
									then
										l_entity := json_to_node_blog (l_node_type, j, l_node_api)
										if l_entity /= Void then
											if l_entity.is_published then
												if l_entity.author = Void then
														-- FIXME!!!
													if attached l_entity.editor as l_last_editor then
														l_entity.set_author (l_last_editor)
													else
														l_entity.set_author (l_blog_api.cms_api.user)
													end
													a_import_ctx.log (l_node_type.name + " %"" + fp.utf_8_name + "%" WARNING (Author is unknown!)")
												end
												if attached l_entity.author as l_author then
													if
														attached l_blog_api.blogs_by_title (l_author, l_entity.title) as l_blogs and then
														not l_blogs.is_empty
													then
															-- Blog Already exists!
															-- FIXME/TODO
														l_entity := l_blogs.first
														a_import_ctx.log (l_node_type.name + " %"" + fp.utf_8_name + "%" SKIPPED (already exists for user #" + l_author.id.out + ")!")
													else
														a_import_ctx.log (l_node_type.name + " #" + l_entity.id.out + " imported from %"" + fp.utf_8_name + "%" for user #" + l_author.id.out + ".")
														l_blog_api.import_blog (l_entity)
														apply_taxonomy_to_node (j, l_entity, l_blog_api.cms_api)
														if attached {CMS_LOCAL_LINK} l_entity.link as l_link then
															loc := l_node_api.node_path (l_entity)
															if not l_link.location.starts_with_general ("node/") then
																l_blog_api.cms_api.set_path_alias (loc, l_link.location, False)
															end
														end
													end
													if l_entity /= Void and then l_entity.has_id then
															-- Support for comments
														import_comments_file_for_entity (p.extended (l_id).extended ("comments.json"), l_entity, l_node_api.cms_api, a_import_ctx)
													end
												else
													a_import_ctx.log (l_node_type.name + " %"" + fp.utf_8_name + "%" skipped (Author is unknown!)")
												end
											else
												a_import_ctx.log (l_node_type.name + " %"" + fp.utf_8_name + "%" skipped (Status is Not Published!)")
											end
										end
									end
								end
							end
						end
					end
				else
					a_import_ctx.log ("Importing [" + l_node_type.name + "] NOT ALLOWED!")
				end
			end
		end

	json_to_node_blog (a_node_type: CMS_BLOG_NODE_TYPE; j: JSON_OBJECT; a_node_api: CMS_NODE_API): detachable CMS_BLOG
		do
			if attached json_to_node (a_node_type, j, a_node_api) as l_node then
				Result := a_node_type.new_node (l_node)
			end
		end

end

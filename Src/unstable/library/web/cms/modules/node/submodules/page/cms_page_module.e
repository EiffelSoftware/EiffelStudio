note
	description: "Node page implementation."
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_PAGE_MODULE

inherit
	CMS_MODULE
		rename
			module_api as page_api
		redefine
			setup_hooks,
			initialize,
			install, is_installed,
			page_api
		end

	CMS_HOOK_EXPORT

	CMS_HOOK_IMPORT

	CMS_WITH_MODULE_ADMINISTRATION

	CMS_EXPORT_NODE_UTILITIES

	CMS_IMPORT_NODE_UTILITIES

create
	make

feature {NONE} -- Initialization

	make
		do
			version := "1.0"
			description := "Page service"
			package := "content"
			add_dependency ({CMS_NODE_MODULE})
		end

feature -- Access

	name: STRING = "page"

feature {CMS_API} -- Module Initialization			

	initialize (a_api: CMS_API)
			-- <Precursor>
		local
			p1,p2: CMS_PAGE
			ct: CMS_PAGE_NODE_TYPE
		do
			Precursor (a_api)
			if attached {CMS_NODE_API} a_api.module_api ({CMS_NODE_MODULE}) as l_node_api then
				node_api := l_node_api

				create page_api.make (a_api, l_node_api)

					-- Add support for CMS_PAGE, which requires a storage extension to store the optional "parent" id.
					-- For now, we only have extension based on SQL statement.
				if attached {CMS_NODE_STORAGE_SQL} l_node_api.node_storage as l_sql_node_storage then
					l_sql_node_storage.register_node_storage_extension (create {CMS_NODE_STORAGE_SQL_PAGE_EXTENSION}.make (l_node_api, l_sql_node_storage))

						-- FIXME: the following code is mostly for test purpose/initialization, remove later
					if l_sql_node_storage.sql_table_items_count ("page_nodes") = 0 then
						if attached a_api.user_api.user_by_id (1) as u then
							create ct
							p1 := ct.new_node (Void)
							p1.set_title ("Welcome")
							p1.set_content ("Welcome, you are using the ROC Eiffel CMS", Void, Void) -- Use default format
							p1.set_author (u)
							p1.set_editor (u)
							l_sql_node_storage.save_node (p1)

							p2 := ct.new_node (Void)
							p2.set_title ("A new page example")
							p2.set_content ("This is the content of a page", Void, Void) -- Use default format
							p2.set_author (u)
							p2.set_editor (u)
							p2.set_parent (p1)
							l_sql_node_storage.save_node (p2)
						end
					end
				else
						-- FIXME: maybe provide a default solution based on file system, when no SQL storage is available.
						-- IDEA: we could also have generic extension to node system, that handle generic addition field.
				end
			end
		end

feature {CMS_API} -- Module management

	is_installed (a_api: CMS_API): BOOLEAN
			-- Is Current module installed?
		do
			Result := Precursor (a_api)
			if Result and attached a_api.storage.as_sql_storage as l_sql_storage then
				Result := l_sql_storage.sql_table_exists ("page_nodes")
			end
		end

	install (a_api: CMS_API)
		do
				-- Schema
			if attached a_api.storage.as_sql_storage as l_sql_storage then
				if attached a_api.installed_module ({CMS_NODE_MODULE}) as l_node_module then
					l_sql_storage.sql_execute_file_script (a_api.module_resource_location (l_node_module, (create {PATH}.make_from_string ("scripts")).extended (name).appended_with_extension ("sql")), Void)
				end
				if l_sql_storage.has_error then
					a_api.report_error ("[" + name + "]: installation failed!", l_sql_storage.error_handler.as_string_representation)
				else
					Precursor {CMS_MODULE} (a_api)
				end
			end
		end

feature {NONE} -- Administration

	administration: CMS_SELF_MODULE_ADMINISTRATION [CMS_PAGE_MODULE]
			-- Administration module.
		do
			create Result.make (Current)
		end

feature {CMS_API, CMS_MODULE_API, CMS_MODULE} -- Access: API

	page_api: detachable CMS_PAGE_API
			-- <Precursor>

	node_api: detachable CMS_NODE_API

feature -- Access: router

	setup_router (a_router: WSF_ROUTER; a_api: CMS_API)
			-- <Precursor>
		do
		end

feature -- Hooks

	setup_hooks (a_hooks: CMS_HOOK_CORE_MANAGER)
		do
			a_hooks.subscribe_to_export_hook (Current)
			a_hooks.subscribe_to_import_hook (Current)
		end

	export_to (a_export_id_list: detachable ITERABLE [READABLE_STRING_GENERAL]; a_export_ctx: CMS_EXPORT_CONTEXT; a_response: CMS_RESPONSE)
			-- Export data identified by `a_export_id_list',
			-- or export all data if `a_export_id_list' is Void.
		local
			n: CMS_PAGE
			p: PATH
			d: DIRECTORY
			f: PLAIN_TEXT_FILE
			lst: LIST [CMS_NODE]
		do
			if
				attached node_api as l_node_api and then
				attached l_node_api.node_type ("page") as l_node_type and then
				(	a_export_id_list = Void
					or else across a_export_id_list as ic some ic.item.same_string (l_node_type.name) end
				)
			then
				if
					a_response.has_permissions (<<"export any node", "export " + l_node_type.name>>) and then
					attached page_api as l_page_api
				then
					lst := l_page_api.pages
					a_export_ctx.log ("Exporting " + lst.count.out + " notes of type `" + l_node_type.name + "`.")
					create d.make_with_path (a_export_ctx.location.extended ("nodes").extended (l_node_type.name))
					if d.exists then
						d.recursive_delete
					end
					across
						lst as ic
					loop
						if attached {CMS_PAGE} ic.item as l_page_node then
							n := l_page_api.full_page_node (l_page_node)
							a_export_ctx.log (n.content_type + " #" + n.id.out)

							p := a_export_ctx.location.extended ("nodes").extended (n.content_type).extended (n.id.out).appended_with_extension ("json")
							create d.make_with_path (p.parent)
							if not d.exists then
								d.recursive_create_dir
							end

							create f.make_with_path (p)
							if not f.exists or else f.is_access_writable then
								f.open_write
								f.put_string (json_to_string (page_node_to_json (n, l_page_api)))
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
									if attached {CMS_PAGE} revs_ic.item as l_rev_page then
										create f.make_with_path (p.extended ("rev-" + n.revision.out).appended_with_extension ("json"))
										if not f.exists or else f.is_access_writable then
											f.open_write
											f.put_string (json_to_string (page_node_to_json (l_rev_page, l_page_api)))
										end
										f.close
									end
								end
							end
						end
					end
				end
			end
		end

	page_node_to_json (a_page: CMS_PAGE; a_page_api: CMS_PAGE_API): JSON_OBJECT
		local
			j: JSON_OBJECT
			p: CMS_PAGE
		do
			Result := node_to_json (a_page, a_page_api.node_api)
			if attached a_page.parent as l_parent_page then
				p := a_page_api.full_page_node (l_parent_page)
				create j.make_empty
				j.put_string (p.content_type, "type")
				j.put_string (p.title, "title")
				j.put_integer (p.id, "nid")
				if attached p.link as lnk then
					j.put (link_to_json (lnk), "link")
				end
				Result.put (j, "parent")
			end
		end

	import_from (a_import_id_list: detachable ITERABLE [READABLE_STRING_GENERAL]; a_import_ctx: CMS_IMPORT_CONTEXT; a_response: CMS_RESPONSE)
			-- Import data identified by `a_import_id_list',
			-- or import all data if `a_import_id_list' is Void.
		local
			l_id: STRING_32
			p, fp: PATH
			d: DIRECTORY
			loc: READABLE_STRING_8
			l_parentable_list: ARRAYED_LIST [TUPLE [page: CMS_PAGE; parent: CMS_PAGE]]
			l_new_pages: STRING_TABLE [CMS_PAGE] -- indexed by link location, if any.
			l_entity: detachable CMS_PAGE
		do
			if
				attached node_api as l_node_api and then
				attached {CMS_PAGE_NODE_TYPE} l_node_api.node_type ({CMS_PAGE_NODE_TYPE}.name) as l_node_type and then
				attached page_api as l_page_api and then
				(	a_import_id_list = Void
					or else across a_import_id_list as ic some ic.item.same_string (l_node_type.name) end
				)
			then
				if
					a_response.has_permissions (<<"import any node", "import " + l_node_type.name>>)
				then
					p := a_import_ctx.location.extended ("nodes").extended (l_node_type.name)
					create d.make_with_path (p)
					if d.exists and then d.is_readable then
						create l_parentable_list.make (0)
						create l_new_pages.make (0)
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
										l_entity := json_to_node_page (l_node_type, j, l_node_api)
										if l_entity /= Void then
											if l_entity.is_published then
												if l_entity.author = Void then
														-- FIXME!!!
													if attached l_entity.editor as l_editor then
														l_entity.set_author (l_editor)
													else
														l_entity.set_author (l_page_api.cms_api.user)
													end
													a_import_ctx.log (l_node_type.name + " %"" + html_encoded (fp.name) + "%" WARNING (Author is unknown!)")
												end
												if attached l_entity.author as l_author then
													if
														attached l_page_api.pages_with_title (l_entity.title) as l_pages and then
														not l_pages.is_empty
													then
															-- Page Already exists!
															-- FIXME/TODO
														l_entity := l_pages.first
														a_import_ctx.log (l_node_type.name + " from %"" + html_encoded (fp.name) + "%" SKIPPED (already exists for user #" + l_author.id.out + ")!")
													else
														if
															attached l_entity.parent as l_parent and then
															not l_parent.has_id
														then
															l_parentable_list.extend ([l_entity, l_parent])
															l_entity.set_parent (Void)
														end
														l_page_api.import_page (l_entity)
														apply_taxonomy_to_node (j, l_entity, l_page_api.cms_api)
														l_new_pages.force (l_entity, l_node_api.node_path (l_entity))
														a_import_ctx.log (l_node_type.name + " #" + l_entity.id.out + " imported from %"" + html_encoded (fp.name) + "%" for user #" + l_author.id.out + ".")
														if attached {CMS_LOCAL_LINK} l_entity.link as l_link then
															loc := l_node_api.node_path (l_entity)
															if not l_link.location.starts_with_general ("node/") then
																l_page_api.cms_api.set_path_alias (loc, l_link.location, False)
																l_new_pages.force (l_entity, l_link.location)
															end
														end
													end
													if l_entity /= Void and then l_entity.has_id then
															-- Support for comments
														import_comments_file_for_entity (p.extended (l_id).extended ("comments.json"), l_entity, l_node_api.cms_api, a_import_ctx)
													end
												else
													a_import_ctx.log (l_node_type.name + " %"" + html_encoded (fp.name) + "%" skipped (Author is unknown!)")
												end
											else
												a_import_ctx.log (l_node_type.name + " %"" + html_encoded (fp.name) + "%" skipped (Status is Not Published!)")
											end
										end
									end
								end
							end
						end
						across
							l_parentable_list as ic
						loop
							l_entity := ic.item.page
							update_page_parent (l_entity, ic.item.parent, l_new_pages)
							if attached l_entity.parent as l_parent then
								a_import_ctx.log (l_node_type.name + " #" + l_entity.id.out + " assigned to parent #" + l_parent.id.out)
								l_page_api.import_page (l_entity)
							else
								a_import_ctx.log (l_node_type.name + " #" + l_entity.id.out + " : unable to find parent!")
							end
						end
					end
				else
					a_import_ctx.log ("Importing [" + l_node_type.name + "] NOT ALLOWED!")
				end
			end
		end

	json_to_node_page (a_node_type: CMS_PAGE_NODE_TYPE; j: JSON_OBJECT; a_node_api: CMS_NODE_API): detachable CMS_PAGE
		local
			p: detachable CMS_PAGE
		do
			if attached json_to_node (a_node_type, j, a_node_api) as l_node then
				Result := a_node_type.new_node (l_node)
				if
					attached {JSON_OBJECT} j.item ("parent") as j_parent and then
					attached json_string_item (j_parent, "title") as l_title
				then
					p := a_node_type.new_node_with_title (l_title, Void)
					if
						attached {JSON_OBJECT} j_parent.item ("link") as j_link and then
						attached json_to_local_link (j_link) as l_parent_lnk and then
						not l_parent_lnk.location.starts_with ("node/")
					then
						p.set_link (l_parent_lnk)
					else
							-- No link ..
					end
					if not Result.is_parent_of (p) then
						Result.set_parent (p)
					end
				end
			end
		end

	update_page_parent (a_page: CMS_PAGE; a_parent: CMS_PAGE; a_new_pages: STRING_TABLE [CMS_PAGE])
		require
			no_parent_set: a_page.parent = Void
		local
			lst: detachable LIST [CMS_PAGE]
			p: detachable CMS_PAGE
		do
			p := a_parent
			if attached page_api as l_page_api then
				if attached a_parent.link as l_parent_lnk then
					lst := l_page_api.pages_with_title (a_parent.title)
					across
						lst as ic
					until
						p.has_id
					loop
						if
							attached ic.item.link as lnk and then
							lnk.location.same_string_general (l_parent_lnk.location)
						then
							p := ic.item
						end
					end
				else
					lst := l_page_api.pages_with_title (a_parent.title)
					if lst.count = 1 then
						p := lst.first
					end
				end
			end
			if p.has_id then
				a_page.set_parent (p)
			end
		end

end

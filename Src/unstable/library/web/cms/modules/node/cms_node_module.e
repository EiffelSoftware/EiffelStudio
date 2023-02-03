note
	description: "CMS module bringing support for NODE management."
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_NODE_MODULE

inherit
	CMS_MODULE_WITH_SQL_STORAGE
		redefine
			setup_hooks,
			initialize,
			is_installed,
			module_api,
			permissions
		end

	CMS_WITH_MODULE_ADMINISTRATION

	CMS_HOOK_MENU_SYSTEM_ALTER

	CMS_HOOK_RESPONSE_ALTER

	CMS_HOOK_BLOCK

	CMS_RECENT_CHANGES_HOOK

	FEED_PROVIDER_HOOK

	CMS_SITEMAP_HOOK

	CMS_TAXONOMY_HOOK

create
	make

feature {NONE} -- Initialization

	make
			-- Create Current module, disabled by default.
		do
			version := "1.0.0.1"
			description := "Service to manage content based on 'node'"
			package := "core"
				-- Optional dependencies, mainly for information.
			add_optional_dependency ({CMS_RECENT_CHANGES_MODULE})
			add_optional_dependency ({FEED_AGGREGATOR_MODULE})
			add_optional_dependency ({CMS_SITEMAP_MODULE})
			add_optional_dependency ({CMS_TAXONOMY_MODULE})
		end

feature -- Access

	name: STRING = "node"

feature {CMS_API} -- Module Initialization			

	initialize (a_api: CMS_API)
			-- <Precursor>
		local
			l_node_api: like node_api
			l_node_storage: CMS_NODE_STORAGE_I
		do
			Precursor (a_api)

				-- Storage initialization
			if attached a_api.storage.as_sql_storage as l_storage_sql then
				create {CMS_NODE_STORAGE_SQL} l_node_storage.make (l_storage_sql)
			else
				-- FIXME: in case of NULL storage, should Current be disabled?
				create {CMS_NODE_STORAGE_NULL} l_node_storage.make
			end

				-- Node API initialization
			create l_node_api.make_with_storage (a_api, l_node_storage)
			node_api := l_node_api
		ensure then
			node_api_set: node_api /= Void
		end

feature {CMS_API} -- Module management

	is_installed (a_api: CMS_API): BOOLEAN
			-- Is Current module installed?
		do
			Result := Precursor (a_api)
			if Result then
				Result := has_sql_table ("nodes", a_api)
			end
		end

feature {CMS_API, CMS_NODE_MODULE_ADMINISTRATION} -- Access: API

	module_api: detachable CMS_MODULE_API
			-- <Precursor>
		do
			if attached node_api as l_api then
				Result := l_api
			else
					-- Current is initialized, so node_api should be set.
				check has_node_api: False end
			end
		end

	node_api: detachable CMS_NODE_API
			-- <Precursor>

feature {NONE} -- Administration

	administration: CMS_NODE_MODULE_ADMINISTRATION
		do
			create Result.make (Current)
		end

feature -- Access			

	permissions: LIST [READABLE_STRING_8]
			-- <Precursor>.
		local
			l_type_name: READABLE_STRING_8
		do
			Result := Precursor
			Result.force ("create any node")
			Result.force ("export any node")

			if attached node_api as l_node_api then
				across
					l_node_api.node_types as ic
				loop
					l_type_name := ic.item.name
					if not l_type_name.is_whitespace then
						Result.force ("create " + l_type_name)
						Result.force ("delete " + l_type_name)
						Result.force ("trash " + l_type_name)

						Result.force ("view any " + l_type_name)
						Result.force ("edit any " + l_type_name)
						Result.force ("delete any " + l_type_name)
						Result.force ("trash any " + l_type_name)
						Result.force ("restore any " + l_type_name)

						Result.force ("view revisions any " + l_type_name)

						Result.force ("view own " + l_type_name)
						Result.force ("edit own " + l_type_name)
						Result.force ("delete own " + l_type_name)
						Result.force ("trash own " + l_type_name)
						Result.force ("restore own " + l_type_name)

						Result.force ("view unpublished " + l_type_name)
						Result.force ("view revisions own " + l_type_name)

						Result.force ("export " + l_type_name)
					end
				end
				Result.force ("view trash")
				Result.force ("view own trash")
			end
		end

feature -- Access: router

	setup_router (a_router: WSF_ROUTER; a_api: CMS_API)
			-- <Precursor>
		do
			if attached node_api as l_node_api then
				configure_web (a_api, l_node_api, a_router)
			end
		end

	configure_web (a_api: CMS_API; a_node_api: CMS_NODE_API; a_router: WSF_ROUTER)
		local
			l_node_handler: NODE_HANDLER
			l_nodes_handler: NODES_HANDLER
			l_uri_mapping: WSF_URI_MAPPING
			l_trash_handler: TRASH_HANDLER
		do
				-- TODO: for now, focused only on web interface, add REST api later. [2015-April-29]
			create l_node_handler.make (a_api, a_node_api)
			create l_uri_mapping.make_trailing_slash_ignored ("/node", l_node_handler)
			a_router.map (l_uri_mapping, a_router.methods_get_post)

			a_router.handle ("/node/add/{type}", l_node_handler, a_router.methods_get_post)
			a_router.handle ("/node/preview/{type}", l_node_handler, a_router.methods_post)
			a_router.handle ("/node/{id}/revision", l_node_handler, a_router.methods_get)
			a_router.handle ("/node/{id}/edit", l_node_handler, a_router.methods_get_post)
			a_router.handle ("/node/{id}/preview", l_node_handler, a_router.methods_post)
			a_router.handle ("/node/{id}/delete", l_node_handler, a_router.methods_get_post)
			a_router.handle ("/node/{id}/trash", l_node_handler, a_router.methods_get_post)

			a_router.handle ("/node/{id}", l_node_handler, a_router.methods_get)
				-- For now: no REST API handling... a_router.methods_get_put_delete + a_router.methods_get_post)

				-- Nodes
			create l_nodes_handler.make (a_api, a_node_api)
			create l_uri_mapping.make_trailing_slash_ignored ("/nodes", l_nodes_handler)
			a_router.map (l_uri_mapping, a_router.methods_get)
			a_router.handle ("/nodes/{type}", l_nodes_handler, a_router.methods_get)
			a_router.handle ("/nodes/{type}/feed", l_nodes_handler, a_router.methods_get)

				-- Trash
			create l_trash_handler.make (a_api, a_node_api)
			create l_uri_mapping.make_trailing_slash_ignored ("/trash", l_trash_handler)
			a_router.map (l_uri_mapping, a_router.methods_get)

		end

feature -- Hooks

	setup_hooks (a_hooks: CMS_HOOK_CORE_MANAGER)
			-- <Precursor>
		do
			a_hooks.subscribe_to_menu_system_alter_hook (Current)
			a_hooks.subscribe_to_block_hook (Current)
			a_hooks.subscribe_to_response_alter_hook (Current)
--			a_hooks.subscribe_to_export_hook (Current)

				-- Module specific hook, if available.
			a_hooks.subscribe_to_hook (Current, {CMS_RECENT_CHANGES_HOOK})
			a_hooks.subscribe_to_hook (Current, {CMS_SITEMAP_HOOK})
			a_hooks.subscribe_to_hook (Current, {CMS_TAXONOMY_HOOK})
			a_hooks.subscribe_to_hook (Current, {FEED_PROVIDER_HOOK})
		end

	response_alter (a_response: CMS_RESPONSE)
			-- <Precursor>
		do
			a_response.add_style (a_response.module_resource_url (Current, "/files/css/node.css", Void), Void)
			if attached {NODE_FORM_RESPONSE} a_response then
				a_response.add_javascript_url (a_response.module_resource_url (Current, "/files/js/node_form.js", Void))
			end
		end

	block_list: ITERABLE [like {CMS_BLOCK}.name]
			-- <Precursor>
		do
			Result := <<"?node-info">>
		end

	get_block_view (a_block_id: READABLE_STRING_8; a_response: CMS_RESPONSE)
		local
--			b: CMS_CONTENT_BLOCK
		do
--			create b.make (a_block_id, "Block::node", "This is a block test", Void)
--			a_response.add_block (b, "sidebar_second")
		end

	menu_system_alter (a_menu_system: CMS_MENU_SYSTEM; a_response: CMS_RESPONSE)
		local
			lnk: CMS_LOCAL_LINK
			perms: ARRAYED_LIST [READABLE_STRING_8]
		do
			debug
				create lnk.make ("List of nodes", "nodes")
				a_menu_system.navigation_menu.extend (lnk)
			end
			create lnk.make ("Trash", "trash")
			a_menu_system.navigation_menu.extend (lnk)
			lnk.set_permission_arguments (<<"view trash">>)

			create lnk.make ("Create ..", "node")
			a_menu_system.navigation_menu.extend (lnk)
			if attached node_api as l_node_api then
				create perms.make (2)
				perms.force ("create any node")
				across
					l_node_api.node_types as ic
				loop
					perms.force ("create " + ic.item.name)
				end
				lnk.set_permission_arguments (perms)
			end
		end

	recent_changes_sources: detachable LIST [READABLE_STRING_8]
			-- <Precursor>
		local
			lst: ARRAYED_LIST [READABLE_STRING_8]
		do
			if
				attached node_api as l_node_api and then
				attached l_node_api.node_types as l_types and then
				not l_types.is_empty
			then
				create lst.make (l_types.count)
				across
					l_types as ic
				loop
					lst.force (ic.item.name)
				end
				Result := lst
			end
		end

	populate_recent_changes (a_changes: CMS_RECENT_CHANGE_CONTAINER; a_current_user: detachable CMS_USER)
		local
			params: CMS_DATA_QUERY_PARAMETERS
			ch: CMS_RECENT_CHANGE_ITEM
			n: CMS_NODE
			l_info: STRING_8
			l_src: detachable READABLE_STRING_8
			l_nodes: ITERABLE [CMS_NODE]
			l_date: detachable DATE_TIME
		do
			create params.make (0, a_changes.limit)
			if attached node_api as l_node_api then
				l_src := a_changes.source
				l_date := a_changes.date
				if l_date = Void then
					create l_date.make_now_utc
				end
				l_nodes := l_node_api.recent_node_changes_before (params, l_date)
				across l_nodes as ic loop
					n := ic.item
					a_changes.set_last_date_for_source (n.modification_date, n.content_type)
					if l_src = Void or else l_src.is_case_insensitive_equal_general (n.content_type) then
						if l_node_api.has_permission_for_action_on_node ("view", n, a_current_user) then
							n := l_node_api.full_node (n)
							create ch.make (n.content_type, create {CMS_LOCAL_LINK}.make (n.title, "node/" + n.id.out), n.modification_date)
							ch.set_id (n.content_type + ":id" + n.id.out + "-rev" + n.revision.out)
							if n.creation_date ~ n.modification_date then
								l_info := "new"
								if not n.is_published then
									l_info.append (" (unpublished)")
								end
							else
								if n.is_trashed then
									l_info := "deleted"
								else
									l_info := "updated"
									if not n.is_published then
										l_info.append (" (unpublished)")
									end
								end
							end
							ch.set_information (l_info)
							if n.editor = Void then
								ch.set_author (n.author)
							else
								ch.set_author (n.editor)
							end
							ch.set_summary (n.summary)
							if attached {CMS_TAXONOMY_API} l_node_api.cms_api.module_api ({CMS_TAXONOMY_MODULE}) as l_taxonomy_api then
								if attached l_taxonomy_api.terms_of_content (n, Void) as l_terms then
									across
										l_terms as t_ic
									loop
										ch.add_category (t_ic.item.text)
									end
								end
							end
							if a_changes.has_expected_author (ch) then
								a_changes.force (ch)
							else
									-- filtered out.
							end
						else
							-- Forbidden
							-- FIXME: provide a visual indication!
						end
					end
				end
			end
		end

	populate_content_associated_with_term (t: CMS_TERM; a_contents: CMS_TAXONOMY_ENTITY_CONTAINER)
		local
			l_node_typenames: ARRAYED_LIST [READABLE_STRING_8]
			nid: INTEGER_64
			l_info_to_remove: ARRAYED_LIST [TUPLE [entity: READABLE_STRING_32; typename: detachable READABLE_STRING_32]]
		do
			if
				attached node_api as l_node_api and then
				attached l_node_api.node_types as l_node_types and then
				not l_node_types.is_empty
			then
				create l_node_typenames.make (l_node_types.count)
				across
					l_node_types as ic
				loop
					l_node_typenames.force (ic.item.name)
				end
				create l_info_to_remove.make (0)
				across
					a_contents.taxonomy_info as ic
				loop
					if
						attached ic.item.typename as l_typename and then
						across l_node_typenames as t_ic some t_ic.item.same_string_general (l_typename) end
					then
						if ic.item.entity.is_integer then
							nid := ic.item.entity.to_integer_64
							if nid > 0 and then attached l_node_api.node (nid) as l_node then
								if l_node.link = Void then
									l_node.set_link (l_node_api.node_link (l_node))
								end
								a_contents.force (create {CMS_TAXONOMY_ENTITY}.make (l_node, l_node.modification_date))
								l_info_to_remove.force (ic.item)
							end
						end
					end
				end
				across
					l_info_to_remove as ic
				loop
					a_contents.taxonomy_info.prune_all (ic.item)
				end
			end
		end

	populate_sitemap (a_sitemap: CMS_SITEMAP)
			-- Populate `a_sitemap`.
		local
			i: CMS_SITEMAP_ITEM
			n: CMS_NODE
		do
			if attached node_api as l_node_api then
				across
					l_node_api.nodes as ic -- FIXME: do not load all nodes at once!
				loop
					n := ic.item
					create i.make (l_node_api.node_link (n), n.modification_date)
					a_sitemap.force (i)
				end
			end
		end

feature -- Feed hook

	feed (a_location: READABLE_STRING_8): detachable FEED
			-- Feed associated with `a_location`.
		local
			l_path, s: READABLE_STRING_8
		do
			if
				attached node_api as l_node_api and then
				attached l_node_api.cms_api.site_url as l_site_url and then
				a_location.starts_with (l_site_url)
			then
				l_path := a_location.substring (l_site_url.count, a_location.count) -- Keep the first slash.
				if l_path.starts_with_general ("/nodes/") and l_path.ends_with ("/feed") then
					s := l_path.substring (8, l_path.count - 5)
					if attached l_node_api.node_type (s) as l_node_type then
						Result := l_node_api.feed (l_node_type, 0, l_path)
					end
				end
			end
		end

end

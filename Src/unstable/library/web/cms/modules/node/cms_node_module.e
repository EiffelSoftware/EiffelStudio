note
	description: "CMS module bringing support for NODE management."
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_NODE_MODULE

inherit
	CMS_MODULE
		redefine
			register_hooks,
			initialize,
			is_installed,
			install,
			module_api,
			permissions
		end

	CMS_HOOK_MENU_SYSTEM_ALTER

	CMS_HOOK_RESPONSE_ALTER

	CMS_HOOK_BLOCK

	CMS_RECENT_CHANGES_HOOK

create
	make

feature {NONE} -- Initialization

	make (a_setup: CMS_SETUP)
			-- Create Current module, disabled by default.
		do
			version := "1.0"
			description := "Service to manage content based on 'node'"
			package := "core"
			config := a_setup
		end

	config: CMS_SETUP
			-- Node configuration.

feature -- Access

	name: STRING = "node"

feature {CMS_API} -- Module Initialization			

	initialize (a_api: CMS_API)
			-- <Precursor>
		local
			p1,p2: CMS_PAGE
			ct: CMS_PAGE_NODE_TYPE
			l_node_api: like node_api
			l_node_storage: CMS_NODE_STORAGE_I
		do
			Precursor (a_api)

				-- Storage initialization
			if attached {CMS_STORAGE_SQL_I} a_api.storage as l_storage_sql then
				create {CMS_NODE_STORAGE_SQL} l_node_storage.make (l_storage_sql)
			else
				-- FIXME: in case of NULL storage, should Current be disabled?
				create {CMS_NODE_STORAGE_NULL} l_node_storage.make
			end

				-- Node API initialization
			create l_node_api.make_with_storage (a_api, l_node_storage)
			node_api := l_node_api

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
						l_sql_node_storage.save_node (p1)

						p2 := ct.new_node (Void)
						p2.set_title ("A new page example")
						p2.set_content ("This is the content of a page", Void, Void) -- Use default format
						p2.set_author (u)
						p2.set_parent (p1)
						l_sql_node_storage.save_node (p2)
					end
				end
			else
					-- FIXME: maybe provide a default solution based on file system, when no SQL storage is available.
					-- IDEA: we could also have generic extension to node system, that handle generic addition field.
			end
		ensure then
			node_api_set: node_api /= Void
		end

feature {CMS_API} -- Module management

	is_installed (a_api: CMS_API): BOOLEAN
			-- Is Current module installed?
		do
			Result := Precursor (a_api)
			if Result and attached {CMS_STORAGE_SQL_I} a_api.storage as l_sql_storage then
				Result := l_sql_storage.sql_table_exists ("nodes") and
					l_sql_storage.sql_table_exists ("page_nodes")
			end
		end

	install (a_api: CMS_API)
		do
				-- Schema
			if attached {CMS_STORAGE_SQL_I} a_api.storage as l_sql_storage then
				l_sql_storage.sql_execute_file_script (a_api.module_resource_location (Current, (create {PATH}.make_from_string ("scripts")).extended (name).appended_with_extension ("sql")), Void)
			end
			Precursor {CMS_MODULE}(a_api)
		end

feature {CMS_API} -- Access: API

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

feature -- Access			

	permissions: LIST [READABLE_STRING_8]
			-- <Precursor>.
		local
			l_type_name: READABLE_STRING_8
		do
			Result := Precursor
			Result.force ("create any node")

			if attached node_api as l_node_api then
				across
					l_node_api.content_types as ic
				loop
					l_type_name := ic.item.name
					if not l_type_name.is_whitespace then
						Result.force ("create " + l_type_name)

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
					end
				end
				Result.force ("view trash")
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
			a_router.handle ("/node/{id}/revision", l_node_handler, a_router.methods_get)
			a_router.handle ("/node/{id}/edit", l_node_handler, a_router.methods_get_post)
			a_router.handle ("/node/{id}/delete", l_node_handler, a_router.methods_get_post)
			a_router.handle ("/node/{id}/trash", l_node_handler, a_router.methods_get_post)

			a_router.handle ("/node/{id}", l_node_handler, a_router.methods_get)
				-- For now: no REST API handling... a_router.methods_get_put_delete + a_router.methods_get_post)

				-- Nodes
			create l_nodes_handler.make (a_api, a_node_api)
			create l_uri_mapping.make_trailing_slash_ignored ("/nodes", l_nodes_handler)
			a_router.map (l_uri_mapping, a_router.methods_get)

				-- Trash
			create l_trash_handler.make (a_api, a_node_api)
			create l_uri_mapping.make_trailing_slash_ignored ("/trash", l_trash_handler)
			a_router.map (l_uri_mapping, a_router.methods_get)

		end

feature -- Hooks

	register_hooks (a_response: CMS_RESPONSE)
			-- <Precursor>
		do
			a_response.hooks.subscribe_to_menu_system_alter_hook (Current)
			a_response.hooks.subscribe_to_block_hook (Current)
			a_response.hooks.subscribe_to_response_alter_hook (Current)

				-- Module specific hook, if available.
			a_response.hooks.subscribe_to_hook (Current, {CMS_RECENT_CHANGES_HOOK})
		end

	response_alter (a_response: CMS_RESPONSE)
			-- <Precursor>
		do
			a_response.add_style (a_response.url ("/module/" + name + "/files/css/node.css", Void), Void)
		end

	block_list: ITERABLE [like {CMS_BLOCK}.name]
			-- <Precursor>
		do
			Result := <<"node-info">>
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
					l_node_api.content_types as ic
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
				attached l_node_api.content_types as l_types and then
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
					if l_src = Void or else l_src.is_case_insensitive_equal_general (n.content_type) then
						if l_node_api.has_permission_for_action_on_node ("view", n, a_current_user) then
							n := l_node_api.full_node (n)
							create ch.make (n.content_type, create {CMS_LOCAL_LINK}.make (n.title, "node/" + n.id.out), n.modification_date)
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
							ch.set_author (n.author)
							a_changes.force (ch)
						else
							-- Forbidden
							-- FIXME: provide a visual indication!
						end
					end
				end
			end
		end

end

note
	description: "CMS module that bring support for NODE management."
	date: "$Date$"
	revision: "$Revision$"

class
	NODE_MODULE

inherit

	CMS_MODULE
		rename
			module_api as node_api
		redefine
			register_hooks,
			initialize,
			is_installed,
			install,
			node_api
		end

	CMS_HOOK_MENU_SYSTEM_ALTER

	CMS_HOOK_BLOCK

create
	make

feature {NONE} -- Initialization

	make (a_setup: CMS_SETUP)
			-- Create Current module, disabled by default.
		do
			name := "node"
			version := "1.0"
			description := "Service to manage content based on 'node'"
			package := "core"
			config := a_setup
		end

	config: CMS_SETUP
			-- Node configuration.

feature {CMS_API} -- Module Initialization			

	initialize (api: CMS_API)
			-- <Precursor>
		local
			p1,p2: CMS_PAGE
			ct: CMS_PAGE_NODE_TYPE
			l_node_api: like node_api
		do
			Precursor (api)
			create l_node_api.make (api)
			node_api := l_node_api

				-- Add support for CMS_PAGE, which requires a storage extension to store the optional "parent" id.
				-- For now, we only have extension based on SQL statement.
			if attached {CMS_NODE_STORAGE_SQL} l_node_api.node_storage as l_sql_node_storage then
				l_sql_node_storage.register_node_storage_extension (create {CMS_NODE_STORAGE_SQL_PAGE_EXTENSION}.make (l_sql_node_storage))

					-- FIXME: the following code is mostly for test purpose/initialization, remove later
				if l_sql_node_storage.sql_table_items_count ("page_nodes") = 0 then
					if attached api.user_api.user_by_id (1) as u then
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
		end

feature {CMS_API} -- Module management

	is_installed (api: CMS_API): BOOLEAN
			-- Is Current module installed?
		do
			if attached {CMS_STORAGE_SQL_I} api.storage as l_sql_storage then
				Result := l_sql_storage.sql_table_exists ("nodes") and
					l_sql_storage.sql_table_exists ("page_nodes")
			end
		end

	install (api: CMS_API)
		do
				-- Schema
			if attached {CMS_STORAGE_SQL_I} api.storage as l_sql_storage then
				l_sql_storage.sql_execute_file_script (api.setup.environment.path.extended ("scripts").extended (name).appended_with_extension ("sql"))
			end
		end

feature {CMS_API} -- Access: API

	node_api: detachable CMS_NODE_API
			-- <Precursor>

feature -- Access: router

	setup_router (a_router: WSF_ROUTER; a_api: CMS_API)
			-- <Precursor>
		local
			l_node_api: like node_api
		do
			l_node_api := node_api
			if l_node_api = Void then
				create l_node_api.make (a_api)
				node_api := l_node_api
			end
			configure_web (a_api, l_node_api, a_router)
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
			a_router.map_with_request_methods (l_uri_mapping, a_router.methods_get_post)

			a_router.handle_with_request_methods ("/node/add/{type}", l_node_handler, a_router.methods_get_post)
			a_router.handle_with_request_methods ("/node/{id}/edit", l_node_handler, a_router.methods_get_post)
			a_router.handle_with_request_methods ("/node/{id}/delete", l_node_handler, a_router.methods_get_post)
			a_router.handle_with_request_methods ("/node/{id}/trash", l_node_handler, a_router.methods_get_post)

			a_router.handle_with_request_methods ("/node/{id}", l_node_handler, a_router.methods_get)
				-- For now: no REST API handling... a_router.methods_get_put_delete + a_router.methods_get_post)

				-- Nodes
			create l_nodes_handler.make (a_api, a_node_api)
			create l_uri_mapping.make_trailing_slash_ignored ("/nodes", l_nodes_handler)
			a_router.map_with_request_methods (l_uri_mapping, a_router.methods_get)

				--Trash

			create l_trash_handler.make (a_api, a_node_api)
			create l_uri_mapping.make_trailing_slash_ignored ("/trash", l_trash_handler)
			a_router.map_with_request_methods (l_uri_mapping, a_router.methods_get)

		end

feature -- Hooks

	register_hooks (a_response: CMS_RESPONSE)
			-- <Precursor>
		do
			a_response.subscribe_to_menu_system_alter_hook (Current)
			a_response.subscribe_to_block_hook (Current)
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
--			perms: detachable ARRAYED_LIST [READABLE_STRING_8]
		do
			create lnk.make ("List of nodes", a_response.url ("/nodes", Void))
			a_menu_system.primary_menu.extend (lnk)

			create lnk.make ("Trash nodes", a_response.url ("/trash", Void))
			a_menu_system.primary_menu.extend (lnk)

			create lnk.make ("Create ..", a_response.url ("/node/", Void))
			a_menu_system.primary_menu.extend (lnk)
		end

end

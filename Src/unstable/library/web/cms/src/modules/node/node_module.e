note
	description: "CMS module that bring support for NODE management."
	date: "$Date$"
	revision: "$Revision$"

class
	NODE_MODULE

inherit

	CMS_MODULE
		redefine
			register_hooks
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

feature -- Access: router

	router (a_api: CMS_API): WSF_ROUTER
			-- Node router.
		local
			l_node_api: CMS_NODE_API
		do
			create l_node_api.make (a_api)
			create Result.make (5)
			configure_api_node (a_api, l_node_api, Result)
			configure_api_nodes (a_api, l_node_api, Result)
			configure_api_node_title (a_api, l_node_api, Result)
			configure_api_node_summary (a_api, l_node_api, Result)
			configure_api_node_content (a_api, l_node_api, Result)
		end

feature {NONE} -- Implementation: routes

	configure_api_node (a_api: CMS_API; a_node_api: CMS_NODE_API; a_router: WSF_ROUTER)
		local
			l_node_handler: NODE_HANDLER
			l_methods: WSF_REQUEST_METHODS
		do
			create l_node_handler.make (a_api, a_node_api)
			create l_methods
			l_methods.enable_get
			l_methods.enable_post
			l_methods.enable_put
			a_router.handle_with_request_methods ("/node", l_node_handler, l_methods)

			create l_node_handler.make (a_api, a_node_api)
			create l_methods
			l_methods.enable_get
			l_methods.enable_post
			l_methods.enable_put
			l_methods.enable_delete
			a_router.handle_with_request_methods ("/node/{id}", l_node_handler, l_methods)
			a_router.handle_with_request_methods ("/nodes/", create {WSF_URI_AGENT_HANDLER}.make (agent do_get_nodes (?,?, a_api, a_node_api)), a_router.methods_get)
		end

	configure_api_nodes (a_api: CMS_API; a_node_api: CMS_NODE_API; a_router: WSF_ROUTER)
		local
			l_nodes_handler: NODES_HANDLER
			l_methods: WSF_REQUEST_METHODS
		do
			create l_nodes_handler.make (a_api, a_node_api)
			create l_methods
			l_methods.enable_get
			a_router.handle_with_request_methods ("/nodes", l_nodes_handler, l_methods)
		end

	configure_api_node_summary (a_api: CMS_API; a_node_api: CMS_NODE_API; a_router: WSF_ROUTER)
		local
			l_report_handler: NODE_SUMMARY_HANDLER
			l_methods: WSF_REQUEST_METHODS
		do
			create l_report_handler.make (a_api, a_node_api)
			create l_methods
			l_methods.enable_get
			l_methods.enable_post
			l_methods.enable_put
			a_router.handle_with_request_methods ("/node/{id}/summary", l_report_handler, l_methods)
		end

	configure_api_node_title (a_api: CMS_API; a_node_api: CMS_NODE_API; a_router: WSF_ROUTER)
		local
			l_report_handler: NODE_TITLE_HANDLER
			l_methods: WSF_REQUEST_METHODS
		do
			create l_report_handler.make (a_api, a_node_api)
			create l_methods
			l_methods.enable_get
			l_methods.enable_post
			l_methods.enable_put
			a_router.handle_with_request_methods ("/node/{id}/title", l_report_handler, l_methods)
		end

	configure_api_node_content (a_api: CMS_API; a_node_api: CMS_NODE_API; a_router: WSF_ROUTER)
		local
			l_report_handler: NODE_CONTENT_HANDLER
			l_methods: WSF_REQUEST_METHODS
		do
			create l_report_handler.make (a_api, a_node_api)
			create l_methods
			l_methods.enable_get
			l_methods.enable_post
			l_methods.enable_put
			a_router.handle_with_request_methods ("/node/{id}/content", l_report_handler, l_methods)
		end

feature -- Hooks

	register_hooks (a_response: CMS_RESPONSE)
		do
			a_response.subscribe_to_menu_system_alter_hook (Current)
			a_response.subscribe_to_block_hook (Current)
		end

	block_list: ITERABLE [like {CMS_BLOCK}.name]
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
		end

feature -- Handler

	do_get_nodes (req: WSF_REQUEST; res: WSF_RESPONSE; a_api: CMS_API; a_node_api: CMS_NODE_API)
		local
			r: CMS_RESPONSE
			s: STRING
			l_user: CMS_USER
			l_node: CMS_NODE
		do
			create {GENERIC_VIEW_CMS_RESPONSE} r.make (req, res, a_api)

			if attached a_api.user_api.user_by_name ("foo") as u then
				l_user := u
			else
				create l_user.make ("foo")
				l_user.set_password ("foobar#")
				l_user.set_email ("test@example.com")
				a_api.user_api.new_user (l_user)
			end
			if a_node_api.nodes_count = 0 then
				create l_node.make ({STRING_32} "This is a content", {STRING_32} "And a summary", {STRING_32} "Nice title")
				l_node.set_author (l_user)
				a_node_api.new_node (l_node)
			end

			create s.make_from_string ("<p>Nodes:</p>")
			if attached a_node_api.nodes as lst then
				across
					lst as ic
				loop
					s.append ("<li>")
					s.append (a_api.html_encoded (ic.item.title))
					s.append (" (")
					s.append (ic.item.id.out)
					s.append (")")
					s.append ("</li>%N")
				end
			end

			r.set_main_content (s)
			r.add_block (create {CMS_CONTENT_BLOCK}.make ("nodes_warning", Void, "/nodes/ is not yet fully implemented<br/>", Void), "highlighted")
			r.execute
		end

end

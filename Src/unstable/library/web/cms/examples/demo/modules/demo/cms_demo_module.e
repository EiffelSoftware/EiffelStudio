note
	description: "Summary description for {CMS_DEMO_MODULE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_DEMO_MODULE

inherit
	CMS_MODULE
		redefine
			register_hooks,
			initialize,
			is_installed,
			install
		end

	CMS_HOOK_MENU_SYSTEM_ALTER

	CMS_HOOK_BLOCK

create
	make

feature {NONE} -- Initialization

	make
		do
			name := "Demo module"
			version := "1.0"
			description := "Service to demonstrate and test cms system"
			package := "demo"
		end

feature {CMS_API} -- Module Initialization			

	initialize (api: CMS_API)
			-- <Precursor>
		do
			Precursor (api)

				-- Add support for CMS_PAGE, which requires a storage extension to store the optional "parent" id.
				-- For now, we only have extension based on SQL statement.
--			if attached {CMS_NODE_STORAGE_SQL} l_node_api.node_storage as l_sql_node_storage then
--				l_sql_node_storage.register_node_storage_extension (create {CMS_NODE_STORAGE_SQL_PAGE_EXTENSION}.make (l_sql_node_storage))
--			end
		end

feature {CMS_API} -- Module management

	is_installed (api: CMS_API): BOOLEAN
			-- Is Current module installed?
		do
			Result := attached api.storage.custom_value ("is_initialized", "module-" + name) as v and then v.is_case_insensitive_equal_general ("yes")
		end

	install (api: CMS_API)
		local
			sql: STRING
		do
				-- Schema
			if attached {CMS_STORAGE_SQL_I} api.storage as l_sql_storage then
				if not l_sql_storage.sql_table_exists ("tb_demo") then
					sql := "[
CREATE TABLE tb_demo(
  `demo_id` INTEGER PRIMARY KEY AUTO_INCREMENT NOT NULL CHECK("demo_id">=0),
  `name` VARCHAR(100) NOT NULL,
  `value` TEXT
);
					]"
					l_sql_storage.sql_execute_script (sql)
					if l_sql_storage.has_error then
						api.logger.put_error ("Could not initialize database for demo module", generating_type)
					end
				end
				api.storage.set_custom_value ("is_initialized", "module-" + name, "yes")
			end
		end

feature -- Access: router

	setup_router (a_router: WSF_ROUTER; a_api: CMS_API)
			-- <Precursor>
		do
			map_uri_template_agent (a_router, "/demo/", agent handle_demo (?,?,a_api))
			map_uri_template_agent (a_router, "/demo/{id}", agent handle_demo_entry (?,?,a_api))
		end

feature -- Hooks

	register_hooks (a_response: CMS_RESPONSE)
		do
			a_response.subscribe_to_menu_system_alter_hook (Current)
			a_response.subscribe_to_block_hook (Current)
		end

	block_list: ITERABLE [like {CMS_BLOCK}.name]
		do
			Result := <<"demo-info">>
		end

	get_block_view (a_block_id: READABLE_STRING_8; a_response: CMS_RESPONSE)
		local
--			b: CMS_CONTENT_BLOCK
			mb: CMS_MENU_BLOCK
			m: CMS_MENU
			lnk: CMS_LOCAL_LINK
		do
			if a_block_id.is_case_insensitive_equal_general ("demo-info") then
				if a_response.request.request_uri.starts_with ("/demo/") then
					create m.make_with_title (a_block_id, "Demo", 2)
					create lnk.make ("demo: abc", "demo/abc")
					m.extend (lnk)
					create lnk.make ("demo: 123", "demo/123")
					m.extend (lnk)
					create mb.make (m)
					a_response.add_block (mb, "sidebar_second")
				end
			end
		end

	menu_system_alter (a_menu_system: CMS_MENU_SYSTEM; a_response: CMS_RESPONSE)
		local
			lnk: CMS_LOCAL_LINK
--			perms: detachable ARRAYED_LIST [READABLE_STRING_8]
		do
			create lnk.make ("Demo", "demo/")
			a_menu_system.primary_menu.extend (lnk)
		end

feature -- Handler

	handle_demo,
	handle_demo_entry (req: WSF_REQUEST; res: WSF_RESPONSE; a_api: CMS_API)
		local
			r: NOT_IMPLEMENTED_ERROR_CMS_RESPONSE
		do
			create r.make (req, res, a_api)
			r.set_main_content ("DEMO module does not yet implement %"" + req.path_info + "%" ...")
			r.add_error_message ("DEMO Module: not yet implemented")
			r.execute
		end

feature -- Mapping helper: uri template

	map_uri_template (a_router: WSF_ROUTER; a_tpl: STRING; h: WSF_URI_TEMPLATE_HANDLER)
			-- Map `h' as handler for `a_tpl'
		require
			a_tpl_attached: a_tpl /= Void
			h_attached: h /= Void
		do
			map_uri_template_with_request_methods (a_router, a_tpl, h, Void)
		end

	map_uri_template_with_request_methods (a_router: WSF_ROUTER; a_tpl: READABLE_STRING_8; h: WSF_URI_TEMPLATE_HANDLER; rqst_methods: detachable WSF_REQUEST_METHODS)
			-- Map `h' as handler for `a_tpl' for request methods `rqst_methods'.
		require
			a_tpl_attached: a_tpl /= Void
			h_attached: h /= Void
		do
			a_router.map_with_request_methods (create {WSF_URI_TEMPLATE_MAPPING}.make (a_tpl, h), rqst_methods)
		end

feature -- Mapping helper: uri template agent

	map_uri_template_agent (a_router: WSF_ROUTER; a_tpl: READABLE_STRING_8; proc: PROCEDURE [ANY, TUPLE [req: WSF_REQUEST; res: WSF_RESPONSE]])
			-- Map `proc' as handler for `a_tpl'
		require
			a_tpl_attached: a_tpl /= Void
			proc_attached: proc /= Void
		do
			map_uri_template_agent_with_request_methods (a_router, a_tpl, proc, Void)
		end

	map_uri_template_agent_with_request_methods (a_router: WSF_ROUTER; a_tpl: READABLE_STRING_8; proc: PROCEDURE [ANY, TUPLE [req: WSF_REQUEST; res: WSF_RESPONSE]]; rqst_methods: detachable WSF_REQUEST_METHODS)
			-- Map `proc' as handler for `a_tpl' for request methods `rqst_methods'.
		require
			a_tpl_attached: a_tpl /= Void
			proc_attached: proc /= Void
		do
			map_uri_template_with_request_methods (a_router, a_tpl, create {WSF_URI_TEMPLATE_AGENT_HANDLER}.make (proc), rqst_methods)
		end

end

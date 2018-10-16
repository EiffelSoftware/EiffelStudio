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
			setup_hooks,
			initialize,
			install
		end

	CMS_HOOK_MENU_SYSTEM_ALTER

	CMS_HOOK_BLOCK

create
	make

feature {NONE} -- Initialization

	make
		do
			version := "1.0"
			description := "Service to demonstrate and test cms system"
			package := "demo"
		end

feature -- Access

	name: STRING = "demo"

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
					l_sql_storage.sql_execute_script (sql, Void)
					if l_sql_storage.has_error then
						api.report_error ("[" + name + "]: installation failed!", l_sql_storage.error_handler.as_string_representation)
					end
				end
			end
				-- For this demo, be flexible, and do not required sql.
			Precursor {CMS_MODULE}(api)
		end

feature -- Access: router

	setup_router (a_router: WSF_ROUTER; a_api: CMS_API)
			-- <Precursor>
		do
			map_uri_template_agent (a_router, "/demo/", agent handle_demo (?,?,a_api), Void)
			map_uri_template_agent (a_router, "/demo/{id}", agent handle_demo_entry (?,?,a_api), Void)
		end

feature -- Hooks

	setup_hooks (a_hooks: CMS_HOOK_CORE_MANAGER)
		do
			a_hooks.subscribe_to_menu_system_alter_hook (Current)
			a_hooks.subscribe_to_block_hook (Current)
		end

	block_list: ITERABLE [like {CMS_BLOCK}.name]
		do
			Result := <<"?demo-info">>
		end

	get_block_view (a_block_id: READABLE_STRING_8; a_response: CMS_RESPONSE)
		local
--			b: CMS_CONTENT_BLOCK
			mb: CMS_MENU_BLOCK
			m: CMS_MENU
			lnk: CMS_LOCAL_LINK
		do
			if a_block_id.same_string ("demo-info") then
				if a_response.location.starts_with_general ("demo/") then
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
			r.set_main_content ("DEMO module does not yet implement %"" + req.percent_encoded_path_info + "%" ...")
			r.add_error_message ("DEMO Module: not yet implemented")
			r.execute
		end

feature -- Mapping helper: uri template

	map_uri_template (a_router: WSF_ROUTER; a_tpl: READABLE_STRING_8; h: WSF_URI_TEMPLATE_HANDLER; rqst_methods: detachable WSF_REQUEST_METHODS)
			-- Map `h' as handler for `a_tpl' for request methods `rqst_methods'.
		require
			a_tpl_attached: a_tpl /= Void
			h_attached: h /= Void
		do
			a_router.map (create {WSF_URI_TEMPLATE_MAPPING}.make (a_tpl, h), rqst_methods)
		end

feature -- Mapping helper: uri template agent

	map_uri_template_agent (a_router: WSF_ROUTER; a_tpl: READABLE_STRING_8; proc: PROCEDURE [WSF_REQUEST, WSF_RESPONSE]; rqst_methods: detachable WSF_REQUEST_METHODS)
			-- Map `proc' as handler for `a_tpl' for request methods `rqst_methods'.
		require
			a_tpl_attached: a_tpl /= Void
			proc_attached: proc /= Void
		do
			map_uri_template (a_router, a_tpl, create {WSF_URI_TEMPLATE_AGENT_HANDLER}.make (proc), rqst_methods)
		end

end

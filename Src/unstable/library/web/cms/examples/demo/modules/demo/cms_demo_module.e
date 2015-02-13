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
			register_hooks
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

feature -- Access: router

	router (a_api: CMS_API): WSF_ROUTER
			-- Node router.
		do
			create Result.make (2)
			map_uri_template_agent (Result, "/demo/", agent handle_demo (?,?,a_api))
			map_uri_template_agent (Result, "/demo/{id}", agent handle_demo_entry (?,?,a_api))
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
					create lnk.make ("/demo/abc", a_response.url ("/demo/abc", Void))
					m.extend (lnk)
					create lnk.make ("/demo/123", a_response.url ("/demo/123", Void))
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
			create lnk.make ("Demo", "/demo/")
			a_menu_system.primary_menu.extend (lnk)
		end

feature -- Handler

	initialize_module (a_api: CMS_API)
		local
			sql: STRING
		do
			if attached {CMS_STORAGE_SQL} a_api.storage as sql_db then
				sql_db.sql_query ("select count(*) from tb_demo;", Void)
				if sql_db.has_error then
						-- Initialize db for demo module
					sql := "[
CREATE TABLE "tb_demo"(
  "did" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL CHECK("did">=0),
  "name" VARCHAR(100) NOT NULL,
  "value" TEXT
);
					]"
					sql_db.reset_error
					sql_db.sql_change (sql, Void)
					if sql_db.has_error then
						a_api.logger.put_error ("Could not initialize database for demo module", generating_type)
					end
				end
			end
		end

	handle_demo,
	handle_demo_entry (req: WSF_REQUEST; res: WSF_RESPONSE; a_api: CMS_API)
		local
			r: NOT_IMPLEMENTED_ERROR_CMS_RESPONSE
		do
			initialize_module (a_api)

			create r.make (req, res, a_api)
			r.set_main_content ("NODE module does not yet implement %"" + req.path_info + "%" ...")
			r.add_error_message ("NODE Module: not yet implemented")
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

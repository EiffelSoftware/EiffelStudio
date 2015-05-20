note
	description: "Summary description for {CMS_BLOG_MODULE}."
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_BLOG_MODULE

inherit
	CMS_MODULE
		redefine
			register_hooks,
			initialize,
			is_installed,
			install
		end

	CMS_HOOK_MENU_SYSTEM_ALTER

create
	make

feature {NONE} -- Initialization

	make
		do
			name := "Blog demo module"
			version := "1.0"
			description := "Service to demonstrate new node for blog"
			package := "demo"
		end

feature {CMS_API} -- Module Initialization			

	initialize (api: CMS_API)
			-- <Precursor>
		local
			ct: CMS_BLOG_NODE_TYPE
		do
			Precursor (api)

			if attached {CMS_NODE_API} api.module_api ({NODE_MODULE}) as l_node_api then
				create ct
				l_node_api.add_content_type (ct)
				l_node_api.add_content_type_webform_manager (create {CMS_BLOG_NODE_TYPE_WEBFORM_MANAGER}.make (ct))
					-- Add support for CMS_BLOG, which requires a storage extension to store the optional "tags" value
					-- For now, we only have extension based on SQL statement.
				if attached {CMS_NODE_STORAGE_SQL} l_node_api.node_storage as l_sql_node_storage then
					l_sql_node_storage.register_node_storage_extension (create {CMS_NODE_STORAGE_SQL_BLOG_EXTENSION}.make (l_sql_node_storage))
				end
			end
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
				if not l_sql_storage.sql_table_exists ("blog_post_nodes") then
					sql := "[
CREATE TABLE "blog_post_nodes"(
  "nid" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL CHECK("nid">=0),
  "revision" INTEGER,
  "tags" VARCHAR(255)
);
					]"
					l_sql_storage.sql_execute_script (sql)
					if l_sql_storage.has_error then
						api.logger.put_error ("Could not initialize database for blog module", generating_type)
					end
				end
				api.storage.set_custom_value ("is_initialized", "module-" + name, "yes")
			end
		end

feature -- Access: router

	setup_router (a_router: WSF_ROUTER; a_api: CMS_API)
			-- <Precursor>
		do
			a_router.handle_with_request_methods ("/blogs/", create {WSF_URI_AGENT_HANDLER}.make (agent handle_blogs (?,?, a_api)), a_router.methods_get)
		end

feature -- Hooks

	register_hooks (a_response: CMS_RESPONSE)
		do
			a_response.subscribe_to_menu_system_alter_hook (Current)
		end

	menu_system_alter (a_menu_system: CMS_MENU_SYSTEM; a_response: CMS_RESPONSE)
		local
			lnk: CMS_LOCAL_LINK
		do
			create lnk.make ("Blogs", "blogs/")
			a_menu_system.primary_menu.extend (lnk)
		end

feature -- Handler

	handle_blogs (req: WSF_REQUEST; res: WSF_RESPONSE; a_api: CMS_API)
		local
			r: NOT_IMPLEMENTED_ERROR_CMS_RESPONSE
		do
			create r.make (req, res, a_api)
			r.set_main_content ("Blog module is in development ...")
			r.execute
		end

end

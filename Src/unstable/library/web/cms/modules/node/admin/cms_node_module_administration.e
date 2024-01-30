note
	description: "Summary description for {CMS_NODE_MODULE_ADMINISTRATION}."
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_NODE_MODULE_ADMINISTRATION

inherit
	CMS_MODULE_ADMINISTRATION [CMS_NODE_MODULE]
		redefine
			setup_hooks,
			permissions
		end

	CMS_HOOK_AUTO_REGISTER

	CMS_HOOK_MENU_SYSTEM_ALTER

create
	make

feature -- Security

	permissions: LIST [READABLE_STRING_8]
			-- List of permission ids, used by this module, and declared.
		do
			Result := Precursor
			Result.force (perm_admin_nodes)
		end

	perm_admin_nodes: STRING = "admin nodes"

feature {NONE} -- Router/administration

	setup_administration_router (a_router: WSF_ROUTER; a_api: CMS_API)
			-- <Precursor>
		local
			hlr: WSF_URI_TEMPLATE_AGENT_HANDLER
		do
			if attached module.node_api as l_mod_api then
				create hlr.make (agent handle_get_nodes (?, ?, l_mod_api))
				a_router.handle ("/nodes/", hlr, a_router.Methods_get)

				create hlr.make (agent handle_get_typed_nodes (?, ?, l_mod_api))
				a_router.handle ("/nodes/{type}", hlr, a_router.Methods_get)
			end
		end

feature -- Routes

	handle_get_nodes (req: WSF_REQUEST; res: WSF_RESPONSE; api: CMS_NODE_API)
		local
			l_response: CMS_RESPONSE
			s: STRING
		do
			if api.cms_api.has_permission (perm_admin_nodes) then
				create {GENERIC_VIEW_CMS_RESPONSE} l_response.make (req, res, api.cms_api)
				create s.make_empty
				s.append ("<h1>Manage nodes ...</h1>%N")
				if attached module.node_api as l_node_api then
					s.append ("<ul class=%"nodes%">")
					across l_node_api.node_types as ic loop
						s.append ("<li><a href=%""+ url_encoded (ic.item.name) +"%">" + html_encoded (ic.item.title) + "</a></li>")
					end
					s.append ("</ul>")
				end

				l_response.set_main_content (s)
				l_response.execute
			else
				api.cms_api.response_api.send_access_denied ("", req, res)
			end
		end

	handle_get_typed_nodes (req: WSF_REQUEST; res: WSF_RESPONSE; api: CMS_NODE_API)
		local
			l_response: CMS_RESPONSE
			s: STRING
			nb: NATURAL_64
			qp: CMS_DATA_QUERY_PARAMETERS
			l_page_helper: CMS_PAGINATION_GENERATOR
			s_pager: STRING
--			l_lower, l_upper: NATURAL_64
		do
			if api.cms_api.has_permission (perm_admin_nodes) then
				if attached {WSF_STRING} req.path_parameter ("type") as p_node_type then
					create {GENERIC_VIEW_CMS_RESPONSE} l_response.make (req, res, api.cms_api)
					create s.make_empty
					if attached module.node_api as l_node_api then
						if attached l_node_api.node_type (p_node_type.value) as nt then
							nb := l_node_api.nodes_of_type_count (nt)

							create s_pager.make_empty
							create l_page_helper.make (req.percent_encoded_path_info + "?page={page}&size={size}", nb, 25) -- FIXME: Make this default page size a global CMS settings
							l_page_helper.get_setting_from_request (req)
							if l_page_helper.has_upper_limit and then l_page_helper.pages_count > 1 then
								l_page_helper.append_to_html (l_response, s_pager)
							end

							s.append ("<h1>" + nb.out + " " + html_encoded (nt.title) + " nodes ...</h1>%N")
							s.append (s_pager)
							s.append ("<ul class=%"nodes%">")
							create qp.make (l_page_helper.current_page_offset, l_page_helper.page_size)
							across l_node_api.recent_nodes_of_type (nt, qp) as ic loop
								s.append ("<li class=%""+ url_encoded (nt.name)+"%">")
								s.append ("<a href=%""+ api.cms_api.url (api.node_path (ic.item), Void) +"%">" + html_encoded (ic.item.title) + "</a>")
								s.append ("</li>")
							end
							s.append ("</ul>")
							s.append (s_pager)
						else
							api.cms_api.response_api.send_not_found (Void, req, res)
						end
					end
					l_response.set_main_content (s)
					l_response.execute
				else
					api.cms_api.response_api.send_bad_request (Void, req, res)
				end
			else
				api.cms_api.response_api.send_access_denied ("", req, res)
			end
		end

feature -- Hooks configuration

	setup_hooks (a_hooks: CMS_HOOK_CORE_MANAGER)
			-- Module hooks configuration.
		do
			a_hooks.subscribe_to_menu_system_alter_hook (Current)
		end

	menu_system_alter (a_menu_system: CMS_MENU_SYSTEM; a_response: CMS_RESPONSE)
			-- Hook execution on collection of menu contained by `a_menu_system'
			-- for related response `a_response'.
		local
			lnk: CMS_LOCAL_LINK
		do
			if a_response.has_permission (perm_admin_nodes) then
				lnk := a_response.api.administration_link ("Nodes", "nodes/")
				lnk.set_permission_arguments (<<perm_admin_nodes>>)
				a_menu_system.management_menu.extend_into (lnk, "Admin", a_response.api.administration_path_location (""))
			end
		end

end


note
	description: "Summary description for {CMS_CUSTOM_BLOCK_MODULE_ADMINISTRATION}."
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_CUSTOM_BLOCK_MODULE_ADMINISTRATION

inherit
	CMS_MODULE_ADMINISTRATION [CMS_CUSTOM_BLOCK_MODULE]
		redefine
			setup_hooks,
			permissions
		end

	CMS_HOOK_AUTO_REGISTER

	CMS_HOOK_MENU_SYSTEM_ALTER

	CMS_HOOK_RESPONSE_ALTER

create
	make

feature -- Security

	permissions: LIST [READABLE_STRING_8]
			-- List of permission ids, used by this module, and declared.
		do
			Result := Precursor;
			Result.force ("admin custom blocks")
		end

feature {NONE} -- Router/administration

	setup_administration_router (a_router: WSF_ROUTER; a_api: CMS_API)
			-- Setup url dispatching for Current module administration.
			-- (note: `a_router` is already based with admin path prefix).
		local
		do
			if attached module.custom_block_api as l_api then
				a_router.handle ("/custom-blocks/", create {WSF_URI_AGENT_HANDLER}.make (agent handle_custom_blocks (?, ?, l_api)), a_router.Methods_get)
			end
		end

feature -- Request

	handle_custom_blocks (req: WSF_REQUEST; res: WSF_RESPONSE; api: CMS_CUSTOM_BLOCK_API)
		local
			r: CMS_RESPONSE
			s: STRING_8
			bk: CMS_CUSTOM_BLOCK
		do
			create {GENERIC_VIEW_CMS_RESPONSE} r.make (req, res, api.cms_api);
			r.set_title ("Custom blocks");
			r.set_page_title ("Custom Blocks")
			create s.make (1024);
			s.append ("<div class=%"custom-blocks%">")
			across
				api.blocks as ic
			loop
				bk := ic.item;
				s.append ("<div><span class=%"id%">");
				s.append (html_encoded (bk.id));
				s.append ("</span>")
				if attached bk.title as t then
					s.append (" <span class=%"title%">");
					s.append (html_encoded (t));
					s.append ("</span>")
				end
				if bk.is_raw then
					s.append (" [RAW]")
				end;
				s.append (" weight=" + bk.weight.out)
				if attached bk.conditions as l_conds and then not l_conds.is_empty then
					if l_conds.count = 1 and then attached l_conds.first as c then
						s.append (" condition=");
						s.append (html_encoded (c.expression))
					else
						s.append ("<div>Conditions:<ul>")
						across
							l_conds as cic
						loop
							s.append ("<li>");
							s.append (html_encoded (cic.item.expression));
							s.append ("</li>%N")
						end;
						s.append ("</ul></div>")
					end
				end
				if attached api.block_template (bk.id) as tpl and then attached tpl.informations as tu then
					if tu.is_writable then
						s.append ("<div class=%"code editable%">")
					else
						s.append ("<div class=%"code readonly%">")
					end;
					s.append ("<span>Path: " + html_encoded (tu.location.name) + "</span>%N");
					s.append ("<textarea rows=%"10%" cols=%"75%">");
					s.append (tu.utf_8_code);
					s.append ("</textarea>");
					s.append ("</div>")
				end;
				s.append ("</div>")
			end;
			s.append ("</div>");
			r.set_main_content (s);
			r.execute
		end

feature

	setup_hooks (a_hooks: CMS_HOOK_CORE_MANAGER)
			-- Hook execution on collection of menu contained by `a_menu_system`
			-- for related response `a_response`.
		do
			a_hooks.subscribe_to_menu_system_alter_hook (Current)
		end

	response_alter (a_response: CMS_RESPONSE)
		do
			a_response.add_style (a_response.module_resource_url (Current, "/files/css/style.css", Void), Void)
		end

	menu_system_alter (a_menu_system: CMS_MENU_SYSTEM; a_response: CMS_RESPONSE)
			-- Hook execution on collection of menu contained by `a_menu_system`
			-- for related response `a_response`.
		local
			lnk: CMS_LOCAL_LINK
		do
			if a_response.has_permission ("admin custom blocks") then
				lnk := a_response.api.administration_link ("custom-blocks", "custom-blocks/")
				lnk.set_permission_arguments (<<"admin custom blocks">>)
				a_menu_system.management_menu.extend_into (lnk, "Admin", a_response.api.administration_path_location (""))
			end
		end

end

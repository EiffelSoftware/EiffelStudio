note
	description: "Summary description for {NODE_MODULE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	NODE_MODULE

inherit
	CMS_MODULE
		redefine
			permissions
		end

	CMS_HOOK_MENU_ALTER

	CMS_HOOK_BLOCK

create
	make

feature {NONE} -- Initialization

	make
		do
			name := "node"
			version := "1.0"
			description := "Service to manage content based on 'node'"
			package := "core"

			enable
		end

feature -- Access

	permissions (a_service: CMS_SERVICE): LIST [CMS_PERMISSION]
		do
			Result := Precursor (a_service)
			across
				a_service.content_types as c
			loop
				Result.extend ("create " + c.item.name)
				Result.extend ("edit " + c.item.name)
				Result.extend ("delete " + c.item.name)
			end
		end

feature {CMS_SERVICE} -- Registration

	service: detachable CMS_SERVICE

	register (a_service: CMS_SERVICE)
		local
			h: CMS_HANDLER
		do
			service := a_service
			a_service.map_uri ("/node/add", agent handle_node_add (a_service, ?, ?))
			a_service.map_uri_template ("/node/add/{type}", agent handle_node_add (a_service, ?, ?))

			create {CMS_HANDLER} h.make (agent handle_node_view (a_service, ?, ?))
			a_service.router.map (create {WSF_URI_TEMPLATE_MAPPING}.make ("/node/{nid}", h))
			a_service.router.map (create {WSF_URI_TEMPLATE_MAPPING}.make ("/node/{nid}/view", h))

			a_service.map_uri_template ("/node/{nid}/edit", agent handle_node_edit (a_service, ?, ?))

			a_service.add_content_type (create {CMS_PAGE_CONTENT_TYPE}.make)

			a_service.add_menu_alter_hook (Current)
			a_service.add_block_hook (Current)

		end

feature -- Hooks

	block_list: ITERABLE [like {CMS_BLOCK}.name]
		do
			Result := <<"node-info">>
		end

	get_block_view (a_block_id: detachable READABLE_STRING_8; a_execution: CMS_EXECUTION)
--		local
--			b: CMS_CONTENT_BLOCK
		do
--			if
--				a_execution.is_front and then
--				attached a_execution.user as u
--			then
--				create b.make ("node-info", "Node", "Node ...", a_execution.formats.plain_text)
--				a_execution.add_block (b, Void)
--			end
		end

	menu_alter (a_menu_system: CMS_MENU_SYSTEM; a_execution: CMS_EXECUTION)
		local
			lnk: CMS_LOCAL_LINK
			perms: detachable ARRAYED_LIST [READABLE_STRING_8]
		do
			if attached a_execution.service.content_types as lst then
				create perms.make (lst.count)
				across
					lst as c
				loop
					perms.force ("create " + c.item.name)
				end
			end
			create lnk.make ("Add content", "/node/add/")
			lnk.set_permission_arguments (perms)
			a_menu_system.navigation_menu.extend (lnk)
		end

	handle_node_view (cms: CMS_SERVICE; req: WSF_REQUEST; res: WSF_RESPONSE)
		do
			(create {NODE_VIEW_CMS_EXECUTION}.make (req, res, cms)).execute
		end

	handle_node_edit (cms: CMS_SERVICE; req: WSF_REQUEST; res: WSF_RESPONSE)
		do
			(create {NODE_EDIT_CMS_EXECUTION}.make (req, res, cms)).execute
		end

	handle_node_add (cms: CMS_SERVICE; req: WSF_REQUEST; res: WSF_RESPONSE)
		do
			(create {NODE_ADD_CMS_EXECUTION}.make (req, res, cms)).execute
		end

end

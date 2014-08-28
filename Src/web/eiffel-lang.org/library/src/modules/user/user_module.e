note
	description: "Summary description for {USER_MODULE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	USER_MODULE

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
			name := "user"
			version := "1.0"
			description := "Users management"
			package := "core"

			enable
		end

feature {CMS_SERVICE} -- Registration

	service: detachable CMS_SERVICE

	register (a_service: CMS_SERVICE)
		local
			h: CMS_HANDLER
		do
			service := a_service

			a_service.map_uri ("/user/logout", agent handle_logout (a_service, ?, ?))
			a_service.map_uri ("/user/register", agent handle_register (a_service, ?, ?))
			a_service.map_uri ("/user/password", agent handle_request_new_password (a_service, ?, ?))

			create {CMS_HANDLER} h.make (agent handle_user (a_service, ?, ?))
			a_service.router.map (create {WSF_URI_TEMPLATE_MAPPING}.make ("/user/{uid}", h))
			a_service.router.map (create {WSF_URI_MAPPING}.make_trailing_slash_ignored ("/user", h))
			a_service.map_uri_template ("/user/{uid}/edit", agent handle_edit (a_service, ?, ?))
			a_service.map_uri_template ("/user/reset/{uid}/{last-signed}/{extra}", agent handle_reset_password (a_service, ?, ?))

			a_service.add_menu_alter_hook (Current)
			a_service.add_block_hook (Current)
		end

feature -- Hooks

	permissions (a_service: CMS_SERVICE): LIST [CMS_PERMISSION]
		do
			Result := Precursor (a_service)
			Result.extend ("register account")
			Result.extend ("change username")
		end

	block_list: ITERABLE [like {CMS_BLOCK}.name]
		do
			Result := <<"user-info">>
		end

	get_block_view (a_block_id: detachable READABLE_STRING_8; a_execution: CMS_EXECUTION)
		local
			b: CMS_CONTENT_BLOCK
		do
			if
				a_execution.is_front and then
				attached a_execution.user as u
			then
				create b.make ("user-info", "User", "Welcome " + a_execution.html_encoded (u.name), a_execution.formats.plain_text)
				a_execution.add_block (b, Void)
			end
		end

	menu_alter (a_menu_system: CMS_MENU_SYSTEM; a_execution: CMS_EXECUTION)
		local
			lnk: CMS_LOCAL_LINK
			opts: CMS_API_OPTIONS
		do
			if attached a_execution.user as u then
				create lnk.make ("Logout", "/user/logout")
				a_execution.add_to_main_menu (lnk)
			else
				create lnk.make ("Login", "/user")
				create opts.make_from_manifest (<<["query", <<["destination", a_execution.request.path_info]>> ]>>)
				lnk.set_options (opts)
				a_execution.add_to_main_menu (lnk)

				create lnk.make ("Sign up", "/user/register")
				lnk.set_options (opts)
				a_execution.add_to_main_menu (lnk)
			end
			if a_execution.authenticated then
				if attached a_execution.user as u then
					create lnk.make ("My Account (" + u.name + ")", "/user")
				else
					create lnk.make ("My Account", "/user")
				end
				a_menu_system.user_menu.extend (lnk)
				create lnk.make ("Logout", "/user/logout")
				a_menu_system.user_menu.extend (lnk)
			else
				create lnk.make ("Login", "/user")
				a_menu_system.user_menu.extend (lnk)
			end
		end

feature -- Handlers		

	handle_logout (cms: CMS_SERVICE; req: WSF_REQUEST; res: WSF_RESPONSE)
		do
			(create {USER_LOGOUT_CMS_EXECUTION}.make (req, res, cms)).execute
		end

	handle_user (cms: CMS_SERVICE; req: WSF_REQUEST; res: WSF_RESPONSE)
		do
			(create {USER_CMS_EXECUTION}.make (req, res, cms)).execute
		end

	handle_edit (cms: CMS_SERVICE; req: WSF_REQUEST; res: WSF_RESPONSE)
		do
			(create {USER_EDIT_CMS_EXECUTION}.make (req, res, cms)).execute
		end

	handle_register (cms: CMS_SERVICE; req: WSF_REQUEST; res: WSF_RESPONSE)
		do
			(create {USER_REGISTER_CMS_EXECUTION}.make (req, res, cms)).execute
		end

	handle_request_new_password (cms: CMS_SERVICE; req: WSF_REQUEST; res: WSF_RESPONSE)
		do
			(create {USER_NEW_PASSWORD_CMS_EXECUTION}.make (req, res, cms)).execute
		end

	handle_reset_password (cms: CMS_SERVICE; req: WSF_REQUEST; res: WSF_RESPONSE)
		do
			(create {USER_RESET_PASSWORD_CMS_EXECUTION}.make (req, res, cms)).execute
		end


end

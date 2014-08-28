note
	description: "[
				This is the execution of the cms handler request
				It builds the content to get process to render the output
			]"

deferred class
	CMS_EXECUTION

inherit
	CMS_COMMON_API

feature {NONE} -- Initialization

	make (req: WSF_REQUEST; res: WSF_RESPONSE; a_service: like service)
		do
			status_code := {HTTP_STATUS_CODE}.ok
			service := a_service
			request := req
			response := res
			create header.make
			initialize
		end

	initialize
		do
			is_front := service.is_front_page (request)
			has_js := True -- by default it is true, check cookie to see if this is not supported.
			if attached request.cookie ("has_js") as c_has_js then
				has_js := c_has_js.same_string ("0")
			end
			get_theme
			controller := service.session_controller (request)
			create menu_system.make
			create blocks.make (3)

			if attached {like message} session_item (pending_messages_session_item_name) as m then
				message := m
			end
			remove_session_item (pending_messages_session_item_name)
		end

feature -- Access

	service: CMS_SERVICE
	request: WSF_REQUEST

feature {CMS_SESSION_CONTROLER} -- Access: restricted		

	response: WSF_RESPONSE

	controller: CMS_SESSION_CONTROLER

	pending_messages_session_item_name: STRING = "cms.pending_messages"
			-- Session item name to get the pending messages.

feature -- Access: CMS

	site_name: STRING_32
		do
			Result := service.site_name
		end

	front_page_url: READABLE_STRING_8
		do
			Result := url ("/", Void)
		end

feature -- Permission

	frozen has_permissions (lst: detachable ITERABLE [READABLE_STRING_8]): BOOLEAN
		do
			if lst = Void then
				Result := True
			else
				Result := across lst as c all has_permission (c.item) end
			end
		end

	frozen has_permission (s: detachable READABLE_STRING_8): BOOLEAN
			-- Anonymous or Current `user' has permission for `s'
			--| `s' could be "create page",
		local
			u: detachable CMS_USER
		do
			if s = Void then
				Result := True
			else
				if s.same_string ("authenticated") then
					Result := authenticated
				else
					u := user
					if u /= Void and then u.is_admin then
						Result := True
					else
						Result := service.user_has_permission (u, s)
					end
				end
			end
		end

feature -- Status		

	is_front: BOOLEAN

	has_js: BOOLEAN
			-- Client has javascript enabled?
			-- FIXME: not yet implemented

	is_mobile: BOOLEAN
			-- Is Client on mobile device?			
			-- FIXME: not yet implemented

feature -- Theme

	theme: CMS_THEME

	get_theme
		local
			l_info: CMS_THEME_INFORMATION
		do
			if attached service.theme_information_location as fn then
				create l_info.make (fn)
			else
				create l_info.make_default
			end
			if l_info.engine.is_case_insensitive_equal_general ("smarty") then
				create {SMARTY_CMS_THEME} theme.make (service, l_info)
			else
				create {DEFAULT_CMS_THEME} theme.make (service, l_info)
			end
		end

feature -- Access: User

	authenticated: BOOLEAN
		do
			Result := user /= Void
		end

	user: detachable CMS_USER
		do
			if attached {CMS_USER} session_item ("user") as u then
				Result := u
			end
		end

	last_user_access_date: detachable DATE_TIME
		do
			if attached {DATE_TIME} session_item ("last_access") as dt then
				Result := dt
			end
		end

feature -- Element change: user

	login (u: attached like user; req: WSF_REQUEST)
		do
			controller.start_session (req)
			u.set_last_login_date_now
			storage.save_user (u)
			set_user (u)
			init_last_user_access_date
			log ("user", "user %"" + u.name + "%" signed in.", 0, user_local_link (u))
		end

	logout (req: WSF_REQUEST)
		require
			authenticated
		do
			if attached user as u then
				log ("user", "user %"" + u.name + "%" signed out.", 0, user_local_link (u))
			end
			set_user (Void)
			controller.start_session (req)
		end

feature -- Logging

	log	(a_category: READABLE_STRING_8; a_message: READABLE_STRING_8; a_level: INTEGER; a_link: detachable CMS_LINK)
		local
			l_log: CMS_LOG
		do
			create l_log.make (a_category, a_message, a_level, Void)
			if a_link /= Void then
				l_log.set_link (a_link)
			end
			l_log.set_info (request.http_user_agent)
			service.storage.save_log (l_log)
		end

feature -- Menu

	menu_system: CMS_MENU_SYSTEM

	main_menu: CMS_MENU
		do
			Result := menu_system.main_menu
		end

	management_menu: CMS_MENU
		do
			Result := menu_system.management_menu
		end

	navigation_menu: CMS_MENU
		do
			Result := menu_system.navigation_menu
		end

	user_menu: CMS_MENU
		do
			Result := menu_system.user_menu
		end

	primary_tabs: CMS_MENU
		do
			Result := menu_system.primary_tabs
		end

feature -- Menu: change

	add_to_main_menu (lnk: CMS_LINK)
		do
			if attached {CMS_LOCAL_LINK} lnk as l_local then
				l_local.get_is_active (request)
			end
			main_menu.extend (lnk)
		end

	add_to_menu (lnk: CMS_LINK; m: CMS_MENU)
		do
			if attached {CMS_LOCAL_LINK} lnk as l_local then
				l_local.get_is_active (request)
			end
			m.extend (lnk)
		end

feature -- Message

	add_message (a_msg: READABLE_STRING_8; a_category: detachable READABLE_STRING_8)
		local
			m: like message
		do
			m := message
			if m = Void then
				create m.make (a_msg.count + 9)
				message := m
			end
			if a_category /= Void then
				m.append ("<li class=%""+ a_category +"%">")
			else
				m.append ("<li>")
			end
			m.append (a_msg + "</li>")
		end

	add_notice_message (a_msg: READABLE_STRING_8)
		do
			add_message (a_msg, "notice")
		end

	add_warning_message (a_msg: READABLE_STRING_8)
		do
			add_message (a_msg, "warning")
		end

	add_error_message (a_msg: READABLE_STRING_8)
		do
			add_message (a_msg, "error")
		end

	add_success_message (a_msg: READABLE_STRING_8)
		do
			add_message (a_msg, "success")
		end

	report_form_errors (fd: WSF_FORM_DATA)
		require
			has_error: not fd.is_valid
		do
			if attached fd.errors as errs then
				across
					errs as err
				loop
					if attached err.item as e then
						if attached e.field as l_field then
							if attached e.message as e_msg then
								add_error_message (e_msg) --"Field [" + l_field.name + "] is invalid. " + e_msg)
							else
								add_error_message ("Field [" + l_field.name + "] is invalid.")
							end
						elseif attached e.message as e_msg then
							add_error_message (e_msg)
						end
					end
				end
			end
		end

	message: detachable STRING_8

feature -- Blocks	

	formats: CMS_FORMATS
		once
			create Result
		end

	blocks: ARRAYED_LIST [TUPLE [block: CMS_BLOCK; name: READABLE_STRING_8; region: READABLE_STRING_8]]

	add_block (b: CMS_BLOCK; a_region: detachable READABLE_STRING_8)
		do
			if a_region /= Void then
				blocks.extend ([b, b.name, a_region])
			elseif attached block_region (b) as l_region then
				blocks.extend ([b, b.name, l_region])
			end
		end

	block_region (b: CMS_BLOCK): detachable READABLE_STRING_8
		local
			l_name: READABLE_STRING_8
		do
			l_name := b.name
			if l_name.starts_with ("footer") then
				Result := "footer"
			elseif l_name.starts_with ("management") then
				Result := "first_sidebar"
			elseif l_name.starts_with ("navigation") then
				Result := "first_sidebar"
			elseif l_name.starts_with ("user") then
				Result := "first_sidebar"
			else
				Result := "first_sidebar"
			end
			-- FIXME: let the user choose ...
		end

	get_blocks
		local
			b: CMS_CONTENT_BLOCK
			s: STRING_8
			m: CMS_MENU
		do
			m := management_menu
			if not m.is_empty then
				add_block (create {CMS_MENU_BLOCK}.make (m), Void)
			end

			m := navigation_menu
			if not m.is_empty then
				add_block (create {CMS_MENU_BLOCK}.make (m), Void)
			end

			m := user_menu
			if not m.is_empty then
				add_block (create {CMS_MENU_BLOCK}.make (m), Void)
			end

--			create s.make_empty
--			s.append ("This site demonstrates a first implementation of CMS using EWF.%N")
--			create b.make ("about", "About", s, formats.plain_text)
--			add_block (b, "second_sidebar")

			create s.make_empty
			s.append ("Made with <a href=%"http://www.eiffel.com/%">EWF</a>")
			create b.make ("made_with", Void, s, formats.full_html)
			add_block (b, "footer")

			service.hook_block_view (Current)
		end

feature -- Access

	status_code: INTEGER

	header: WSF_HEADER

	title: detachable READABLE_STRING_32
			-- HTML>head>title value

	page_title: detachable READABLE_STRING_32
			-- Page title

	additional_page_head_lines: detachable LIST [READABLE_STRING_8]
			-- HTML>head>...extra lines

	main_content: detachable STRING_8

	redirection: detachable READABLE_STRING_8

feature -- Generation

	prepare_menu_system (a_menu_system: CMS_MENU_SYSTEM)
		do
			across
				a_menu_system as c
			loop
				prepare_links (c.item)
			end
		end

	prepare_links (a_menu: CMS_LINK_COMPOSITE)
		local
			to_remove: ARRAYED_LIST [CMS_LINK]
		do
			create to_remove.make (0)
			across
				a_menu as c
			loop
				if attached {CMS_LOCAL_LINK} c.item as lm then
					if attached lm.permission_arguments as perms and then not has_permissions (perms) then
						to_remove.force (lm)
					else
						-- if lm.permission_arguments is Void , this is permitted
						lm.get_is_active (request)
						if attached {CMS_LINK_COMPOSITE} lm as comp then
							prepare_links (comp)
						end
					end
				elseif attached {CMS_LINK_COMPOSITE} c.item as comp then
					prepare_links (comp)
				end
			end
			across
				to_remove as c
			loop
				a_menu.remove (c.item)
			end
		end

	prepare (page: CMS_HTML_PAGE)
		local
			s: STRING_8
		do
			page.register_variable (is_front, "is_front")
			page.register_variable (request.absolute_script_url (""), "site_url")

			if attached additional_page_head_lines as l_head_lines then
				across
					l_head_lines as hl
				loop
					page.head_lines.force (hl.item)
				end
			end

			add_to_main_menu (create {CMS_LOCAL_LINK}.make ("Home", "/"))

			service.call_menu_alter_hooks (menu_system, Current)
			prepare_menu_system (menu_system)

			get_blocks

			if attached title as l_title then
				page.set_title (l_title)
			else
				page.set_title ("CMS::" + request.path_info)
			end

			page.add_to_header_region (top_header_region)
			page.add_to_header_region (header_region)
			if attached message as m and then not m.is_empty then
				page.add_to_content_region ("<div id=%"message%">" + m + "</div>")
			end
			page.add_to_content_region ("<a id=%"main-content%"></a>%N")
			if attached page_title as l_page_title then
				page.add_to_content_region ("<h1 id=%"page-title%" class=%"title%">"+ l_page_title +"</h1>%N")
			end
			if attached primary_tabs as tabs_menu and then not tabs_menu.is_empty then
				page.add_to_content_region (theme.menu_html (tabs_menu, True))
			end
			page.add_to_content_region (content_region)

			-- blocks
			across
				blocks as c
			loop
				if attached c.item as b_info then
					create s.make_from_string ("<div class=%"block%" id=%"" + b_info.name + "%">")
					if attached b_info.block.title as l_title then
						s.append ("<div class=%"title%">" + html_encoded (l_title) + "</div>")
					end
					s.append ("<div class=%"inside%">")
					s.append (b_info.block.to_html (theme))
					s.append ("</div>")
					s.append ("</div>")
					page.add_to_region (s, b_info.region)
				end
			end
		end

	logo_location: STRING
		do
			Result := url ("/theme/logo.png", Void)
		end

	top_header_region: STRING_8
		do
			Result := "<a href=%""+ url ("/", Void) +"%"><img id=%"logo%" src=%"" + logo_location + "%"/></a><div id=%"title%">" + html_encoded (site_name) + "</div>"
			Result.append ("<div id=%"menu-bar%">")
			Result.append (theme.menu_html (main_menu, True))
			Result.append ("</div>")
		end

	header_region: STRING_8
		do
			Result := ""
		end

	content_region: STRING_8
		do
			if attached main_content as l_content then
				Result := l_content
			else
				Result := ""
				debug
					Result := "No Content"
				end
			end
		end

feature -- Head customization

	add_additional_head_line (s: READABLE_STRING_8; a_allow_duplication: BOOLEAN)
		local
			lst: like additional_page_head_lines
		do
			lst := additional_page_head_lines
			if lst = Void then
				create {ARRAYED_LIST [like additional_page_head_lines.item]} lst.make (1)
				additional_page_head_lines := lst
			end
			if a_allow_duplication or else across lst as c all not c.item.same_string (s) end then
				lst.extend (s)
			end
		end

	add_style (a_href: STRING; a_media: detachable STRING)
		local
			s: STRING_8
		do
			s := "<link rel=%"stylesheet%" href=%""+ a_href + "%" type=%"text/css%""
			if a_media /= Void then
				s.append (" media=%""+ a_media + "%"")
			end
			s.append ("/>")
			add_additional_head_line (s, False)
		end

	add_javascript_url (a_src: STRING)
		local
			s: STRING_8
		do
			s := "<script type=%"text/javascript%" src=%"" + a_src + "%"></script>"
			add_additional_head_line (s, False)
		end

	add_javascript_content (a_script: STRING)
		local
			s: STRING_8
		do
			s := "<script type=%"text/javascript%">%N" + a_script + "%N</script>"
			add_additional_head_line (s, True)
		end

feature -- Element change				

	set_title (t: like title)
		do
			title := t
			set_page_title (t)
		end

	set_page_title (t: like page_title)
		do
			page_title := t
		end

	set_main_content (s: like main_content)
		do
			main_content := s
		end

	set_redirection (a_url: like redirection)
		do
			if a_url /= Void and then a_url.same_string (request.path_info) and request.is_get_request_method then
				redirection := Void
			else
				redirection := a_url
			end
		end

feature -- Execution

	execute
		do
			begin
			process
			terminate
		end

feature {NONE} -- Execution		

	begin
		do
		end

	process
		deferred
		end

	frozen terminate
		local
			cms_page: CMS_HTML_PAGE
			page: CMS_HTML_PAGE_RESPONSE
		do
			if is_front then
				create cms_page.make_typed ("front")
			else
				create cms_page.make
			end
			prepare (cms_page)

			create page.make (theme.page_html (cms_page))
			if attached redirection as l_redirection then
				if attached message as m then
					set_session_item ("cms.pending_messages", m)
				end
				page.set_status_code ({HTTP_STATUS_CODE}.found)
				page.header.put_location (l_redirection)
			else
				page.set_status_code (status_code)
			end

			controller.session_commit (page, Current)
			response.send (page)
			on_terminated
		end

	on_terminated
		do

		end

feature {NONE} -- Implementation

	set_user (u: like user)
		do
			set_session_item ("user", u)
		end

	init_last_user_access_date
		do
			set_session_item ("last_access", (create {DATE_TIME}.make_now_utc))
		end

feature -- Access: Session		

	session_item (k: READABLE_STRING_GENERAL): detachable ANY
		do
			Result := controller.session.item (k)
		end

	set_session_item (k: READABLE_STRING_GENERAL; v: detachable ANY)
		do
			controller.session.remember (v, k)
		end

	remove_session_item (k: READABLE_STRING_GENERAL)
		do
			controller.session.forget (k)
		end

feature -- Storage

	storage: CMS_STORAGE
		do
			Result := service.storage
		end

feature -- Helper: output

	user_local_link (u: CMS_USER): CMS_LINK
		do
			create {CMS_LOCAL_LINK} Result.make (u.name, user_url (u))
		end

	node_local_link (n: CMS_NODE): CMS_LINK
		do
			create {CMS_LOCAL_LINK} Result.make (n.title, node_url (n))
		end

	truncated_string (s: READABLE_STRING_8; nb: INTEGER; a_ellipsis: detachable READABLE_STRING_8): STRING_8
			-- Truncated string `s' to `nb' character
		require
			a_ellipsis /= Void implies a_ellipsis.count < nb
		local
			f: CMS_NO_HTML_FILTER
		do
			if s.count <= nb then
				Result := s.string
			else
				create f
				create Result.make_from_string (s)
				f.filter (Result)
				if Result.count > nb then
					if a_ellipsis /= Void and then not a_ellipsis.is_empty then
						Result.keep_head (nb - a_ellipsis.count)
						Result.append (a_ellipsis)
					else
						Result.keep_head (nb - 3)
						Result.append ("...")
					end
				end
			end
		end

feature -- Helper: request

	non_empty_string_path_parameter (a_name: READABLE_STRING_GENERAL): detachable STRING
		do
			if
				attached {WSF_STRING} request.path_parameter (a_name) as p and then
				not p.is_empty
			then
				Result := p.value
			end
		end

invariant

note
	copyright: "2011-2014, Jocelyn Fiat, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end

note
	description: "[
			Generic CMS Response.
			It builds the content to get process to render the output.
		]"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CMS_RESPONSE

inherit
	CMS_URL_UTILITIES

	REFACTORING_HELPER

feature {NONE} -- Initialization

	make (req: WSF_REQUEST; res: WSF_RESPONSE; a_api: like api)
		do
			status_code := {HTTP_STATUS_CODE}.ok
			api := a_api
			request := req
			response := res
			create header.make
			create values.make (3)
			initialize
		end

	initialize
		do
			initialize_site_url
			get_theme
			create menu_system.make
			initialize_block_region_settings
			create hook_subscribers.make (0)
			register_hooks
		end

	initialize_site_url
				-- Initialize site and base url.
		local
			l_url: detachable STRING_8
			i,j: INTEGER
		do
				--| WARNING: do not use `absolute_url' and `url', since it relies on site_url and base_url.
			if attached setup.site_url as l_site_url and then not l_site_url.is_empty then
				create l_url.make_from_string (l_site_url)
			else
				l_url := request.absolute_script_url ("/")
			end
			check is_not_empty: not l_url.is_empty end
			if l_url [l_url.count] /= '/' then
				l_url.append_character ('/')
			end
			site_url := l_url
			i := l_url.substring_index ("://", 1)
			if i > 0 then
				j := l_url.index_of ('/', i + 3)
				if j > 0 then
					base_url := l_url.substring (j, l_url.count)
				end
			end
		ensure
			site_url_set: site_url /= Void
			site_url_ends_with_slash: site_url.ends_with_general ("/")
		end

	register_hooks
		local
			l_module: CMS_MODULE
			l_enabled_modules: CMS_MODULE_COLLECTION
		do
			l_enabled_modules := setup.enabled_modules
			across
				l_enabled_modules as ic
			loop
				l_module := ic.item
				if attached {CMS_HOOK_AUTO_REGISTER} l_module as l_auto then
					l_auto.auto_subscribe_to_hooks (Current)
				end
				l_module.register_hooks (Current)
			end
		end

feature -- Access

	request: WSF_REQUEST

	response: WSF_RESPONSE

	status_code: INTEGER

	header: WSF_HEADER

	title: detachable READABLE_STRING_32

	page_title: detachable READABLE_STRING_32
			-- Page title

	main_content: detachable STRING_8

	additional_page_head_lines: detachable LIST [READABLE_STRING_8]
			-- HTML>head>...extra lines

	redirection: detachable READABLE_STRING_8
			-- Location for eventual redirection.

	location: STRING_8
			-- Associated cms local location.
		do
			create Result.make_from_string (request.percent_encoded_path_info)
			if not Result.is_empty and then Result[1] = '/' then
				Result.remove_head (1)
			end
		end

feature -- Internationalization (i18n)

	translation (a_text: READABLE_STRING_GENERAL; opts: detachable CMS_API_OPTIONS): STRING_32
			-- Translated text `a_text' according to expected context (lang, ...)
			-- and adapt according to options eventually set by `opts'.
		do
			to_implement ("Implement i18n support [2015-may]")
			Result := a_text.as_string_32
		end

	formatted_string (a_text: READABLE_STRING_GENERAL; args: TUPLE): STRING_32
			-- Format `a_text' using arguments `args'.
			--| ex: formatted_string ("hello $1, see page $title.", ["bob", "contact"] -> "hello bob, see page contact"
		local
			l_formatter: CMS_STRING_FORMATTER
		do
			create l_formatter
			Result := l_formatter.formatted_string (a_text, args)
		end

feature -- API

	api: CMS_API
			-- Current CMS API.

	setup: CMS_SETUP
			-- Current setup
		do
			Result := api.setup
		end

	formats: CMS_FORMATS
			-- Available content formats.
		do
			Result := api.formats
		end

feature -- Module

	module_resource_path (a_module: CMS_MODULE; a_resource: PATH): detachable PATH
			-- Resource path of `a_resource' for module `a_module', if resource exists.
		local
			rp: PATH
			ut: FILE_UTILITIES
		do
			rp := module_assets_theme_location (a_module)
			Result := rp.extended_path (a_resource)
			if not ut.file_path_exists (Result) then
				rp := module_assets_location (a_module)
				Result := rp.extended_path (a_resource)
				if not ut.file_path_exists (Result) then
					Result := Void
				end
			end
		end

	module_assets_location (a_module: CMS_MODULE): PATH
			-- Location for the assets associated with `a_module'.
		do
			Result := setup.environment.path.extended ("modules").extended (a_module.name)
		end

	module_assets_theme_location (a_module: CMS_MODULE): PATH
			-- Location for the assets associated with `a_module'.
		do
			Result := setup.theme_location.extended ("modules").extended (a_module.name)
		end

feature -- URL utilities

	is_front: BOOLEAN
			-- Is current response related to "front" page?
		local
			l_path_info: READABLE_STRING_8
		do
			l_path_info := request.percent_encoded_path_info
			if attached setup.front_page_path as l_front_page_path then
				Result := l_front_page_path.same_string (l_path_info)
			else
				if attached base_url as l_base_url then
					Result := l_path_info.same_string (l_base_url)
				else
					Result := l_path_info.is_empty or else l_path_info.same_string ("/")
				end
			end
		end

	site_url: IMMUTABLE_STRING_8
			-- Absolute site url.

	base_url: detachable IMMUTABLE_STRING_8
			-- Base url if any.
			--| Usually it is Void, but it could be
			--|  /project/demo/

feature -- Access: CMS

	site_name: STRING_32
		do
			Result := setup.site_name
		end

	front_page_url: READABLE_STRING_8
		do
			Result := absolute_url ("/", Void)
		end

	values: CMS_VALUE_TABLE
			-- Associated values indexed by string name.


feature -- User access

	user: detachable CMS_USER
		do
			Result := current_user (request)
		end

feature -- Permission

	has_permission (a_permission: READABLE_STRING_GENERAL): BOOLEAN
			-- Does current user has permission `a_permission' ?
		do
			Result := user_has_permission (current_user (request), a_permission)
		end

	has_permissions (a_permission_list: ITERABLE [READABLE_STRING_GENERAL]): BOOLEAN
			-- Does current user has any of the permissions `a_permission_list' ?
		do
			Result := user_has_permissions (current_user (request), a_permission_list)
		end

	user_has_permission (a_user: detachable CMS_USER; a_permission: READABLE_STRING_GENERAL): BOOLEAN
			-- Does `a_user' has permission `a_permission' ?
		do
			Result := api.user_has_permission (a_user, a_permission)
		end

	user_has_permissions (a_user: detachable CMS_USER; a_permission_list: ITERABLE [READABLE_STRING_GENERAL]): BOOLEAN
			-- Does `a_user' has any of the permissions `a_permission_list' ?
		do
			across
				a_permission_list as ic
			until
				Result
			loop
				Result := user_has_permission (a_user, ic.item)
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

	set_value (v: detachable ANY; k: READABLE_STRING_GENERAL)
			-- Set value `v' associated with name `k'.
		do
			values.force (v, k)
		end

	unset_value (k: READABLE_STRING_GENERAL)
			-- Unset value associated with name `k'.
		do
			values.remove (k)
		end

	set_redirection (a_location: READABLE_STRING_8)
			-- Set `redirection' to `a_location'.
		do
			redirection := a_location
		end

feature -- Logging

	log	(a_category: READABLE_STRING_8; a_message: READABLE_STRING_8; a_level: INTEGER; a_link: detachable CMS_LINK)
		local
--			l_log: CMS_LOG
		do
			debug
				to_implement ("Add implementation")
			end
--			create l_log.make (a_category, a_message, a_level, Void)
--			if a_link /= Void then
--				l_log.set_link (a_link)
--			end
--			l_log.set_info (request.http_user_agent)
--			service.storage.save_log (l_log)
		end

feature -- Menu

	menu_system: CMS_MENU_SYSTEM

	main_menu: CMS_MENU
		obsolete
			"Use `primary_menu' [Nov/2014]"
		do
			Result := primary_menu
		end

	primary_menu: CMS_MENU
		do
			Result := menu_system.primary_menu
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

feature -- Blocks initialization

	initialize_block_region_settings
		local
			l_table: like block_region_settings
		do
			debug ("refactor_fixme")
				fixme ("CHECK:Can we use the same structure as in theme.info?")
				fixme ("let the user choose ...")
			end
			create regions.make_caseless (5)

			create l_table.make_caseless (10)
			l_table["top"] := "top"
			l_table["header"] := "header"
			l_table["highlighted"] := "highlighted"
			l_table["help"] := "help"
			l_table["content"] := "content"
			l_table["footer"] := "footer"
			l_table["management"] := "first_sidebar"
			l_table["navigation"] := "first_sidebar"
			l_table["user"] := "first_sidebar"
			l_table["bottom"] := "page_bottom"
			block_region_settings := l_table
		end

feature -- Blocks regions

	regions: STRING_TABLE [CMS_BLOCK_REGION]
			-- Layout regions, that contains blocks.

	block_region_settings: STRING_TABLE [STRING]

	block_region (b: CMS_BLOCK; a_default_region: detachable READABLE_STRING_8): CMS_BLOCK_REGION
			-- Region associated with block `b', or else `a_default_region' if provided.
		local
			l_region_name: detachable READABLE_STRING_8
		do
			l_region_name := block_region_settings.item (b.name)
			if l_region_name = Void then
				if a_default_region /= Void then
					l_region_name := a_default_region
				else
						-- Default .. put it in same named region
						-- Maybe a bad idea

					l_region_name := b.name.as_lower
				end
			end
			if attached regions.item (l_region_name) as res then
				Result := res
			else
				create Result.make (l_region_name)
				regions.force (Result, l_region_name)
			end
		end

feature -- Blocks 		

	add_block (b: CMS_BLOCK; a_default_region: detachable READABLE_STRING_8)
			-- Add block `b' to associated region or `a_default_region' if provided.
		local
			l_region: detachable like block_region
		do
			l_region := block_region (b, a_default_region)
			l_region.extend (b)
		end

	get_blocks
		do
			debug ("refactor_fixme")
				fixme ("find a way to have this in configuration or database, and allow different order")
			end
			add_block (top_header_block, "top")
			add_block (header_block, "header")
			if attached message_block as m then
				add_block (m, "content")
			end
			if attached primary_tabs_block as m then
				add_block (m, "content")
			end
			add_block (content_block, "content")

			if attached management_menu_block as l_block then
				add_block (l_block, "first_sidebar")
			end
			if attached navigation_menu_block as l_block then
				add_block (l_block, "first_sidebar")
			end
			if attached user_menu_block as l_block then
				add_block (l_block, "first_sidebar")
			end

			invoke_block
			debug ("cms")
				add_block (create {CMS_CONTENT_BLOCK}.make ("made_with", Void, "Made with <a href=%"http://www.eiffel.com/%">EWF</a>", Void), "footer")
			end
		end

	primary_menu_block: detachable CMS_MENU_BLOCK
		do
			if attached primary_menu as m and then not m.is_empty then
				create Result.make (m)
			end
		end

	management_menu_block: detachable CMS_MENU_BLOCK
		do
			if attached management_menu as m and then not m.is_empty then
				create Result.make (m)
			end
		end

	navigation_menu_block: detachable CMS_MENU_BLOCK
		do
			if attached navigation_menu as m and then not m.is_empty then
				create Result.make (m)
			end
		end

	user_menu_block: detachable CMS_MENU_BLOCK
		do
			if attached user_menu as m and then not m.is_empty then
				create Result.make (m)
			end
		end

	primary_tabs_block: detachable CMS_MENU_BLOCK
		do
			if attached primary_tabs as m and then not m.is_empty then
				create Result.make (m)
				Result.is_horizontal := True
				Result.set_is_raw (True)
				Result.add_css_class ("tabs")
			end
		end

	top_header_block: CMS_CONTENT_BLOCK
		local
			s: STRING
		do
			create s.make_empty
			create Result.make ("page_top", Void, s, Void)
			Result.set_is_raw (True)
		end

	header_block: CMS_CONTENT_BLOCK
		local
			s: STRING
			l_hb: STRING
		do
			create s.make_from_string (theme.menu_html (primary_menu, True, Void))
			create l_hb.make_empty
			create Result.make ("header", Void, l_hb, Void)
			Result.set_is_raw (True)
		end

	horizontal_primary_menu_html: STRING
		do
			create Result.make_empty
			Result.append ("<div id=%"menu-bar%">")
			Result.append (theme.menu_html (primary_menu, True, Void))
			Result.append ("</div>")
		end

	horizontal_primary_tabs_html: STRING
		do
			create Result.make_empty
			Result.append ("<div id=%"tabs-bar%">")
			Result.append (theme.menu_html (primary_tabs, True, Void))
			Result.append ("</div>")
		end

	message_html: detachable STRING
		do
			if attached message as m and then not m.is_empty then
				Result := "<div id=%"message%">" + m + "</div>"
			end
		end

	message_block: detachable CMS_CONTENT_BLOCK
		do
			if attached message as m and then not m.is_empty then
				create Result.make ("message", Void, "<div id=%"message%">" + m + "</div>", Void)
				Result.set_is_raw (True)
			end
		end

	content_block: CMS_CONTENT_BLOCK
		local
			s: STRING
		do
			if attached main_content as l_content then
				s := l_content
			else
				s := ""
				debug
					s := "No Content"
				end
			end
			create Result.make ("content", Void, s, Void)
			Result.set_is_raw (True)
		end

feature -- Hooks

	hook_subscribers: HASH_TABLE [LIST [CMS_HOOK], TYPE [CMS_HOOK]]
			-- Hook indexed by hook identifier.

	subscribe_to_hook (h: CMS_HOOK; a_hook_type: TYPE [CMS_HOOK])
			-- Subscribe `h' to hooks identified by `a_hook_type'.
		local
			lst: detachable LIST [CMS_HOOK]
		do
			lst := hook_subscribers.item (a_hook_type)
			if lst = Void then
				create {ARRAYED_LIST [CMS_HOOK]} lst.make (1)
				hook_subscribers.force (lst, a_hook_type)
			end
			if not lst.has (h) then
				lst.force (h)
			end
		end

feature -- Hook: value alter

	subscribe_to_value_table_alter_hook (h: CMS_HOOK_VALUE_TABLE_ALTER)
			-- Add `h' as subscriber of value table alter hooks CMS_HOOK_VALUE_TABLE_ALTER.		
		do
			subscribe_to_hook (h, {CMS_HOOK_VALUE_TABLE_ALTER})
		end

	invoke_value_table_alter (a_table: CMS_VALUE_TABLE)
			-- Invoke value table alter hook for table `a_table'.		
		do
			if attached hook_subscribers.item ({CMS_HOOK_VALUE_TABLE_ALTER}) as lst then
				across
					lst as c
				loop
					if attached {CMS_HOOK_VALUE_TABLE_ALTER} c.item as h then
						h.value_table_alter (a_table, Current)
					end
				end
			end
		end

feature -- Hook: menu_system_alter

	subscribe_to_menu_system_alter_hook (h: CMS_HOOK_MENU_SYSTEM_ALTER)
			-- Add `h' as subscriber of menu system alter hooks CMS_HOOK_MENU_SYSTEM_ALTER.	
		do
			subscribe_to_hook (h, {CMS_HOOK_MENU_SYSTEM_ALTER})
		end

	invoke_menu_system_alter (a_menu_system: CMS_MENU_SYSTEM)
			-- Invoke menu system alter hook for menu `a_menu_system'.	
		do
			if attached hook_subscribers.item ({CMS_HOOK_MENU_SYSTEM_ALTER}) as lst then
				across
					lst as c
				loop
					if attached {CMS_HOOK_MENU_SYSTEM_ALTER} c.item as h then
						h.menu_system_alter (a_menu_system, Current)
					end
				end
			end
		end

feature -- Hook: menu_alter

	subscribe_to_menu_alter_hook (h: CMS_HOOK_MENU_ALTER)
			-- Add `h' as subscriber of menu alter hooks CMS_HOOK_MENU_ALTER.
		do
			subscribe_to_hook (h, {CMS_HOOK_MENU_ALTER})
		end

	invoke_menu_alter (a_menu: CMS_MENU)
			-- Invoke menu alter hook for menu `a_menu'.
		do
			if attached hook_subscribers.item ({CMS_HOOK_MENU_ALTER}) as lst then
				across
					lst as c
				loop
					if attached {CMS_HOOK_MENU_ALTER} c.item as h then
						h.menu_alter (a_menu, Current)
					end
				end
			end
		end

feature -- Hook: form_alter

	subscribe_to_form_alter_hook (h: CMS_HOOK_FORM_ALTER)
			-- Add `h' as subscriber of form alter hooks CMS_HOOK_FORM_ALTER.
		do
			subscribe_to_hook (h, {CMS_HOOK_MENU_ALTER})
		end

	invoke_form_alter (a_form: CMS_FORM; a_form_data: detachable WSF_FORM_DATA)
			-- Invoke form alter hook for form `a_form' and associated data `a_form_data'
		do
			if attached hook_subscribers.item ({CMS_HOOK_FORM_ALTER}) as lst then
				across
					lst as c
				loop
					if attached {CMS_HOOK_FORM_ALTER} c.item as h then
						h.form_alter (a_form, a_form_data, Current)
					end
				end
			end
		end

feature -- Hook: block		

	subscribe_to_block_hook (h: CMS_HOOK_BLOCK)
			-- Add `h' as subscriber of hooks CMS_HOOK_BLOCK.
		do
			subscribe_to_hook (h, {CMS_HOOK_BLOCK})
		end

	invoke_block
			-- Invoke block hook in order to get block from modules.
		do
			if attached hook_subscribers.item ({CMS_HOOK_BLOCK}) as lst then
				across
					lst as c
				loop
					if attached {CMS_HOOK_BLOCK} c.item as h then
						across
							h.block_list as blst
						loop
							h.get_block_view (blst.item, Current)
						end
					end
				end
			end
		end

feature -- Menu: change

	add_to_main_menu (lnk: CMS_LINK)
		obsolete
			"use add_to_primary_menu [Nov/2014]"
		do
			add_to_primary_menu (lnk)
		end

	add_to_primary_menu (lnk: CMS_LINK)
		do
			add_to_menu (lnk, primary_menu)
		end

	add_to_primary_tabs (lnk: CMS_LINK)
		do
			add_to_menu (lnk, primary_tabs)
		end

	add_to_menu (lnk: CMS_LINK; m: CMS_MENU)
		do
--			if attached {CMS_LOCAL_LINK} lnk as l_local then
--				l_local.get_is_active (request)
--			end
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

feature -- Theme

	theme: CMS_THEME
			-- Current theme

	get_theme
		local
			l_info: CMS_THEME_INFORMATION
		do
			if attached setup.theme_information_location as fn then
				create l_info.make (fn)
			else
				create l_info.make_default
			end
			if l_info.engine.is_case_insensitive_equal_general ("smarty") then
				create {SMARTY_CMS_THEME} theme.make (setup, l_info, site_url)
			else
				create {MISSING_CMS_THEME} theme.make (setup, l_info, site_url)
				status_code := {HTTP_STATUS_CODE}.service_unavailable
				to_implement ("Check how to add the Retry-after, http://tools.ietf.org/html/rfc7231#section-6.6.4 and http://tools.ietf.org/html/rfc7231#section-7.1.3")
			end
		end

feature -- Element Change

	set_status_code (a_status: INTEGER)
			-- Set `status_code' with `a_status'.
		note
			EIS: "src=eiffel:?class=HTTP_STATUS_CODE"
		do
			to_implement ("Feature to test if a_status is a valid status code!!!.")
			status_code := a_status
		ensure
			status_code_set: status_code = a_status
		end

feature -- Generation

	prepare (page: CMS_HTML_PAGE)
		local
			lnk: CMS_LINK
		do
				-- Menu
			create {CMS_LOCAL_LINK} lnk.make ("Home", "")
			lnk.set_weight (-10)
			add_to_primary_menu (lnk)
			invoke_menu_system_alter (menu_system)
			prepare_menu_system (menu_system)

				-- Blocks
			get_blocks
			across
				regions as reg_ic
			loop
				across
					reg_ic.item.blocks as ic
				loop
					if attached {CMS_MENU_BLOCK} ic.item as l_menu_block then
						recursive_get_active (l_menu_block.menu, request)
					end
				end
			end

				-- Sort items
			across menu_system as ic loop
				ic.item.sort
			end

				-- Values
			common_prepare (page)
			custom_prepare (page)

				-- Cms values
			invoke_value_table_alter (values)

				-- Predefined values
			page.register_variable (page, "page") -- DO NOT REMOVE

				-- Values Associated with current Execution object.
			across
				values as ic
			loop
				page.register_variable (ic.item, ic.key)
			end

				-- Block rendering
			across
				regions as reg_ic
			loop
				across
					reg_ic.item.blocks as ic
				loop
--					if attached {CMS_SMARTY_CONTENT_BLOCK} ic.item as l_tpl_block then
--						across
--							page.variables as var_ic
--						loop
--							l_tpl_block.set_value (var_ic.item, var_ic.key)
--						end
--					end
					page.add_to_region (theme.block_html (ic.item), reg_ic.item.name)
				end
			end

				-- Additional lines in <head ../>
			if attached additional_page_head_lines as l_head_lines then
				across
					l_head_lines as hl
				loop
					page.head_lines.force (hl.item)
				end
			end
		end

	common_prepare (page: CMS_HTML_PAGE)
			-- Common preparation for page `page'.
		do
			debug ("refactor_fixme")
				fixme ("Fix generation common")
			end

				-- Information
			page.set_title (title)
			debug ("cms")
				if title = Void then
					page.set_title ("CMS::" + request.path_info) --| FIXME: probably, should be removed and handled by theme.
				end
			end

				-- Variables
			page.register_variable (absolute_url ("", Void), "site_url")
			page.register_variable (absolute_url ("", Void), "host") -- Same as `site_url'.
			page.register_variable (request.is_https, "is_https")
			if attached current_user_name (request) as l_user then
				page.register_variable (l_user, "user")
			end
			page.register_variable (title, "site_title")
			page.set_is_front (is_front)
			page.set_is_https (request.is_https)

				-- Variables/Misc

-- FIXME: logo .. could be a settings of theme, managed by admin front-end/database.
--			if attached logo_location as l_logo then
--				page.register_variable (l_logo, "logo")
--			end

				-- Menu...
			page.register_variable (horizontal_primary_menu_html, "primary_nav")
			page.register_variable (horizontal_primary_tabs_html, "primary_tabs")

				-- Page related
			if attached page_title as l_page_title then
				page.register_variable (l_page_title, "page_title")
			end
		end

	custom_prepare (page: CMS_HTML_PAGE)
			-- Common preparation for page `page' that can be redefined by descendants.
		do
		end

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
--					if attached lm.permission_arguments as perms and then not has_permissions (perms) then
--						to_remove.force (lm)
--					else
						-- if lm.permission_arguments is Void , this is permitted
						get_local_link_active_status (lm)
						if attached {CMS_LINK_COMPOSITE} lm as comp then
							prepare_links (comp)
						end
--					end
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

	recursive_get_active (a_comp: CMS_LINK_COMPOSITE; req: WSF_REQUEST)
			-- Update the active status recursively on `a_comp'.
		local
			ln: CMS_LINK
			l_comp_link: detachable CMS_LOCAL_LINK
		do
			if attached {CMS_LOCAL_LINK} a_comp as lnk then
				l_comp_link := lnk
			end
			if attached a_comp.items as l_items then
				across
					l_items as ic
				loop
					ln := ic.item
					if attached {CMS_LOCAL_LINK} ln as l_local then
						get_local_link_active_status (l_local)
					end
					if (ln.is_expanded or ln.is_collapsed) and then attached {CMS_LINK_COMPOSITE} ln as l_comp then
						recursive_get_active (l_comp, req)
					end
					if l_comp_link /= Void then
						if ln.is_expanded or (not ln.is_expandable and ln.is_active) then
							l_comp_link.set_expanded (True)
						end
					end
				end
			end
			if l_comp_link /= Void and then l_comp_link.is_active then
				l_comp_link.set_expanded (True)
			end
		end

	get_local_link_active_status (a_lnk: CMS_LOCAL_LINK)
			-- Get `a_lnk.is_active' value according to `request' data.
		local
			qs: STRING
			l_is_active: BOOLEAN
		do
			create qs.make_from_string (request.percent_encoded_path_info)
			if qs.starts_with ("/") then
				qs.remove_head (1)
			end
			l_is_active := qs.same_string (a_lnk.location)
			if not l_is_active then
				if attached request.query_string as l_query_string and then not l_query_string.is_empty then
					qs.append_character ('?')
					qs.append (l_query_string)
				end
				l_is_active := qs.same_string (a_lnk.location)
			end
			a_lnk.set_is_active (l_is_active)
		end

feature -- Custom Variables

	variables: detachable STRING_TABLE[ANY]
			-- Custom variables to feed the templates.

feature -- Element change: Add custom variables.

	add_variable (a_element: ANY; a_key:READABLE_STRING_32)
		local
			l_variables: like variables
		do
			l_variables := variables
			if l_variables = Void then
				create l_variables.make (5)
				variables := l_variables
			end
			l_variables.force (a_element, a_key)
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
			utf: UTF_CONVERTER
			h: HTTP_HEADER
		do
			if attached {READABLE_STRING_GENERAL} values.item ("optional_content_type") as l_type then
				create cms_page.make_typed (utf.utf_32_string_to_utf_8_string_8 (l_type))
			else
				create cms_page.make
			end
			prepare (cms_page)
			create page.make (theme.page_html (cms_page))
			page.set_status_code (status_code)
			h := page.header
			h.put_content_length (page.html.count)
			h.put_current_date
			if attached redirection as l_location then
					-- FIXME: find out if this is safe or not.
				if l_location.has_substring ("://") then
--					h.put_location (l_location)
					response.redirect_now (l_location)
				else
--					h.put_location (request.absolute_url (l_location, Void))
					response.redirect_now (absolute_url (l_location, Void))
				end
			else
				h.put_header_object (header)

				response.send (page)
			end
			on_terminated
		end

	on_terminated
		do

		end

end

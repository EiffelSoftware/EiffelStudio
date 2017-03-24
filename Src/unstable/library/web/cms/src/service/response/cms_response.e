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
			site_url := a_api.site_url
			base_url := a_api.base_url
			initialize
		end

	initialize
		local
			s: READABLE_STRING_8
		do
			get_theme
			create menu_system.make
			initialize_block_region_settings

			s := request.percent_encoded_path_info
			if not s.is_empty and then s[1] = '/' then
				create location.make_from_string (s.substring (2, s.count))
			else
				create location.make_from_string (s)
			end
		end

feature -- Access

	request: WSF_REQUEST

	response: WSF_RESPONSE

	status_code: INTEGER

	header: WSF_HEADER

	main_content: detachable STRING_8

feature -- Settings

	is_administration_mode: BOOLEAN
			-- Is administration mode?
		do
			Result := api.is_administration_mode
		end

feature -- Access: metadata

	title: detachable READABLE_STRING_32

	page_title: detachable READABLE_STRING_32
			-- Page title

	description: detachable READABLE_STRING_32

	keywords: detachable READABLE_STRING_32

	publication_date: detachable DATE_TIME
			-- Optional publication date.

	modification_date: detachable DATE_TIME
			-- Optional modification date.

	additional_page_head_lines: detachable LIST [READABLE_STRING_8]
			-- HTML>head>...extra lines

	redirection: detachable READABLE_STRING_8
			-- Location for eventual redirection.

	redirection_delay: NATURAL
			-- Optional redirection delay in seconds.

feature -- Access: query

	location: IMMUTABLE_STRING_8
			-- Associated cms local location.

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

	is_authenticated: BOOLEAN
			-- Is user authenticated?
		do
			Result := user /= Void
		end

	user: detachable CMS_USER
			-- Active user if authenticated.
		do
			Result := api.user
		end

	set_user (u: CMS_USER)
			-- Set active user to `u'.
		require
			attached_u: u /= Void
		do
			api.set_user (u)
		end

	unset_user
			-- Unset active user.
		do
			api.unset_user
		end

feature -- Permission

	has_permission_on_link (a_link: CMS_LINK): BOOLEAN
			-- Does current user has permission to access link `a_link'?
		do
			Result := True
			if
				attached {CMS_LOCAL_LINK} a_link as lnk and then
				attached lnk.permission_arguments as l_perms
			then
				Result := has_permissions (l_perms)
			end
		end

	has_permission (a_permission: READABLE_STRING_GENERAL): BOOLEAN
			-- Does current user has permission `a_permission' ?
		do
			Result := user_has_permission (user, a_permission)
		end

	has_permissions (a_permission_list: ITERABLE [READABLE_STRING_GENERAL]): BOOLEAN
			-- Does current user has any of the permissions `a_permission_list' ?
		do
			Result := user_has_permissions (user, a_permission_list)
		end

	user_has_permission (a_user: detachable CMS_USER; a_permission: READABLE_STRING_GENERAL): BOOLEAN
			-- Does `a_user' has permission `a_permission' ?
		do
			Result := api.user_has_permission (a_user, a_permission)
		end

	user_has_permissions (a_user: detachable CMS_USER; a_permission_list: ITERABLE [READABLE_STRING_GENERAL]): BOOLEAN
			-- Does `a_user' has any of the permissions `a_permission_list' ?
		do
			Result := api.user_has_permissions (a_user, a_permission_list)
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
			create s.make_from_string ("<link rel=%"stylesheet%" href=%"")
			s.append (a_href)
			s.append ("%" type=%"text/css%"")
			if a_media /= Void then
				s.append (" media=%""+ a_media + "%"")
			end
			s.append ("/>")
			add_additional_head_line (s, False)
		end

	add_style_content (a_style_content: STRING)
			-- Add style content `a_style_content' in the head, using <style> tag.
		local
			s: STRING_8
		do
			create s.make_from_string ("<style>%N")
			s.append (a_style_content)
			s.append ("%N</style>")
			add_additional_head_line (s, True)
		end

	add_javascript_url (a_src: STRING)
		local
			s: STRING_8
		do
			create s.make_from_string ("<script type=%"text/javascript%" src=%"")
			s.append (a_src)
			s.append ("%"></script>")
			add_additional_head_line (s, False)
		end

	add_javascript_content (a_script: STRING)
		local
			s: STRING_8
		do
			create s.make_from_string ("<script type=%"text/javascript%">%N")
			s.append (a_script)
			s.append ("%N</script>")
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

	set_description (d: like description)
		do
			description := d
		end

	set_keywords (s: like keywords)
		do
			keywords := s
		end

	set_publication_date (dt: like publication_date)
		do
			publication_date := dt
			if dt /= Void and modification_date = Void then
				modification_date := dt
			end
		end

	set_modification_date (dt: like modification_date)
		do
			modification_date := dt
			if dt /= Void and publication_date = Void then
				publication_date := dt
			end
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

	set_redirection_delay (nb_secs: NATURAL)
		do
			redirection_delay := nb_secs
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
			create blocks.make (10)

			create l_table.make_caseless (10)
			l_table["top"] := block_region_preference ("top", "top")
			l_table["header"] := block_region_preference ("header", "header")
			l_table["highlighted"] := block_region_preference ("highlighted", "highlighted")
			l_table["help"] := block_region_preference ("help", "help")
			l_table["content"] := block_region_preference ("content", "content")
			l_table["footer"] := block_region_preference ("footer", "footer")
			l_table["management"] := block_region_preference ("management", "sidebar_first")
			l_table["navigation"] := block_region_preference ("navigation", "sidebar_first")
			l_table["user"] := block_region_preference ("user", "sidebar_first")
			l_table["bottom"] := block_region_preference ("bottom", "page_bottom")

			block_region_settings := l_table
		end

	block_region_preference (a_block_id: READABLE_STRING_8; a_default_region: READABLE_STRING_8): READABLE_STRING_8
			-- Region associated with `a_block_id' in configuration, if any.
		do
			Result := setup.text_item_or_default ("blocks." + a_block_id + ".region", a_default_region)
		end

feature -- Block management

	update_block (a_block: CMS_BLOCK)
			-- Update parameters for block `a_block' according to configuration.
		do
			if
				attached setup.text_item ("blocks." + a_block.name + ".weight") as w and then
				w.is_integer
			then
				a_block.set_weight (w.to_integer)
			end
			if
				attached setup.text_item ("blocks." + a_block.name + ".title") as l_title
			then
				if l_title.same_string ("<none>") then
					a_block.set_title (Void)
				else
					a_block.set_title (l_title)
				end
			end
		end

	block_conditions (a_block_id: READABLE_STRING_8): detachable ARRAYED_LIST [CMS_BLOCK_EXPRESSION_CONDITION]
			-- Condition associated with `a_block_id' in configuration, if any.
		do
			if attached setup.text_item ("blocks." + a_block_id + ".condition") as s then
				create Result.make (1)
				Result.force (create {CMS_BLOCK_EXPRESSION_CONDITION}.make (s))
			end
			if attached setup.text_list_item ("blocks." + a_block_id + ".conditions") as lst then
				if Result = Void then
					create Result.make (lst.count)
				end
				across
					lst as ic
				loop
					Result.force (create {CMS_BLOCK_EXPRESSION_CONDITION}.make (ic.item))
				end
			end
		end

	block_options (a_block_id: READABLE_STRING_8): detachable STRING_TABLE [READABLE_STRING_32]
			-- Options associated with `a_block_id' in configuration, if any.
		do
			if attached setup.text_table_item ("blocks." + a_block_id + ".options") as tb then
				Result := tb
			end
		end

	is_block_included (a_block_id: READABLE_STRING_8; dft: BOOLEAN): BOOLEAN
			-- Is block `a_block_id' included in current response?
			-- If no preference, return `dft'.
		do
			if attached block_conditions (a_block_id) as l_conditions then
				Result := across l_conditions as ic some ic.item.satisfied_for_response (Current) end
			else
				Result := dft
			end
		end

	block_cache (a_block_id: READABLE_STRING_8): detachable TUPLE [block: CMS_CACHE_BLOCK; region: READABLE_STRING_8; expired: BOOLEAN]
			-- Cached version of block `a_block_id'.
		local
			l_cache: CMS_FILE_STRING_8_CACHE
		do
			if
				attached setup.text_item ("blocks." + a_block_id + ".expiration") as nb_secs and then
				nb_secs.is_integer
			then
				if attached block_region_preference (a_block_id, "none") as l_region and then not l_region.same_string_general ("none") then
					create l_cache.make (api.cache_location.extended ("_blocks").extended (a_block_id).appended_with_extension ("html"))
					if
						l_cache.exists and then
						not l_cache.expired (Void, nb_secs.to_integer)
					then
						Result := [create {CMS_CACHE_BLOCK} .make (a_block_id, l_cache), l_region, False]
					else
						Result := [create {CMS_CACHE_BLOCK} .make (a_block_id, l_cache), l_region, True]
					end
				end
			end
		end

	clear_block_caches (a_block_id_list: detachable ITERABLE [READABLE_STRING_GENERAL])
			-- Clear cache for block `a_block_id_list' if set,
			-- otherwise clear all block caches if `a_block_id_list' is Void.
		local
			p,pb: PATH
			dir: DIRECTORY
			l_cache: CMS_FILE_STRING_8_CACHE
		do
			p := api.cache_location.extended ("_blocks")
			if a_block_id_list /= Void then
				across
					a_block_id_list as ic
				loop
						-- FIXME: find a smarter way to avoid conflict between block id, and other cache id.
						-- however, this is only about "Cache" so not that critical if deleted by mistake.
					pb := p.extended (ic.item).appended_with_extension ("html")
					create l_cache.make (pb)
					if l_cache.exists then
						l_cache.delete
					end
				end
			else
					-- Clear all block caches.
				create dir.make_with_path (p)
				dir.recursive_delete
			end
			add_notice_message ("Blocks cache cleared.")
		end

feature {CMS_HOOK_CORE_MANAGER} -- Block management: internal

	internal_block_alias_table: like block_alias_table
			-- Internal memory cache for `block_alias_table'.

	block_alias_table: detachable STRING_TABLE [LIST [READABLE_STRING_8]]
			-- Table of included block aliases, if any.
			-- note: { block_id => [ alias-names ..] }
		local
			k,v: READABLE_STRING_GENERAL
			l_block_id, l_alias_id: READABLE_STRING_8
			lst: detachable LIST [READABLE_STRING_8]
		do
			Result := internal_block_alias_table
			if
				Result = Void and then
				attached setup.text_table_item ("blocks.&aliases") as tb
			then
				create Result.make (tb.count)
				across
					tb as ic
				loop
					k := ic.key
					v := ic.item
					if v.is_valid_as_string_8 then
						l_block_id := v.to_string_8
						if k.is_valid_as_string_8 then
							l_alias_id := k.to_string_8
							if is_block_included (l_alias_id, False) then
								lst := Result.item (l_block_id)
								if lst = Void then
									create {ARRAYED_LIST [READABLE_STRING_8]} lst.make (1)
								end
								lst.force (l_alias_id)
								Result.force (lst, l_block_id)
							end
						else
							check valid_alias_id: False end
						end
					else
						check valid_block_id: False end
					end
				end
			end
		end

feature -- Blocks regions

	regions: STRING_TABLE [CMS_BLOCK_REGION]
			-- Layout regions, that contains blocks.

	blocks: STRING_TABLE [CMS_BLOCK]
			-- Blocks indexed by their block id.

	block_region_settings: STRING_TABLE [STRING]

	block_region (b: CMS_BLOCK; a_default_region: detachable READABLE_STRING_8): CMS_BLOCK_REGION
			-- Region associated with block `b', or else `a_default_region' if provided.
		local
			l_region_name: detachable READABLE_STRING_8
		do
			l_region_name := block_region_settings.item (b.name)
			if l_region_name = Void then
				if attached setup.text_item ("blocks." + b.name + ".region") as l_setup_name then
					l_region_name := l_setup_name.as_string_8 -- FIXME: potential truncated string 32.
						-- Remember for later.
					block_region_settings.force (l_region_name, b.name)
				elseif a_default_region /= Void then
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

feature {NONE} -- Blocks

	put_core_block (b: CMS_BLOCK; a_default_region: detachable READABLE_STRING_8; is_block_included_by_default: BOOLEAN; a_alias_table: like block_alias_table)
			-- Add block `b' to associated region or `a_default_region' if provided
			-- and check optional associated condition.
			-- If no condition then use `is_block_included_by_default' to
			-- decide if block is included or not.
		local
			l_region: detachable like block_region
		do
			if is_block_included (b.name, is_block_included_by_default) then
				l_region := block_region (b, a_default_region)
				l_region.extend (b)
				blocks.force (b, b.name)
			end
				-- Included alias block ids.
			if
				a_alias_table /= Void and then
				attached a_alias_table.item (b.name) as l_aliases
			then
				across
					l_aliases as ic
				loop
					add_block (create {CMS_ALIAS_BLOCK}.make_with_block (ic.item, b), a_default_region)
				end
			end
		end

feature -- Blocks

	put_block (b: CMS_BLOCK; a_default_region: detachable READABLE_STRING_8; is_block_included_by_default: BOOLEAN)
			-- Add block `b' to associated region or `a_default_region' if provided
			-- and check optional associated condition.
			-- If no condition then use `is_block_included_by_default' to
			-- decide if block is included or not.
		do
			if is_block_included (b.name, is_block_included_by_default) then
				add_block (b, a_default_region)
			end
		end

	add_block (b: CMS_BLOCK; a_default_region: detachable READABLE_STRING_8)
			-- Add block `b' to associated region or `a_default_region' if provided.
			-- WARNING: ignore any block condition! USE WITH CARE!
		local
			l_region: detachable like block_region
		do
			l_region := block_region (b, a_default_region)
			l_region.extend (b)
			blocks.force (b, b.name)
		end

	remove_block (b: CMS_BLOCK)
			-- Remove block `b' from associated region.
		local
			l_region: detachable like block_region
			l_found: BOOLEAN
		do
			across
				regions as reg_ic
			until
				l_found
			loop
				l_region := reg_ic.item
				l_found := l_region.blocks.has (b)
				if l_found then
					l_region.remove (b)
				end
			end
			blocks.remove (b.name)
		end

	get_blocks
			-- Get block from CMS core, and from modules.
		local
			l_region: CMS_BLOCK_REGION
			b: CMS_BLOCK
		do
			get_core_blocks
			get_module_blocks

			across
				regions as reg_ic
			loop
				l_region := reg_ic.item
				across
					l_region.blocks as ic
				loop
					update_block (ic.item)
				end
				l_region.sort
			end

			debug ("cms")
				create {CMS_CONTENT_BLOCK} b.make ("made_with", Void, "Made with <a href=%"https://www.eiffel.org/%">EWF</a>", Void)
				b.set_weight (99)
				put_block (b, "footer", True)
			end
		end

	get_core_blocks
			-- Get blocks provided by the CMS core.
		local
			l_alias_table: like block_alias_table
		do
				-- Get included aliased blocks.
			l_alias_table := block_alias_table

			put_core_block (top_header_block, "top", True, l_alias_table)
			put_core_block (header_block, "header", True, l_alias_table)
			if attached message_block as m then
				put_core_block (m, "content", True, l_alias_table)
			end
			if attached primary_tabs_block as m then
				put_core_block (m, "content", True, l_alias_table)
			end
			add_block (content_block, "content") -- Can not be disabled!

			if attached management_menu_block as l_block then
				put_core_block (l_block, "sidebar_first", True, l_alias_table)
			end
			if attached navigation_menu_block as l_block then
				put_core_block (l_block, "sidebar_first", True, l_alias_table)
			end
			if attached user_menu_block as l_block then
				put_core_block (l_block, "sidebar_second", True, l_alias_table)
			end
		end

	get_module_blocks
			-- Get blocks provided by modules.
		do
				-- Get block from modules, and related alias.
			api.hooks.invoke_block (Current)
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

	top_header_block: CMS_CONTENT_BLOCK
		local
			s: STRING
		do
			create s.make_empty
			create Result.make ("page_top", Void, s, Void)
			Result.set_weight (-5)
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
			Result.set_weight (-4)
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
				Result.set_weight (-3)
			end
		end

	primary_tabs_block: detachable CMS_MENU_BLOCK
		do
			if attached primary_tabs as m and then not m.is_empty then
				create Result.make (m)
				Result.is_horizontal := True
				Result.set_is_raw (True)
				Result.set_weight (-2)
				Result.add_css_class ("tabs")
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
			Result.set_weight (-1)
			Result.set_is_raw (True)
		end

feature -- Hooks

	hooks: CMS_HOOK_CORE_MANAGER
			-- Manager handling hook subscriptions.
		obsolete
			"Use api.hooks [dec/2015]"
		do
			Result := api.hooks
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
			m.extend (lnk)
		end

feature -- Internationalization (i18n)

	translation (a_text: READABLE_STRING_GENERAL; opts: detachable CMS_API_OPTIONS): STRING_32
			-- Translated text `a_text' according to expected context (lang, ...)
			-- and adapt according to options eventually set by `opts'.
		do
			Result := api.translation (a_text, opts)
		end

	formatted_string (a_text: READABLE_STRING_GENERAL; args: TUPLE): STRING_32
			-- Format `a_text' using arguments `args'.
			--| ex: formatted_string ("hello $1, see page $title.", ["bob", "contact"] -> "hello bob, see page contact"
		do
			Result := api.formatted_string (a_text, args)
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

	add_debug_message (a_msg: READABLE_STRING_8)
		do
			if api.is_debug then
				add_message (a_msg, "debug")
			end
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
				create {SMARTY_CMS_THEME} theme.make (api, l_info, site_url)
			else
				create {MISSING_CMS_THEME} theme.make (api, l_info, site_url)
				status_code := {HTTP_STATUS_CODE}.service_unavailable
				to_implement ("Check how to add the Retry-after, http://tools.ietf.org/html/rfc7231#section-6.6.4 and http://tools.ietf.org/html/rfc7231#section-7.1.3")
			end
		end

feature -- Theme helpers

	wsf_theme: WSF_THEME
			-- WSF Theme from CMS `theme' for Current response.
		local
			t: like internal_wsf_theme
		do
			t := internal_wsf_theme
			if t = Void then
				create {CMS_TO_WSF_THEME} t.make (Current, theme)
				internal_wsf_theme := t
			end
			Result := t
		end

feature {NONE} -- Theme helpers		

	internal_wsf_theme: detachable WSF_THEME
			-- Once per object for `wsf_theme'.

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

feature -- Cache managment

	clear_cache (a_cache_id_list: detachable ITERABLE [READABLE_STRING_GENERAL])
			-- Clear caches identified by `a_cache_id_list',
			-- or clear all caches if `a_cache_id_list' is Void.	
		do
			if has_permissions (<<"clear blocks cache", "admin core caches">>) then
				clear_block_caches (a_cache_id_list)
			end
		end

feature -- Response builtin variables

	builtin_variables: STRING_TABLE [detachable ANY]
			-- builtin variables value indexed by name.
		do
			Result := api.builtin_variables
			Result ["site_url"] := site_url
			Result ["host"] := site_url -- FIXME: check and remove if unused.
			Result ["is_https"] := request.is_https
		end

feature -- Generation

	prepare (page: CMS_HTML_PAGE)
		local
			lnk: CMS_LINK
			l_region: CMS_BLOCK_REGION
			l_menu_list_prepared: ARRAYED_LIST [CMS_LINK_COMPOSITE]
			l_empty_blocks: detachable ARRAYED_LIST [CMS_BLOCK]
			l_block_html: STRING
		do
				-- Menu
			create {CMS_LOCAL_LINK} lnk.make ("Home", "")
			lnk.set_weight (-10)
			add_to_primary_menu (lnk)
			api.hooks.invoke_menu_system_alter (menu_system, Current)

			if api.enabled_modules.count = 1 then
					-- It is the required CMS_CORE_MODULE!
				add_to_primary_menu (api.administration_link ("Install", "install"))
			end

				-- Blocks
			create l_menu_list_prepared.make (0)
			get_blocks
			across
				regions as reg_ic
			loop
				l_region := reg_ic.item
				across
					l_region.blocks as ic
				loop
					if attached {CMS_MENU_BLOCK} ic.item as l_menu_block then
						l_menu_list_prepared.force (l_menu_block.menu)
						prepare_links (l_menu_block.menu)
						if l_menu_block.menu.is_empty then
							if l_empty_blocks = Void then
								create l_empty_blocks.make (1)
							end
							l_empty_blocks.force (l_menu_block)
						end
					end
				end
				if l_empty_blocks /= Void then
					across
						l_empty_blocks as ic
					loop
						l_region.remove (ic.item)
					end
					l_empty_blocks := Void
				end
			end

				-- Prepare menu not in a block.
			across
				menu_system as ic
			loop
				if not l_menu_list_prepared.has (ic.item) then
					l_menu_list_prepared.force (ic.item)
					prepare_links (ic.item)
				end
			end
			l_menu_list_prepared.wipe_out -- Clear for memory purpose.

				-- Sort items
			across menu_system as ic loop
				ic.item.sort
			end

				-- Values
			common_prepare (page)
			custom_prepare (page)

				-- Cms response
			api.hooks.invoke_response_alter (Current)

				-- Cms values
			api.hooks.invoke_value_table_alter (values, Current)

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
				l_region := reg_ic.item
					-- region blocks Already sorted.
				across
					l_region.blocks as ic
				loop
					if attached {CMS_SMARTY_TEMPLATE_BLOCK} ic.item as l_tpl_block then
							-- Apply page variables to smarty block.
							-- FIXME: maybe add notion of values at the CMS_BLOCK level
							--        or consider a CMS_BLOCK_WITH_VALUES ...
						across
							page.variables as var_ic
						loop
							if not l_tpl_block.values.has (var_ic.key) then
									-- Do not overwrite if has key.
								l_tpl_block.set_value (var_ic.item, var_ic.key)
							end
						end
					end
					l_block_html := theme.block_html (ic.item)
					if attached {CMS_CACHE_BLOCK} ic.item then

					elseif attached block_cache (ic.item.name) as l_cache_block then
						l_cache_block.block.cache.put (l_block_html)
					end
					page.add_to_region (l_block_html, reg_ic.item.name)
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
					page.set_title ({STRING_32} "CMS::" + request.path_info) --| FIXME: probably, should be removed and handled by theme.
				end
			end

				-- Fill with CMS builtin variables.
			across
				builtin_variables as ic
			loop
				page.register_variable (ic.item, ic.key)
			end

				-- Variables
			page.register_variable (absolute_url ("", Void), "site_url")
			page.register_variable (absolute_url ("", Void), "host") -- Same as `site_url'.
			page.register_variable (request.is_https, "is_https")
			if attached title as l_title then
				page.register_variable (l_title, "site_title")
			else
				page.register_variable (site_name, "site_title")
			end
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

	prepare_links (a_comp: CMS_LINK_COMPOSITE)
			-- Update the active status recursively on `a_comp'.
		local
			to_remove: ARRAYED_LIST [CMS_LINK]
			ln: CMS_LINK
			l_comp_link: detachable CMS_LOCAL_LINK
		do
			if attached {CMS_LOCAL_LINK} a_comp as lnk then
				l_comp_link := lnk
				get_local_link_active_status (lnk)
			end
			if attached a_comp.items as l_items then
				create to_remove.make (0)
				across
					l_items as ic
				loop
					ln := ic.item
					if attached {CMS_LOCAL_LINK} ln as l_local then
						get_local_link_active_status (l_local)
					end
					if ln.is_forbidden then
						to_remove.force (ln)
					else
						if
							(ln.is_expanded or ln.is_collapsed) and then
							attached {CMS_LINK_COMPOSITE} ln as l_comp
						then
							prepare_links (l_comp)
						end
						if l_comp_link /= Void then
							if ln.is_expanded or (not ln.is_expandable and ln.is_active) then
								l_comp_link.set_expanded (True)
							end
						end
					end
				end
				across
					to_remove as ic
				loop
					a_comp.remove (ic.item)
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
			a_lnk.set_is_forbidden (not has_permission_on_link (a_lnk))
		end

feature -- Helpers: cms link

	administration_link (a_title: READABLE_STRING_GENERAL; a_relative_location: detachable READABLE_STRING_8): CMS_LOCAL_LINK
		require
			no_first_slash: a_relative_location = Void or else not a_relative_location.starts_with_general ("/")
		do
			Result := api.administration_link (a_title, a_relative_location)
		end

	local_link (a_title: READABLE_STRING_GENERAL; a_location: READABLE_STRING_8): CMS_LOCAL_LINK
		do
			Result := api.local_link (a_title, a_location)
		end

	user_local_link (u: CMS_USER; a_opt_title: detachable READABLE_STRING_GENERAL): CMS_LOCAL_LINK
		do
			Result := api.user_local_link (u, a_opt_title)
		end

feature -- Helpers: html links

	user_profile_name, user_display_name (u: CMS_USER): READABLE_STRING_32
		do
			Result := api.user_display_name (u)
		end

	user_html_link (u: CMS_USER): STRING
		require
			u_with_name: not u.name.is_whitespace
		do
			Result := api.user_html_link (u)
		end

feature -- Helpers: URLs	

	location_absolute_url (a_location: READABLE_STRING_8; opts: detachable CMS_API_OPTIONS): STRING
			-- Absolute URL for `a_location'.
			--| Options `opts' could be
			--|  - absolute: True|False	=> return absolute url
			--|  - query: string		=> append "?query"
			--|  - fragment: string		=> append "#fragment"
		do
			Result := api.location_absolute_url (a_location, opts)
		end

	location_url (a_location: READABLE_STRING_8; opts: detachable CMS_API_OPTIONS): STRING
			-- URL for `a_location'.
			--| Options `opts' could be
			--|  - absolute: True|False	=> return absolute url
			--|  - query: string		=> append "?query"
			--|  - fragment: string		=> append "#fragment"
		do
			Result := api.location_url (a_location, opts)
		end

	user_url (u: CMS_USER): like url
		require
			u_with_id: u.has_id
		do
			Result := api.user_url (u)
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
			l_new_location: detachable READABLE_STRING_8
			l_redirection_delay: like redirection_delay
		do
			if attached redirection as l_location then
					-- FIXME: find out if this is safe or not.
				if l_location.has_substring ("://") then
					l_new_location := l_location
				else
					l_new_location := location_absolute_url (l_location, Void)
				end
				l_redirection_delay := redirection_delay
				if l_redirection_delay > 0 then
					add_additional_head_line ("<meta http-equiv=%"refresh%" content=%"" + l_redirection_delay.out + ";url=" + l_new_location + "%" />", True)
				end
			end

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
			if l_new_location /= Void and l_redirection_delay = 0 then
				response.redirect_now (l_new_location)
			else
				h.put_header_object (header)

				response.send (page)
			end
			on_terminated
		end

	on_terminated
		do

		end

note
	copyright: "2011-2017, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end

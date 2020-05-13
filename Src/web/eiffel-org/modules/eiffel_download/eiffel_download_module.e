note
	description: "Summary description for {EIFFEL_DOWNLOAD_MODULE}."
	date: "$Date$"
	revision: "$Revision$"

class
	EIFFEL_DOWNLOAD_MODULE

inherit
	CMS_MODULE
		rename
			module_api as eiffel_download_api
		redefine
			initialize,
			setup_hooks,
			eiffel_download_api
		end

	CMS_WITH_WEBAPI

	CMS_HOOK_AUTO_REGISTER

	CMS_HOOK_BLOCK
		redefine
			setup_block
		end

	CMS_HOOK_BLOCK_HELPER

	SHARED_EXECUTION_ENVIRONMENT
		export
			{NONE} all
		end

	SHARED_HTML_ENCODER

	SHARED_WSF_PERCENT_ENCODER

	REFACTORING_HELPER

	SHARED_LOGGER

	CMS_ADMINISTRABLE

create
	make

feature {NONE} -- Initialization

	make
			-- Create current module
		do
			version := "1.0"
			description := "Eiffel Community Download"
			package := "eiffel"
		end

feature -- Access

	name: STRING = "eiffel_download"

feature {CMS_EXECUTION} -- Administration

	administration: EIFFEL_DOWNLOAD_MODULE_ADMINISTRATION
		do
			create Result.make (Current)
		end

	webapi: EIFFEL_DOWNLOAD_WEBAPI
		do
			create Result.make (Current)
		end

feature {CMS_API} -- Module Initialization			

	initialize (api: CMS_API)
			-- <Precursor>
		do
			Precursor (api)
			create eiffel_download_api.make (api)
		end

feature {CMS_API, CMS_MODULE} -- Access: API

	eiffel_download_api: detachable EIFFEL_DOWNLOAD_API
			-- Eventual module api.

feature -- Router

	setup_router (a_router: WSF_ROUTER; a_api: CMS_API)
			-- Router configuration.
		do
			a_router.handle ("/download", create {WSF_URI_TEMPLATE_AGENT_HANDLER}.make (agent handle_download (a_api, ?, ?)), a_router.methods_head_get)
			a_router.handle ("/download/channel/{channel}", create {WSF_URI_TEMPLATE_AGENT_HANDLER}.make (agent handle_download (a_api, ?, ?)), a_router.methods_head_get)
			a_router.handle ("/downloads", create {WSF_URI_TEMPLATE_AGENT_HANDLER}.make (agent handle_download_channel (a_api, "stable", ?, ?)), a_router.methods_head_get)
			a_router.handle ("/downloads/channel/{channel}", create {WSF_URI_TEMPLATE_AGENT_HANDLER}.make (agent handle_download_channel (a_api, Void, ?, ?)), a_router.methods_head_get)
		end

feature -- Hooks configuration

	setup_hooks (a_hooks: CMS_HOOK_CORE_MANAGER)
			-- Module hooks configuration.
		do
			auto_subscribe_to_hooks (a_hooks)
			a_hooks.subscribe_to_block_hook (Current)
		end

feature -- Hooks

	populate_values (vals: CMS_VALUE_TABLE; a_channel: detachable READABLE_STRING_GENERAL; a_response: CMS_RESPONSE)
		local
			ch: READABLE_STRING_GENERAL
			l_ua: CMS_USER_AGENT
			l_platform: READABLE_STRING_GENERAL
			lnk: CMS_LOCAL_LINK
		do
			if a_channel = Void then
				ch := "stable"
			else
				ch := a_channel
			end
			if
				attached eiffel_download_api as l_api and then
				attached l_api.download_channel_configuration (ch) as cfg
			then
				create l_ua.make_from_string (a_response.request.http_user_agent)
				l_platform := get_platform (l_ua)
				vals.force (l_platform, "platform")

				if attached l_api.retrieve_product_community (cfg) as l_product then
					if
						attached l_product.name as l_name and then
						attached l_product.version  as l_version and then
						attached l_api.retrieve_mirror_community (cfg) as l_mirror
					then
						vals.force (l_name + " " + l_version, "last_release")
						if attached l_product.default_mirror as dft_mirror then
							vals.force (dft_mirror, "mirror")
						else
							vals.force (l_mirror, "mirror")
						end
						if ch.same_string ("stable") then
							create lnk.make ("download", "download")
						else
							create lnk.make ("download", "download/channel/" + url_encoded (ch))
						end
						vals.force (a_response.absolute_url (lnk.location, Void), "download_link")
						if ch.same_string ("stable") then
							create lnk.make ("download others", "downloads/channel/stable")
						else
							create lnk.make ("download others", "downloads/channel/" + url_encoded (ch))
						end
						vals.force (a_response.absolute_url (lnk.location, Void), "download_other_link")
					end
					if
						attached l_api.selected_platform (l_product.downloads, l_platform) as l_selected
					then
						vals.force (l_selected.filename, "filename")
					end
				end
			end
		end

	block_list: ITERABLE [like {CMS_BLOCK}.name]
				-- <Precursor>
		do
			Result := <<"?download_area", "?download_channel">>
		end

	get_block_view (a_block_id: READABLE_STRING_8; a_response: CMS_RESPONSE)
				-- <Precursor>
		local
			i: INTEGER
			l_loc: READABLE_STRING_8
			ch: detachable READABLE_STRING_GENERAL
		do
			l_loc := a_response.location
			if l_loc.starts_with_general ("downloads/channel/") then
				i := l_loc.substring_index ("/channel/", 1)
				i := l_loc.index_of ('/', i + 1)
				ch := l_loc.substring (i + 1, l_loc.count)
			else
				ch := "stable"
			end
			if a_block_id.is_case_insensitive_equal_general ("download_area") then
				get_block_view_download_area (a_block_id, ch, a_response)
			elseif a_block_id.is_case_insensitive_equal_general ("download_channel") then
				get_block_view_download_channel (a_block_id, ch, a_response)
			end
		end

	setup_block (a_block: CMS_BLOCK; a_response: CMS_RESPONSE)
			-- <Precursor>
		do
			a_response.add_style (a_response.module_resource_url (Current, "/files/css/download.css", Void), Void)
		end

feature {NONE} -- Block view implementation

	get_block_view_download_area (a_block_id: READABLE_STRING_8; a_channel: READABLE_STRING_GENERAL; a_response: CMS_RESPONSE)
				--  Get block download area object identified by `a_block_id' and associate with `a_response'.
		local
			vals: CMS_VALUE_TABLE
			bl: CMS_CONTENT_BLOCK
		do
			if attached smarty_template_block (Current, a_block_id, a_response.api) as l_tpl_block then
				create vals.make (5)
				populate_values (vals, a_channel, a_response)
				across
					vals as ic
				loop
					l_tpl_block.set_value (ic.item, ic.key)
				end
				create bl.make (a_block_id, Void, l_tpl_block.to_html (a_response.theme), Void)
				a_response.add_block (bl, "header")
			else
				a_response.add_warning_message ("Error with block [" + a_block_id + "]")
				write_warning_log ("Error with block [" + a_block_id + "]")
			end
		end

	get_block_view_download_channel (a_block_id: READABLE_STRING_8; a_channel: READABLE_STRING_GENERAL; a_response: CMS_RESPONSE)
				--  Get block download channel object identified by `a_block_id' and associate with `a_response'.
		do
			if attached downloads_channel_block (a_block_id, a_channel, a_response) as l_block then
				a_response.add_block (l_block, "content")
			else
				a_response.add_warning_message ("Error with block [block_download_channel]")
				write_warning_log ("Error with block [block_download_channel]")
			end
		end

feature -- Handler	

	handle_download_channel (api: CMS_API; a_channel: detachable READABLE_STRING_GENERAL; req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			r: CMS_RESPONSE
			ch: READABLE_STRING_GENERAL
		do
			write_debug_log (generator + ".handle_download_channel")
			create {GENERIC_VIEW_CMS_RESPONSE} r.make (req, res, api)

			if a_channel /= Void then
				ch := a_channel
			elseif attached {WSF_STRING} req.path_parameter ("channel") as p_channel then
				ch := p_channel.value
			else
				ch := "stable"
			end
			if attached downloads_channel_block ("download_channel", ch, r) as l_block then
				l_block.set_weight (10)
				r.add_block (l_block, "content")
			else
				r.add_warning_message ("Error with block [block_download_channel]")
				write_warning_log ("Error with block [block_download_channel]")
			end
			r.add_style (r.module_resource_url (Current, "/files/css/download.css", Void), Void)
			r.execute
		end

	downloads_channel_block (a_block_id: READABLE_STRING_8; a_channel: READABLE_STRING_GENERAL; a_response: CMS_RESPONSE): detachable CMS_BLOCK
		local
			vals: CMS_VALUE_TABLE
		do
			if attached smarty_template_block (Current, a_block_id, a_response.api) as l_tpl_block then
				create vals.make (8)
				across
					a_response.values as ic
				loop
					l_tpl_block.set_value (ic.item, ic.key)
				end
				populate_values (vals, a_channel, a_response)
				across
					vals as ic
				loop
					l_tpl_block.set_value (ic.item, ic.key)
				end
				l_tpl_block.set_value (a_channel, "download_channel")

				if attached eiffel_download_api as l_api then
					if
						attached l_api.download_channel_configuration (a_channel) as cfg
					then
						vals.force (l_api.retrieve_product_community (cfg), "product")
						if attached l_api.retrieve_products (cfg) as l_products then
								-- Compute download links if needed.
							across
								l_products as ic
							loop
								l_api.sort_downloads (ic.item)
								if attached ic.item.downloads as l_downloads then
									across
										l_downloads as d_ic
									loop
										d_ic.item.get_link
									end
								end
							end
							vals.force (l_products, "products")
						else
							vals.force (Void, "products")
						end
						vals.force (l_api.retrieve_mirror_community (cfg), "mirror")
						across
							vals as ic
						loop
							l_tpl_block.set_value (ic.item, ic.key)
						end
					end

					Result := l_tpl_block
				end
			end
		end

	handle_download (api: CMS_API; req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			l_link: STRING
			l_ua: CMS_USER_AGENT
			err: INTERNAL_SERVER_ERROR_CMS_RESPONSE
			done: BOOLEAN
			ch: READABLE_STRING_GENERAL
		do
			if attached {WSF_STRING} req.path_parameter ("channel") as p_channel then
				ch := p_channel.value
			else
				ch := "stable"
			end
			write_debug_log (generator + ".handle_download")
			if
				attached eiffel_download_api as l_api and then
				attached l_api.download_channel_configuration (ch) as cfg
			then
				create l_ua.make_from_string (req.http_user_agent)
				write_debug_log (generator + ".handle_download [ User_agent: " + l_ua.user_agent  + " ]")

				if attached l_api.retrieve_product_community (cfg) as l_product then
					if
						attached l_api.selected_platform (l_product.downloads, get_platform (l_ua)) as l_selected and then
						attached l_selected.filename as l_filename
					then
						write_debug_log (generator + ".handle_download [ Filename: " + url_encoded (l_filename)  + " ]")
						l_selected.get_link
						if attached l_selected.link as lnk then
							l_link := lnk
						elseif
							attached l_product.build as l_build and then
							attached l_product.name as l_name and then
							attached l_product.number as l_number and then
							attached l_api.retrieve_mirror_community (cfg) as l_mirror
						then
						    create l_link.make_from_string (l_mirror)
						    l_link.append (url_encoded (l_name))
						    l_link.append_character (' ')
						    l_link.append (url_encoded (l_number))
						    l_link.append_character ('/')
						    l_link.append (url_encoded (l_build))
						    l_link.append_character ('/')
							l_link.append (url_encoded (l_filename))
						    write_debug_log (generator + ".handle_download [ Link: " + l_link  + " ]")
						end
						if l_link /= Void then
							file_download (req, res, l_link)
							done := True
						end
					end
				end
			end
			if not done then
					-- If not answer was done, return internal server error.
				create err.make (req, res, api)
				err.execute
			end
		end

	file_download  (req: WSF_REQUEST; res: WSF_RESPONSE; a_link: READABLE_STRING_32)
			-- Simple response to download content
			-- Harcoded for testing.
		local
			h: HTTP_HEADER
		do
			create h.make
			h.put_content_disposition ("attachment; filename", utf_8_encoded (a_link))
			h.put_current_date
			h.put_header_key_value ("Content-type", "application/octet-stream")
			h.put_location (utf_8_encoded (a_link))
			res.set_status_code ({HTTP_STATUS_CODE}.see_other)
			res.put_header_text (h.string)
		end

feature {NONE}  -- Helper

	get_platform (a_user_agent: CMS_USER_AGENT)	: READABLE_STRING_32
				-- Set by default win64
				--	<option value="freebsd-x86">FreeBSD x86 32-bit</option>
				--	<option value="freebsd-x86-64">FreeBSD x86 64-bit</option>
				--	<option value="linux-x86">Linux x86 32-bit</option>
				--	<option value="linux-x86-64">Linux x86 64-bit</option>
				--	<option value="macosx-x86-64">Mac OS X</option>
				--  <option value="openbsd-x86">OpenBSD x86 32-bit</option>
				--	<option value="openbsd-x86-64">OpenBSD x86 64-bit</option>
				--	<option value="solaris-x86">Solaris x86 32-bit</option>
				--	<option value="solaris-x86-64">Solaris x64 64-bit</option>
				--	<option value="solaris-sparc">Solaris Sparc 32-bit</option>
				--	<option value="solaris-sparc-64">Solaris Sparc 64-bit</option>
				--	<option value="win64" selected="">Windows 64-bit</option>
				--	<option value="windows">Windows 32-bit</option>		
		do
			write_debug_log (generator + ".get_platform [ from " + a_user_agent.user_agent  + " ]")
			Result := "win64"
			if a_user_agent.is_windows_os then
				if a_user_agent.is_64bits then
					Result := "win64"
				else
					Result := "windows"
				end
			elseif a_user_agent.is_linux_os then
				if a_user_agent.is_64bits then
					Result := "linux-x86-64"
				else
					Result := "linux-x86"
				end
			elseif a_user_agent.is_mac_os then
				Result := "macosx-x86-64"
			end
			write_debug_log (generator + ".get_platform [ platform inferred "+  Result  + " ]")
		end

end

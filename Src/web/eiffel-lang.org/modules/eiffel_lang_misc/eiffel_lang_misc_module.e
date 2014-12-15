note
	description: "Summary description for {EIFFEL_LANG_MISC_MODULE}."
	date: "$Date$"
	revision: "$Revision$"

class
	EIFFEL_LANG_MISC_MODULE

inherit
	CMS_MODULE
		redefine
			register_hooks
		end

	CMS_HOOK_BLOCK

	CMS_HOOK_AUTO_REGISTER

	CMS_HOOK_MENU_SYSTEM_ALTER

	SHARED_EXECUTION_ENVIRONMENT
		export
			{NONE} all
		end

	SHARED_HTML_ENCODER

	SHARED_WSF_PERCENT_ENCODER

	REFACTORING_HELPER

	SHARED_LOGGER

create
	make

feature {NONE} -- Initialization

	make
			-- Create current module
		do
			name := "eiffel_lang_misc"
			version := "1.0"
			description := "Eiffel Lang Misc module"
			package := "misc"

			create root_dir.make_current
			cache_duration := 0
		end

feature -- Access: docs

	root_dir: PATH

	cache_duration: INTEGER
			-- Caching duration
			--|  0: disable
			--| -1: cache always valie
			--| nb: cache expires after nb seconds.

	cache_disabled: BOOLEAN
		do
			Result := cache_duration = 0
		end

feature -- Router

	router (a_api: CMS_API): WSF_ROUTER
			-- Router configuration.
		do
			create Result.make (0)
			Result.handle_with_request_methods ("/contribute", create {WSF_URI_AGENT_HANDLER}.make (agent handle_contribute (a_api, ?, ?)), Result.methods_head_get)
		end

feature -- Hooks configuration

	register_hooks (a_response: CMS_RESPONSE)
			-- Module hooks configuration.
		do
			auto_subscribe_to_hooks (a_response)
			a_response.subscribe_to_block_hook (Current)
		end

feature -- Hooks

	menu_system_alter (a_menu_system: CMS_MENU_SYSTEM; a_response: CMS_RESPONSE)
			-- Hook execution on collection of menu contained by `a_menu_system'
			-- for related response `a_response'.
		do
			debug ("refactor_fixme")
				fixme ("add /about and /contribute to primary menu")
			end
		end

	block_list: ITERABLE [like {CMS_BLOCK}.name]
		local
			l_string: STRING
		do
			Result := <<"social_buttons", "codeboard", "updates", "popular_nodes", "libraries", "social_area", "eiffel_copyright">>
			create l_string.make_empty
			across Result as ic loop
					l_string.append (ic.item)
					l_string.append_character (' ')
				end
			log.write_debug (generator + ".block_list:" + l_string )
		end

	get_block_view (a_block_id: READABLE_STRING_8; a_response: CMS_RESPONSE)
		do
			if a_block_id.is_case_insensitive_equal_general ("social_buttons") then
				if
					attached {READABLE_STRING_GENERAL} a_response.values.item ("optional_content_type") as l_type and then
					l_type.same_string ("doc")
				then
					if attached template_block (a_block_id, a_response) as l_tpl_block then
						a_response.add_block (l_tpl_block, "sidebar_second")
					else
						debug ("cms")
							a_response.add_warning_message ("Error with block [" + a_block_id + "]")
						end
					end
				end
			elseif a_block_id.is_case_insensitive_equal_general ("popular_nodes") then
				if attached template_block (a_block_id, a_response) as l_tpl_block then
					a_response.add_block (l_tpl_block, "sidebar_second")
				else
					debug ("cms")
						a_response.add_warning_message ("Error with block [" + a_block_id + "]")
					end
				end
			elseif a_block_id.is_case_insensitive_equal_general ("social_area") and then  a_response.request.path_info ~ "/" then
				if attached template_block (a_block_id, a_response) as l_tpl_block then
					l_tpl_block.set_is_raw (True)
					-- TODO: double check: Social Header is only included in the home page.
					a_response.add_block (l_tpl_block, "header")
				else
					debug ("cms")
						a_response.add_warning_message ("Error with block [" + a_block_id + "]")
					end
				end
			elseif a_block_id.is_case_insensitive_equal_general ("eiffel_copyright") then
				if attached template_block (a_block_id, a_response) as l_tpl_block then
					l_tpl_block.set_is_raw (True)
					a_response.add_block (l_tpl_block, "footer")
				else
					a_response.add_warning_message ("Error with block [" + a_block_id + "]")
				end
			elseif a_block_id.is_case_insensitive_equal_general ("updates") then
				if a_response.is_front then
					if attached template_block (a_block_id, a_response) as l_tpl_block then
						a_response.add_block (l_tpl_block, "sidebar_second")
					else
						debug ("cms")
							a_response.add_warning_message ("Error with block [" + a_block_id + "]")
						end
					end
				end
			elseif a_block_id.is_case_insensitive_equal_general ("libraries") then
				if a_response.is_front then
					if attached template_block (a_block_id, a_response) as l_tpl_block then
						a_response.add_block (l_tpl_block, "sidebar_second")
					else
						debug ("cms")
							a_response.add_warning_message ("Error with block [" + a_block_id + "]")
						end
					end
				end
			elseif a_block_id.is_case_insensitive_equal_general ("codeboard") and then  a_response.request.path_info ~ "/" then
				if a_response.is_front then
					if attached template_block (a_block_id, a_response) as l_tpl_block then
--						a_response.add_block (l_tpl_block, "header")
					else
						debug ("cms")
							a_response.add_warning_message ("Error with block [" + a_block_id + "]")
						end
					end
				end
			end
		end

	handle_contribute (api: CMS_API; req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			r: CMS_RESPONSE
		do
			fixme ("Use CMS node and associated content for Contribute link!")
			create {GENERIC_VIEW_CMS_RESPONSE} r.make (req, res, api)
			r.set_value ("contribute", "optional_content_type")
			r.set_title ("Contribute")
			r.set_main_content ("")
			if attached template_block ("contribute_page", r) as l_tpl_block then
				r.add_block (l_tpl_block, "content")
			else
				debug ("cms")
					r.add_warning_message ("Error with block [contribute_page]")
				end
			end
			r.execute
		end

feature {NONE} -- Helpers

	template_block (a_block_id: READABLE_STRING_8; a_response: CMS_RESPONSE): detachable CMS_SMARTY_TEMPLATE_BLOCK
			-- Smarty content block for `a_block_id'
		local
			p: detachable PATH
		do
			create p.make_from_string ("templates")
			p := p.extended ("block_").appended (a_block_id).appended_with_extension ("tpl")
			p := a_response.module_resource_path (Current, p)
			if p /= Void then
				if attached p.entry as e then
					create Result.make (a_block_id, Void, p.parent, e)
				else
					create Result.make (a_block_id, Void, p.parent, p)
				end
			end
		end

feature {NONE} -- Implementation: date and time

	http_date_format_to_date (s: READABLE_STRING_8): detachable DATE_TIME
		local
			d: HTTP_DATE
		do
			create d.make_from_string (s)
			if not d.has_error then
				Result := d.date_time
			end
		end

	file_date (p: PATH): DATE_TIME
		require
			path_exists: (create {FILE_UTILITIES}).file_path_exists (p)
		local
			f: RAW_FILE
		do
			create f.make_with_path (p)
			Result := timestamp_to_date (f.date)
		end

	timestamp_to_date (n: INTEGER): DATE_TIME
		local
			d: HTTP_DATE
		do
			create d.make_from_timestamp (n)
			Result := d.date_time
		end

feature {NONE} -- Implementation		

	html_encoded (s: detachable READABLE_STRING_GENERAL): STRING_8
		do
			if s /= Void then
				Result := html_encoder.general_encoded_string (s)
			else
				create Result.make_empty
			end
		end

note
	copyright: "Copyright (c) 1984-2013, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end

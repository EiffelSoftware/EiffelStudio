note
	description: "Summary description for {EIFFEL_COMMUNITY_MODULE}."
	date: "$Date$"
	revision: "$Revision$"

class
	EIFFEL_COMMUNITY_MODULE

inherit
	CMS_MODULE
		redefine
			setup_hooks,
			permissions
		end

	CMS_HOOK_BLOCK

	CMS_HOOK_BLOCK_HELPER

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
			version := "1.0"
			description := "Eiffel Community module"
			package := "misc"

			create root_dir.make_current
			cache_duration := 0
		end

feature -- Access

	name: STRING = "eiffel_community"

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

	setup_router (a_router: WSF_ROUTER; a_api: CMS_API)
			-- Router configuration.
		do
		end

feature -- Access			

	permissions: LIST [READABLE_STRING_8]
			-- <Precursor>.
		do
			Result := Precursor
			Result.force ("manage " + name)
		end

feature -- Hooks configuration

	setup_hooks (a_hooks: CMS_HOOK_CORE_MANAGER)
			-- Module hooks configuration.
		do
			auto_subscribe_to_hooks (a_hooks)
			a_hooks.subscribe_to_block_hook (Current)
		end

feature -- Hooks

	menu_system_alter (a_menu_system: CMS_MENU_SYSTEM; a_response: CMS_RESPONSE)
			-- Hook execution on collection of menu contained by `a_menu_system'
			-- for related response `a_response'.
		do
			debug ("refactor_fixme")
				fixme ("add /about ... and /contribute to primary menu")
			end
		end

	block_list: ITERABLE [like {CMS_BLOCK}.name]
		do
			Result := <<
						"none"
					>>
		end

	get_block_view (a_block_id: READABLE_STRING_8; a_response: CMS_RESPONSE)
		local
--			loc: READABLE_STRING_8
		do
--			loc := a_response.location

--			if a_block_id.is_case_insensitive_equal_general ("play_with_eiffel") and then loc.is_empty then
--				if attached smarty_template_block (Current, a_block_id, a_response.api) as l_tpl_block then
--					-- TODO: double check: Social Header is only included in the home page.
--					a_response.add_block (l_tpl_block, "header")
--					write_debug_log (generator + ".get_block_view with smarty_template_block:" + l_tpl_block.out)
--				else
--					debug ("cms")
--						a_response.add_warning_message ("Error with block [" + a_block_id + "]")
--					end
--				end
--			end
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

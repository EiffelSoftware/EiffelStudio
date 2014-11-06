note
	description: "Summary description for {EIFFEL_LANG_MISC_MODULE}."
	date: "$Date$"
	revision: "$Revision$"

class
	EIFFEL_LANG_MISC_MODULE

inherit
	CMS_MODULE

	CMS_HOOK_BLOCK

	CMS_HOOK_AUTO_REGISTER

	SHARED_EXECUTION_ENVIRONMENT
		export
			{NONE} all
		end

	SHARED_HTML_ENCODER

	SHARED_WSF_PERCENT_ENCODER

	REFACTORING_HELPER

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

feature {CMS_SERVICE} -- Registration

	service: detachable CMS_SERVICE

	register (a_service: CMS_SERVICE)
		do
			service := a_service

				-- FIXME: this code could/should be retarded to when it is really needed
				-- then if the module is disabled, it won't take CPU+memory for nothing.
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

feature -- Hooks

	block_list: ITERABLE [like {CMS_BLOCK}.name]
		do
			Result := <<"social_buttons", "popular_nodes", "eiffel_copyright">>
		end

	get_block_view (a_block_id: detachable READABLE_STRING_8; a_execution: CMS_EXECUTION)
		local
			l_menublock: CMS_MENU_BLOCK
			l_content_block: CMS_CONTENT_BLOCK
			s: STRING
		do
			-- FIXME: we should try to use template for that .. find a solution, maybe CMS_TEMPLATE_BLOCK ?
			if a_block_id /= Void then
				if a_block_id.is_case_insensitive_equal_general ("social_buttons") then
					s := "[
							<div class="social-plugin"><img src="/theme/images/img-plugin.jpg" width="248" height="88" alt="Image Description"></div>
						]"
					create l_content_block.make (a_block_id, Void, s, Void)
					a_execution.add_block (l_content_block, "sidebar_second")
				elseif a_block_id.is_case_insensitive_equal_general ("popular_nodes") then
					s := "[
							<nav class="widget popular">
								<h2><a href="#">Popular</a></h2>
								<ul>
									<li><a href="#"><img src="/theme/images/ico6.png" width="24" height="25" alt="Image Description"> EiffelBase</a></li>
									<li><a href="#"><img src="/theme/images/ico7.png" width="26" height="23" alt="Image Description"> EiffelVision 2</a></li>
									<li><a href="#"><img src="/theme/images/ico8.png" width="24" height="24" alt="Image Description"> EiffelCOM</a></li>
									<li><a href="#">EiffelNet</a></li>
								</ul>
							</nav>
						]"
					create l_content_block.make (a_block_id, Void, s, Void)
					a_execution.add_block (l_content_block, "sidebar_second")
				elseif a_block_id.is_case_insensitive_equal_general ("eiffel_copyright") then
					s := "[
							<ul class="copyrights">
								<li><a href="#">Eiffel Language Community</a></li>
								<li>&copy; Copyright 2014</li>
								<li><a href="#">Privacy Policy</a></li>
								<li><a href="#">Terms of use</a></li>
							</ul>
						]"
					create l_content_block.make (a_block_id, Void, s, Void)
					a_execution.add_block (l_content_block, "footer")
				else
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

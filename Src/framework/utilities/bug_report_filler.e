indexing
	description: "[
					Filler which can fill a bug report on http://support.eiffel.com
																							]"
	status: "See notice at end of class."
	legal: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	BUG_REPORT_FILLER

create
	make

feature {NONE} -- Initialization

	make is
			-- Creation method
		do
			create login_failed_actions
			create curl_failed_actions
		end

feature -- Command

	fill_report (a_data: BUG_REPORT_DATA) is
			-- Fill a bug report with `a_data'.
		require
			not_void: a_data /= Void
			ready: a_data.is_all_data_filled
		local
			l_html: STRING
			l_excep: EXCEPTIONS
			l_retry: BOOLEAN
			l_stop_retry: BOOLEAN
		do
			if is_curl_library_exists then
				if not l_retry then
					init

					data := a_data
					l_html := login
					if is_login_successed (l_html) then
						fill_bug_report (html_of_submit_page)
					else
						login_failed_actions.call (Void)
					end

					clean_up
				else
					if not l_stop_retry then
						l_stop_retry := True
						clean_up
						create l_excep
						curl_failed_actions.call (["cURL error: " + last_result.out])
					else
						curl_failed_actions.call (["cURL error: unknown"])
					end
				end
			else
				curl_failed_actions.call (["cURL dynamic link library not exists."])
			end
		rescue
			l_retry := True
			retry
		end

feature -- Query

	is_curl_library_exists: BOOLEAN is
			-- If cURL dll/so files exits?
		do
			Result := curl.is_dynamic_library_exists
		end

	data: BUG_REPORT_DATA
			-- Data for bug report.

	login_failed_actions: ACTION_SEQUENCE [TUPLE []]
			-- Actions performed just after login failed.

	curl_failed_actions: ACTION_SEQUENCE [TUPLE [a_tag: STRING]]
			-- Actions performed just after curl_easy.perform failed.

	last_result: INTEGER
			-- Last cURL easy perform result.

feature {NONE} -- Implementation

	login: STRING is
			-- Login http://support.eiffel.com
			-- Result is return HTML
		require
			not_void: data /= Void
			ready: data.is_all_data_filled
		local
			l_whole_file: CURL_STRING
			l_view_state_value, l_event_validation: STRING
			l_post_string: CURL_STRING
		do
			create l_whole_file.make_empty

			curl_easy.setopt_string (curl_handle, {CURL_OPT_CONSTANTS}.curlopt_url, "https://www2.eiffel.com/login/secure/logon.aspx")
			curl_easy.setopt_curl_string (curl_handle, {CURL_OPT_CONSTANTS}.curlopt_writedata, l_whole_file)

			easy_perform

			l_view_state_value := find_view_state (l_whole_file.string.as_string_8)
			l_event_validation := find_event_validation (l_whole_file.string.as_string_8)

			url_encoding (l_view_state_value)
			url_encoding (l_event_validation)

			create l_whole_file.make_empty
			--curl_set_header_opt (curl_handle)

			create l_post_string.make_from_string (post_string_for_login (l_view_state_value, l_event_validation, data.username.as_string_8, data.password.as_string_8))

			curl_easy.setopt_string (curl_handle, {CURL_OPT_CONSTANTS}.curlopt_url, "https://www2.eiffel.com/login/secure/logon.aspx")
 			curl_easy.setopt_integer (curl_handle, {CURL_OPT_CONSTANTS}.curlopt_post, 1)
 			curl_easy.setopt_string (curl_handle, {CURL_OPT_CONSTANTS}.curlopt_postfields, l_post_string)
 			curl_easy.setopt_curl_string (curl_handle, {CURL_OPT_CONSTANTS}.curlopt_writedata, l_whole_file)
 			curl_easy.setopt_string (curl_handle, {CURL_OPT_CONSTANTS}.curlopt_cookie, "____Pagemain_div__ToggleState=1")

			easy_perform
			Result := l_whole_file.string.as_string_8
		end

	fill_bug_report (a_last_html: STRING_GENERAL) is
			-- Filling a bug report after login.
		require
			not_void: a_last_html /= Void
			login:
		local
			l_view_state, l_validation: STRING
			l_final_url_location: STRING
			l_last_html, l_result_string: STRING_GENERAL
		do
			-- Post for preview
			l_last_html := post_for_preview (a_last_html)

			-- Get HTML of confirm page, so we can get VIEWSTAE and EVENTVALIDATION value for next step.
			l_last_html := html_of_confirm_page (l_last_html)

			-- Final submit
			l_final_url_location := find_location (l_last_html.as_string_8)
			-- We need this page to find the latest VIEWSTATE and EVENTVALIDATION value.
			l_result_string := html_of_final_submit_page ("https://www2.eiffel.com" + l_final_url_location)

			l_view_state := find_view_state (l_result_string.as_string_8)
			l_validation := find_event_validation (l_result_string.as_string_8)

			url_encoding (l_view_state)
			url_encoding (l_validation)

			final_submit ("https://www2.eiffel.com" + l_final_url_location, post_string_for_final_submit (l_view_state, l_validation), "Referer: " + "https://www2.eiffel.com" + l_final_url_location)
		end

	post_for_preview (a_last_html: STRING_GENERAL): STRING_GENERAL is
			-- Post bug report data, then we can go to the bug report preview page.
		require
			exists: curl_handle /= default_pointer
			not_void: a_last_html /= Void
		local
			l_view_state, l_validation: STRING
			l_event_target: STRING
			l_form: CURL_FORM
			l_memory: CURL_STRING
		do
			l_view_state := (find_view_state (a_last_html.as_string_8))
			l_validation := (find_event_validation (a_last_html.as_string_8))

			l_event_target := ("ctl00$ctl00$default_main_content$main_content$category_list")
			l_form := form_for_bug_report (l_view_state, l_validation, l_event_target)
			create l_memory.make_empty

			setopt_with_form (l_memory, l_form)

			easy_perform

			Result := l_memory.string
		end

	 final_submit (a_target_url: STRING; a_post_url_string: STRING; a_refer_header: STRING) is
	 		-- Final step of submitting a bug report.
	 	require
	 		exists: curl_handle /= default_pointer
	 		not_void: a_target_url /= Void
	 		not_void: a_post_url_string /= Void
	 		not_void: a_refer_header /= Void
	 	local
	 		l_data: CURL_STRING
		do
			create l_data.make_empty
			curl_easy.setopt_curl_string (curl_handle, {CURL_OPT_CONSTANTS}.curlopt_writedata, l_data)
			curl_easy.setopt_string (curl_handle, {CURL_OPT_CONSTANTS}.curlopt_url, a_target_url)
			curl_easy.setopt_integer (curl_handle, {CURL_OPT_CONSTANTS}.curlopt_post, 1)
			curl_easy.setopt_string (curl_handle, {CURL_OPT_CONSTANTS}.curlopt_postfields, a_post_url_string)

			easy_perform
	 	end

feature {NONE} -- Html contents

	html_of_submit_page: STRING_GENERAL is
			-- Web content of bug report page.
		require
			not_void: curl_handle /= default_pointer
		local
			l_data: CURL_STRING
		do
			curl_easy.setopt_string (curl_handle, {CURL_OPT_CONSTANTS}.curlopt_url, "https://www2.eiffel.com/support/protected/problem_report_form.aspx")
			curl_easy.setopt_integer (curl_handle, {CURL_OPT_CONSTANTS}.curlopt_post, 0)

			create l_data.make_empty
			curl_easy.setopt_curl_string (curl_handle, {CURL_OPT_CONSTANTS}.curlopt_writedata, l_data)

			easy_perform
			Result := l_data.string
		end

	html_of_confirm_page (a_last_html: STRING_GENERAL): STRING_GENERAL is
			-- HTML of bug report submit confirm page.
		require
			not_void: a_last_html /= Void
			not_void: curl_handle /= default_pointer
		local
			l_view_state, l_validation: STRING
			l_event_target: STRING
			l_result_string: STRING
			l_form: CURL_FORM
			l_result_html: CURL_STRING
		do
			l_result_string := a_last_html.as_string_8

			l_view_state := (find_view_state (l_result_string))
			l_validation := (find_event_validation (l_result_string))
			l_event_target := ""

			l_form := form_for_bug_report (l_view_state, l_validation, l_event_target)

			create l_result_html.make_empty
			setopt_with_form (l_result_html, l_form)

			easy_perform

			Result := l_result_html.string
		end

	html_of_final_submit_page (a_final_sutmit_page: STRING): STRING_GENERAL is
			-- HTML content of final bug report submit confirm page.
		require
			not_void: curl_handle /= default_pointer
			not_void: a_final_sutmit_page /= Void
		local
			l_result_html: CURL_STRING
		do
			create l_result_html.make_empty

			curl_easy.setopt_integer (curl_handle, {CURL_OPT_CONSTANTS}.curlopt_post, 0)
			curl_easy.setopt_string (curl_handle, {CURL_OPT_CONSTANTS}.curlopt_url, a_final_sutmit_page)
			curl_easy.setopt_curl_string (curl_handle, {CURL_OPT_CONSTANTS}.curlopt_writedata, l_result_html)

			easy_perform

			Result := l_result_html.string
		end

feature {NONE} -- Finding in html

	find_view_state (a_string: STRING): STRING is
			-- Find __VIEWSTATE value in `a_string'.
		require
			not_void: a_string /= Void
		local
			l_matcher: RX_PCRE_MATCHER
		do
			create l_matcher.make
			l_matcher.compile ("<input\s+type=%"hidden%"\s+name=%"__VIEWSTATE%"\s+id=%"__VIEWSTATE%"\s+value=%"(.*?)%"\s/>")
			l_matcher.match (a_string)

			if l_matcher.has_matched then
				Result := l_matcher.captured_substring (1)
				l_matcher.next_match
				check no_more: not l_matcher.has_matched end
			end
		end

	find_location (a_string: STRING): STRING is
			-- Find href in `a_string'.
		require
			not_void: a_string /= Void
		local
			l_matcher: RX_PCRE_MATCHER
		do
			create l_matcher.make
			l_matcher.compile ("<a\shref=%"(.*?)%">here")
			l_matcher.match (a_string)

			if l_matcher.has_matched then
				Result := l_matcher.captured_substring (1)
				l_matcher.next_match
				check no_more: not l_matcher.has_matched end
			end
		end

	find_event_validation (a_string: STRING): STRING is
			-- Find EVENT_VALIDATION value in `a_string'.
		require
			not_void: a_string /= Void
		local
			l_matcher: RX_PCRE_MATCHER
		do
			create l_matcher.make
			l_matcher.compile ("<input\s+type=%"hidden%"\s+name=%"__EVENTVALIDATION%"\s+id=%"__EVENTVALIDATION%"\s+value=%"(.*?)%"\s/>")
			l_matcher.match (a_string)

			if l_matcher.has_matched then
				Result := l_matcher.captured_substring (1)
				l_matcher.next_match
				check no_more: not l_matcher.has_matched end
			end
		end

	is_login_successed (a_html: STRING): BOOLEAN is
			-- Find if account information redirection codes exist in return HTML
		require
			not_void: a_html /= Void
		local
			l_matcher: RX_PCRE_MATCHER
		do
			create l_matcher.make
			l_matcher.compile ("Object\smoved\sto\s<a\shref=%"https://www2.eiffel.com/login/secure/protected/account_info.aspx%">here")
			l_matcher.match (a_html)

			Result := l_matcher.has_matched
		end

feature {NONE} -- cURL level implementations

	init is
			-- Prepare cURL environment.
		local
			l_file: RAW_FILE
		do
			curl.global_init
			curl_handle := curl_easy.init
			debug ("cURL")
				curl_easy.set_debug_function (curl_handle)
				curl_easy.setopt_integer (curl_handle, {CURL_OPT_CONSTANTS}.curlopt_verbose, 1)
			end
			curl_easy.set_write_function (curl_handle)
			curl_easy.setopt_string (curl_handle, {CURL_OPT_CONSTANTS}.curlopt_cookiefile, "cookie.txt")
			curl_easy.setopt_integer (curl_handle, {CURL_OPT_CONSTANTS}.curlopt_ssl_verifypeer, 0)

			create l_file.make_create_read_write (temp_file)
			l_file.close
		ensure
			exists: curl_handle /= default_pointer
		end

	easy_perform is
			-- Perform a cURL action.
		require
			not_void: curl_handle /= default_pointer
		do
			last_result := curl_easy.perform (curl_handle)
			if last_result /= {CURL_CODES}.curle_ok then
				(create {EXCEPTIONS}).raise ("cURL error: " + last_result.out)
			end
		end

	 setopt_with_form (a_data: CURL_STRING; a_formpost: CURL_FORM) is
	 		-- Set options with `a_formpost'.
	 	require
	 		not_void_and_exists: a_formpost /= Void and then a_formpost.is_exists
	 		not_void: curl_handle /= default_pointer
		do
			curl_easy.setopt_curl_string (curl_handle, {CURL_OPT_CONSTANTS}.curlopt_writedata, a_data)
			curl_easy.setopt_string (curl_handle, {CURL_OPT_CONSTANTS}.curlopt_cookie, "____Pagemain_div__ToggleState=1; ____Pagemain_id__ToggleState=1")
			curl_easy.setopt_string (curl_handle, {CURL_OPT_CONSTANTS}.curlopt_url, "https://www2.eiffel.com/support/protected/problem_report_form.aspx")
			curl_easy.setopt_form (curl_handle, {CURL_OPT_CONSTANTS}.curlopt_httppost, a_formpost)
		end

	form_for_bug_report (a_view_state_value: STRING; a_event_validation_value: STRING; a_event_target: STRING): CURL_FORM is
			-- Create a form for bug report submit.
		require
			not_void: a_view_state_value /= Void
			not_void: a_event_validation_value /= Void
			not_void: a_event_target /= Void
		local
			l_last_form: CURL_FORM
		do
			create Result.make
			create l_last_form.make
			curl.formadd_string_string (Result, l_last_form, {CURL_FORM_CONSTANTS}.curlform_copyname, "__EVENTTARGET", {CURL_FORM_CONSTANTS}.curlform_copycontents, "a_event_target", {CURL_FORM_CONSTANTS}.curlform_end)
			curl.formadd_string_string (Result, l_last_form, {CURL_FORM_CONSTANTS}.curlform_copyname, "__EVENTARGUMENT", {CURL_FORM_CONSTANTS}.curlform_copycontents, "", {CURL_FORM_CONSTANTS}.curlform_end)
			curl.formadd_string_string (Result, l_last_form, {CURL_FORM_CONSTANTS}.curlform_copyname, "__LASTFOCUS", {CURL_FORM_CONSTANTS}.curlform_copycontents, "", {CURL_FORM_CONSTANTS}.curlform_end)
			curl.formadd_string_string (Result, l_last_form, {CURL_FORM_CONSTANTS}.curlform_copyname, "__VIEWSTATE", {CURL_FORM_CONSTANTS}.curlform_copycontents, a_view_state_value, {CURL_FORM_CONSTANTS}.curlform_end)
			curl.formadd_string_string (Result, l_last_form, {CURL_FORM_CONSTANTS}.curlform_copyname, "ctl00$ctl00$default_main_content$main_content$category_list", {CURL_FORM_CONSTANTS}.curlform_copycontents, "24", {CURL_FORM_CONSTANTS}.curlform_end)
			curl.formadd_string_string (Result, l_last_form, {CURL_FORM_CONSTANTS}.curlform_copyname, "ctl00$ctl00$default_main_content$main_content$severity_list", {CURL_FORM_CONSTANTS}.curlform_copycontents, "3", {CURL_FORM_CONSTANTS}.curlform_end)
			curl.formadd_string_string (Result, l_last_form, {CURL_FORM_CONSTANTS}.curlform_copyname, "ctl00$ctl00$default_main_content$main_content$class_list", {CURL_FORM_CONSTANTS}.curlform_copycontents, "1", {CURL_FORM_CONSTANTS}.curlform_end)
			curl.formadd_string_string (Result, l_last_form, {CURL_FORM_CONSTANTS}.curlform_copyname, "ctl00$ctl00$default_main_content$main_content$priority_list", {CURL_FORM_CONSTANTS}.curlform_copycontents, "3", {CURL_FORM_CONSTANTS}.curlform_end)
			curl.formadd_string_string (Result, l_last_form, {CURL_FORM_CONSTANTS}.curlform_copyname, "ctl00$ctl00$default_main_content$main_content$release_text", {CURL_FORM_CONSTANTS}.curlform_copycontents, data.release, {CURL_FORM_CONSTANTS}.curlform_end)
			curl.formadd_string_string (Result, l_last_form, {CURL_FORM_CONSTANTS}.curlform_copyname, "ctl00$ctl00$default_main_content$main_content$confidential_list", {CURL_FORM_CONSTANTS}.curlform_copycontents, "True", {CURL_FORM_CONSTANTS}.curlform_end)
			curl.formadd_string_string (Result, l_last_form, {CURL_FORM_CONSTANTS}.curlform_copyname, "ctl00$ctl00$default_main_content$main_content$environment_text", {CURL_FORM_CONSTANTS}.curlform_copycontents, data.environment, {CURL_FORM_CONSTANTS}.curlform_end)
			curl.formadd_string_string (Result, l_last_form, {CURL_FORM_CONSTANTS}.curlform_copyname, "ctl00$ctl00$default_main_content$main_content$synopsis_text", {CURL_FORM_CONSTANTS}.curlform_copycontents, data.synopsis, {CURL_FORM_CONSTANTS}.curlform_end)
			curl.formadd_string_string (Result, l_last_form, {CURL_FORM_CONSTANTS}.curlform_copyname, "ctl00$ctl00$default_main_content$main_content$attachments_table$uploaded_file", {CURL_FORM_CONSTANTS}.curlform_file, temp_file, {CURL_FORM_CONSTANTS}.curlform_end)
			curl.formadd_string_string (Result, l_last_form, {CURL_FORM_CONSTANTS}.curlform_copyname, "ctl00$ctl00$default_main_content$main_content$description_text", {CURL_FORM_CONSTANTS}.curlform_copycontents, data.description, {CURL_FORM_CONSTANTS}.curlform_end)
			curl.formadd_string_string (Result, l_last_form, {CURL_FORM_CONSTANTS}.curlform_copyname, "ctl00$ctl00$default_main_content$main_content$to_reproduce_text", {CURL_FORM_CONSTANTS}.curlform_copycontents, "", {CURL_FORM_CONSTANTS}.curlform_end)
			curl.formadd_string_string (Result, l_last_form, {CURL_FORM_CONSTANTS}.curlform_copyname, "ctl00$ctl00$default_main_content$main_content$submit_button", {CURL_FORM_CONSTANTS}.curlform_copycontents, "Preview", {CURL_FORM_CONSTANTS}.curlform_end)
			curl.formadd_string_string (Result, l_last_form, {CURL_FORM_CONSTANTS}.curlform_copyname, "__EVENTVALIDATION", {CURL_FORM_CONSTANTS}.curlform_copycontents, a_event_validation_value, {CURL_FORM_CONSTANTS}.curlform_end)
		ensure
			exist: Result /= Void and then Result.is_exists
		end

	post_string_for_login (a_view_state, a_event_validation: STRING; a_username, a_password: STRING): STRING is
			-- Create post string for login page.
		require
			not_void: a_view_state /= Void
			not_void: a_event_validation /= Void
			not_void: a_username /= Void
			not_void: a_password /= Void
		do
			create Result.make_empty
			Result.append ("__EVENTTARGET=")
			Result.append ("&")
			Result.append ("__EVENTARGUMENT=")
			Result.append ("&")
			Result.append ("__VIEWSTATE=" + a_view_state)
			Result.append ("&")
			Result.append ("ctl00%%24ctl00%%24default_main_content%%24main_content%%24display_username=")
			Result.append ("&")
			Result.append ("ctl00%%24ctl00%%24default_main_content%%24main_content%%24register_username=" + a_username)
			Result.append ("&")
			Result.append ("ctl00%%24ctl00%%24default_main_content%%24main_content%%24display_password=")
			Result.append ("&")
			Result.append ("ctl00%%24ctl00%%24default_main_content%%24main_content%%24register_password=" + a_password)
			Result.append ("&")
			Result.append ("ctl00%%24ctl00%%24default_main_content%%24main_content%%24login_button=Login")
			Result.append ("&")
			Result.append ("__EVENTVALIDATION=" + a_event_validation)
		ensure
			not_void: Result /= Void
		end

	post_string_for_final_submit (a_view_state, a_event_validation: STRING): STRING is
			-- Post strings for final bug report submit.
		require
			not_void: a_view_state /= Void
			not_viod: a_event_validation /= Void
		do
			create Result.make_empty
			Result.append ("__EVENTTARGET=ctl00%%24ctl00%%24default_main_content%%24main_content%%24SubmitLink")
			Result.append ("&")
			Result.append ("__EVENTARGUMENT=")
			Result.append ("&")
			Result.append ("__VIEWSTATE=" + a_view_state)
			Result.append ("&")
			Result.append ("__EVENTVALIDATION=" + a_event_validation)
		ensure
			not_void: Result /= Void
		end

	clean_up is
			-- Clean up resources.
		local
			l_file: RAW_FILE
		do
			if curl_handle /= default_pointer  then
				curl_easy.cleanup (curl_handle)
				curl_handle := default_pointer
			end

			create l_file.make_open_read (temp_file)
			if l_file.exists then
				l_file.close
				l_file.delete
			end
		ensure
			cleared: curl_handle = default_pointer
			file_deleted:
		end

	url_encoding (a_string: STRING) is
			-- Simple URL encoding.
			-- Only replace / and + for the moment.
		require
			not_void: a_string /= Void
		do
			a_string.replace_substring_all ("/", "%%2F")
			a_string.replace_substring_all ("+", "%%2B")
		ensure
			replaced: not a_string.has_substring ("/")
			replaced: not a_string.has_substring ("+")
		end

feature {NONE} -- Implementation attributes

	curl: CURL_EXTERNALS is
			-- cURL externals.
		once
			create Result
		ensure
			not_void: Result /= Void
		end

	curl_easy: CURL_EASY_EXTERNALS is
			-- cURL easy externals.
		once
			create Result
		ensure
			not_void: Result /= Void
		end

	temp_file: STRING is "bug_report_tmp.txt"
			-- Temp file name.

	curl_handle: POINTER
			-- cURL C handle.

invariant
	not_void: login_failed_actions /= Void
	not_void: curl_failed_actions /= Void

indexing
	copyright: "Copyright (c) 1984-2007, Eiffel Software"
	license:   "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end

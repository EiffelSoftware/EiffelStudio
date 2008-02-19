indexing
	description: "[
		Communicates with the support site to permit the submission of a bug report.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision $"

class
	COMM_SUPPORT_BUG_REPORTER

inherit
	COMM_SUPPORT_LOGIN

create
	make

feature -- Query

	bug_reporting_url (a_relative_url: STRING; a_secure: BOOLEAN): STRING
			-- Retrieve full URL for support site
			--
			-- `a_relative_url': Relative url to the support site
			-- `a_secure': Indicates if a suecure connection should be used.
			-- `Result': An absolute URL to the requested page
		require
			not_a_relative_url_is_empty: a_relative_url /= Void implies not a_relative_url.is_empty
		do
			if a_relative_url /= Void then
				Result := support_url (once "support/" + a_relative_url, a_secure)
			else
				Result := support_url (once "support/", a_secure)
			end
		ensure
			result_attached: Result /= Void
			not_result_is_empty: not Result.is_empty
		end

feature -- Basic operations

	report_bug (a_report: COMM_SUPPORT_BUG_REPORT)
			-- Reports a bug
			-- Note: A login must be performed before attempting to submit a report.
			--
			-- `a_report': Report to submit to the public bug report system.
		require
			is_support_accessible: is_support_accessible
			is_logged_in: is_logged_in
			a_report_attached: a_report /= Void
		do
			fill_bug_report (submit_page_content, a_report)
		end

feature {NONE} -- Basic operations

	fill_bug_report (a_last_html: STRING_GENERAL; a_report: COMM_SUPPORT_BUG_REPORT) is
			-- Filling a bug report after login.
		require
			is_support_accessible: is_support_accessible
			a_last_html_attached: a_last_html /= Void
		local
			l_view_state: STRING_GENERAL
			l_validation: STRING_GENERAL
			l_last_html: STRING_GENERAL
			l_result_string: STRING_GENERAL
			l_final_url_location: like find_location
		do
				-- Post bug report and retrieve preview page
			l_last_html := perform_preview (a_last_html, a_report)

				-- Get HTML of confirm page, so we can get VIEWSTAE and EVENTVALIDATION value for next step.
			l_last_html := confirm_sumbit_page_content (l_last_html, a_report)

				-- Final submit
			l_final_url_location := find_location (l_last_html)

				-- We need this page to find the latest VIEWSTATE and EVENTVALIDATION value.
			l_result_string := final_submit_page_content (support_url (l_final_url_location, True))

			l_view_state := find_view_state (l_result_string)
			l_validation := find_event_validation (l_result_string)

			l_view_state := encoding_url (l_view_state.as_string_8)
			l_validation := encoding_url (l_validation.as_string_8)

			perfom_final_submit (support_url (l_final_url_location, True), post_string_for_final_submit (l_view_state, l_validation))--, "Referer: " + "https://www2.eiffel.com" + l_final_url_location)
		end

	perform_preview (a_last_html: STRING_GENERAL; a_report: COMM_SUPPORT_BUG_REPORT): STRING_GENERAL is
			-- Post bug report data, then we can go to the bug report preview page.
		require
			is_support_accessible: is_support_accessible
			a_last_html_attached: a_last_html /= Void
			a_report_attaced: a_report /= Void
		local
			l_view_state: STRING_GENERAL
			l_validation: STRING_GENERAL
			l_form: CURL_FORM
			l_memory: CURL_STRING
		do
			l_view_state := find_view_state (a_last_html)
			l_validation := find_event_validation (a_last_html)

			if l_view_state /= Void and l_validation /= Void then
				l_form := form_for_bug_report (l_view_state, l_validation, "ctl00$ctl00$default_main_content$main_content$category_list", a_report)
				create l_memory.make_empty
				setopt_with_form (l_memory, l_form)
				perform

				Result := l_memory.string
				if Result = Void then
					create {STRING_32} Result.make_empty
				end
			else
				(create {EXCEPTIONS}).raise ("Connection error: " + a_last_html.as_string_8.out)
			end
		ensure
			result_attached: Result /= Void
		end

	 perfom_final_submit (a_target_url: STRING_GENERAL; a_post_url_string: STRING_GENERAL) is
	 		-- Performs final step of submitting a bug report.
	 	require
			is_support_accessible: is_support_accessible
	 		a_target_url_attached: a_target_url /= Void
	 		not_a_target_url_is_empty: not a_target_url.is_empty
	 		a_post_url_string_attached: a_post_url_string /= Void
	 		not_a_post_url_string_is_empty: not a_post_url_string.is_empty
	 	local
	 		l_curl: like curl
	 		l_data: CURL_STRING
		do
			l_curl := curl

			create l_data.make_empty
			l_curl.setopt_curl_string (curl_hnd, {CURL_OPT_CONSTANTS}.curlopt_writedata, l_data)
			l_curl.setopt_string (curl_hnd, {CURL_OPT_CONSTANTS}.curlopt_url, a_target_url)
			l_curl.setopt_integer (curl_hnd, {CURL_OPT_CONSTANTS}.curlopt_post, 1)
			l_curl.setopt_string (curl_hnd, {CURL_OPT_CONSTANTS}.curlopt_postfields, a_post_url_string)
			perform
	 	end

feature {NONE} -- Html contents

	submit_page_content: STRING_GENERAL
			-- Raw HTML of bug report submit page
		require
			is_support_accessible: is_support_accessible
		local
			l_curl: like curl
			l_data: CURL_STRING
		do
			l_curl := curl
			l_curl.setopt_string (curl_hnd, {CURL_OPT_CONSTANTS}.curlopt_url, bug_reporting_url ("/protected/problem_report_form.aspx", True))
			l_curl.setopt_integer (curl_hnd, {CURL_OPT_CONSTANTS}.curlopt_post, 0)

			create l_data.make_empty
			curl.setopt_curl_string (curl_hnd, {CURL_OPT_CONSTANTS}.curlopt_writedata, l_data)
			perform

			Result := l_data.string
			if Result = Void then
				create {STRING_32} Result.make_empty
			end
		ensure
			result_attached: Result /= Void
		end

	confirm_sumbit_page_content (a_last_html: STRING_GENERAL; a_report: COMM_SUPPORT_BUG_REPORT): STRING_GENERAL
			-- Raw HTML of bug report submit/confirm page
		require
			is_support_accessible: is_support_accessible
			a_last_html_attached: a_last_html /= Void
		local
			l_view_state: STRING_GENERAL
			l_validation: STRING_GENERAL
			l_result_string: STRING_GENERAL
			l_form: CURL_FORM
			l_result_html: CURL_STRING
		do
			l_result_string := a_last_html.as_string_8

			l_view_state := find_view_state (l_result_string)
			l_validation := find_event_validation (l_result_string)

			l_form := form_for_bug_report (l_view_state, l_validation, "", a_report)

			create l_result_html.make_empty
			setopt_with_form (l_result_html, l_form)

			perform

			Result := l_result_html.string
		end

	final_submit_page_content (a_final_sutmit_page: STRING): STRING_GENERAL is
			-- Raw HTML content of final bug report submit confirm page.
		require
			not_void: curl_hnd /= default_pointer
			not_void: a_final_sutmit_page /= Void
		local
			l_result_html: CURL_STRING
		do
			create l_result_html.make_empty

			curl.setopt_integer (curl_hnd, {CURL_OPT_CONSTANTS}.curlopt_post, 0)
			curl.setopt_string (curl_hnd, {CURL_OPT_CONSTANTS}.curlopt_url, a_final_sutmit_page)
			curl.setopt_curl_string (curl_hnd, {CURL_OPT_CONSTANTS}.curlopt_writedata, l_result_html)

			perform

			Result := l_result_html.string
		end

feature {NONE}

	 setopt_with_form (a_data: CURL_STRING; a_formpost: CURL_FORM) is
	 		-- Set options with `a_formpost'.
	 	require
	 		not_void_and_exists: a_formpost /= Void and then a_formpost.is_exists
	 		not_void: curl_hnd /= default_pointer
		do
			curl.setopt_curl_string (curl_hnd, {CURL_OPT_CONSTANTS}.curlopt_writedata, a_data)
			curl.setopt_string (curl_hnd, {CURL_OPT_CONSTANTS}.curlopt_cookie, "____Pagemain_div__ToggleState=1; ____Pagemain_id__ToggleState=1")
			curl.setopt_string (curl_hnd, {CURL_OPT_CONSTANTS}.curlopt_url, "https://www2.eiffel.com/support/protected/problem_report_form.aspx")
			curl.setopt_form (curl_hnd, {CURL_OPT_CONSTANTS}.curlopt_httppost, a_formpost)
		end

	form_for_bug_report (a_view_state_value: STRING_GENERAL; a_event_validation_value: STRING_GENERAL; a_event_target: STRING_GENERAL; a_report: COMM_SUPPORT_BUG_REPORT): CURL_FORM is
			-- Create a form for bug report submit.
		require
			not_void: a_view_state_value /= Void
			not_void: a_event_validation_value /= Void
			not_void: a_event_target /= Void
			a_report_attached: a_report/= Void
		local
			l_curl: CURL_EXTERNALS
			l_last_form: CURL_FORM
		do
			create Result.make
			create l_last_form.make
			create l_curl
			l_curl.formadd_string_string (Result, l_last_form, {CURL_FORM_CONSTANTS}.curlform_copyname, "__EVENTTARGET", {CURL_FORM_CONSTANTS}.curlform_copycontents, "a_event_target", {CURL_FORM_CONSTANTS}.curlform_end)
			l_curl.formadd_string_string (Result, l_last_form, {CURL_FORM_CONSTANTS}.curlform_copyname, "__EVENTARGUMENT", {CURL_FORM_CONSTANTS}.curlform_copycontents, "", {CURL_FORM_CONSTANTS}.curlform_end)
			l_curl.formadd_string_string (Result, l_last_form, {CURL_FORM_CONSTANTS}.curlform_copyname, "__LASTFOCUS", {CURL_FORM_CONSTANTS}.curlform_copycontents, "", {CURL_FORM_CONSTANTS}.curlform_end)
			l_curl.formadd_string_string (Result, l_last_form, {CURL_FORM_CONSTANTS}.curlform_copyname, "__VIEWSTATE", {CURL_FORM_CONSTANTS}.curlform_copycontents, a_view_state_value.as_string_8, {CURL_FORM_CONSTANTS}.curlform_end)
			l_curl.formadd_string_string (Result, l_last_form, {CURL_FORM_CONSTANTS}.curlform_copyname, "ctl00$ctl00$default_main_content$main_content$category_list", {CURL_FORM_CONSTANTS}.curlform_copycontents, "15", {CURL_FORM_CONSTANTS}.curlform_end)
			l_curl.formadd_string_string (Result, l_last_form, {CURL_FORM_CONSTANTS}.curlform_copyname, "ctl00$ctl00$default_main_content$main_content$severity_list", {CURL_FORM_CONSTANTS}.curlform_copycontents, "1", {CURL_FORM_CONSTANTS}.curlform_end)
			l_curl.formadd_string_string (Result, l_last_form, {CURL_FORM_CONSTANTS}.curlform_copyname, "ctl00$ctl00$default_main_content$main_content$class_list", {CURL_FORM_CONSTANTS}.curlform_copycontents, "1", {CURL_FORM_CONSTANTS}.curlform_end)
			l_curl.formadd_string_string (Result, l_last_form, {CURL_FORM_CONSTANTS}.curlform_copyname, "ctl00$ctl00$default_main_content$main_content$priority_list", {CURL_FORM_CONSTANTS}.curlform_copycontents, "2", {CURL_FORM_CONSTANTS}.curlform_end)
			l_curl.formadd_string_string (Result, l_last_form, {CURL_FORM_CONSTANTS}.curlform_copyname, "ctl00$ctl00$default_main_content$main_content$release_text", {CURL_FORM_CONSTANTS}.curlform_copycontents, a_report.release.as_string_8, {CURL_FORM_CONSTANTS}.curlform_end)
			l_curl.formadd_string_string (Result, l_last_form, {CURL_FORM_CONSTANTS}.curlform_copyname, "ctl00$ctl00$default_main_content$main_content$confidential_list", {CURL_FORM_CONSTANTS}.curlform_copycontents, a_report.confidential.out.as_string_8, {CURL_FORM_CONSTANTS}.curlform_end)
			l_curl.formadd_string_string (Result, l_last_form, {CURL_FORM_CONSTANTS}.curlform_copyname, "ctl00$ctl00$default_main_content$main_content$environment_text", {CURL_FORM_CONSTANTS}.curlform_copycontents, a_report.environment.as_string_8, {CURL_FORM_CONSTANTS}.curlform_end)
			l_curl.formadd_string_string (Result, l_last_form, {CURL_FORM_CONSTANTS}.curlform_copyname, "ctl00$ctl00$default_main_content$main_content$synopsis_text", {CURL_FORM_CONSTANTS}.curlform_copycontents, a_report.synopsis.as_string_8, {CURL_FORM_CONSTANTS}.curlform_end)
			--l_curl.formadd_string_string (Result, l_last_form, {CURL_FORM_CONSTANTS}.curlform_copyname, "ctl00$ctl00$default_main_content$main_content$attachments_table$uploaded_file", {CURL_FORM_CONSTANTS}.curlform_file, "", {CURL_FORM_CONSTANTS}.curlform_end)
			l_curl.formadd_string_string (Result, l_last_form, {CURL_FORM_CONSTANTS}.curlform_copyname, "ctl00$ctl00$default_main_content$main_content$description_text", {CURL_FORM_CONSTANTS}.curlform_copycontents, a_report.description.as_string_8, {CURL_FORM_CONSTANTS}.curlform_end)
			l_curl.formadd_string_string (Result, l_last_form, {CURL_FORM_CONSTANTS}.curlform_copyname, "ctl00$ctl00$default_main_content$main_content$to_reproduce_text", {CURL_FORM_CONSTANTS}.curlform_copycontents, "", {CURL_FORM_CONSTANTS}.curlform_end)
			l_curl.formadd_string_string (Result, l_last_form, {CURL_FORM_CONSTANTS}.curlform_copyname, "ctl00$ctl00$default_main_content$main_content$submit_button", {CURL_FORM_CONSTANTS}.curlform_copycontents, "Preview", {CURL_FORM_CONSTANTS}.curlform_end)
			l_curl.formadd_string_string (Result, l_last_form, {CURL_FORM_CONSTANTS}.curlform_copyname, "__EVENTVALIDATION", {CURL_FORM_CONSTANTS}.curlform_copycontents, a_event_validation_value.as_string_8, {CURL_FORM_CONSTANTS}.curlform_end)
		ensure
			exist: Result /= Void and then Result.is_exists
		end

	post_string_for_final_submit (a_view_state: STRING_GENERAL a_event_validation: STRING_GENERAL): STRING_GENERAL
			-- Post strings for final bug report submit.
		require
			a_view_state_attached: a_view_state /= Void
			a_event_validation_attached: a_event_validation /= Void
		local
			l_result: STRING_32
		do
			create l_result.make (256)
			l_result.append ("__EVENTTARGET=ctl00%%24ctl00%%24default_main_content%%24main_content%%24SubmitLink")
			l_result.append_character ('&')
			l_result.append ("__EVENTARGUMENT=")
			l_result.append_character ('&')
			l_result.append ("__VIEWSTATE=" + a_view_state.as_string_32)
			l_result.append_character ('&')
			l_result.append ("__EVENTVALIDATION=" + a_event_validation.as_string_32)
			Result := l_result
		ensure
			not_void: Result /= Void
		end

;indexing
	copyright:	"Copyright (c) 1984-2007, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end

note
	description: "Concreate class to converts data into the html representation."
	date: "$Date$"
	revision: "$Revision$"

class
	ESA_HTML_REPRESENTATION_HANDLER

inherit

	ESA_REPRESENTATION_HANDLER

	REFACTORING_HELPER

create
	make

feature -- View

	home_page (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Home page representation
		local
			l_hp: HTML_HOME
		do

			if attached req.http_host as l_host then
				create l_hp.make (absolute_host (req, ""), current_user_name (req))
				if attached l_hp.representation as l_home_page then
					new_response_get (req, res, l_home_page)
				end
			end
		end

	home_page_redirect (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Home redirect
		do
			if attached req.http_host as l_host then
				compute_response_redirect (req, res, absolute_host (req, ""))
			end
		end

	problem_report (req: WSF_REQUEST; res: WSF_RESPONSE; a_report: REPORT)
			-- <Precursor>
		local
			l_hp: HTML_REPORT_DETAIL
		do
			if attached req.http_host as l_host then
				create l_hp.make (absolute_host (req, ""), a_report, current_user_name (req))
				if attached l_hp.representation as l_home_page then
					new_response_get (req, res, l_home_page)
				end
			end
		end

	problem_reports_guest (req: WSF_REQUEST; res: WSF_RESPONSE; a_report_view: ESA_REPORT_VIEW)
			-- Problem reports representation for a guest user
		local
			l_hp: HTML_REPORT
		do
			debug
				log.write_information (generator + ".problem_reports_guest")
			end
			if attached req.http_host as l_host then
				create l_hp.make (absolute_host (req, ""), a_report_view)
				if attached l_hp.representation as l_report_page then
					new_response_get (req, res, l_report_page)
				end
			end
			debug
				log.write_information (generator + ".problem_reports_guest executed")
			end
		end

	problem_closed_reports_guest (req: WSF_REQUEST; res: WSF_RESPONSE; a_report_view: ESA_REPORT_VIEW)
			-- <Precursor>
		local
			l_hp: HTML_CLOSED_REPORT
		do
			debug
				log.write_information (generator + ".problem_closed_reports_guest")
			end
			if attached req.http_host as l_host then
				create l_hp.make (absolute_host (req, ""), a_report_view)
				if attached l_hp.representation as l_report_page then
					new_response_get (req, res, l_report_page)
				end
			end
			debug
				log.write_information (generator + ".problem_reports_guest executed")
			end
		end

	problem_user_reports (req: WSF_REQUEST; res: WSF_RESPONSE; a_view: ESA_REPORT_VIEW)
			-- <Precursor>
		local
			l_hp: HTML_USER_REPORT
		do
			if attached req.http_host as l_host then
				create l_hp.make (absolute_host (req, ""), a_view)
				if attached l_hp.representation as l_home_page then
					new_response_get (req, res, l_home_page)
				end
			end
		end

	problem_reports_responsible (req: WSF_REQUEST; res: WSF_RESPONSE; a_report_view: ESA_REPORT_VIEW)
			-- <Precursor>
		local
			l_hp: HTML_RESPONSIBLE_REPORT
		do
			if attached req.http_host as l_host then
				create l_hp.make (absolute_host (req, ""), a_report_view)
				if attached l_hp.representation as l_home_page then
					new_response_get_cache (req, res, l_home_page)
				end
			end
		end

	problem_reports_responsible_closed (req: WSF_REQUEST; res: WSF_RESPONSE; a_report_view: ESA_REPORT_VIEW)
			-- <Precursor>
		local
			l_hp: HTML_CLOSED_REPORT
		do
			debug
				log.write_information (generator + ".problem_reports_responsible_closed")
			end
			if attached req.http_host as l_host then
				create l_hp.make (absolute_host (req, ""), a_report_view)
				if attached l_hp.representation as l_report_page then
					new_response_get (req, res, l_report_page)
				end
			end
			debug
				log.write_information (generator + ".problem_reports_responsible_closed executed")
			end
		end

	report_form (req: WSF_REQUEST; res: WSF_RESPONSE; a_form: ESA_REPORT_FORM_VIEW)
			-- <Precursor>
		local
			l_hp: HTML_REPORT_FORM
		do
			if attached req.http_host as l_host then
				create l_hp.make (absolute_host (req, ""), a_form, current_user_name (req))
				if attached l_hp.representation as l_form_page then
					new_response_get (req, res, l_form_page)
				end
			end
		end

	report_form_confirm (req: WSF_REQUEST; res: WSF_RESPONSE; a_form: ESA_REPORT_FORM_VIEW)
			-- <Precursor>
		local
			l_hp: HTML_REPORT_FORM_CONFIRM
		do
			if attached req.http_host as l_host then
				create l_hp.make (absolute_host (req, ""), a_form, current_user_name (req))
				if attached l_hp.representation as l_form_page then
					new_response_get (req, res, l_form_page)
				end
			end
		end

	report_form_confirm_redirect (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Report form confirm redirect
		do
			if attached current_user_name (req) as l_user then
				compute_response_redirect (req, res, absolute_host (req, "/user_reports/" + {UTF_CONVERTER}.utf_32_string_to_utf_8_string_8 (l_user)))
			end
		end

	report_form_confirm_page (req: WSF_REQUEST; res: WSF_RESPONSE; a_id: INTEGER)
			-- Report form confirm page
		do
			to_implement ("Implement")
		end

	report_form_error (req: WSF_REQUEST; res: WSF_RESPONSE; a_form: ESA_REPORT_FORM_VIEW)
			-- Report form error
		local
			l_hp: HTML_REPORT_FORM
		do
			if attached req.http_host as l_host then
				create l_hp.make (absolute_host (req, ""), a_form, current_user_name (req))
				if attached l_hp.representation as l_form_page then
					new_response_get_400 (req, res, l_form_page)
				end
			end
		end

	update_report_responsible (req: WSF_REQUEST; res: WSF_RESPONSE; a_redirect_uri: READABLE_STRING_8)
			-- Update report responsible
		do
			compute_response_redirect (req, res, absolute_host (req, a_redirect_uri))
		end

	not_found_page (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Home page representation
		local
			l_hp: HTML_404
		do
			if attached req.http_host as l_host then
				create l_hp.make (absolute_host (req, ""), current_user_name (req))
				if attached l_hp.representation as l_home_page then
					new_response_get_404 (req, res, l_home_page)
				end
			end
		end

	login_page (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Login page
		do

			compute_response_redirect (req, res, absolute_host (req, "/"))
		end

	logout_page (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Logout page
		local
			l_hp: HTML_LOGOUT
		do
			if attached req.http_host as l_host then
				create l_hp.make (absolute_host (req, ""))
				if attached l_hp.representation as l_home_page then
					if attached req.query_parameter ("prompt") as l_prompt then
						new_response_access_unauthorized (req, res, l_home_page)
					else
						new_response_access_denied (req, res, l_home_page)
					end
				end
			end
		end

	bad_request_page (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- <Precursor>
		local
			l_hp: HTML_400
		do
			if attached req.http_host as l_host then
				create l_hp.make (absolute_host (req, ""), current_user_name (req))
				if attached l_hp.representation as l_bad_page then
					new_response_get_400 (req, res, l_bad_page)
				end
			end
		end

	bad_request_with_errors_page (req: WSF_REQUEST; res: WSF_RESPONSE; errors: STRING_TABLE [READABLE_STRING_32])
			-- Bad request with error page
		local
			l_hp: HTML_400
		do
			if attached req.http_host as l_host then
				create l_hp.make_with_errors (absolute_host (req, ""), errors, current_user_name (req))
				if attached l_hp.representation as l_bad_page then
					new_response_get_400 (req, res, l_bad_page)
				end
			end
		end
	new_response_unauthorized (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Generate a Reponse based on the Media Type
		local
			l_hp: HTML_401
		do
			if attached req.http_host as l_host then
				create l_hp.make_with_redirect (absolute_host (req, ""), req.request_uri, current_user_name (req))
				if attached l_hp.representation as l_unauthorized then
					new_response_access_unauthorized (req, res, l_unauthorized)
				end
			end
		end

	internal_server_error (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- internal_server_error
		local
			l_hp: HTML_500
		do
			if attached req.http_host as l_host then
				create l_hp.make (absolute_host (req, ""))
				if attached l_hp.representation as l_unauthorized then
					new_response_access_unauthorized (req, res, l_unauthorized)
				end
			end
		end

	register_page (req: WSF_REQUEST; res: WSF_RESPONSE; a_view: ESA_REGISTER_VIEW)
			-- Register form
		local
			l_hp: HTML_REGISTER
		do
			if attached req.http_host as l_host then
				create l_hp.make (absolute_host (req, ""), a_view, current_user_name (req))
				if attached l_hp.representation as l_register_page then
					if attached a_view.errors then
						new_response_get_400 (req, res, l_register_page)
					else
						new_response_get (req, res, l_register_page)
					end
				end
			end
		end

	post_register_page (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Post Register page
		local
			l_hp: HTML_POST_REGISTER
		do
			if attached req.http_host as l_host then
				create l_hp.make (absolute_host (req, ""), current_user_name (req))
				if attached l_hp.representation as l_register_page then
					new_response_get (req, res, l_register_page)
				end
			end
		end

	activation_page (req: WSF_REQUEST; res: WSF_RESPONSE; a_view: detachable ESA_ACTIVATION_VIEW)
			-- Activation page
		local
			l_hp: HTML_ACTIVATION
		do
			if attached req.http_host as l_host then
				create l_hp.make (absolute_host (req, ""), a_view, current_user_name (req))
				if attached l_hp.representation as l_activation_page then
					if attached a_view and then (attached a_view.error_message or else not a_view.is_valid_form) then
						new_response_get_400 (req, res, l_activation_page)
					else
						new_response_get (req, res, l_activation_page)
					end
				end
			end
		end

	activation_confirmation_page (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Confirmation page
		local
			l_hp: HTML_CONFIRMATION
		do
			if attached req.http_host as l_host then
				create l_hp.make (absolute_host (req, ""), current_user_name (req))
				if attached l_hp.representation as l_confirmation_page then
					new_response_get (req, res, l_confirmation_page)
				end
			end
		end

	status_page (req: WSF_REQUEST; res: WSF_RESPONSE; a_list: LIST [REPORT_STATUS])
			-- <Precursor>
		do
			to_implement ("Add HTML implementation")
		end

	severity_page (req: WSF_REQUEST; res: WSF_RESPONSE; a_list: LIST [REPORT_SEVERITY])
			-- <Precursor>
		do
			to_implement ("Add HTML implementation")
		end

	category_page (req: WSF_REQUEST; res: WSF_RESPONSE; a_list: LIST [REPORT_CATEGORY])
			-- <Precursor>
		do
			to_implement ("Add HTML implementation")
		end

	priority_page (req: WSF_REQUEST; res: WSF_RESPONSE; a_list: detachable LIST [REPORT_PRIORITY])
			-- <Precursor>
		do
			to_implement ("Add HTML implementation")
		end

	responsible_page (req: WSF_REQUEST; res: WSF_RESPONSE; a_list: detachable LIST [USER])
			-- <Precursor>
		do
			to_implement ("Add HTML implementation")
		end

	add_interaction_form (req: WSF_REQUEST; res: WSF_RESPONSE; a_form: ESA_INTERACTION_FORM_VIEW)
			-- Interaction Form
		local
			l_hp: HTML_INTERACTION
		do
			if attached req.http_host as l_host then
				create l_hp.make (absolute_host (req, ""), a_form, current_user_name (req))
				if attached l_hp.representation as l_confirmation_page then
					new_response_get (req, res, l_confirmation_page)
				end
			end
		end

	interaction_form_confirm (req: WSF_REQUEST; res: WSF_RESPONSE; a_form: ESA_INTERACTION_FORM_VIEW)
			-- Interaction Form Confirm.
		local
			l_hp: HTML_INTERACTION_CONFIRM
		do
			if attached req.http_host as l_host then
				create l_hp.make (absolute_host (req, ""), a_form, current_user_name (req))
				if attached l_hp.representation as l_form_page then
					new_response_get (req, res, l_form_page)
				end
			end
		end

	interaction_form_error (req: WSF_REQUEST; res: WSF_RESPONSE; a_form: detachable ESA_INTERACTION_FORM_VIEW)
			-- <Precursor>
		do
			to_implement ("Add HTML implementation")
		end

	interaction_form_confirm_redirect (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Interaction form redirect
		do
			if attached current_user_name (req) as l_user then
				compute_response_redirect (req, res, absolute_host (req, "/reports"))
			end
		end

	interaction_form_confirm_page (req: WSF_REQUEST; res: WSF_RESPONSE; a_report_id: INTEGER; a_id: INTEGER)
			-- Interaction form confirm page
		do
			to_implement ("to be implemented")
		end

	reminder_page (req: WSF_REQUEST; res: WSF_RESPONSE; a_error: detachable READABLE_STRING_GENERAL)
			-- Reminder page
		local
			l_hp: HTML_REMINDER
		do
			if attached req.http_host as l_host then
				create l_hp.make (absolute_host (req, ""), a_error)
				if attached l_hp.representation as l_reminder_page then
					new_response_get (req, res, l_reminder_page)
				end
			end
		end

	post_reminder_page (req: WSF_REQUEST; res: WSF_RESPONSE; a_email: detachable STRING)
			-- <Precursor>
		local
			l_hp: HTML_POST_REMINDER
		do
			if attached req.http_host as l_host then
				create l_hp.make (absolute_host (req, ""), a_email)
				if attached l_hp.representation as l_post_reminder_page then
					new_response_get (req, res, l_post_reminder_page)
				end
			end
		end

	account_information_page (req: WSF_REQUEST; res: WSF_RESPONSE; a_account: ESA_ACCOUNT_VIEW)
			-- <Precursor>
		local
			l_hp: HTML_ACCOUNT
		do
			if attached req.http_host as l_host then
				create l_hp.make (absolute_host (req, ""), a_account)
				if attached l_hp.representation as l_account_information_page then
					new_response_get (req, res, l_account_information_page)
				end
			end
		end

	post_account_information_page (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- <Precursor>
		do
			if attached current_user_name (req) as l_user then
				compute_response_redirect (req, res, absolute_host (req, "/user_reports/" + {UTF_CONVERTER}.utf_32_string_to_utf_8_string_8 (l_user)))
			end
		end

	change_password (req: WSF_REQUEST; res: WSF_RESPONSE; a_view: ESA_PASSWORD_VIEW)
			-- <Precursor>
		local
			l_hp: HTML_CHANGE_PASSWORD
		do
			if attached req.http_host as l_host then
				create l_hp.make (absolute_host (req, ""), current_user_name (req), a_view)
				if attached l_hp.representation as l_change_password_page then
					if attached a_view.errors then
						new_response_get_400 (req, res, l_change_password_page)
					else
						new_response_get (req, res, l_change_password_page)
					end
				end
			end
		end

	change_email (req: WSF_REQUEST; res: WSF_RESPONSE; a_view: ESA_EMAIL_VIEW)
			-- <Precursor>
		local
			l_hp: HTML_CHANGE_EMAIL
		do
			if attached req.http_host as l_host then
				create l_hp.make (absolute_host (req, ""), current_user_name (req), a_view)
				if attached l_hp.representation as l_change_password_page then
					if attached a_view.errors then
						new_response_get_400 (req, res, l_change_password_page)
					else
						new_response_get (req, res, l_change_password_page)
					end
				end
			end
		end

	post_email_change_page (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- <Precursor>
		local
			l_hp: HTML_POST_CHANGE_EMAIL
		do
			if attached req.http_host as l_host then
				create l_hp.make (absolute_host (req, ""), current_user_name (req))
				if attached l_hp.representation as l_change_password_page then
					new_response_get (req, res, l_change_password_page)
				end
			end
		end

	confirm_change_email (req: WSF_REQUEST; res: WSF_RESPONSE; a_view: ESA_EMAIL_VIEW)
			-- <Precursor>
		local
			l_hp: HTML_CONFIRM_EMAIL_CHANGE
		do
			if attached req.http_host as l_host then
				create l_hp.make (absolute_host (req, ""), current_user_name (req), a_view)
				if attached l_hp.representation as l_change_password_page then
					if attached a_view.errors then
						new_response_get_400 (req, res, l_change_password_page)
					else
						new_response_get (req, res, l_change_password_page)
					end
				end
			end
		end

	confirm_change_password (req: WSF_REQUEST; res: WSF_RESPONSE; a_view: ESA_PASSWORD_RESET_VIEW)
			-- <Precursor>
		local
			l_hp: HTML_CONFIRM_PASSWORD_CHANGE
		do
			if attached req.http_host as l_host then
				create l_hp.make (absolute_host (req, ""), current_user_name (req), a_view)
				if attached l_hp.representation as l_change_password_page then
					if attached a_view.errors then
						new_response_get_400 (req, res, l_change_password_page)
					else
						new_response_get (req, res, l_change_password_page)
					end
				end
			end
		end

	post_confirm_email_change_page (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- <Precursor>
		do
			if attached current_user_name (req) as l_user then
				compute_response_redirect (req, res, absolute_host (req, "/user_reports/" + {UTF_CONVERTER}.utf_32_string_to_utf_8_string_8 (l_user)))
			end
		end

	subscribe_to_category (req: WSF_REQUEST; res: WSF_RESPONSE; a_list: LIST [ESA_CATEGORY_SUBSCRIBER_VIEW])
			-- <Precursor>
		local
			l_hp: ESA_SUBSCRIBE_TO_CATEGORY
		do
			if attached req.http_host as l_host then
				create l_hp.make (absolute_host (req, ""), current_user_name (req), a_list)
				if attached l_hp.representation as l_change_password_page then
					new_response_get (req, res, l_change_password_page)
				end
			end
		end

feature -- Response

	new_response_get_home (req: WSF_REQUEST; res: WSF_RESPONSE; output: STRING)
		local
			h: HTTP_HEADER
		do
			create h.make
			h.put_content_type_text_html
			h.put_content_length (output.count)
			if attached media_variants.vary_header_value as l_vary then
				h.put_header_key_value ("Vary", l_vary)
			end
			h.add_header_key_value ("Cache-Control", "public, max-age=3600")
			h.put_current_date
			res.set_status_code ({HTTP_STATUS_CODE}.ok)
			res.put_header_text (h.string)
			res.put_string (output)
		end

	new_response_get (req: WSF_REQUEST; res: WSF_RESPONSE; output: STRING)
		local
			h: HTTP_HEADER
		do
			create h.make
			h.put_content_type_text_html
			h.put_content_length (output.count)
			if attached media_variants.vary_header_value as l_vary then
				h.put_header_key_value ("Vary", l_vary)
			end
			h.put_current_date
			res.set_status_code ({HTTP_STATUS_CODE}.ok)
			res.put_header_text (h.string)
			res.put_string (output)
		end

	new_response_get_cache (req: WSF_REQUEST; res: WSF_RESPONSE; output: STRING)
		local
			h: HTTP_HEADER
		do
			create h.make
			h.put_content_type_text_html

			h.add_header_key_value ("Cache-Control", "public; max-age=180")
			h.put_content_length (output.count)
			if attached media_variants.vary_header_value as l_vary then
				h.put_header_key_value ("Vary", l_vary)
			end
			h.put_current_date
			res.set_status_code ({HTTP_STATUS_CODE}.ok)
			res.put_header_text (h.string)
			res.put_string (output)
		end

	new_response_get_400 (req: WSF_REQUEST; res: WSF_RESPONSE; output: STRING)
		local
			h: HTTP_HEADER
		do
			fixme ("Refactor code and create a simple abstraction to send messages")
			create h.make
			h.put_content_type_text_html
			h.put_content_length (output.count)
			if attached media_variants.vary_header_value as l_vary then
				h.put_header_key_value ("Vary", l_vary)
			end
			h.put_current_date
			res.set_status_code ({HTTP_STATUS_CODE}.bad_request)
			res.put_header_text (h.string)
			res.put_string (output)
		end

	new_response_get_404 (req: WSF_REQUEST; res: WSF_RESPONSE; output: STRING)
		local
			h: HTTP_HEADER
		do
			fixme ("Refactor code and create a simple abstraction to send messages")
			create h.make
			h.put_content_type_text_html
			h.put_content_length (output.count)
			if attached media_variants.vary_header_value as l_vary then
				h.put_header_key_value ("Vary", l_vary)
			end
			h.put_current_date
			res.set_status_code ({HTTP_STATUS_CODE}.not_found)
			res.put_header_text (h.string)
			res.put_string (output)
		end

	new_response_access_denied (req: WSF_REQUEST; res: WSF_RESPONSE; output: STRING)
		local
			h: HTTP_HEADER
		do
			create h.make
			h.put_content_type_text_html
			h.put_content_length (output.count)
			if attached media_variants.vary_header_value as l_vary then
				h.put_header_key_value ("Vary", l_vary)
			end
			h.put_current_date
			res.set_status_code ({HTTP_STATUS_CODE}.unauthorized)
			res.put_header_text (h.string)
			res.put_string (output)
		end

	new_response_access_unauthorized (req: WSF_REQUEST; res: WSF_RESPONSE; output: STRING)
		local
			h: HTTP_HEADER
		do
			create h.make
			h.put_content_type_text_html
			h.put_content_length (output.count)
				--			h.put_header_key_value ({HTTP_HEADER_NAMES}.header_www_authenticate, "Basic realm=%"User%"")
			if attached media_variants.vary_header_value as l_vary then
				h.put_header_key_value ("Vary", l_vary)
			end
			h.put_current_date
			res.set_status_code ({HTTP_STATUS_CODE}.forbidden)
			res.put_header_text (h.string)
			res.put_string (output)
		end

	compute_response_redirect (req: WSF_REQUEST; res: WSF_RESPONSE; a_location: READABLE_STRING_8)
			-- Redirect to `a_location'
		local
			h: HTTP_HEADER
		do
			create h.make
			h.put_content_length (0)
			h.put_content_type_text_html
			h.put_current_date
			h.put_location (a_location)
			res.set_status_code ({HTTP_STATUS_CODE}.see_other)
			res.put_header_text (h.string)
		end

	new_response_authenticate (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Handle forbidden.
		local
			h: HTTP_HEADER
		do
			create h.make
			h.put_content_type_text_html
			h.put_current_date
			h.put_header_key_value ({HTTP_HEADER_NAMES}.header_www_authenticate, "Basic realm=%"User%"")
			res.set_status_code ({HTTP_STATUS_CODE}.unauthorized)
			res.put_header_text (h.string)
		end

end

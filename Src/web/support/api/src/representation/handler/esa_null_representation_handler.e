note
	description: "[
		Class to handle negotiation failures for a given resource
		Return status code 406 Not Acceptable
]"
	date: "$Date$"
	revision: "$Revision$"

class
	ESA_NULL_REPRESENTATION_HANDLER

inherit

	ESA_REPRESENTATION_HANDLER

	REFACTORING_HELPER

create
	make

feature -- View
	home_page_redirect (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Home redirect
		do
			generic_response (req, res)
		end


	home_page (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Home page representation.
		do
			generic_response (req, res)
		end

	problem_report (req: WSF_REQUEST; res: WSF_RESPONSE; a_report: REPORT)
			-- <Precursor>
		do
			generic_response (req, res)
		end

	problem_reports_guest (req: WSF_REQUEST; res: WSF_RESPONSE; a_report_view: ESA_REPORT_VIEW)
			-- Problem reports representation for a guest user
		do
			generic_response (req, res)
		end

	problem_user_reports  (req: WSF_REQUEST; res: WSF_RESPONSE; a_view: ESA_REPORT_VIEW)
			-- <Precursor>
		do
			generic_response (req, res)
		end

	problem_reports_responsible	(req: WSF_REQUEST; res: WSF_RESPONSE; a_report_view: detachable ESA_REPORT_VIEW)
			-- <Precursor>
		do
			generic_response (req, res)
		end


	report_form (req: WSF_REQUEST; res: WSF_RESPONSE; a_form: ESA_REPORT_FORM_VIEW)
			-- <Precursor>
		do
			generic_response (req, res)
		end

	report_form_confirm (req: WSF_REQUEST; res: WSF_RESPONSE; a_form: ESA_REPORT_FORM_VIEW)
			-- Report form confirm
		do
			generic_response (req, res)
		end

	report_form_confirm_redirect (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Report form confirm redirect
		do
			generic_response (req, res)
		end

	report_form_confirm_page (req: WSF_REQUEST; res: WSF_RESPONSE; a_id: INTEGER)
			-- Report form confirm page
		do
			generic_response (req, res)
		end


	report_form_error (req: WSF_REQUEST; res: WSF_RESPONSE; a_form: ESA_REPORT_FORM_VIEW)
			-- Report form error
		do
			generic_response (req, res)
		end

	update_report_responsible (req: WSF_REQUEST; res: WSF_RESPONSE; a_redirect_uri: READABLE_STRING_8)
			-- Update report responsible
		do
			generic_response (req, res)
		end


	not_found_page (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- <Precursor>
		do
			generic_response (req, res)
		end

	login_page (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Login page
		do
			generic_response (req, res)
		end

	logout_page (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- <Precursor>
		do
			generic_response (req, res)
		end

	bad_request_page (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- <Precursor>
		do
			generic_response (req, res)
		end

	bad_request_with_errors_page (req: WSF_REQUEST; res: WSF_RESPONSE; a_error: STRING_TABLE[READABLE_STRING_32])
			-- <Precursor>
		do
			generic_response (req, res)
		end

	new_response_unauthorized(req: WSF_REQUEST; res: WSF_RESPONSE)
				-- Generate a Reponse based on the Media Type
		do
			generic_response (req, res)
		end

	new_response_authenticate (req: WSF_REQUEST; res: WSF_RESPONSE)
		do
			generic_response (req, res)
		end

	internal_server_error (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- internal_server_error
		do
			generic_response (req, res)
		end


	register_page (req: WSF_REQUEST; res: WSF_RESPONSE; a_view: ESA_REGISTER_VIEW)
			-- Register form
		do
			generic_response (req, res)
		end

	post_register_page 	(req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Post Register page
		do
			generic_response (req, res)
		end


	activation_page (req: WSF_REQUEST; res: WSF_RESPONSE; a_view: ESA_ACTIVATION_VIEW)
			-- Activation page
		do
			generic_response (req, res)
		end

	activation_confirmation_page (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Confirmation page
		do
			generic_response (req, res)
		end

	status_page (req: WSF_REQUEST; res: WSF_RESPONSE; a_list: LIST[REPORT_STATUS])
			-- <Precursor>
		do
			generic_response (req, res)
		end


	severity_page (req: WSF_REQUEST; res: WSF_RESPONSE; a_list: LIST[REPORT_SEVERITY])
			-- <Precursor>
		do
			generic_response (req, res)
		end


	category_page (req: WSF_REQUEST; res: WSF_RESPONSE; a_list: LIST[REPORT_CATEGORY])
			-- <Precursor>
		do
			generic_response (req, res)
		end

	priority_page (req: WSF_REQUEST; res: WSF_RESPONSE; a_list: detachable LIST[REPORT_PRIORITY])
			-- <Precursor>
		do
			generic_response (req, res)
		end

	responsible_page (req: WSF_REQUEST; res: WSF_RESPONSE; a_list: detachable LIST[USER])
			-- <Precursor>
		do
			generic_response (req, res)
		end

	add_interaction_form (req: WSF_REQUEST; res: WSF_RESPONSE; a_form: ESA_INTERACTION_FORM_VIEW)
			-- Interaction Form
		do
			generic_response (req, res)
		end

	interaction_form_confirm (req: WSF_REQUEST; res: WSF_RESPONSE; a_form: detachable ESA_INTERACTION_FORM_VIEW)
			-- Interaction Form Confirm.
		do
			generic_response (req, res)
		end

	interaction_form_error (req: WSF_REQUEST; res: WSF_RESPONSE; a_form: detachable ESA_INTERACTION_FORM_VIEW)
			-- <Precursor>
		do
			generic_response (req, res)
		end

	interaction_form_confirm_redirect (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Interaction form redirect
		do
			generic_response (req, res)
		end

	interaction_form_confirm_page (req: WSF_REQUEST; res: WSF_RESPONSE; a_report_id: INTEGER; a_id: INTEGER)
			-- Interaction form confirm page
		do
			generic_response (req, res)
		end

	reminder_page (req: WSF_REQUEST; res: WSF_RESPONSE; a_error: detachable STRING)
			-- Reminder page.
		do
			generic_response (req, res)
		end

	post_reminder_page (req: WSF_REQUEST; res: WSF_RESPONSE; a_email: detachable STRING)
			-- <Precursor>
		do
			generic_response (req, res)
		end

	account_information_page (req: WSF_REQUEST; res: WSF_RESPONSE; a_account: ESA_ACCOUNT_VIEW)
			-- <Precursor>
		do
			generic_response (req, res)
		end

	post_account_information_page (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- <Precursor>
		do
			generic_response (req, res)
		end

	change_password (req: WSF_REQUEST; res: WSF_RESPONSE; a_view: detachable ESA_PASSWORD_VIEW)
			-- <Precursor>
		do
			generic_response (req, res)
		end

	change_email (req: WSF_REQUEST; res: WSF_RESPONSE; a_view: detachable ESA_EMAIL_VIEW)
			-- <Precursor>
		do
			generic_response (req, res)
		end

	post_email_change_page (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- <Precursor>
		do
			generic_response (req, res)
		end

	confirm_change_email (req: WSF_REQUEST; res: WSF_RESPONSE; a_view: detachable ESA_EMAIL_VIEW)
			-- <Precursor>
		do
			generic_response (req, res)
		end

	confirm_change_password (req: WSF_REQUEST; res: WSF_RESPONSE; a_view: detachable ESA_PASSWORD_RESET_VIEW)
			-- <Precursor>
		do
			generic_response (req, res)
		end


	post_confirm_email_change_page (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- <Precursor>
		do
			generic_response (req, res)
		end


	subscribe_to_category (req: WSF_REQUEST; res: WSF_RESPONSE; a_list: detachable ANY )
			-- <Precursor>
		do
			generic_response (req, res)
		end

feature -- Response

	new_response_get (req: WSF_REQUEST; res: WSF_RESPONSE; output: STRING)
		local
			h: HTTP_HEADER
		do
			create h.make
			h.put_content_type_text_html
			h.put_content_length (output.count)
			h.put_current_date
			res.set_status_code ({HTTP_STATUS_CODE}.not_acceptable)
			res.put_header_text (h.string)
			res.put_string (output)
		end


	generic_response (req: WSF_REQUEST; res: WSF_RESPONSE)
			local
				l_np: HTML_406
			do
				if attached req.http_host as l_host then
					create l_np.make (req.absolute_script_url (""),req.percent_encoded_path_info,req.http_accept)
					if attached l_np.representation as l_406_page then
						new_response_get (req, res, l_406_page)
					end
				end
			end

end

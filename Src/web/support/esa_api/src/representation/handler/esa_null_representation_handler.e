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

	home_page (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Home page representation.
		do
			generic_response (req, res)
		end

	problem_report (req: WSF_REQUEST; res: WSF_RESPONSE; a_report: ESA_REPORT)
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
				l_np: ESA_HTML_406_PAGE
			do
				if attached req.http_host as l_host then
					create l_np.make (req.absolute_script_url (""),req.percent_encoded_path_info,req.http_accept)
					if attached l_np.representation as l_406_page then
						new_response_get (req, res, l_406_page)
					end
				end
			end

end

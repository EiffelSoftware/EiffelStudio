note
	description: "Concreate class to converts data into the CJ representation."
	date: "$Date$"
	revision: "$Revision$"

class
	ESA_CJ_REPRESENTATION_HANDLER

inherit

	ESA_REPRESENTATION_HANDLER

	REFACTORING_HELPER

create
	make

feature -- View

	home_page (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Home page representation
		local
			l_cj: ESA_CJ_ROOT_PAGE
		do
			if attached req.http_host as l_host then
				create l_cj.make (req.absolute_script_url (""), current_user_name (req))
				if attached l_cj.representation as l_cj_api then
					new_response_get (req, res,l_cj_api)
				end
			end
		end

	problem_report (req: WSF_REQUEST; res: WSF_RESPONSE; a_report: ESA_REPORT)
			-- <Precursor>
		local
			l_cj: ESA_CJ_REPORT_DETAIL_PAGE
		do
			if attached req.http_host as l_host then
				create l_cj.make (req.absolute_script_url (""), a_report, current_user_name (req))
				if attached l_cj.representation as l_cj_api then
					new_response_get (req, res, l_cj_api)
				end
			end
		end

	problem_reports_guest (req: WSF_REQUEST; res: WSF_RESPONSE; a_report_view: ESA_REPORT_VIEW)
			-- Problem reports representation for a guest user
		local
			l_hp: ESA_CJ_REPORT_PAGE
		do
			if attached req.http_host as l_host then
				create l_hp.make (req.absolute_script_url (""), a_report_view)
				if attached l_hp.representation as l_report_page then
					new_response_get (req, res, l_report_page)
				end
			end
		end

	problem_user_reports  (req: WSF_REQUEST; res: WSF_RESPONSE; a_report_view: ESA_REPORT_VIEW)
			-- Problem reports representation for a given user
		local
			l_hp: ESA_CJ_REPORT_PAGE
			l_pages: INTEGER
		do
			if attached req.http_host as l_host then
				create l_hp.make (req.absolute_script_url (""), a_report_view)
				if attached l_hp.representation as l_home_page then
					new_response_get (req, res, l_home_page)
				end
			end
		end

	problem_reports_responsible  (req: WSF_REQUEST; res: WSF_RESPONSE; a_report_view: ESA_REPORT_VIEW)
			-- <Precursor>
		do
			to_implement ("Add Implementation")
		end


	update_report_responsible  (req: WSF_REQUEST; res: WSF_RESPONSE; a_redirect_uri: READABLE_STRING_32 )
			-- <Precursor>
		do
			to_implement ("Add Implementation")
		end


	report_form (req: WSF_REQUEST; res: WSF_RESPONSE; a_form: ESA_REPORT_FORM_VIEW)
			-- <Precursor>
		do
		end

	report_form_confirm (req: WSF_REQUEST; res: WSF_RESPONSE; a_form: ESA_REPORT_FORM_VIEW)
			-- Report form confirm
		do
		end

	report_form_confirm_redirect (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Report form confirm redirect
		do
		end


	not_found_page (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Home page representation
		local
			l_cj: ESA_CJ_ROOT_PAGE
		do
			if attached req.http_host as l_host then
				create l_cj.make_with_error (req.absolute_script_url (""), "The resource " + req.percent_encoded_path_info + "was not found", 404, current_user_name (req))
				if attached l_cj.representation as l_representation then
					new_response_get_404 (req, res, l_representation)
				end
			end
		end

	login_page (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Login page
		local
			l_cj: ESA_CJ_ROOT_PAGE
		do
			if attached req.http_host as l_host then
				create l_cj.make (req.absolute_script_url (""), req.execution_variable ("user"))
				if attached l_cj.representation as l_cj_api then
					new_response_get (req, res,l_cj_api)
				end
			end
		end

	logout_page (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- <Precursor>
		local
			l_cj: ESA_CJ_ROOT_PAGE
		do
			if attached req.http_host as l_host then
				create l_cj.make (req.absolute_script_url (""), Void)
				if attached l_cj.representation as l_cj_api then
					new_response_access_denied (req, res,l_cj_api)
				end
			end
		end

	bad_request_page (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- <Precursor>
		local
			l_cj: ESA_CJ_ROOT_PAGE
		do
			if attached req.http_host as l_host then
				create l_cj.make_with_error (req.absolute_script_url (""), "Bad Request " + req.path_info.as_string_8, 400, current_user_name (req))
				if attached l_cj.representation as l_representation then
					new_response_get_400 (req, res, l_representation)
				else
					to_implement ("Internal server error")
				end
			end
		end

	new_response_unauthorized(req: WSF_REQUEST; res: WSF_RESPONSE)
				-- Generate a Reponse based on the Media Type
		local
			h: HTTP_HEADER
			l_msg: STRING
			hdate: HTTP_DATE
		do
			create h.make
			create l_msg.make_from_string ("Unauthorized")
			h.put_content_type ("application/vnd.collection+json")
			h.put_content_length (l_msg.count)
			if attached media_variants.vary_header_value as l_vary then
				h.put_header_key_value ("Vary", l_vary)
			end
			if attached req.request_time as time then
				create hdate.make_from_date_time (time)
				h.add_header ("Date:" + hdate.rfc1123_string)
			end
			res.set_status_code ({HTTP_STATUS_CODE}.unauthorized)
			res.put_header_text (h.string)
			res.put_string (l_msg)
		end

	internal_server_error (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- internal_server_error
		do
		end


feature -- Response

	new_response_get (req: WSF_REQUEST; res: WSF_RESPONSE; output: STRING)
		local
			h: HTTP_HEADER
		do
			create h.make
			h.put_content_type ("application/vnd.collection+json")
			h.put_content_length (output.count)
			if attached media_variants.vary_header_value as l_vary then
				h.put_header_key_value ("Vary",l_vary)
			end
			h.put_current_date
			res.set_status_code ({HTTP_STATUS_CODE}.ok)
			res.put_header_text (h.string)
			res.put_string (output)
		end

	new_response_get_404 (req: WSF_REQUEST; res: WSF_RESPONSE; output: STRING)
		local
			h: HTTP_HEADER
		do
			fixme ("Refactor code and create a simple abstraction to send messages")
			create h.make
			h.put_content_type ("application/vnd.collection+json")
			h.put_content_length (output.count)
			if attached media_variants.vary_header_value as l_vary then
				h.put_header_key_value ("Vary", l_vary)
			end
			h.put_current_date
			res.set_status_code ({HTTP_STATUS_CODE}.not_found)
			res.put_header_text (h.string)
			res.put_string (output)
		end

	new_response_get_400 (req: WSF_REQUEST; res: WSF_RESPONSE; output: STRING)
		local
			h: HTTP_HEADER
		do
			fixme ("Refactor code and create a simple abstraction to send messages")
			create h.make
			h.put_content_type ("application/vnd.collection+json")
			h.put_content_length (output.count)
			if attached media_variants.vary_header_value as l_vary then
				h.put_header_key_value ("Vary", l_vary)
			end
			h.put_current_date
			res.set_status_code ({HTTP_STATUS_CODE}.bad_request)
			res.put_header_text (h.string)
			res.put_string (output)
		end

	new_response_access_denied (req: WSF_REQUEST; res: WSF_RESPONSE; output: STRING)
		local
			h: HTTP_HEADER
		do
			create h.make
			h.put_content_type ("application/vnd.collection+json")
			h.put_content_length (output.count)
			if attached media_variants.vary_header_value as l_vary then
				h.put_header_key_value ("Vary", l_vary)
			end
			h.put_current_date
			res.set_status_code ({HTTP_STATUS_CODE}.unauthorized)
			res.put_header_text (h.string)
			res.put_string (output)
		end


	new_response_authenticate (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Handle forbidden.
		local
			h: HTTP_HEADER
		do
			create h.make
			h.put_content_type ("application/vnd.collection+json")
			h.put_current_date
			h.put_header_key_value ({HTTP_HEADER_NAMES}.header_www_authenticate, "Basic realm=%"User%"")
			res.set_status_code ({HTTP_STATUS_CODE}.unauthorized)
			res.put_header_text (h.string)
		end

end

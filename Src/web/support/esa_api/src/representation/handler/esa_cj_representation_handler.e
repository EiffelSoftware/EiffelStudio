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
					new_response_get (req, res, l_cj_api)
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

	problem_user_reports (req: WSF_REQUEST; res: WSF_RESPONSE; a_report_view: ESA_REPORT_VIEW)
			-- Problem reports representation for a given user
		local
			l_hp: ESA_CJ_REPORT_PAGE
		do
			if attached req.http_host as l_host then
				create l_hp.make (req.absolute_script_url (""), a_report_view)
				if attached l_hp.representation as l_home_page then
					new_response_get (req, res, l_home_page)
				end
			end
		end

	problem_reports_responsible (req: WSF_REQUEST; res: WSF_RESPONSE; a_report_view: ESA_REPORT_VIEW)
			-- <Precursor>
		local
			l_hp: ESA_CJ_RESPONSIBLE_PAGE
		do
			if attached req.http_host as l_host then
				create l_hp.make (req.absolute_script_url (""), a_report_view)
				if attached l_hp.representation as l_home_page then
					new_response_get (req, res, l_home_page)
				end
			end
		end

	update_report_responsible (req: WSF_REQUEST; res: WSF_RESPONSE; a_redirect_uri: READABLE_STRING_32)
			-- <Precursor>
		do
			to_implement ("Add Implementation")
		end

	report_form (req: WSF_REQUEST; res: WSF_RESPONSE; a_form: ESA_REPORT_FORM_VIEW)
			-- <Precursor>
		local
			l_hp: ESA_CJ_REPORT_FORM_PAGE
		do
			if attached req.http_host as l_host then
				if a_form.id > 0 then
					create l_hp.make_with_data (req.absolute_script_url (""), a_form, current_user_name (req))
				else
					create l_hp.make (req.absolute_script_url (""), a_form, current_user_name (req))
				end
				if attached l_hp.representation as l_form_page then
					new_response_get (req, res, l_form_page)
				end
			end
		end

	report_form_confirm (req: WSF_REQUEST; res: WSF_RESPONSE; a_form: ESA_REPORT_FORM_VIEW)
			-- Report form confirm
		local
			l_hp: ESA_CJ_REPORT_FORM_PAGE
		do
			if attached req.http_host as l_host then
				create l_hp.make_with_data (req.absolute_script_url (""), a_form, current_user_name (req))
				if attached l_hp.representation as l_form_page then
					new_response_redirect (req, res, l_form_page, req.absolute_script_url ("/report_form/" + a_form.id.out))
				end
			end
		end

	report_form_confirm_redirect (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Report form confirm redirect
		do
			if attached current_user_name (req) as l_user then
				compute_response_redirect (req, res,req.absolute_script_url ("/user_reports/"+l_user))
			end
		end

	report_form_confirm_page (req: WSF_REQUEST; res: WSF_RESPONSE; a_id: INTEGER)
			-- Report form confirm page
		local
			l_hp: ESA_CJ_REPORT_FORM_CONFIRM_PAGE
		do
			if attached req.http_host as l_host then
				create l_hp.make (req.absolute_script_url (""), a_id, current_user_name (req))
				if attached l_hp.representation as l_form_page then
					new_response_get (req, res, l_form_page)
				end
			end
		end


	report_form_error (req: WSF_REQUEST; res: WSF_RESPONSE; a_form: ESA_REPORT_FORM_VIEW)
			-- Report form error
		local
			l_hp: ESA_CJ_REPORT_FORM_PAGE
		do
			if attached req.http_host as l_host then
				create l_hp.make_with_error (req.absolute_script_url (""), a_form, current_user_name (req))
				if attached l_hp.representation as l_form_page then
					new_response_400 (req, res, l_form_page)
				end
			end
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
				create l_cj.make (req.absolute_script_url (""), current_user_name (req))
				if attached l_cj.representation as l_cj_api then
					new_response_get (req, res, l_cj_api)
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
					new_response_access_denied (req, res, l_cj_api)
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
					new_response_400 (req, res, l_representation)
				else
					to_implement ("Internal server error")
				end
			end
		end

	new_response_unauthorized (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Generate a Reponse based on the Media Type
		local
			h: HTTP_HEADER
			l_msg: STRING
		do
			create h.make
			create l_msg.make_from_string ("Unauthorized")
			h.put_content_type ("application/vnd.collection+json")
			h.put_content_length (l_msg.count)
			if attached media_variants.vary_header_value as l_vary then
				h.put_header_key_value ("Vary", l_vary)
			end
			h.put_current_date
			res.set_status_code ({HTTP_STATUS_CODE}.unauthorized)
			res.put_header_text (h.string)
			res.put_string (l_msg)
		end

	internal_server_error (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- internal_server_error
		do
		end

	register_page (req: WSF_REQUEST; res: WSF_RESPONSE; a_view: ESA_REGISTER_VIEW)
			-- Register form
		local
				l_cj: ESA_CJ_REGISTER_PAGE
		do
			if attached req.http_host as l_host then
				create l_cj.make (req.absolute_script_url (""), a_view , current_user_name (req))
				if attached l_cj.representation as l_representation then
					if attached a_view.errors  then
						new_response_400 (req, res, l_representation)
					else
						new_response_get (req, res, l_representation)
					end
				else
					to_implement ("Internal server error")
				end
			end
		end

	post_register_page (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Post Register page
		local
				l_cj: ESA_CJ_POST_REGISTER_PAGE
		do
			if attached req.http_host as l_host then
				create l_cj.make (req.absolute_script_url (""),  current_user_name (req))
				if attached l_cj.representation as l_representation then
						new_response_get (req, res, l_representation)
				else
					to_implement ("Internal server error")
				end
			end
		end


	activation_page (req: WSF_REQUEST; res: WSF_RESPONSE; a_view: detachable ESA_ACTIVATION_VIEW)
			-- Activation Page
		local
				l_cj: ESA_CJ_ACTIVATION_PAGE
		do
			if attached req.http_host as l_host then
				create l_cj.make (req.absolute_script_url (""), a_view, current_user_name (req))
				if attached l_cj.representation as l_representation then
					if attached a_view and then( attached a_view.error_message or else not a_view.is_valid_form )then
						new_response_400 (req, res, l_representation)
					else
						new_response_get (req, res, l_representation)
					end
				else
					to_implement ("Internal server error")
				end
			end
		end


	activation_confirmation_page (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Confirmation page
		local
			l_hp: ESA_CJ_CONFIRMATION_PAGE
		do
			if attached req.http_host as l_host then
				create l_hp.make (req.absolute_script_url (""), current_user_name (req))
				if attached l_hp.representation as l_confirmation_page then
					new_response_get (req, res, l_confirmation_page)
				end
			end
		end


	status_page (req: WSF_REQUEST; res: WSF_RESPONSE; a_list: LIST[ESA_REPORT_STATUS])
			-- <Precursor>
		local
			l_hp: ESA_CJ_STATUS_PAGE
		do
			if attached req.http_host as l_host then
				create l_hp.make (req.absolute_script_url (""),a_list,current_user_name (req))
				if attached l_hp.representation as l_status_page then
					new_response_get (req, res, l_status_page)
				end
			end
		end


	severity_page (req: WSF_REQUEST; res: WSF_RESPONSE; a_list: LIST[ESA_REPORT_SEVERITY])
			-- <Precursor>
		local
			l_hp: ESA_CJ_SEVERITY_PAGE
		do
			if attached req.http_host as l_host then
				create l_hp.make (req.absolute_script_url (""),a_list,current_user_name (req))
				if attached l_hp.representation as l_severity_page then
					new_response_get (req, res, l_severity_page)
				end
			end
		end


	category_page (req: WSF_REQUEST; res: WSF_RESPONSE; a_list: LIST[ESA_REPORT_CATEGORY])
			-- <Precursor>
		local
			l_hp: ESA_CJ_CATEGORY_PAGE
		do
			if attached req.http_host as l_host then
				create l_hp.make (req.absolute_script_url (""),a_list,current_user_name (req))
				if attached l_hp.representation as l_category_page then
					new_response_get (req, res, l_category_page)
				end
			end
		end


	priority_page (req: WSF_REQUEST; res: WSF_RESPONSE; a_list: LIST[ESA_REPORT_PRIORITY])
			-- <Precursor>
		local
			l_hp: ESA_CJ_PRIORITY_PAGE
		do
			if attached req.http_host as l_host then
				create l_hp.make (req.absolute_script_url (""),a_list,current_user_name (req))
				if attached l_hp.representation as l_priority_page then
					new_response_get (req, res, l_priority_page)
				end
			end
		end

	responsible_page (req: WSF_REQUEST; res: WSF_RESPONSE; a_list: LIST[ESA_USER])
			-- <Precursor>
		local
			l_hp: ESA_CJ_USER_RESPONSIBLE_PAGE
		do
			if attached req.http_host as l_host then
				create l_hp.make (req.absolute_script_url (""),a_list,current_user_name (req))
				if attached l_hp.representation as l_responsible_page then
					new_response_get (req, res, l_responsible_page)
				end
			end
		end

	add_interaction_form (req: WSF_REQUEST; res: WSF_RESPONSE; a_form: ESA_INTERACTION_FORM_VIEW)
			-- Interaction Form
		local
				l_hp: ESA_CJ_INTERACTION_PAGE
		do
			if attached req.http_host as l_host then
				create l_hp.make (req.absolute_script_url (""), a_form, current_user_name (req))
				if attached l_hp.representation as l_confirmation_page then
					new_response_get (req, res, l_confirmation_page)
				end
			end
		end

	interaction_form_confirm (req: WSF_REQUEST; res: WSF_RESPONSE; a_form: ESA_INTERACTION_FORM_VIEW)
			-- Interaction Form Confirm.
		local
			l_hp: ESA_CJ_INTERACTION_CONFIRM_PAGE
		do
			if attached req.http_host as l_host then
				create l_hp.make (req.absolute_script_url (""), a_form, current_user_name (req))
				if attached l_hp.representation as l_form_page then
					new_response_get (req, res, l_form_page)
				end
			end
		end


	interaction_form_error (req: WSF_REQUEST; res: WSF_RESPONSE; a_form: detachable ESA_INTERACTION_FORM_VIEW)
			-- <Precursor>
		do
			to_implement ("Add CJ implementation")
		end

	interaction_form_confirm_redirect (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Interaction form redirect
		do
			if attached current_user_name (req) as l_user then
				compute_response_redirect (req, res,"/user_reports/"+l_user)
			end
		end


feature -- Response

	compute_response_redirect (req: WSF_REQUEST; res: WSF_RESPONSE; a_location: READABLE_STRING_32)
			-- Redirect to `a_location'
		local
			h: HTTP_HEADER
		do
			create h.make
			h.put_content_type ("application/vnd.collection+json")
			h.put_current_date
			h.put_location (a_location)
			res.set_status_code ({HTTP_STATUS_CODE}.see_other)
			res.put_header_text (h.string)
		end

	new_response_get (req: WSF_REQUEST; res: WSF_RESPONSE; output: STRING)
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
			res.set_status_code ({HTTP_STATUS_CODE}.ok)
			res.put_header_text (h.string)
			res.put_string (output)
		end

	new_response_redirect (req: WSF_REQUEST; res: WSF_RESPONSE; output: STRING; a_location: STRING)
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
			h.put_location (a_location)
			res.set_status_code ({HTTP_STATUS_CODE}.see_other)
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

	new_response_400 (req: WSF_REQUEST; res: WSF_RESPONSE; output: STRING)
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

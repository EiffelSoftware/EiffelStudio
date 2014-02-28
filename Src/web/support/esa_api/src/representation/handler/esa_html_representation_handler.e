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
			l_hp: ESA_HOME_PAGE
		do
			if attached req.http_host as l_host then
				create l_hp.make ("http://" + l_host, req.execution_variable ("user"))
				if attached l_hp.representation as l_home_page then
					new_response_get (req, res, l_home_page)
				end
			end
		end

	problem_report (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- <Precursor>
		local
			l_hp: ESA_REPORT_DETAIL_PAGE
		do
			if attached req.http_host as l_host then
				if attached {WSF_STRING} req.path_parameter ("id") as l_id and then l_id.is_integer then
					if attached api_service.problem_report (l_id.as_string.integer_value) as l_report then
						create l_hp.make ("http://" + l_host, l_report, req.execution_variable ("user"))
						if attached l_hp.representation as l_home_page then
							new_response_get (req, res, l_home_page)
						end
					else
						not_found_page (req, res)
					end
				else
					bad_request_page (req, res)
				end
			end
		end

	problem_reports_guest (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- <Precursor>
		local
			l_hp: ESA_REPORT_PAGE
			l_pages: INTEGER
		do
			if attached req.http_host as l_host then
				l_pages := api_service.row_count_problem_report_guest
				l_pages := l_pages // 10
				if attached {WSF_STRING} req.path_parameter ("id") as l_id then
					if l_id.is_integer then
						create l_hp.make ("http://" + l_host, api_service.problem_reports_guest (l_id.as_string.integer_value, 10), l_id.as_string.integer_value, l_pages, req.execution_variable ("user"))
						if attached l_hp.representation as l_home_page then
							new_response_get (req, res, l_home_page)
						end
					else
						bad_request_page (req, res)
					end
				else
					create l_hp.make ("http://" + l_host, api_service.problem_reports_guest (1, 10), 1, l_pages, req.execution_variable ("user"))
					if attached l_hp.representation as l_home_page then
						new_response_get (req, res, l_home_page)
					end
				end
			end
		end

	problem_user_reports (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- <Precursor>
		local
			l_hp: ESA_USER_REPORT_PAGE
		do
			to_implement ("Retrieve pages")
			if attached req.http_host as l_host then
				if attached {WSF_STRING} req.path_parameter ("user") as l_user and then	l_user.is_string then
					create l_hp.make ("http://" + l_host, api_service.problem_reports (l_user.value, False, 0, 0),0, 0, l_user.value)
					if attached l_hp.representation as l_home_page then
						new_response_get (req, res, l_home_page)
					end
				else
					bad_request_page (req, res)
				end
			end
		end

	not_found_page (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Home page representation
		local
			l_hp: ESA_HTML_404_PAGE
		do
			if attached req.http_host as l_host then
				create l_hp.make ("http://" + l_host)
				if attached l_hp.representation as l_home_page then
					new_response_get_404 (req, res, l_home_page)
				end
			end
		end

	login_page (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Login page
		do
			if attached {STRING_32} req.execution_variable ("user") as l_user and then
				api_service.is_active (l_user) then
			 	-- Valid user
				to_implement ("Add logic when a registered users logged in, maybe Statistics etc!!!.")
				compute_response_redirect (req, res)
			else
				handle_unauthorized ("Unauthorized",req, res)
			end
		end


	logout_page (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Logout page
		local
			l_hp: ESA_LOGOUT_PAGE
		do
			if attached req.http_host as l_host then
				create l_hp.make ("http://" + l_host)
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
			l_hp: ESA_HTML_400_PAGE
		do
			if attached req.http_host as l_host then
				create l_hp.make ("http://" + l_host)
				if  attached l_hp.representation as l_bad_page then
					new_response_get_400 (req, res, l_bad_page)
				end
			end
		end

feature -- Response

	new_response_get (req: WSF_REQUEST; res: WSF_RESPONSE; output: STRING)
		local
			h: HTTP_HEADER
			l_msg: STRING
			hdate: HTTP_DATE
		do
			create h.make
			create l_msg.make_from_string (output)
			h.put_content_type_text_html
			h.put_content_length (l_msg.count)
			if attached media_variants.vary_header_value as l_vary then
				h.put_header_key_value ("Vary", l_vary)
			end
			if attached req.request_time as time then
				create hdate.make_from_date_time (time)
				h.add_header ("Date:" + hdate.rfc1123_string)
			end
			res.set_status_code ({HTTP_STATUS_CODE}.ok)
			res.put_header_text (h.string)
			res.put_string (l_msg)
		end


	new_response_get_400 (req: WSF_REQUEST; res: WSF_RESPONSE; output: STRING)
		local
			h: HTTP_HEADER
			l_msg: STRING
			hdate: HTTP_DATE
		do
			fixme ("Refactor code and create a simple abstraction to send messages")
			create h.make
			create l_msg.make_from_string (output)
			h.put_content_type_text_html
			h.put_content_length (l_msg.count)
			if attached media_variants.vary_header_value as l_vary then
				h.put_header_key_value ("Vary", l_vary)
			end
			if attached req.request_time as time then
				create hdate.make_from_date_time (time)
				h.add_header ("Date:" + hdate.rfc1123_string)
			end
			res.set_status_code ({HTTP_STATUS_CODE}.bad_request)
			res.put_header_text (h.string)
			res.put_string (l_msg)
		end

	new_response_get_404 (req: WSF_REQUEST; res: WSF_RESPONSE; output: STRING)
		local
			h: HTTP_HEADER
			l_msg: STRING
			hdate: HTTP_DATE
		do
			fixme ("Refactor code and create a simple abstraction to send messages")
			create h.make
			create l_msg.make_from_string (output)
			h.put_content_type_text_html
			h.put_content_length (l_msg.count)
			if attached media_variants.vary_header_value as l_vary then
				h.put_header_key_value ("Vary", l_vary)
			end
			if attached req.request_time as time then
				create hdate.make_from_date_time (time)
				h.add_header ("Date:" + hdate.rfc1123_string)
			end
			res.set_status_code ({HTTP_STATUS_CODE}.not_found)
			res.put_header_text (h.string)
			res.put_string (l_msg)
		end

	new_response_access_denied (req: WSF_REQUEST; res: WSF_RESPONSE; output: STRING)
		local
			h: HTTP_HEADER
			l_msg: STRING
			hdate: HTTP_DATE
		do
			create h.make
			create l_msg.make_from_string (output)
			h.put_content_type_text_html
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

	new_response_access_unauthorized (req: WSF_REQUEST; res: WSF_RESPONSE; output: STRING)
		local
			h: HTTP_HEADER
			l_msg: STRING
			hdate: HTTP_DATE
		do
			create h.make
			create l_msg.make_from_string (output)
			h.put_content_type_text_html
			h.put_content_length (l_msg.count)
--			h.put_header_key_value ({HTTP_HEADER_NAMES}.header_www_authenticate, "Basic realm=%"User%"")
			if attached media_variants.vary_header_value as l_vary then
				h.put_header_key_value ("Vary", l_vary)
			end
			if attached req.request_time as time then
				create hdate.make_from_date_time (time)
				h.add_header ("Date:" + hdate.rfc1123_string)
			end
			res.set_status_code ({HTTP_STATUS_CODE}.forbidden)
			res.put_header_text (h.string)
			res.put_string (l_msg)
		end


	compute_response_redirect (req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			h: HTTP_HEADER
			hdate: HTTP_DATE
		do
			create h.make
			h.put_content_type_text_html
			if attached req.request_time as time then
				create hdate.make_from_date_time (time)
				h.add_header ("Date:" + hdate.rfc1123_string)
				h.add_header ("Location:" + "/")
			end
			res.set_status_code ({HTTP_STATUS_CODE}.see_other)
			res.put_header_text (h.string)
		end

	handle_unauthorized (a_description: STRING; req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Handle forbidden.
		local
			h: HTTP_HEADER
		do
			create h.make
			h.put_content_type_text_html
			h.put_content_length (a_description.count)
			h.put_current_date
			h.put_header_key_value ({HTTP_HEADER_NAMES}.header_www_authenticate, "Basic realm=%"User%"")
			res.set_status_code ({HTTP_STATUS_CODE}.unauthorized)
			res.put_header_text (h.string)
			res.put_string (a_description)
		end


end

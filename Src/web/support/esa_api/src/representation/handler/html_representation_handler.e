note
	description: "Concreate class to converts data into the html representation."
	date: "$Date$"
	revision: "$Revision$"

class
	HTML_REPRESENTATION_HANDLER

inherit

	REPRESENTATION_HANDLER

	REFACTORING_HELPER

create
	make

feature -- View

	home_page (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Home page representation
		local
			l_hp: HOME_PAGE
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
			l_hp: REPORT_DETAIL_PAGE
		do
			if attached req.http_host as l_host then
				if attached {WSF_STRING} req.path_parameter ("id") as l_id and then l_id.is_integer then
					if attached api_service.problem_report (l_id.as_string.integer_value) as l_report then
						create l_hp.make ("http://" + l_host, l_report)
						if attached l_hp.representation as l_home_page then
							new_response_get (req, res, l_home_page)
						end
					else
						not_found_page (req, res)
					end
				else
					not_found_page (req, res)
					to_implement ("It's a bad request")
				end
			end
		end

	problem_reports_guest (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- <Precursor>
		local
			l_hp: REPORT_PAGE
			l_pages: INTEGER
		do
			if attached req.http_host as l_host then
				l_pages := api_service.row_count_problem_report_guest
				l_pages := l_pages // 10
				if attached {WSF_STRING} req.path_parameter ("id") as l_id then
					if l_id.is_integer then
						create l_hp.make ("http://" + l_host, api_service.problem_reports_guest (l_id.as_string.integer_value, 10), l_id.as_string.integer_value, l_pages)
						if attached l_hp.representation as l_home_page then
							new_response_get (req, res, l_home_page)
						end
					else
						to_implement ("Bad request")
					end
				else
					create l_hp.make ("http://" + l_host, api_service.problem_reports_guest (1, 10), 1, l_pages)
					if attached l_hp.representation as l_home_page then
						new_response_get (req, res, l_home_page)
					end
				end
			end
		end

	not_found_page (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Home page representation
		local
			l_hp: HTML_404_PAGE
		do
			if attached req.http_host as l_host then
				create l_hp.make ("http://" + l_host)
				if attached l_hp.representation as l_home_page then
					new_response_get_404 (req, res, l_home_page)
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

end

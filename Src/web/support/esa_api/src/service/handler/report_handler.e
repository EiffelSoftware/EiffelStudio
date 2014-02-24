note
	description: "Summary description for {REPORT_HANDLER}."
	date: "$Date$"
	revision: "$Revision$"

class
	REPORT_HANDLER

inherit

	WSF_FILTER

	WSF_URI_HANDLER
		rename
			execute as uri_execute,
			new_mapping as new_uri_mapping
		end

	WSF_URI_TEMPLATE_HANDLER
		rename
			execute as uri_template_execute,
			new_mapping as new_uri_template_mapping
		select
			new_uri_template_mapping
		end

	WSF_RESOURCE_HANDLER_HELPER
		redefine
			do_get
		end

	SHARED_API_SERVICE

	SHARED_CONNEG_HELPER

	REFACTORING_HELPER


feature -- execute

	execute (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Execute request handler
		do
			execute_methods (req, res)
			execute_next (req, res)
		end

	uri_execute (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Execute request handler
		do
			execute_methods (req, res)
		end

	uri_template_execute (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Execute request handler
		do
			execute_methods (req, res)
		end

feature -- HTTP Methods


	do_get (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Using GET to retrieve resource information.
			-- If the GET request is SUCCESS, we response with
			-- 200 OK, and a representation of the root collection JSON
			-- If the GET request is not SUCCESS, we response with
			-- 404 Resource not found and their corresponding error in collection json
		local
			media_variants: HTTP_ACCEPT_MEDIA_TYPE_VARIANTS
			l_rhf: REPRESENTATION_HANDLER_FACTORY
		do
			media_variants := media_type_variants (req)
			if media_variants.is_acceptable then
				if attached media_variants.media_type as l_type then
					create l_rhf
					l_rhf.new_representation_handler (l_type,media_variants).problem_reports_guest (req, res)
				end
			else
				create l_rhf
				l_rhf.new_representation_handler ("",media_variants).problem_reports_guest (req, res)
			end
			to_implement ("use case for registered users")
		end

--			local
--				l_hp: REPORT_PAGE
--				l_pages: INTEGER
--				l_cp: CJ_REPORT_PAGE
--			do
--				if attached req.http_host as l_host then
--					l_pages := api_service.row_count_problem_report_guest
--					l_pages := l_pages // 10
--					if attached req.path_parameter ("id") as l_id then
--						if attached req.http_accept as l_accept then
--							if l_accept.as_string_32.has_substring ("application/vnd.collection+json") then
--									-- CJ
--								create l_cp.make ("http://" + l_host, api_service.problem_reports_guest (l_id.as_string.integer_value, 10), l_id.as_string.integer_value, l_pages)
--								if attached l_cp.representation as l_cj_api then
--									compute_response_cj_get (req, res, l_cj_api)
--								end
--							else
--									-- HTML
--								create l_hp.make ("http://" + l_host, api_service.problem_reports_guest (l_id.as_string.integer_value, 10), l_id.as_string.integer_value, l_pages)
--								if attached l_hp.representation as l_home_page then
--									compute_response_get (req, res, l_home_page)
--								end
--							end
--						else
--								-- HTML
--							create l_hp.make ("http://" + l_host, api_service.problem_reports_guest (l_id.as_string.integer_value, 10), l_id.as_string.integer_value, l_pages)
--							if attached l_hp.representation as l_home_page then
--								compute_response_get (req, res, l_home_page)
--							end
--						end
--					else
--						if attached req.http_accept as l_accept then
--							if l_accept.as_string_32.has_substring ("application/vnd.collection+json") then
--									-- CJ
--								create l_cp.make ("http://" + l_host, api_service.problem_reports_guest (1, 10), 1, l_pages)
--								if attached l_cp.representation as l_cj_api then
--									compute_response_cj_get (req, res, l_cj_api)
--								end
--							else
--								create l_hp.make ("http://" + l_host, api_service.problem_reports_guest (1, 10), 1, l_pages)
--								if attached l_hp.representation as l_home_page then
--									compute_response_get (req, res, l_home_page)
--								end
--							end
--						else
--							create l_hp.make ("http://" + l_host, api_service.problem_reports_guest (1, 10), 1, l_pages)
--							if attached l_hp.representation as l_home_page then
--								compute_response_get (req, res, l_home_page)
--							end
--						end
--					end
--				end
--			end

feature -- HTML Responses

	compute_response_get (req: WSF_REQUEST; res: WSF_RESPONSE; output: STRING)
		local
			h: HTTP_HEADER
			l_msg: STRING
			hdate: HTTP_DATE
		do
			create h.make
			create l_msg.make_from_string (output)
			h.put_content_type_text_html
			h.put_content_length (l_msg.count)
			if attached req.request_time as time then
				create hdate.make_from_date_time (time)
				h.add_header ("Date:" + hdate.rfc1123_string)
			end
			res.set_status_code ({HTTP_STATUS_CODE}.ok)
			res.put_header_text (h.string)
			res.put_string (l_msg)
		end

	compute_response_get_txt (req: WSF_REQUEST; res: WSF_RESPONSE; output: STRING)
		local
			h: HTTP_HEADER
			l_msg: STRING
			hdate: HTTP_DATE
		do
			create h.make
			create l_msg.make_from_string (output)
			h.put_content_type_text_plain
			h.put_content_length (l_msg.count)
			if attached req.request_time as time then
				create hdate.make_from_date_time (time)
				h.add_header ("Date:" + hdate.rfc1123_string)
			end
			res.set_status_code ({HTTP_STATUS_CODE}.ok)
			res.put_header_text (h.string)
			res.put_string (l_msg)
		end

	compute_response_cj_get (req: WSF_REQUEST; res: WSF_RESPONSE; output: STRING)
		local
			h: HTTP_HEADER
			l_msg: STRING
			hdate: HTTP_DATE
		do
			create h.make
			create l_msg.make_from_string (output)
			h.put_content_type ("application/vnd.collection+json")
			h.put_content_length (l_msg.count)
			if attached req.request_time as time then
				create hdate.make_from_date_time (time)
				h.add_header ("Date:" + hdate.rfc1123_string)
			end
			res.set_status_code ({HTTP_STATUS_CODE}.ok)
			res.put_header_text (h.string)
			res.put_string (l_msg)
		end


end

note
	description: "[
		application service
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	EWF_ESA_API

inherit

	WSF_LAUNCHABLE_SERVICE
		redefine
			initialize
		end

	WSF_ROUTED_SERVICE

	WSF_URI_HELPER_FOR_ROUTED_SERVICE

	WSF_URI_TEMPLATE_HELPER_FOR_ROUTED_SERVICE

	APPLICATION_LAUNCHER

create
	make_and_launch

feature {NONE} -- Initialization

	initialize
			-- Initialize current service.
		do
			Precursor
			set_service_option ("port", 9090)
			create api_service.make
			initialize_router
		end

	setup_router
			-- Setup `router'
		local
			fhdl: WSF_FILE_SYSTEM_HANDLER
		do
			map_uri_agent_with_request_methods ("/", agent handle_home_page, router.methods_GET)
			map_uri_agent_with_request_methods ("/reports", agent handle_report_page, router.methods_GET)
			map_uri_template_agent_with_request_methods ("/reports/{id}", agent handle_report_page, router.methods_GET)
			map_uri_template_agent_with_request_methods ("/report_detail/{id}", agent handle_report_detail_page, router.methods_GET)
			map_uri_template_agent_with_request_methods ("/report_interaction/{id}/{name}", agent handle_report_interaction_download, router.methods_GET)
			router.handle_with_request_methods ("/doc", create {WSF_ROUTER_SELF_DOCUMENTATION_HANDLER}.make (router), router.methods_GET)
			create fhdl.make_hidden ("www")
			fhdl.set_directory_index (<<"index.html">>)
			router.handle_with_request_methods ("", fhdl, router.methods_GET)
		end

feature -- Database Provider

	api_service: API_SERVICE

feature -- Conneg

	conneg (req: WSF_REQUEST): SERVER_CONTENT_NEGOTIATION
			-- Content negotiatior for all requests
		once
			create Result.make ({HTTP_MIME_TYPES}.text_html, "en", "UTF-8", "identity")
		end

	mime_types_supported (req: WSF_REQUEST): LIST [STRING]
			-- All values for Accept header that `Current' can serve
		do
			create {ARRAYED_LIST [STRING]} Result.make_from_array (<<{HTTP_MIME_TYPES}.text_html, "application/vnd.collection+json">>)
			Result.compare_objects
		ensure
			mime_types_supported_includes_default: Result.has (conneg (req).default_media_type)
		end

	media_type_variants (req: WSF_REQUEST): HTTP_ACCEPT_MEDIA_TYPE_VARIANTS
			-- Media type negotiation
		do
			Result := conneg (req).media_type_preference (mime_types_supported (req), req.http_accept)
		end

feature -- Handle Responses
	-- Try to use Policy Framework.

	handle_home_page_old (req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			l_hp: HOME_PAGE
			l_cj: CJ_API_PAGE
			media_variants: HTTP_ACCEPT_MEDIA_TYPE_VARIANTS
		do
			media_variants := media_type_variants (req)
			if media_variants.is_acceptable then
				if attached req.http_host as l_host then
					if attached media_variants.media_type as l_type then
						if l_type.same_string ("application/vnd.collection+json") then
								-- Collection + JSON
							create l_cj.make ("http://" + l_host)
							if attached l_cj.representation as l_cj_api then
								compute_response_cj_get (req, res, l_cj_api)
							end
						elseif l_type.same_string ("text/html") then
								-- HTML
							create l_hp.make ("http://" + l_host)
							if attached l_hp.representation as l_home_page then
								compute_response_get (req, res, l_home_page)
							end
						end
					end
				end
			end
		end

	handle_home_page (req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			media_variants: HTTP_ACCEPT_MEDIA_TYPE_VARIANTS
			l_rhf: REPRESENTATION_HANDLER_FACTORY
		do
			media_variants := media_type_variants (req)
			if media_variants.is_acceptable then
				if attached media_variants.media_type as l_type then
					create l_rhf
					l_rhf.new_representation_handler (l_type).home_page (req, res)
				end
			end
		end

	handle_report_page (req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			l_hp: REPORT_PAGE
			l_pages: INTEGER
			l_cp: CJ_REPORT_PAGE
		do
			if attached req.http_host as l_host then
				l_pages := api_service.row_count_problem_report_guest
				l_pages := l_pages // 10
				if attached req.path_parameter ("id") as l_id then
					if attached req.http_accept as l_accept then
						if l_accept.as_string_32.has_substring ("application/vnd.collection+json") then
								-- CJ
							create l_cp.make ("http://" + l_host, api_service.problem_reports_guest (l_id.as_string.integer_value, 10), l_id.as_string.integer_value, l_pages)
							if attached l_cp.representation as l_cj_api then
								compute_response_cj_get (req, res, l_cj_api)
							end
						else
								-- HTML
							create l_hp.make ("http://" + l_host, api_service.problem_reports_guest (l_id.as_string.integer_value, 10), l_id.as_string.integer_value, l_pages)
							if attached l_hp.representation as l_home_page then
								compute_response_get (req, res, l_home_page)
							end
						end
					else
							-- HTML
						create l_hp.make ("http://" + l_host, api_service.problem_reports_guest (l_id.as_string.integer_value, 10), l_id.as_string.integer_value, l_pages)
						if attached l_hp.representation as l_home_page then
							compute_response_get (req, res, l_home_page)
						end
					end
				else
					if attached req.http_accept as l_accept then
						if l_accept.as_string_32.has_substring ("application/vnd.collection+json") then
								-- CJ
							create l_cp.make ("http://" + l_host, api_service.problem_reports_guest (1, 10), 1, l_pages)
							if attached l_cp.representation as l_cj_api then
								compute_response_cj_get (req, res, l_cj_api)
							end
						else
							create l_hp.make ("http://" + l_host, api_service.problem_reports_guest (1, 10), 1, l_pages)
							if attached l_hp.representation as l_home_page then
								compute_response_get (req, res, l_home_page)
							end
						end
					else
						create l_hp.make ("http://" + l_host, api_service.problem_reports_guest (1, 10), 1, l_pages)
						if attached l_hp.representation as l_home_page then
							compute_response_get (req, res, l_home_page)
						end
					end
				end
			end
		end

	handle_report_detail_page (req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			l_hp: REPORT_DETAIL_PAGE
			l_report: detachable REPORT
			l_cj: CJ_REPORT_DETAIL_PAGE
		do
			if attached req.http_host as l_host then
				if attached req.path_parameter ("id") as l_id then
					if attached req.http_accept as l_accept then
						if l_accept.as_string_32.has_substring ("application/vnd.collection+json") then
								-- Collection + JSON
							l_report := api_service.problem_report (l_id.as_string.integer_value)
							create l_cj.make ("http://" + l_host, l_report)
							if attached l_cj.representation as l_cj_api then
								compute_response_cj_get (req, res, l_cj_api)
							end
						else
								-- HTML
							l_report := api_service.problem_report (l_id.as_string.integer_value)
							create l_hp.make ("http://" + l_host, l_report)
							if attached l_hp.representation as l_home_page then
								compute_response_get (req, res, l_home_page)
							end
						end
					else -- HTML default
						l_report := api_service.problem_report (l_id.as_string.integer_value)
						create l_hp.make ("http://" + l_host, l_report)
						if attached l_hp.representation as l_home_page then
							compute_response_get (req, res, l_home_page)
						end
					end
				end
			end
		end

	handle_report_interaction_download (req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			l_hp: REPORT_DETAIL_PAGE
			l_report: detachable REPORT
			l_interactions: LIST [REPORT_INTERACTION]
			l_attachments: LIST [REPORT_ATTACHMENT]
		do
			if attached req.http_host as l_host then
				if attached req.path_parameter ("id") as l_id and then attached req.path_parameter ("name") as l_name then
					compute_response_get_txt (req, res, api_service.attachments_content (l_id.as_string.integer_value))
				end
					--TODO
			end
		end

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

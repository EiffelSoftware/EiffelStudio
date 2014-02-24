note
	description: "Summary description for {REPORT_INTERACTION_HANDLER}."
	date: "$Date$"
	revision: "$Revision$"

class
	REPORT_INTERACTION_HANDLER

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

feature -- Response	
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
end

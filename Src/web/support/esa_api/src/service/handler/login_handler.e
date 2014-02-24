note
	description: "Summary description for {LOGIN_HANDLER}."
	date: "$Date$"
	revision: "$Revision$"

class
	LOGIN_HANDLER

inherit
	WSF_FILTER

	WSF_URI_HANDLER
		rename
			execute as uri_execute,
			new_mapping as new_uri_mapping
		end

--	WSF_URI_TEMPLATE_HANDLER
--		rename
--			execute as uri_template_execute,
--			new_mapping as new_uri_template_mapping
--		select
--			new_uri_template_mapping
--		end

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

feature -- HTTP Methods


	do_get (req: WSF_REQUEST; res: WSF_RESPONSE)
		do
			if attached {STRING_32} req.execution_variable ("user") as l_user and then
			  not l_user.is_equal ("Guest") then
				-- Valid user
				to_implement ("Add logic when a registered users logged in, maybe Statistics etc!!!.")
				compute_response_redirect (req, res)
			else
				handle_unauthorized ("Unauthorized",req, res)
			end
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


	compute_response_redirect (req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			h: HTTP_HEADER
			l_msg: STRING
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

end

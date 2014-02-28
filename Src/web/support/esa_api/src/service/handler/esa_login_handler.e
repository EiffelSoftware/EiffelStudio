note
	description: "Handle Basic Authentication"
	date: "$Date$"
	revision: "$Revision$"

class
	ESA_LOGIN_HANDLER

inherit
	ESA_ABSTRACT_HANDLER
		rename
			set_esa_config as make
		end

	WSF_URI_HANDLER
		rename
			execute as uri_execute,
			new_mapping as new_uri_mapping
		end

	WSF_FILTER


	WSF_RESOURCE_HANDLER_HELPER
		redefine
			do_get
		end

	REFACTORING_HELPER

create
	make

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
		local
			media_variants: HTTP_ACCEPT_MEDIA_TYPE_VARIANTS
			l_rhf: ESA_REPRESENTATION_HANDLER_FACTORY
		do
			media_variants := media_type_variants (req)
			if media_variants.is_acceptable then
				if attached media_variants.media_type as l_type then
					create l_rhf
					l_rhf.new_representation_handler (esa_config, l_type, media_variants).login_page (req, res)
				end
			else
				create l_rhf
				l_rhf.new_representation_handler (esa_config, "", media_variants).login_page (req, res)
			end
		end




	do_get2 (req: WSF_REQUEST; res: WSF_RESPONSE)
		do
			to_implement ("Check different browsers!!!")
			if attached {STRING_32} req.execution_variable ("user") as l_user and then
				api_service.is_active (l_user) then
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

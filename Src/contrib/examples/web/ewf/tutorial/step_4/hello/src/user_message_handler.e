note
	description: "[
				Handler to process /user/{user}/message/ requests
			]"
	date: "$Date$"
	revision: "$Revision$"

class
	USER_MESSAGE_HANDLER

inherit
	WSF_URI_TEMPLATE_RESPONSE_HANDLER
	SHARED_WSF_PERCENT_ENCODER
		rename
			percent_encoder as url_encoder
		end

feature -- Access

	response (req: WSF_REQUEST): WSF_RESPONSE_MESSAGE
		local
			l_username: READABLE_STRING_32
		do
			if attached {WSF_STRING} req.path_parameter ("user") as u then
				l_username := html_decoded_string (u.value)
				if req.is_request_method ("GET") then
					Result := user_message_get (l_username, req)
				elseif req.is_request_method ("POST") then
					Result := user_message_response_post (l_username, req)
				else
					Result := unsupported_method_response (req)
				end
			else
				Result := missing_argument_response ("Missing parameter 'user'.", req)
			end
		end

	missing_argument_response (m: READABLE_STRING_8; req: WSF_REQUEST): WSF_PAGE_RESPONSE
		do
			create Result.make
			Result.set_status_code ({HTTP_STATUS_CODE}.bad_request)
			Result.put_string (req.request_uri + ": " + m)
		end

	unsupported_method_response (req: WSF_REQUEST): WSF_PAGE_RESPONSE
		do
			create Result.make
			Result.set_status_code ({HTTP_STATUS_CODE}.bad_request)
			Result.put_string (req.request_uri + " only support: GET and POST; " + req.request_method + " is not supported.")
		end


	user_message_get (u: READABLE_STRING_32; req: WSF_REQUEST): WSF_HTML_PAGE_RESPONSE
		local
			s: STRING_8
		do
			create Result.make
			s := "<p>No message from user '" + Result.html_encoded_string (u) + "'.</p>"
			s.append ("<form action=%""+ req.request_uri +"%" method=%"POST%">")
			s.append ("<textarea name=%"message%" rows=%"10%" cols=%"70%" ></textarea>")
			s.append ("<input type=%"submit%" value=%"Ok%" />")
			s.append ("</form>")
			Result.set_body (s)
		end

	user_message_response_post (u: READABLE_STRING_32; req: WSF_REQUEST): WSF_HTML_PAGE_RESPONSE
		local
			s: STRING_8
		do
			create Result.make
			s := "<p>Message from user '<a href=%"/users/" + url_encoded_string (u) + "/%">" + Result.html_encoded_string (u) + "</a>'.</p>"
			if attached {WSF_STRING} req.form_parameter ("message") as m and then not m.is_empty then
				s.append ("<textarea>"+ m.value +"</textarea>")
			else
				s.append ("<strong>No or empty message!</strong>")
			end
			Result.set_body (s)
		end

	url_encoded_string (s: READABLE_STRING_32): STRING_8
		do
			create Result.make (s.count)
			url_encoder.append_percent_encoded_string_to (s, Result)
		end

	html_decoded_string (v: READABLE_STRING_32): READABLE_STRING_32
		do
			if v.is_valid_as_string_8 then
				Result := (create {HTML_ENCODER}).general_decoded_string (v)
			else
				Result := v
			end
		end

end

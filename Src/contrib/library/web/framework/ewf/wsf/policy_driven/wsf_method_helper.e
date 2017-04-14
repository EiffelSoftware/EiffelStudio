note

	description: "[
						Policy-driven helpers to implement a method.

					  ]"
	date: "$Date$"
	revision: "$Revision$"

deferred class WSF_METHOD_HELPER

inherit

	HTTP_STATUS_CODE_MESSAGES

	SHARED_HTML_ENCODER
		export {NONE} all end

feature -- Access

	resource_exists: BOOLEAN
			-- Does the requested resource (request URI) exist?

feature -- Setting

	set_resource_exists
			-- Set `resource_exists' to `True'.
		do
			resource_exists := True
		ensure
			set: resource_exists
		end

feature -- Basic operations

	execute_new_resource (req: WSF_REQUEST; res: WSF_RESPONSE; a_handler: WSF_SKELETON_HANDLER)
			-- Write response to non-existing resource requested by  `req.' into `res'.
			-- Policy routines are available in `a_handler'.
			-- Upto four execution variables may be set on `req':
			-- "NEGOTIATED_MEDIA_TYPE"
			-- "NEGOTIATED_LANGUAGE"
			-- "NEGOTIATED_CHARSET"
			-- "NEGOTIATED_ENCODING"
			-- An HTTP_HEADER is also available as the execution variable "NEGOTIATED_HTTP_HEADER".
			-- It includes the Vary header (if any)
		require
			req_attached: req /= Void
			res_attached: res /= Void
			a_handler_attached: a_handler /= Void
		local
			l_locs: LIST [URI]
		do
			if a_handler.resource_previously_existed (req) then
				if a_handler.resource_moved_permanently (req) then
					l_locs := a_handler.previous_location (req)
					handle_redirection_error (req, res, l_locs, {HTTP_STATUS_CODE}.moved_permanently)
				elseif a_handler.resource_moved_temporarily (req) then
					l_locs := a_handler.previous_location (req)
					handle_redirection_error (req, res, l_locs, {HTTP_STATUS_CODE}.found)
				else
					check attached {HTTP_HEADER} req.execution_variable (a_handler.Negotiated_http_header_execution_variable) as h then
						-- postcondition header_attached of `handle_content_negotiation'
						h.put_content_type_text_plain
						h.put_current_date
						h.put_content_length (0)
						res.set_status_code ({HTTP_STATUS_CODE}.gone)
						res.put_header_lines (h)
					end
				end
			else
				check attached {HTTP_HEADER} req.execution_variable (a_handler.Negotiated_http_header_execution_variable) as h then
						-- postcondition header_attached of `handle_content_negotiation'
					h.put_content_type_text_plain
					h.put_current_date
					h.put_content_length (0)
					res.set_status_code ({HTTP_STATUS_CODE}.not_found)
					res.put_header_lines (h)
				end
			end
		end

	execute_existing_resource (req: WSF_REQUEST; res: WSF_RESPONSE; a_handler: WSF_SKELETON_HANDLER)
			-- Write response to existing resource requested by  `req' into `res'.
			-- Policy routines are available in `a_handler'.
			-- Upto four execution variables may be set on `req':
			-- "NEGOTIATED_MEDIA_TYPE"
			-- "NEGOTIATED_LANGUAGE"
			-- "NEGOTIATED_CHARSET"
			-- "NEGOTIATED_ENCODING"
		require
			req_attached: req /= Void
			res_attached: res /= Void
			a_handler_attached: a_handler /= Void
			not_if_match_star: attached req.http_if_match as l_if_match implies not l_if_match.same_string ("*")
		local
			l_etags: LIST [READABLE_STRING_8]
			l_failed: BOOLEAN
			l_date: HTTP_DATE
		do
			if attached req.http_if_match as l_if_match then
				-- also if-range when we add support for range requests
				if not l_if_match.same_string ("*") then
					l_etags := l_if_match.split (',')
					l_failed := not across l_etags as i_etags some a_handler.matching_etag (req, i_etags.item, True) end
				end
			end
			if l_failed then
				handle_precondition_failed (req, res)
			else
				if attached req.http_if_unmodified_since as l_if_unmodified_since then
					create l_date.make_from_string (l_if_unmodified_since)
					if not l_date.has_error then
						if a_handler.modified_since (req, l_date.date_time) then
							handle_precondition_failed (req, res)
							l_failed := True
						end
					end
				end
				if not l_failed then
					if attached req.http_if_none_match as l_if_none_match then
						l_etags := l_if_none_match.split (',')
						l_failed := l_if_none_match.same_string ("*") or
							across l_etags as i_etags some a_handler.matching_etag (req, i_etags.item, False) end
					end
					if l_failed then
						handle_if_none_match_failed (req, res, a_handler)
					else
						if attached req.http_if_modified_since as l_if_modified_since then
							create l_date.make_from_string (l_if_modified_since)
							if not l_date.has_error then
								if not a_handler.modified_since (req, l_date.date_time) then
									handle_not_modified (req, res, a_handler)
									l_failed := True
								end
							end
						end
					end
					if not l_failed then
						check attached {HTTP_HEADER} req.execution_variable (a_handler.Negotiated_http_header_execution_variable) as h then
								-- postcondition header_attached of `handle_content_negotiation'
							send_response (req, res, a_handler, h, False)
						end
					end
				end
			end
		end

feature -- Content negotiation

	handle_content_negotiation (req: WSF_REQUEST; res: WSF_RESPONSE; a_handler: WSF_SKELETON_HANDLER)
			-- Negotiate acceptable content for, then write, response requested by `req' into `res'.
			-- Policy routines are available in `a_handler'.
			--
			-- Either a 406 Not Acceptable error is sent, or upto four execution variables may be set on `req':
			-- "NEGOTIATED_MEDIA_TYPE"
			-- "NEGOTIATED_LANGUAGE"
			-- "NEGOTIATED_CHARSET"
			-- "NEGOTIATED_ENCODING"
			-- An HTTP_HEADER is also saved as the execution variable "NEGOTIATED_HTTP_HEADER".
			-- It includes the Vary header (if any)
		require
			req_attached: req /= Void
			res_attached: res /= Void
			a_handler_attached: a_handler /= Void
		local
			l_conneg: SERVER_CONTENT_NEGOTIATION
			h: HTTP_HEADER
			l_media: HTTP_ACCEPT_MEDIA_TYPE_VARIANTS
			l_lang: HTTP_ACCEPT_LANGUAGE_VARIANTS
			l_charset: HTTP_ACCEPT_CHARSET_VARIANTS
			l_encoding: HTTP_ACCEPT_ENCODING_VARIANTS
			l_mime_types, l_langs, l_charsets, l_encodings: LIST [STRING]
			l_vary_star: BOOLEAN
		do
			create h.make
			l_vary_star := not a_handler.predictable_response (req)
			if l_vary_star then
				h.add_header_key_value ({HTTP_HEADER_NAMES}.header_vary, "*")
			elseif attached a_handler.additional_variant_headers (req) as l_additional then
				across l_additional as i_additional loop
					h.add_header_key_value ({HTTP_HEADER_NAMES}.header_vary, i_additional.item)
				end
			end
			l_conneg := a_handler.conneg (req)
			l_mime_types := a_handler.mime_types_supported (req)
			l_media := l_conneg.media_type_preference (l_mime_types, req.http_accept)
			if not l_vary_star and l_mime_types.count > 1 and attached l_media.vary_header_value as l_media_variant then
				h.add_header_key_value ({HTTP_HEADER_NAMES}.header_vary, l_media_variant)
			end
			if not l_media.is_acceptable then
				handle_not_acceptable ("None of the requested ContentTypes were acceptable", l_mime_types, req, res)
			else
				l_langs := a_handler.languages_supported (req)
				l_lang := l_conneg.language_preference (l_langs, req.http_accept_language)
				if not l_vary_star and l_langs.count > 1 and attached l_lang.vary_header_value as l_lang_variant then
					h.add_header_key_value ({HTTP_HEADER_NAMES}.header_vary, l_lang_variant)
				end
				if not l_lang.is_acceptable then
					handle_not_acceptable ("None of the requested languages were acceptable", l_langs, req, res)
				else
					if attached l_lang.language as l_language_type then
						h.put_content_language (l_language_type)
						req.set_execution_variable (a_handler.Negotiated_language_execution_variable, l_language_type)
					end
					l_charsets := a_handler.charsets_supported (req)
					l_charset := l_conneg.charset_preference (l_charsets, req.http_accept_charset)
					if not l_vary_star and l_charsets.count > 1 and attached l_charset.vary_header_value as l_charset_variant then
						h.add_header_key_value ({HTTP_HEADER_NAMES}.header_vary, l_charset_variant)
					end
					if not l_charset.is_acceptable then
						handle_not_acceptable ("None of the requested character encodings were acceptable", l_charsets, req, res)
					else
						if attached l_media.media_type as l_media_type then
							if attached l_charset.charset as l_character_type  then
								h.put_content_type (l_media_type + "; charset=" + l_character_type)
								req.set_execution_variable (a_handler.Negotiated_charset_execution_variable, l_charset)
							else
								h.put_content_type (l_media_type)
							end
							req.set_execution_variable (a_handler.Negotiated_media_type_execution_variable, l_media_type)
						end
						l_encodings := a_handler.encodings_supported (req)
						l_encoding := l_conneg.encoding_preference (l_encodings, req.http_accept_encoding)
						if not l_vary_star and l_encodings.count > 1 and attached l_encoding.vary_header_value as l_encoding_variant then
							h.add_header_key_value ({HTTP_HEADER_NAMES}.header_vary, l_encoding_variant)
						end
						if not l_encoding.is_acceptable then
							handle_not_acceptable ("None of the requested transfer encodings were acceptable", l_encodings, req, res)
						else
							if attached l_encoding.encoding as l_compression_type then
								h.put_content_encoding (l_compression_type)
								req.set_execution_variable (a_handler.Negotiated_encoding_execution_variable, l_compression_type)
							end
						end
					end
				end
			end
			req.set_execution_variable (a_handler.Negotiated_http_header_execution_variable, h)
		ensure
			header_attached: attached {HTTP_HEADER} req.execution_variable (a_handler.Negotiated_http_header_execution_variable)
		end

feature {NONE} -- Implementation

	send_response (req: WSF_REQUEST; res: WSF_RESPONSE; a_handler: WSF_SKELETON_HANDLER; a_header: HTTP_HEADER; a_new_resource: BOOLEAN)
			-- Write response to `req' into `res'.
			-- Upto four execution variables may be set on `req':
			-- "NEGOTIATED_MEDIA_TYPE"
			-- "NEGOTIATED_LANGUAGE"
			-- "NEGOTIATED_CHARSET"
			-- "NEGOTIATED_ENCODING"
		require
			req_attached: req /= Void
			res_attached: res /= Void
			a_handler_attached: a_handler /= Void
			a_header_attached: a_header /= Void
		deferred
		end

	send_chunked_response (req: WSF_REQUEST; res: WSF_RESPONSE; a_handler: WSF_SKELETON_HANDLER; a_header: HTTP_HEADER)
			-- Write response in chunks to `req'.
			-- Upto four execution variables may be set on `req':
			-- "NEGOTIATED_MEDIA_TYPE"
			-- "NEGOTIATED_LANGUAGE"
			-- "NEGOTIATED_CHARSET"
			-- "NEGOTIATED_ENCODING"
		require
			req_attached: req /= Void
			res_attached: res /= Void
			a_handler_attached: a_handler /= Void
		local
			l_chunk: TUPLE [a_chunk: READABLE_STRING_8; a_extension: detachable READABLE_STRING_8]
		do
			from
				if a_handler.response_ok (req) then
					l_chunk := a_handler.next_chunk (req)
					res.put_chunk (l_chunk.a_chunk, l_chunk.a_extension)
				else
					write_error_response (req, res)
				end
			until
				a_handler.finished (req) or not a_handler.response_ok (req)
			loop
				a_handler.generate_next_chunk (req)
				if a_handler.response_ok (req) then
					l_chunk := a_handler.next_chunk (req)
					res.put_chunk (l_chunk.a_chunk, l_chunk.a_extension)
				else
					write_error_response (req, res)
				end
			end
			if a_handler.finished (req) then
				-- In future, add support for trailers
				res.put_chunk_end
			end
		end

	generate_cache_headers (req: WSF_REQUEST; a_handler: WSF_SKELETON_HANDLER; a_header: HTTP_HEADER; a_request_time: DATE_TIME)
			-- Write headers affecting caching for `req' into `a_header'.
		require
			req_attached: req /= Void
			a_handler_attached: a_handler /= Void
			a_header_attached: a_header /= Void
			a_request_time_attached: a_request_time /= Void
		local
			l_age, l_age_1, l_age_2: NATURAL
			l_dur: DATE_TIME_DURATION
			l_dt, l_field_names: STRING
		do
			l_age := a_handler.http_1_0_age (req)
			create l_dur.make (0, 0, 0, 0, 0, l_age.as_integer_32)
			l_dt := (create {HTTP_DATE}.make_from_date_time (a_request_time + l_dur)).rfc1123_string
			a_header.put_header_key_value ({HTTP_HEADER_NAMES}.header_expires, l_dt)
			l_age_1 := a_handler.max_age (req)
			if l_age_1 /= l_age then
				a_header.add_header_key_value ({HTTP_HEADER_NAMES}.header_cache_control, "max-age=" + l_age_1.out)
			end
			l_age_2 := a_handler.shared_age (req)
			if l_age_2 /= l_age_1 then
				a_header.add_header_key_value ({HTTP_HEADER_NAMES}.header_cache_control, "s-maxage=" + l_age_2.out)
			end
			if a_handler.is_freely_cacheable (req) then
				a_header.add_header_key_value ({HTTP_HEADER_NAMES}.header_cache_control, "public")
			elseif attached a_handler.private_headers (req) as l_fields then
				l_field_names := "="
				if not l_fields.is_empty then
					append_field_name (l_field_names, l_fields)
				end
				a_header.add_header_key_value ({HTTP_HEADER_NAMES}.header_cache_control, "private" + l_field_names)
			end
			if attached a_handler.non_cacheable_headers (req) as l_fields then
				l_field_names := "="
				if not l_fields.is_empty then
					append_field_name (l_field_names, l_fields)
				end
				a_header.add_header_key_value ({HTTP_HEADER_NAMES}.header_cache_control, "no-cache" + l_field_names)
			end
			if not a_handler.is_transformable (req) then
				a_header.add_header_key_value ({HTTP_HEADER_NAMES}.header_cache_control, "no-transform")
			end
			if a_handler.must_revalidate (req) then
				a_header.add_header_key_value ({HTTP_HEADER_NAMES}.header_cache_control, "must-revalidate")
			end
			if a_handler.must_proxy_revalidate (req) then
				a_header.add_header_key_value ({HTTP_HEADER_NAMES}.header_cache_control, "proxy-revalidate")
			end
		end

	append_field_name (a_field_names: STRING; a_fields: LIST [READABLE_STRING_8])
			-- Append all of `a_fields' as a comma-separated list to `a_field_names'.
		require
			a_field_names_attached: a_field_names /= Void
			a_fields_attached: a_fields /= Void
		do
			across a_fields as i_fields loop
				a_field_names.append_string (i_fields.item)
				if not i_fields.is_last then
					a_field_names.append_character (',')
				end
			end
		end


feature -- Error reporting

	write_error_response (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Write an error response to `res' using `req.error_handler'.
		require
			req_attached: req /= Void
			res_attached: res /= Void
			req_has_error: req.has_error
		local
			h: HTTP_HEADER
			m: READABLE_STRING_8
			utf: UTF_CONVERTER
		do
			m := utf.string_32_to_utf_8_string_8 (req.error_handler.as_string_representation)
			create h.make
			h.put_content_type_utf_8_text_plain
			h.put_content_length (m.count)
			res.set_status_code (req.error_handler.primary_error_code)
			res.put_header_lines (h)
			res.put_string (m)
		end

	handle_redirection_error (req: WSF_REQUEST; res: WSF_RESPONSE; a_locations: LIST [URI]; a_status_code: INTEGER)
			-- Write `a_status_code' error to `res'.
			-- Include all of `a_locations' in the headers, and hyperlink to the first one in the body.
		require
			res_attached: res /= Void
			req_attached: req /= Void
			a_locations_attached: a_locations /= Void
			a_location_not_empty: not a_locations.is_empty
			a_status_code_code: is_valid_http_status_code (a_status_code)
		local
			h: HTTP_HEADER
			s: STRING
		do
			if attached http_status_code_message (a_status_code) as l_msg then
				create h.make
				across a_locations as i_location loop
					h.add_header_key_value ({HTTP_HEADER_NAMES}.header_location, i_location.item.string)
				end
				if req.is_content_type_accepted ({HTTP_MIME_TYPES}.text_html) then
					s := "<html lang=%"en%"><head>"
					s.append ("<title>")
					s.append (html_encoder.general_encoded_string (req.request_uri))
					s.append ("Error " + a_status_code.out + " (" + l_msg + ")")
					s.append ("</title>%N")
					s.append ("[
						<style type="text/css">
						div#header {color: #fff; background-color: #000; padding: 20px; text-align: center; font-size: 2em; font-weight: bold;}
						div#message { margin: 40px; text-align: center; font-size: 1.5em; }
						div#suggestions { margin: auto; width: 60%;}
						div#suggestions ul { }
						div#footer {color: #999; background-color: #eee; padding: 10px; text-align: center; }
						div#logo { float: right; margin: 20px; width: 60px height: auto; font-size: 0.8em; text-align: center; }
						div#logo div.outer { padding: 6px; width: 60px; border: solid 3px #500; background-color: #b00;}
						div#logo div.outer div.inner1 { display: block; margin: 10px 15px;  width: 30px; height: 50px; color: #fff; background-color: #fff; border: solid 2px #900; }
						div#logo div.outer div.inner2 { margin: 10px 15px; width: 30px; height: 15px; color: #fff; background-color: #fff; border: solid 2px #900; }
						</style>
						</head>
						<body>
					]")
					s.append ("<div id=%"header%">Error " + a_status_code.out + " (" + l_msg + ")</div>")
					s.append ("<div id=%"logo%">")
					s.append ("<div class=%"outer%"> ")
					s.append ("<div class=%"inner1%"></div>")
					s.append ("<div class=%"inner2%"></div>")
					s.append ("</div>")
					s.append ("The current location for this resource is <a href=%"" + a_locations.first.string + "%">here</a>")
					s.append ("Error " + a_status_code.out + " (" + l_msg + ")</div>")
					s.append ("<div id=%"message%">Error " + a_status_code.out + " (" + l_msg + "): <code>" + html_encoder.general_encoded_string (req.request_uri) + "</code></div>")
					s.append ("<div id=%"footer%"></div>")
					s.append ("</body>%N")
					s.append ("</html>%N")

					h.put_content_type_text_html
				else
					s := "Error " + a_status_code.out + " (" + l_msg + "): "
					s.append (req.request_uri)
					s.append_character ('%N')
					s.append ("The current location for this resource is " + a_locations.first.string)
					h.put_content_type_text_plain
				end
				h.put_content_length (s.count)
				res.put_header_lines (h)
				res.put_string (s)
				res.flush
			end
		end

	handle_not_acceptable (a_message: READABLE_STRING_8; a_supported: LIST [STRING]; req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Write a Not Acceptable response to `res'.
		require
			req_attached: req /= Void
			res_attached: res /= Void
			a_message_attached: a_message /= Void
			a_supported_attached: a_supported /= Void
		local
			h: HTTP_HEADER
			s: STRING
		do
			create h.make
			h.put_content_type_text_plain
			h.put_current_date
			s := a_message
			s.append_character ('%N')
			s.append_character ('%N')
			s.append_string ("We accept the following:%N%N")
			across a_supported as i_supported loop
				s.append_string (i_supported.item)
				s.append_character ('%N')
			end
			h.put_content_length (s.count)
			res.set_status_code ({HTTP_STATUS_CODE}.not_acceptable)
			res.put_header_lines (h)
			res.put_string (s)
			res.flush
		end

	handle_if_none_match_failed (req: WSF_REQUEST; res: WSF_RESPONSE; a_handler: WSF_SKELETON_HANDLER)
			-- Write a Not Modified response to `res'.
		require
			req_attached: req /= Void
			res_attached: res /= Void
			a_handler_attached: a_handler /= Void
		do
			handle_not_modified (req, res, a_handler)
		end

	handle_not_modified (req: WSF_REQUEST; res: WSF_RESPONSE; a_handler: WSF_SKELETON_HANDLER)
			-- Write a Not Modified response to `res'.
			-- Upto four execution variables may be set on `req':
			-- "NEGOTIATED_MEDIA_TYPE"
			-- "NEGOTIATED_LANGUAGE"
			-- "NEGOTIATED_CHARSET"
			-- "NEGOTIATED_ENCODING"
		require
			req_attached: req /= Void
			res_attached: res /= Void
			a_handler_attached: a_handler /= Void
		local
			h: HTTP_HEADER
		do
			create h.make
			h.put_content_type_text_plain
			h.put_content_length (0)
			if attached a_handler.etag (req) as l_etag then
				h.put_header_key_value ({HTTP_HEADER_NAMES}.header_etag, l_etag)
			end
			generate_cache_headers (req, a_handler, h, create {DATE_TIME}.make_now_utc)
			res.set_status_code ({HTTP_STATUS_CODE}.not_modified)
			res.put_header_lines (h)
		end

	handle_precondition_failed  (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Write a Precondition Failed response for `req' to `res'.
		require
			req_attached: req /= Void
			res_attached: res /= Void
		local
			h: HTTP_HEADER
		do
			create h.make
			h.put_content_type_text_plain
			h.put_current_date
			h.put_content_length (0)
			res.set_status_code ({HTTP_STATUS_CODE}.precondition_failed)
			res.put_header_lines (h)
		end

	handle_unsupported_media_type (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Write a Unsupported Media Type response for `req' to `res'.
		require
			req_attached: req /= Void
			res_attached: res /= Void
		local
			h: HTTP_HEADER
		do
			create h.make
			h.put_content_type_text_plain
			h.put_current_date
			h.put_content_length (0)
			res.set_status_code ({HTTP_STATUS_CODE}.unsupported_media_type)
			res.put_header_lines (h)
		end

	handle_not_implemented (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Write a Not Implemented response for `req' to `res'.
		require
			req_attached: req /= Void
			res_attached: res /= Void
		local
			h: HTTP_HEADER
		do
			create h.make
			h.put_content_type_text_plain
			h.put_current_date
			h.put_content_length (0)
			res.set_status_code ({HTTP_STATUS_CODE}.not_implemented)
			res.put_header_lines (h)
		end

	handle_request_entity_too_large (req: WSF_REQUEST; res: WSF_RESPONSE; a_handler: WSF_SKELETON_HANDLER)
			-- Write a Request Entity Too Large response for `req' to `res'.
		require
			req_attached: req /= Void
			res_attached: res /= Void
			a_handler_attached: a_handler /= Void
		local
			h: HTTP_HEADER
		do
			create h.make
			h.put_content_type_text_plain
			h.put_current_date
			h.put_content_length (0)
			res.set_status_code ({HTTP_STATUS_CODE}.request_entity_too_large)
			res.put_header_lines (h)
			-- FIXME: Need to check if condition is temporary. This needs a new query
			-- on the handler. For now we can claim compliance by saying the condition
			-- is always permenent :-) - author's might not like this though.
		end

note
	copyright: "2011-2017, Colin Adams, Jocelyn Fiat, Javier Velilla, Olivier Ligot, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end

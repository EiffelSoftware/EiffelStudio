note
	description: "[
			This class is used to respond a TRACE request
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	WSF_TRACE_RESPONSE

inherit
	WSF_RESPONSE_MESSAGE

create
	make

feature {NONE} -- Initialization

	make (req: WSF_REQUEST)
		do
			request := req
			create header.make
		end

feature -- Header

	header: HTTP_HEADER
			-- Response' header

	request: WSF_REQUEST
			-- Associated request.

feature {WSF_RESPONSE} -- Output

	send_to (res: WSF_RESPONSE)
		note
			EIS: "name=RFC7231 section 4.3.8", "protocol=URI", "src=https://tools.ietf.org/html/rfc7231#section-4.3.8"
		local
			s: STRING
			t: STRING
			h: like header
			req: like request
			n, nb: INTEGER
		do
			h := header
			res.set_status_code ({HTTP_STATUS_CODE}.ok)
			h.put_content_type_message_http
			req := request
			if attached req.raw_header_data as l_header then
				create s.make (l_header.count)
				s.append (l_header.to_string_8) -- Is valid as string 8, as ensured by req.raw_header_data
				s.append_character ('%N')
			else
				create s.make_empty
			end
			if req.is_chunked_input then
				h.put_transfer_encoding_chunked
				res.put_header_text (h.string)
				res.put_chunk (s, Void)
				if attached req.input as l_input then
					if attached {WGI_CHUNKED_INPUT_STREAM} l_input as l_chunked_input then
						from
							l_chunked_input.read_chunk
						until
							l_chunked_input.last_chunk_size = 0
						loop
							res.put_chunk (l_chunked_input.last_chunk_data, l_chunked_input.last_chunk_extension)
							l_chunked_input.read_chunk
						end
						res.put_custom_chunk_end (l_chunked_input.last_chunk_extension, l_chunked_input.last_trailer)
					else
						check is_chunked_input: False end
						from
							n := 8_192
						until
							n = 0
						loop
							s.wipe_out
							nb := l_input.read_to_string (s, 1, n)
							if nb = 0 then
								n := 0
							else
								if nb < n then
									n := 0
								end
								res.put_chunk (s, Void)
							end
						end
						res.put_chunk_end
					end
				end
				res.flush
			else
				create t.make (req.content_length_value.to_integer_32)
				req.read_input_data_into (t)
				h.put_content_length (s.count + t.count)
				res.put_header_text (h.string)
				res.put_string (s)
				res.put_string (t)
				res.flush
			end
		end

note
	copyright: "2011-2014, Jocelyn Fiat, Javier Velilla, Olivier Ligot, Colin Adams, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end

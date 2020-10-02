note
	description: "Summary description for {WSF_MULTIPART_FORM_DATA_HANDLER}."
	date: "$Date$"
	revision: "$Revision$"

class
	WSF_MULTIPART_FORM_DATA_HANDLER

inherit
	WSF_MIME_HANDLER

	WSF_MIME_HANDLER_HELPER

create
	make

feature {NONE} -- Initialization

	make
			-- Instantiate Current
		do
		end

feature -- Status report

	valid_content_type (a_content_type: HTTP_CONTENT_TYPE): BOOLEAN
		do
			Result := a_content_type.same_simple_type ({HTTP_MIME_TYPES}.multipart_form_data)
		end

feature -- Execution

	handle (a_content_type: HTTP_CONTENT_TYPE; req: WSF_REQUEST;
				a_vars: HASH_TABLE [WSF_VALUE, READABLE_STRING_GENERAL]; a_raw_data: detachable CELL [detachable READABLE_STRING_8])
		local
			s: READABLE_STRING_8
		do
			s := full_input_data (req)
			if a_raw_data /= Void then
				a_raw_data.replace (s)
			end
			--| FIXME: optimization ... fetch the input data progressively, otherwise we might run out of memory ...
			analyze_multipart_form (req, a_content_type, s, a_vars)
		end

feature {NONE} -- Implementation: Form analyzer

	analyze_multipart_form (req: WSF_REQUEST; a_content_type: HTTP_CONTENT_TYPE; s: READABLE_STRING_8; vars: HASH_TABLE [WSF_VALUE, READABLE_STRING_GENERAL])
			-- Analyze multipart form content
			--| FIXME[2011-06-21]: integrate eMIME parser library
		require
			a_content_type_valid: a_content_type /= Void and not a_content_type.has_error
			s_attached: s /= Void
			same_content_length: req.content_length_value > 0 implies req.content_length_value.as_integer_32 <= s.count
			vars_attached: vars /= Void
		local
			p,i,next_b: INTEGER
			l_boundary_prefix: READABLE_STRING_8
			l_boundary_len: INTEGER
			l_boundary: detachable READABLE_STRING_8
			m: READABLE_STRING_8
			tmp: STRING_8
			is_crlf: BOOLEAN
		do
			l_boundary := a_content_type.parameter ("boundary")
			if l_boundary /= Void and then not l_boundary.is_empty then
				p := s.substring_index (l_boundary, 1)
				if p > 1 then
					l_boundary_prefix := s.substring (1, p - 1)
					l_boundary := l_boundary_prefix + l_boundary
				else
					l_boundary_prefix := ""
				end
				l_boundary_len := l_boundary.count
					--| Let's support either %R%N and %N ...
					--| Since both cases might occurs (for instance, our implementation of CGI does not have %R%N)
					--| then let's be as flexible as possible on this.
				is_crlf := s [l_boundary_len + 1] = '%R'
				from
					i := 1 + l_boundary_len + 1
					if is_crlf then
						i := i + 1 --| +1 = CR = %R
					end
					next_b := i
				until
					i = 0
				loop
					next_b := s.substring_index (l_boundary, i)
					if next_b > 0 then
						if is_crlf then
							m := s.substring (i, next_b - 1 - 2) --| 2 = CR LF = %R %N							
						else
							m := s.substring (i, next_b - 1 - 1) --| 1 = LF = %N														
						end
						analyze_multipart_form_input (req, m, vars)
						if s.valid_index (next_b + l_boundary_len + 1) then
							if is_crlf then
								if s[next_b + l_boundary_len] = '%R' and s[next_b + l_boundary_len + 1] = '%N' then
									-- continue
								else
									i := 0 -- reached the end
								end
							else
								if s[next_b + l_boundary_len + 1] = '%N' then
									-- continue
								else
									i := 0 -- reached the end
								end
							end
						else
							i := 0 -- missing end ?
							req.error_handler.add_custom_error (0, "Invalid form data", "Invalid ending for form data from input")
						end
						if i > 0 then
							i := next_b + l_boundary_len + 1
							if is_crlf then
								i := i + 1 --| +1 = CR = %R
							end
						end
					else
						if is_crlf then
							i := i + 1
						end
						tmp := s.substring (i - 1, s.count).to_string_8
						tmp.right_adjust
							-- TODO: check if next condition should not use tmp instead of s
						if i >= s.count and not l_boundary_prefix.same_string (tmp) then
							req.error_handler.add_custom_error (0, "Invalid form data", "Invalid ending for form data from input")
						end
						i := next_b
					end
				end
			end
		end

	analyze_multipart_form_input (req: WSF_REQUEST; s: READABLE_STRING_8; vars: HASH_TABLE [WSF_VALUE, READABLE_STRING_GENERAL])
			-- Analyze multipart entry
		require
			s_not_empty: s /= Void and then not s.is_empty
		local
			n, i,p, b,e: INTEGER
			l_name, l_filename, l_content_type: detachable READABLE_STRING_8
			l_unicode_name: READABLE_STRING_32
			l_header: detachable READABLE_STRING_8
			l_content: detachable READABLE_STRING_8
			l_line: detachable READABLE_STRING_8
			l_up_file: WSF_UPLOADED_FILE
			utf: UTF_CONVERTER
		do
			from
				p := 1
				n := s.count
			until
				p > n or l_header /= Void
			loop
				inspect s[p]
				when '%R' then -- CR
					if
						n >= p + 3 and then
						s[p+1] = '%N' and then -- LF
						s[p+2] = '%R' and then -- CR
						s[p+3] = '%N'		   -- LF
					then
						l_header := s.substring (1, p + 1)
						l_content := s.substring (p + 4, n)
					end
				when '%N' then
					if
						n >= p + 1 and then
						s[p+1] = '%N'
					then
						l_header := s.substring (1, p)
						l_content := s.substring (p + 2, n)
					end
				else
				end
				p := p + 1
			end
			if l_header /= Void and l_content /= Void then
				from
					i := 1
					n := l_header.count
				until
					i = 0 or i > n
				loop
					l_line := Void
					b := i
					p := l_header.index_of ('%N', b)
					if p > 0 then
						if l_header[p - 1] = '%R' then
							p := p - 1
							i := p + 2
						else
							i := p + 1
						end
					end
					if p > 0 then
						l_line := l_header.substring (b, p - 1)
						if l_line.starts_with ("Content-Disposition: form-data") then
							p := l_line.substring_index ("name=", 1)
							if p > 0 then
								p := p + 4 --| 4 = ("name=").count - 1
								if l_line.valid_index (p+1) and then l_line[p+1] = '%"' then
									p := p + 1
									e := l_line.index_of ('"', p + 1)
								else
									e := l_line.index_of (';', p + 1)
									if e = 0 then
										e := l_line.count
									end
								end
								l_name := l_header.substring (p + 1, e - 1)
							end

							p := l_line.substring_index ("filename=", 1)
							if p > 0 then
								p := p + 8 --| 8 = ("filename=").count - 1
								if l_line.valid_index (p+1) and then l_line[p+1] = '%"' then
									p := p + 1
									e := l_line.index_of ('"', p + 1)
								else
									e := l_line.index_of (';', p + 1)
									if e = 0 then
										e := l_line.count
									end
								end
								l_filename := l_header.substring (p + 1, e - 1)
							end
						elseif l_line.starts_with ("Content-Type: ") then
							l_content_type := l_line.substring (15, l_line.count)
						end
					else
						i := 0
					end
				end
				if l_name /= Void then
					if l_filename /= Void and then not l_filename.is_empty then
						if l_content_type = Void then
							l_content_type := default_content_type
						end
						l_unicode_name := utf.utf_8_string_8_to_string_32 (l_name)
						create l_up_file.make (l_unicode_name, utf.utf_8_string_8_to_escaped_string_32 (l_filename), l_content_type, l_content.count)
						add_value_to_table (l_unicode_name, l_up_file, vars)
						--| `l_up_file' might have a new name
						req.save_uploaded_file (l_up_file, l_content)
					else
						add_utf_8_string_value_to_table (l_name, l_content, vars)
					end
				else
					req.error_handler.add_custom_error (0, "unamed multipart entry", Void)
				end
			else
				req.error_handler.add_custom_error (0, "missformed multipart entry", Void)
			end
		end

	default_content_type: STRING = "text/plain"
			-- Default content type		

note
	copyright: "2011-2020, Jocelyn Fiat, Javier Velilla, Olivier Ligot, Colin Adams, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end

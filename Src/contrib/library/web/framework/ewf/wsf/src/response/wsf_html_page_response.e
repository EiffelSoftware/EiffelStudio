note
	description: "Summary description for {WSF_PAGE_RESPONSE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	WSF_HTML_PAGE_RESPONSE

inherit
	WSF_RESPONSE_MESSAGE

create
	make

feature {NONE} -- Initialization

	make
		do
			status_code := {HTTP_STATUS_CODE}.ok
			create header.make
			create {ARRAYED_LIST [STRING]} head_lines.make (5)
			doctype := "<!DOCTYPE html PUBLIC %"-//W3C//DTD XHTML 1.0 Strict//EN%" %"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd%">"
			header.put_content_type_text_html
		end

feature -- Status

	status_code: INTEGER

feature -- Header

	header: HTTP_HEADER

feature -- Html access

	doctype: STRING

	language: detachable STRING

	title: detachable STRING

	head_lines: LIST [STRING]

	body: detachable STRING

feature -- Element change

	set_status_code (c: like status_code)
		do
			status_code := c
		end

	set_language (s: like language)
		do
			language := s
		end

	set_title (s: like title)
		do
			title := s
		end

	add_meta_name_content (a_name: STRING; a_content: STRING)
		local
			s: STRING_8
		do
			s := "<meta name=%"" + a_name + "%" content=%"" + a_content + "%" />"
			head_lines.extend (s)
		end

	add_meta_http_equiv (a_http_equiv: STRING; a_content: STRING)
		local
			s: STRING_8
		do
			s := "<meta http-equiv=%"" + a_http_equiv + "%" content=%"" + a_content + "%" />"
			head_lines.extend (s)
		end

	add_style (a_href: STRING; a_media: detachable STRING)
		local
			s: STRING_8
		do
			s := "<link rel=%"stylesheet%" href=%""+ a_href + "%" type=%"text/css%""
			if a_media /= Void then
				s.append (" media=%""+ a_media + "%"")
			end
			s.append ("/>")
			head_lines.extend (s)
		end

	add_javascript_url (a_src: STRING)
		local
			s: STRING_8
		do
			s := "<script type=%"text/javascript%" src=%"" + a_src + "%"></script>"
			head_lines.extend (s)
		end

	add_javascript_content (a_script: STRING)
		local
			s: STRING_8
		do
			s := "<script type=%"text/javascript%">%N" + a_script + "%N</script>"
			head_lines.extend (s)
		end

	set_body (b: like body)
		do
			body := b
		end

feature {WSF_RESPONSE} -- Output

	send_to (res: WSF_RESPONSE)
		local
			h: like header
			s: STRING_8
		do
			create s.make (64)
			if attached doctype as l_doctype then
				s.append (l_doctype)
				s.append_character ('%N')
			end
			s.append ("<html xmlns=%"http://www.w3.org/1999/xhtml%"")
			if attached language as lang then
				s.append (" xml:lang=%""+ lang +"%" lang=%""+ lang +"%"")
			end
			s.append (">%N")

			append_html_head_code (s)
			append_html_body_code (s)


			s.append ("</html>%N")

			h := header
			res.set_status_code (status_code)

			if not h.has_content_length then
				h.put_content_length (s.count)
			end
			if not h.has_content_type then
				h.put_content_type_text_html
			end
			res.put_header_text (h.string)
			res.put_string (s)
		end

feature -- HTML facilities

	html_encoded_string (s: READABLE_STRING_32): READABLE_STRING_8
		do
			Result := html_encoder.encoded_string (s)
		end

feature {NONE} -- HTML Generation

	html_encoder: HTML_ENCODER
		once ("thread")
			create Result
		end

	append_html_head_code (s: STRING_8)
		local
			t: like title
			lines: like head_lines
		do
			t := title
			lines := head_lines
			if t /= Void or else lines.count > 0 then
				s.append ("<head>")
				if t /= Void then
					s.append ("<title>" + t + "</title>%N")
				end
				s.append_character ('%N')
				across
					lines as l
				loop
					s.append (l.item)
					s.append_character ('%N')
				end
				s.append ("</head>%N")
			end
		end

	append_html_body_code (s: STRING_8)
		local
			b: like body
		do
			b := body
			s.append ("<body>%N")
			if b /= Void then
				s.append (b)
			end
			s.append ("%N</body>")
		end

note
	copyright: "2011-2013, Jocelyn Fiat, Javier Velilla, Olivier Ligot, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end

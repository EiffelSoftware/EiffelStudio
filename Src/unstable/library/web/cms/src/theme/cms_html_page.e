note
	description: "Summary description for {CMS_HTML_PAGE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_HTML_PAGE

create
	make,
	make_typed

feature {NONE} -- Initialization

	make_typed (a_type: attached like type)
			-- Make current page with optional page type `a_type'.
		do
			make
			type := a_type
		end

	make
		do
			create regions.make_caseless (5)
			language := "en"

			status_code := {HTTP_STATUS_CODE}.ok
			create header.make
			create {ARRAYED_LIST [STRING]} head_lines.make (5)
			header.put_content_type_text_html
			create variables.make (0)
		end

feature -- Access

	type: detachable READABLE_STRING_8
			-- Optional page type.
			-- such as "front", "about", ... that could be customized by themes.

	is_front: BOOLEAN

	is_https: BOOLEAN

	title: detachable READABLE_STRING_32

	language: STRING

	head_lines: LIST [READABLE_STRING_8]

	head_lines_to_string: STRING
		do
			create Result.make_empty
			across
				head_lines as h
			loop
				Result.append (h.item)
				Result.append_character ('%N')
			end
		end

	variables: STRING_TABLE [detachable ANY]

feature -- Status


	status_code: INTEGER

feature -- Header

	header: HTTP_HEADER

feature -- Region

	regions: STRING_TABLE [READABLE_STRING_8]
			-- header
			-- content
			-- footer
			-- could have sidebar first, sidebar second, ...

	region (n: READABLE_STRING_GENERAL): READABLE_STRING_8
		do
			if attached regions.item (n) as r then
				Result := r
			else
				Result := ""
				debug
					Result := "{{" + {UTF_CONVERTER}.utf_32_string_to_utf_8_string_8 (n) + "}}"
				end
			end
		end

feature -- Element change

	set_is_front (b: BOOLEAN)
			-- Set `is_front' to `b'.
		do
			is_front := b
		end

	set_is_https (b: BOOLEAN)
			-- Set `is_https' to `b'.
		do
			is_https := b
		end

	register_variable (a_value: detachable ANY; k: READABLE_STRING_GENERAL)
		do
			variables.force (a_value, k)
		end

	add_to_region (a_content: READABLE_STRING_8; k: READABLE_STRING_GENERAL)
		local
			r: detachable READABLE_STRING_8
		do
			r := regions.item (k)
			if r = Void then
				create {STRING_8} r.make_from_string (a_content)
				set_region (r, k)
			else
				if attached {STRING_8} r as rw  then
					rw.append (a_content)
				else
					set_region (r + a_content, k)
				end
			end
		end

	set_region (a_content: READABLE_STRING_8; k: READABLE_STRING_GENERAL)
		do
			regions.force (a_content, k)
		end

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

	add_additional_head_line (s: READABLE_STRING_8)
		do
			head_lines.extend (s)
		end

	add_meta_name_content (a_name: STRING; a_content: STRING)
		local
			s: STRING_8
		do
			s := "<meta name=%"" + a_name + "%" content=%"" + a_content + "%" />"
			add_additional_head_line (s)
		end

	add_meta_http_equiv (a_http_equiv: STRING; a_content: STRING)
		local
			s: STRING_8
		do
			s := "<meta http-equiv=%"" + a_http_equiv + "%" content=%"" + a_content + "%" />"
			add_additional_head_line (s)
		end

	add_style (a_href: STRING; a_media: detachable STRING)
		local
			s: STRING_8
		do
			create s.make_from_string ("<link rel=%"stylesheet%" href=%"")
			s.append (a_href)
			s.append ("%" type=%"text/css%"")
			if a_media /= Void then
				s.append (" media=%""+ a_media + "%"")
			end
			s.append ("/>")
			add_additional_head_line (s)
		end

	add_style_content (a_style_content: STRING)
			-- Add style content `a_style_content' in the head, using <style> tag.
		local
			s: STRING_8
		do
			create s.make_from_string ("<style>%N")
			s.append (a_style_content)
			s.append ("%N</style>")
			add_additional_head_line (s)
		end

	add_javascript_url (a_src: STRING)
		local
			s: STRING_8
		do
			create s.make_from_string ("<script type=%"text/javascript%" src=%"")
			s.append (a_src)
			s.append ("%"></script>")
			add_additional_head_line (s)
		end

	add_javascript_content (a_script: STRING)
		local
			s: STRING_8
		do
			create s.make_from_string ("<script type=%"text/javascript%">%N")
			s.append (a_script)
			s.append ("%N</script>")
			add_additional_head_line (s)
		end

note
	copyright: "2011-2020, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end

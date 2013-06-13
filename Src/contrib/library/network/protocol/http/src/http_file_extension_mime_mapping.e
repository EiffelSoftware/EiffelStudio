note
	description: "[
			Various common MIME types for file extensions
			
			See also for longer list and description
			http://www.webmaster-toolkit.com/mime-types.shtml
			
			Please suggest missing entries
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	HTTP_FILE_EXTENSION_MIME_MAPPING

inherit
	ANY

	HTTP_MIME_TYPES
		export
			{NONE} all
		end

create
	make_empty,
	make_default,
	make_from_string,
	make_from_file

feature {NONE} -- Initialization

	make_empty (n: INTEGER)
			-- Create with no mapping
			-- but one can use `map' to add new mapping
		do
			create mapping.make_caseless (n)
		end

	make_default
			-- Create with default limited mapping
			-- One can use `map' to add new mapping
		local
			m: like mapping
		do
			create m.make_caseless (40)
			mapping := m
			m.force (text_css, "css")
			m.force (text_html, "html")
			m.force (text_xml, "xml")
			m.force (application_json, "json")
			m.force (application_javascript, "js")
			m.force (application_rss_xml, "rss")
			m.force (application_atom_xml, "atom")
			m.force (image_x_ico, "ico")
			m.force (image_gif, "gif")
			m.force (image_jpeg, "jpeg")
			m.force (image_jpg, "jpg")
			m.force (image_png, "png")
			m.force (application_zip, "zip")
			m.force (application_x_bzip, "bz")
			m.force (application_x_bzip2, "bz2")
			m.force (application_x_gzip, "gz")
			m.force (application_x_gzip, "gzip")
			m.force (application_x_tar, "tar")
			m.force (application_x_compressed, "tgz")
			m.force (application_postscript, "ps")
			m.force (application_pdf, "pdf")
			m.force (application_x_shockwave_flash, "swf")
			m.force (text_plain, "conf")
			m.force (text_plain, "log")
			m.force (text_plain, "text")
			m.force (text_plain, "txt")
		end

	make_from_file (fn: READABLE_STRING_GENERAL)
			-- Create with mime.types file
			-- One can use `map' to add new mapping
		local
			f: RAW_FILE
		do
			create f.make_with_name (fn)
			if f.exists and then f.is_readable then
				make_empty (50)
				f.open_read
				from
					f.read_line
				until
					f.exhausted or f.end_of_file
				loop
					add_mapping_line (f.last_string)
					f.read_line
				end
				f.close
			else
				make_empty (0)
			end
		end

	make_from_string (t: READABLE_STRING_8)
			-- Set mapping from multiline string `t'
			-- line should be formatted as in http://svn.apache.org/repos/asf/httpd/httpd/trunk/docs/conf/mime.types
			--| # is a comment
			--| mime-type space(s) extensions
		local
			i,j,n: INTEGER
		do
			make_empty (10)
			n := t.count
			if n > 0 then
				from
					i := 1
				until
					i = 0 or i > n
				loop
					j := t.index_of ('%N', i)
					if j > 0 then
						add_mapping_line (t.substring (i, j - 1))
						i := j + 1
					else
						add_mapping_line (t.substring (i, n))
						i := 0
					end
				end
			end
		end

feature -- Access

	mime_type (ext: READABLE_STRING_GENERAL): detachable READABLE_STRING_8
			-- Mime type for extension `ext'
		do
			Result := mapping.item (ext.as_lower)
		end

feature -- Element change

	map (e: READABLE_STRING_GENERAL; t: READABLE_STRING_8)
			-- Add mapping extension `e' to mime type `t'
		do
			mapping.force (t, e.as_lower)
		end

feature {NONE} -- Implementation

	add_mapping_line (t: READABLE_STRING_8)
		local
			i,j,n: INTEGER
			l_type, l_ext: READABLE_STRING_8
		do
			n := t.count
			if n > 0 then
				-- ignore blanks
				i := next_non_blank_position (t, i)
				if i > 0 then
					if t[i] = '#' then
						--| ignore
					else
						j := next_blank_position (t, i)
						if j > i then
							l_type := t.substring (i, j - 1)
							from
							until
								i = 0
							loop
								i := next_non_blank_position (t, j)
								if i > 0 then
									j := next_blank_position (t, i)
									if j = 0 then
										l_ext := t.substring (i, n)
										i := 0
									else
										l_ext := t.substring (i, j - 1)
										i := j
									end
									map (l_ext, l_type)
								end
							end
						end
					end
				end
			end
		end

	next_blank_position (s: READABLE_STRING_8; p: INTEGER): INTEGER
		local
			i, n: INTEGER
		do
			n := s.count
			from
				i := p + 1
			until
				i > n or s[i].is_space
			loop
				i := i + 1
			end
			if i <= n then
				Result := i
			end
		end

	next_non_blank_position (s: READABLE_STRING_8; p: INTEGER): INTEGER
		local
			i, n: INTEGER
		do
			n := s.count
			from
				i := p + 1
			until
				i > n or not s[i].is_space
			loop
				i := i + 1
			end
			if i <= n then
				Result := i
			end
		end


feature {NONE} -- Extension MIME mapping

	mapping: STRING_TABLE [READABLE_STRING_8]

invariant
	mapping_keys_are_lowercase: across mapping as c all c.key.same_string (c.key.as_lower) end

note
	copyright: "2011-2013, Jocelyn Fiat, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end

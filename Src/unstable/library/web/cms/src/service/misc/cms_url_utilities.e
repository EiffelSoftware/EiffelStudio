note
	description: "Collection of helper routines to manipulate URL for CMS."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CMS_URL_UTILITIES

inherit
	CMS_ENCODERS

feature -- Core

	site_url: READABLE_STRING_8
			-- Absolute site URL of Current CMS site.
		deferred
		end

	base_url: detachable READABLE_STRING_8
			-- Base url if any.
		deferred
		end

	based_path (p: READABLE_STRING_8): STRING_8
			-- Path `p' in the context of the `base_url'
		do
			if attached base_url as l_base_url and then not l_base_url.is_empty then
				if p.starts_with (l_base_url) then
						-- In case `p` is already based on base_url.
					check starts_with_slash: p.starts_with ("/") end
					Result := p.to_string_8
				else
					create Result.make_from_string (l_base_url)
					if p.is_empty then
					else
						if p[1] /= '/' then
							Result.extend ('/')
						end
						Result.append (p)
					end
				end
			else
				if p.is_empty then
					Result := "/"
				elseif p[1] /= '/' then
					create Result.make_from_string (p)
					Result.precede ('/')
				else
					Result := p.to_string_8
				end
			end
		end

feature -- Link

	link (a_text: detachable READABLE_STRING_GENERAL; a_path: READABLE_STRING_8; opts: detachable CMS_API_OPTIONS): STRING
			-- HTML link with title `a_text' and href `a_path'.
			-- `opts' is used for additional settings.
		do
			create Result.make (32)
			append_link_to_html (a_text, a_path, opts, Result)
		end

	absolute_link (a_text: detachable READABLE_STRING_GENERAL; a_path: READABLE_STRING_8; a_opts: detachable CMS_API_OPTIONS): STRING
			-- HTML link with title `a_text' and href `a_path'.
			-- `opts' is used for additional settings.
		local
			opts: CMS_API_OPTIONS
		do
			create opts.make (1)
			if a_opts /= Void then
				opts.import (a_opts)
			end
			opts.force (True, "absolute")
			create Result.make (32)
			append_link_to_html (a_text, a_path, opts, Result)
		end

	link_with_raw_text (a_raw_text: detachable READABLE_STRING_8; a_path: READABLE_STRING_8; opts: detachable CMS_API_OPTIONS): STRING
			-- HTML link with title the html code `a_raw_text' and href `a_path'.
			-- `opts' is used for additional settings.	
		do
			create Result.make (32)
			append_link_with_raw_text_to_html (a_raw_text, a_path, opts, Result)
		end

	append_cms_link_to_html (lnk: CMS_LINK; opts: detachable CMS_API_OPTIONS; a_html: STRING_8)
		do
			append_link_to_html (lnk.title, lnk.location, opts, a_html)
		end

	append_link_to_html (a_text: detachable READABLE_STRING_GENERAL; a_path: READABLE_STRING_8; opts: detachable CMS_API_OPTIONS; a_html: STRING_8)
		local
			l_html: BOOLEAN
			t: READABLE_STRING_GENERAL
		do
			l_html := True
			if opts /= Void then
				l_html := opts.boolean_item ("html", l_html)
			end
			a_html.append ("<a href=%"" + checked_url (url (a_path, opts)) + "%">")
			if a_text = Void then
				t := a_path
			else
				t := a_text
			end
			if l_html then
				a_html.append (html_encoded (t))
			else
				a_html.append (checked_plain (t))
			end
			a_html.append ("</a>")
		end

	append_link_with_raw_text_to_html (a_raw_text: detachable READABLE_STRING_8; a_path: READABLE_STRING_8; opts: detachable CMS_API_OPTIONS; a_html: STRING_8)
		local
			l_html: BOOLEAN
			t: READABLE_STRING_8
		do
			l_html := True
			if opts /= Void then
				l_html := opts.boolean_item ("html", l_html)
			end
			a_html.append ("<a href=%"" + checked_url (url (a_path, opts)) + "%">")
			if a_raw_text = Void then
				t := a_path
			else
				t := a_raw_text
			end
			a_html.append (t)
			a_html.append ("</a>")
		end

feature -- Url

	absolute_url (a_path: READABLE_STRING_8; opts: detachable CMS_API_OPTIONS): STRING_8
		local
			l_opts: detachable CMS_API_OPTIONS
		do
			l_opts := opts
			if l_opts = Void then
				create l_opts.make (1)
			end
			l_opts.force (True, "absolute")
			Result := url (a_path, l_opts)
		end

	url (a_path: READABLE_STRING_8; opts: detachable CMS_API_OPTIONS): STRING_8
			-- URL for path `a_path' and optional parameters from `opts'.
			-- Caller can also use specific CMS_API_URL_OPTIONS (descendant of CMS_API_OPTIONS)
			--| Options `opts' could be
			--|  - absolute: True|False	=> return absolute url
			--|  - query: string		=> append "?query"
			--|  - fragment: string		=> append "#fragment"
		local
			q: detachable STRING_8
			f: detachable READABLE_STRING_8
			l_abs: BOOLEAN
		do
			l_abs := False

			if opts /= Void then
				l_abs := opts.boolean_item ("absolute", l_abs)
				if attached opts.item ("query") as l_query then
					if attached {READABLE_STRING_8} l_query as s_value then
						q := s_value.to_string_8
					elseif attached {ITERABLE [TUPLE [key, value: READABLE_STRING_GENERAL]]} l_query as lst then
						create q.make_empty
						across
							lst as c
						loop
							if q.is_empty then
							else
								q.append_character ('&')
							end
							q.append (url_encoded (c.item.key))
							q.append_character ('=')
							q.append (url_encoded (c.item.value))
						end
					end
				end
				if attached opts.string_item ("fragment") as s_frag then
					f := s_frag
				end
			end
			if l_abs then
				if a_path.substring_index ("://", 1) = 0 then
					create Result.make_from_string (site_url)
					if a_path.is_empty then
					elseif Result.ends_with ("/") then
						if a_path[1] = '/' then
							Result.append_string (a_path.substring (2, a_path.count))
						else
							Result.append_string (a_path)
						end
					else
						if a_path[1] = '/' then
							Result.append_string (a_path)
						else
							Result.append_character ('/')
							Result.append_string (a_path)
						end
					end
				else
					Result := a_path.to_string_8
				end
			else
				Result := based_path (a_path)
			end
			if q /= Void then
				Result.append_character ('?')
				Result.append (q)
			end
			if f /= Void then
				Result.append_character ('#')
				Result.append (f)
			end
		end

	checked_url (a_url: READABLE_STRING_8): READABLE_STRING_8
		do
				-- FIXME: implement a way to check if `a_url' is safe, and does not reveal security issue.
			Result := a_url
		end

	checked_plain (a_text: READABLE_STRING_GENERAL): STRING_8
		do
			Result := html_encoded (a_text)
		end

note
	copyright: "2011-2022, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end

note
	description: "Summary description for {CMS_URL_UTILITIES}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CMS_URL_UTILITIES

inherit
	CMS_REQUEST_UTIL

feature -- Core

	site_url: READABLE_STRING_8
		deferred
		end

	base_url: detachable READABLE_STRING_8
			-- Base url if any.
		deferred
		end

	based_path (p: STRING): STRING
			-- Path `p' in the context of the `base_url'
		do
			if attached base_url as l_base_url then
				create Result.make_from_string (l_base_url)
				if p.is_empty then
				else
					if p[1] = '/' then
						Result.append (p.substring (2, p.count))
					else
						Result.append (p)
					end
				end
			else
				Result := p
			end
		end

feature -- Url

	absolute_url (a_path: STRING; opts: detachable CMS_API_OPTIONS): STRING
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

	url (a_path: READABLE_STRING_8; opts: detachable CMS_API_OPTIONS): STRING
			-- URL for path `a_path' and optional parameters from `opts'.
			--| Options `opts' could be
			--|  - absolute: True|False	=> return absolute url
			--|  - query: string		=> append "?query"
			--|  - fragment: string		=> append "#fragment"
		local
			q,f: detachable STRING_8
			l_abs: BOOLEAN
		do
			l_abs := False

			if opts /= Void then
				l_abs := opts.boolean_item ("absolute", l_abs)
				if attached opts.item ("query") as l_query then
					if attached {READABLE_STRING_8} l_query as s_value then
						q := s_value
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
					Result := a_path
				end
			else
				Result := based_path (a_path)
			end
			if q /= Void then
				Result.append ("?" + q)
			end
			if f /= Void then
				Result.append ("#" + f)
			end
		end

	checked_url (a_url: READABLE_STRING_8): READABLE_STRING_8
		do
			Result := a_url
		end

end

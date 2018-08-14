note
	description: "Summary description for {SECURITY_HTML_CONTENT_FILTER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SECURITY_HTML_CONTENT_FILTER

inherit
	CONTENT_FILTER
		redefine
			default_create,
			html_help
		end

	STRING_HANDLER
		redefine
			default_create
		end

feature {NONE} -- Initialization

	default_create
		local
			lst: ARRAYED_LIST [READABLE_STRING_8]
		do
			Precursor
			create lst.make (10)
			lst.extend ("script")
			forbidden_html_tags := lst
		end

feature -- Access

	name: STRING_8 = "security_html_filter"

	title: STRING_8 = "Security filter for HTML content"

	description: STRING_8
		do
			create Result.make_from_string ("Forbidden HTML tags: ")
			across
				forbidden_html_tags as c
			loop
				Result.append ("<" + c.item + "> ")
			end
		end

	html_help: STRING_8
		do
			create Result.make_from_string ("Forbidden HTML tags: ")
			across
				forbidden_html_tags as c
			loop
				Result.append ("&lt;" + c.item + "&gt; ")
			end
		end

	forbidden_html_tags: LIST [READABLE_STRING_8]
			-- HTML tag to exclude during filtering.

feature -- Conversion

	filter (a_text: STRING_GENERAL)
		local
			l_new: STRING_GENERAL
			i: INTEGER
			n: INTEGER
			in_tag: BOOLEAN
			p1, p2: INTEGER
		do
			if attached {READABLE_STRING_8} a_text then
				create {STRING_8} l_new.make (a_text.count)
			else
				create {STRING_32} l_new.make (a_text.count)
			end

			from
				p1 := 1
				i := a_text.index_of ('<', 1)
				if i > 0 then
					l_new.append (a_text.substring (1, i - 1))
				end
				n := a_text.count
			until
				i = 0 or i > n
			loop
				if a_text[i] = '<' then
					in_tag := True
					p1 := i
					p2 := a_text.index_of ('>', i + 1)
					if p2 = 0 then
						-- next '<'
						i := a_text.index_of ('<', i + 1)
						if i > 0 then
							l_new.append (a_text.substring (p1, i - 1))
						end
					else
						if is_forbidden (a_text.substring (p1, p2)) then
							i := a_text.index_of ('<', p2 + 1)
						else
							l_new.append (secured_element_text (a_text.substring (p1, p2)))
							i := a_text.index_of ('<', p2 + 1)
						end
						if i = 0 then
							p1 := p2 + 1
						else
							l_new.append (a_text.substring (p2 + 1, i - 1))
						end
					end
				else
					i := i + 1
				end
			end
			l_new.append (a_text.substring (p1, n))
			a_text.set_count (0)
			a_text.append (l_new)
		end

	is_forbidden (s: READABLE_STRING_GENERAL): BOOLEAN
			-- Is `s' forbidden?
			--| `s' has either "<....>" or "<..../>" or "</.....>"
		local
			l_tagname: detachable READABLE_STRING_GENERAL
			i,n,p1: INTEGER
		do
--			create l_tagname.make_empty
			from
				i := 2 -- skip first '<'
				n := s.count
			until
				i > n or l_tagname /= Void
			loop
				if p1 > 0 then
					if s[i].is_space or s[i] = '/' or s[i] = '>' then
						l_tagname := s.substring (p1, i - 1)
					end
				else
					if s[i].is_space or s[i] = '/' then
					else
						p1 := i
					end
				end
				i := i + 1
			end
			if l_tagname /= Void then
				if attached {READABLE_STRING_8} l_tagname as l_tagname_s8 then
					l_tagname := l_tagname_s8.as_lower
				elseif attached {READABLE_STRING_32} l_tagname as l_tagname_s32 then
					l_tagname := l_tagname_s32.as_lower
				end
				Result := across forbidden_html_tags as c some l_tagname.same_string (c.item) end
			else
				Result := True
			end
		end

	secured_element_text (a_elt: STRING_GENERAL): STRING_GENERAL
		require
			starts_with_lessthan: a_elt.starts_with ("<")
			ends_with_greaterthan: a_elt.starts_with (">")
		local
			i,j,k,n: INTEGER
			vn,vv,vvk: detachable STRING_GENERAL
			c: CHARACTER_32
		do
			from
				i := 2
				from
						-- Skip ending spaces and ending slash
					n := a_elt.count - 1
				until
					n < i or else (not a_elt[n].is_space and a_elt[n] /= '/')
				loop
					n := n - 1
				end
			until
				i > n
			loop
				vn := Void
				vv := Void
				vvk := Void
					-- Skip spaces
				from until i > n or else not a_elt[i].is_space loop
					i := i + 1
				end
				if i <= n then
					j := i
					k := i
					from
						vn := a_elt.substring (1,0) -- Empty string using same type as `a_elt`.
						c := a_elt [i]
					until
						i > n or else (c.is_space or c = '=')
					loop
						vn.append_code (a_elt.code (i))
						i := i + 1
						if i <= n then
							c := a_elt [i]
						end
					end
					k := i - 1
					if i < n and a_elt[i] = '=' then
						i := i + 1
							-- Skip spaces
						from until i > n or else not a_elt[i].is_space loop
							i := i + 1
						end
						k := i - 1
						if i <= n then
							c := a_elt[i]
							inspect c
							when {CHARACTER_32} '"', {CHARACTER_32} '%'', {CHARACTER_32} '`' then
									-- Find closing mark, if no, use the remaining text.
								k := a_elt.index_of (c, i + 1)
								if k > 0 then
									vv := a_elt.substring (i + 1, k - 1)
								else
									k := n
									vv := a_elt.substring (i + 1, k)
								end
									-- Find vvk (reuse var `i` as it is set back to `k+1` after))
								i := vv.index_of (':', 1)
								if i > 0 then
									vvk := vv.substring (1, i - 1)
								end
								i := k + 1
							else
								from
									vv := a_elt.substring (1,0) -- Empty string using same type as `a_elt`.
									c := a_elt[i]
									k := i
								until
									i > n or else (c.is_space)
								loop
									if vvk = Void and c = ':' then
										vvk := vv.twin
									end
									vv.append_code (a_elt.code (i))
									i := i + 1
									if i <= n then
										k := i
										c := a_elt[i]
									end
								end
							end
						end
					end
					if vn /= Void then
						if vn.as_lower.starts_with ("on") then
							-- Forbidden !!!
							a_elt.remove_substring (j, k)
							n := n - (k - j + 1)
							i := j - 1
						elseif vv /= Void then
							if
								vvk /= Void and then
								vvk.as_lower.ends_with ("script") -- catch javascript:... vbscript:...  *script=...
							then
									-- Forbidden !!!
								a_elt.remove_substring (j, k)
								n := n - (k - j + 1)
								i := j - 1
							end
						end
					end
				end
				i := i + 1
			end
			Result := a_elt
		end

note
	copyright: "2011-2018, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end

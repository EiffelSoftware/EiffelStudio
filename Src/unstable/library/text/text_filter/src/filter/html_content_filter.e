note
	description: "Summary description for {HTML_CONTENT_FILTER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	HTML_CONTENT_FILTER

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
			lst.extend ("a")
			lst.extend ("em")
			lst.extend ("strong")
			lst.extend ("cite")
			lst.extend ("blockquote")
			lst.extend ("code")
			lst.extend ("ul")
			lst.extend ("ol")
			lst.extend ("li")
			lst.extend ("dl")
			allowed_html_tags := lst
		end

feature -- Access

	name: STRING_8 = "html_filter"

	title: STRING_8 = "HTML filter"

	description: STRING_8
		do
			create Result.make_from_string ("Allowed HTML tags: ")
			across
				allowed_html_tags as c
			loop
				Result.append ("<" + c.item + "> ")
			end
		end

	html_help: STRING_8
		do
			create Result.make_from_string ("Allowed HTML tags: ")
			across
				allowed_html_tags as c
			loop
				Result.append ("&lt;" + c.item + "&gt; ")
			end
		end

	allowed_html_tags: LIST [READABLE_STRING_8]
			-- HTML tag to preserve during filtering.

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
						if is_authorized (a_text.substring (p1, p2)) then
							l_new.append (a_text.substring (p1, p2))
							i := a_text.index_of ('<', p2 + 1)
						else
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

	is_authorized (s: READABLE_STRING_GENERAL): BOOLEAN
			-- Is `s' authorized?
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
				Result := across allowed_html_tags as c some l_tagname.same_string (c.item) end
			else
				Result := True
			end
		end

end

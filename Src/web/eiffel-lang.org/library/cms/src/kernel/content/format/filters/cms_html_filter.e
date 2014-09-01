note
	description: "Summary description for {CMS_HTML_FILTER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_HTML_FILTER

inherit
	CMS_FILTER
		redefine
			default_create
		end

feature {NONE} -- Initialization

	default_create
		do
			Precursor
			allowed_html_tags := <<"a", "em", "strong", "cite", "blockquote", "code", "ul", "ol", "li", "dl">>
			description := "Allowed HTML tags: "
			across
				allowed_html_tags as c
			loop
				description.append ("&lt;" + c.item + "&gt; ")
			end
		end

feature -- Access

	name: STRING_8 = "html_filter"

	title: STRING_8 = "HTML filter"

	description: STRING_8

	allowed_html_tags: ITERABLE [READABLE_STRING_8]

feature -- Conversion

	filter (a_text: STRING_8)
		local
			l_new: STRING_8
			i: INTEGER
			n: INTEGER
			in_tag: BOOLEAN
			p1, p2: INTEGER
		do
			create l_new.make (a_text.count)
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
			a_text.wipe_out
			a_text.append (l_new)
		end

	is_authorized (s: READABLE_STRING_8): BOOLEAN
			-- Is `s' authorized?
			--| `s' has either "<....>" or "<..../>" or "</.....>"
		local
			l_tagname: detachable STRING
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
				l_tagname.to_lower
				Result := across allowed_html_tags as c some c.item.same_string (l_tagname) end
			else
				Result := True
			end
		end


end

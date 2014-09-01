note
	description: "Summary description for {CMS_NO_HTML_FILTER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_NO_HTML_FILTER

inherit
	CMS_FILTER
		redefine
			default_create
		end

feature {NONE} -- Initialization

	default_create
		do
			Precursor
		end

feature -- Access

	name: STRING_8 = "no_html_filter"

	title: STRING_8 = "No HTML filter"

	description: STRING_8 = "HTML tags removed! "

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
						i := a_text.index_of ('<', p2 + 1)
						if i > 0 then
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

end

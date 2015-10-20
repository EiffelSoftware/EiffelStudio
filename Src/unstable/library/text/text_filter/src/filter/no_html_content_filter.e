note
	description: "Summary description for {NO_HTML_CONTENT_FILTER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	NO_HTML_CONTENT_FILTER

inherit
	CONTENT_FILTER
		redefine
			default_create
		end

	STRING_HANDLER
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

	filter (a_text: STRING_GENERAL)
		local
			l_new: STRING_GENERAL
			i: INTEGER
			n: INTEGER
			p1, p2, p3: INTEGER
		do
			if attached {STRING_8} a_text then
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
					p1 := i
					p2 := a_text.index_of ('>', i + 1)
					if p2 = 0 then
							-- next '<'
						i := a_text.index_of ('<', i + 1)
						if i > 0 then
							l_new.append (a_text.substring (p1, i - 1))
						end
					else
						p3 := a_text.index_of ('<', i + 1)
						if p3 > 0 and p3 < p2 then
							l_new.append (a_text.substring (p1, p3 - 1))
							i := p3
						else
							i := a_text.index_of ('<', p2 + 1)
							if i > 0 then
								l_new.append (a_text.substring (p2 + 1, i - 1))
							else
								p1 := p2 + 1
							end
						end
					end
				else
					p1 := i
					i := a_text.index_of ('<', p1)
					if i > 0 then
						l_new.append (a_text.substring (p1, i - 1))
					end
				end
			end
			l_new.append (a_text.substring (p1, n))
			a_text.set_count (0)
			a_text.append (l_new)
		end

	tag_name (a_text: READABLE_STRING_8; start_index, end_index: INTEGER): STRING_8
		require
			starts_by_lt: a_text[start_index] = '<'
			ends_by_gt: a_text[end_index] = '>'
		local
			i: INTEGER
		do
			i := start_index + 1

			from until i >= end_index or not a_text[i].is_space loop
				i := i + 1
			end
			from
				create Result.make (end_index - i)
			until
				i >= end_index or a_text[i].is_space
			loop
				Result.append_character (a_text[i])
				i := i + 1
			end
		end

end

note
	description: "Summary description for {WIKI_INDEX}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	WIKI_INDEX

create
	make

feature {NONE} -- Initialization

	make (a_name: READABLE_STRING_8; fn: PATH)
		local
			f: RAW_FILE
			s, t, k: STRING
			ln, p: INTEGER
			wb: detachable WIKI_BOOK
			pwp, wp: detachable WIKI_PAGE
		do
			create f.make_with_path (fn)
			if f.exists and f.is_readable then
				create wb.make (a_name, fn.parent)
				f.open_read
				from
					ln := 0
				until
					f.exhausted or f.end_of_file
				loop
					f.read_line
					s := f.last_string
					ln := ln + 1
					s.left_adjust
					if s.is_empty then
						-- skip
					elseif s.item (1) = '[' then
						pwp := wp
						wp := Void
						p := s.index_of (']', 2)
						if p > 0 then
							t := s.substring (p + 1, s.count)
							s := s.substring (2, p - 1)
							if attached s.split (':') as lst and then lst.count >= 3 then
								lst.start
								lst.forth
								k := lst.item
								create wp.make (t, k)
								wb.add_page (wp)
							end
						else
							-- skip
							print ("Error page line " + ln.out + "[" + s + "]%N")
						end
--						if wp /= Void then
--							pwp.add_page (wp)
--						end
					elseif s.substring (1, 5) ~ "!src=" then
						if wp /= Void then
							wp.set_src (s.substring (6, s.count))
						end
					else
						-- skip
						print ("Error line " + ln.out + "[" + s + "]%N")
					end
--					[0:book:-9] EiffelStudio
--					 !src=eiffelstudio/index
				end
				f.close
			end
			book := wb
		end

feature -- Access

	book: detachable WIKI_BOOK

	analyze
		do
			if
				attached book as wb and then
				attached wb.pages as l_pages
			then
				from
					l_pages.start
				until
					l_pages.after
				loop
					l_pages.item.get_structure (wb.page_path (l_pages.item))
					l_pages.forth
				end
			end

		end

note
	copyright: "2011-2013, Jocelyn Fiat and Eiffel Software"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Jocelyn Fiat
			Contact: http://about.jocelynfiat.net/
		]"
end

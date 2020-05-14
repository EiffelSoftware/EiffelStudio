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
			--| ex:	%[2:software-installation:1] Third Party Tools Installation Help
 			--|		% !src=eiffelstudio/software-installation/third-party-tools-installation-help
		local
			f: RAW_FILE
			s, t, l_parent_key: STRING
			ln, p, l_weight: INTEGER
			wb: detachable WIKI_BOOK
			pwp, wp: detachable WIKI_BOOK_PAGE
			ht: STRING_TABLE [WIKI_BOOK_PAGE]
			l_wp_key: detachable READABLE_STRING_8
		do
			create f.make_with_path (fn)
			if f.exists and f.is_readable then
				create wb.make (a_name, fn.parent)
				create ht.make_caseless (0)
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
								l_parent_key := lst.i_th (2)
								if attached lst.i_th (3) as s_weight and then s_weight.is_integer then
									l_weight := s_weight.to_integer
								else
									l_weight := 0
								end
								t.adjust
								l_parent_key.adjust
								wp := new_wiki_page (t, l_parent_key)
								if attached ht.item (l_parent_key) as l_parent_page then
									wp.set_weight (l_weight)
									l_parent_page.extend (wp)
								end
								wb.add_page (wp)
								l_wp_key := Void
								if lst.count >= 4 then
									l_wp_key := lst.i_th (4)
								end
								if l_wp_key = Void then
									l_wp_key := wp.key
								end
								ht.force (wp, l_wp_key)
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

feature -- Factory

	new_wiki_page (a_title: READABLE_STRING_8; a_parent_key: READABLE_STRING_8): WIKI_BOOK_PAGE
			-- Instantiate a new wiki page with title `a_title' and a parent key `a_parent_key'.
		do
			create Result.make (a_title, a_parent_key)
		end

feature -- Access

	book: detachable WIKI_BOOK

	page (a_name: READABLE_STRING_GENERAL): detachable WIKI_BOOK_PAGE
		do
			if attached book as bk then
				across
					bk.pages as ic
				until
					Result /= Void
				loop
					if ic.item.title.is_case_insensitive_equal_general (a_name) then
						Result := ic.item
					end
				end
			end
		end

	page_by_id (a_id: READABLE_STRING_GENERAL): detachable WIKI_BOOK_PAGE
		local
			l_src, s: READABLE_STRING_8
			p,q: INTEGER
		do
			if attached book as bk then
				across
					bk.pages as ic
				until
					Result /= Void
				loop
					l_src := ic.item.src
					p := l_src.last_index_of ('/', l_src.count)
					if p > 0 then
						s := l_src.substring (p + 1, l_src.count)
						if s.is_case_insensitive_equal_general ("index") then
							q := l_src.last_index_of ('/', p - 1)
							if q > 0 then
								s := l_src.substring (q + 1, p - 1)
							end
						end
					else
						s := l_src
					end
					if s.is_case_insensitive_equal_general (a_id) then
						Result := ic.item
					end
				end
			end
		end

	analyze
		do
			if
				attached book as wb and then
				attached wb.pages as l_pages
			then
				across
					l_pages as ic
				loop
					ic.item.get_structure (wb.page_path (ic.item))
				end
			end

		end

note
	copyright: "2011-2014, Jocelyn Fiat and Eiffel Software"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Jocelyn Fiat
			Contact: http://about.jocelynfiat.net/
		]"
end

note
	description: "Summary description for {WIKI_PAGE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	WIKI_PAGE

inherit
	SHARED_EXECUTION_ENVIRONMENT

	DEBUG_OUTPUT

create
	make

feature {NONE} -- Make

	make (a_title: STRING; a_key: STRING)
		do
			title := a_title
			key := a_key
			src := a_key
		end

feature -- Visitor

	process (a_visitor: WIKI_VISITOR)
		do
			a_visitor.visit_page (Current)
		end

feature -- Access

	title: STRING

	key: STRING

	src: STRING

	pages: detachable ARRAYED_LIST [WIKI_PAGE]

	structure: detachable WIKI_STRUCTURE

feature -- Element change

	get_structure (a_filename: PATH)
		local
			fn: PATH
			f: RAW_FILE
			lst: LIST [STRING]
			t: STRING
			ln, p: INTEGER
			s: STRING
			in_header: BOOLEAN
			h: detachable STRING_TABLE [STRING]
		do
			fn := a_filename
			create f.make_with_path (fn)
			if f.exists and f.is_readable then
				f.open_read
				from
					ln := 0
					in_header := True
					create h.make (3)
					create t.make (f.count)
				until
					f.exhausted or f.end_of_file
				loop
					ln := ln + 1
					f.read_line
					s := f.last_string
					if in_header then
						if s.is_empty then
							in_header := False
						elseif s.item (1) = '#' then
							p := s.index_of ('=', 1)
							if p > 0 then
								h.force (s.substring (p+1, s.count), s.substring (1, p -1))
							else
								in_header := False
							end
						else
							in_header := False
						end
					end
					if not in_header then
						t.append (s)
						t.append_character ('%N')
					end
				end
				f.close
				create structure.make (h, t)
			else
				create structure.make (Void, "!!ERROR!!")
			end
		end

	add_page (a_page: WIKI_PAGE)
		local
			l_pages: like pages
		do
			l_pages := pages
			if l_pages = Void then
				create l_pages.make (3)
				pages := l_pages
			end
			l_pages.extend (a_page)
		end

	set_src (a_src: like src)
		do
			src := a_src
		end

feature -- Status report

	debug_output: STRING
			-- String that should be displayed in debugger to represent `Current'.
		do
			create Result.make_from_string (key)
			Result.append_character (':')
			Result.append_string (title)
			if attached pages as pgs then
				Result.append_character (':')
				Result.append_character (' ')
				Result.append_integer (pgs.count)
				Result.append_string (" pages")
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

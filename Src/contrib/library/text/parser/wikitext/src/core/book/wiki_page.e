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

	make (a_title: STRING; a_parent_key: STRING)
		do
			title := a_title
			parent_key := a_parent_key
			src := a_parent_key + "/" + a_title
		end

feature -- Visitor

	process (a_visitor: WIKI_VISITOR)
		do
			a_visitor.visit_page (Current)
		end

feature -- Access

	title: STRING

	parent_key: STRING

	src: STRING

	pages: detachable ARRAYED_LIST [WIKI_PAGE]

	structure: detachable WIKI_STRUCTURE

	path: detachable PATH

feature -- Query

	key: READABLE_STRING_8
		local
			l_src: like src
			p,q: INTEGER
		do
			l_src := src
			p := l_src.count + 1
			q := l_src.last_index_of ('/', p - 1)
			if q > 0 then
				Result := l_src.substring (q + 1, p - 1)
				if Result.is_case_insensitive_equal ("index") then
					p := q - 1
					q := l_src.last_index_of ('/', p)
					if q > 0 then
						Result := l_src.substring (q + 1, p - 1)
					end
				end
			else
				Result := l_src
			end
		end

feature -- Element change

	get_structure (a_filename: PATH)
		local
			fn: PATH
			f: RAW_FILE
			t: STRING
			ln, p: INTEGER
			s: STRING
			in_header: BOOLEAN
			h: detachable STRING_TABLE [STRING]
		do
			path := a_filename

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
		do
			add_page_with_weight (a_page, 0)
		end

	add_page_with_weight (a_page: WIKI_PAGE; a_weight: INTEGER)
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
			create Result.make_from_string (parent_key)
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

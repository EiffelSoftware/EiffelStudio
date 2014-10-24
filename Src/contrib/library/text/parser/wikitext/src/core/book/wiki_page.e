note
	description: "Summary description for {WIKI_PAGE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	WIKI_PAGE

inherit
	ITERABLE [WIKI_ITEM] -- related to wiki structure
		undefine
			is_equal
		end

	COMPARABLE

	SHARED_EXECUTION_ENVIRONMENT
		undefine
			is_equal
		end

	DEBUG_OUTPUT
		undefine
			is_equal
		end

create
	make

feature {NONE} -- Make

	make (a_title: STRING; a_parent_key: STRING)
			-- Create wiki page with title `a_title', and parent key `a_parent_key'.
		do
			pages_sorted := True
			title := a_title
			parent_key := a_parent_key
			src := a_parent_key + "/" + a_title
		end

feature -- Access

	title: STRING
			-- Page's title.

	src: STRING
			-- Relative URI from wiki book root directory.

	path: detachable PATH
			-- Optional associated path

feature -- Access

	new_cursor: ITERATION_CURSOR [WIKI_ITEM]
			-- Fresh cursor associated with current structure
		do
			Result := structure.new_cursor
		end

	key: READABLE_STRING_8
			-- Unique key identifier in a book structure.
			-- utf8 encoded.
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
						Result := l_src.substring (q + 1, p)
					end
				end
			else
				Result := l_src
			end
		end

	structure: WIKI_STRUCTURE
			-- Associated wiki structure.
		local
			l_internal_structure: detachable WIKI_STRUCTURE
			f: RAW_FILE
			t: STRING
			ln, p: INTEGER
			s: STRING
			in_header: BOOLEAN
			h: detachable STRING_TABLE [STRING]
		do
			l_internal_structure := internal_structure
			if
				l_internal_structure = Void and then
				attached path as fn
			then
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
					create l_internal_structure.make (h, t)
				else
					create l_internal_structure.make (Void, "!!ERROR!!")
				end
				internal_structure := l_internal_structure
			else
				create l_internal_structure.make (Void, "!!ERROR!!")
				internal_structure := l_internal_structure
			end
			Result := l_internal_structure
		end

feature -- Comparison

	is_less alias "<" (other: like Current): BOOLEAN
			-- Is current object less than `other'?
			--| index page are always on top, then depends on `weight', and then on `title'.
		do
			if is_index_page or other.is_index_page then
				if is_index_page then
					if other.is_index_page then
						if weight = other.weight then
							Result := title < other.title
						else
							Result := weight < other.weight
						end
					else
						Result := True
					end
				else
					Result := False
				end
			else
				if weight = other.weight then
					Result := title < other.title
				else
					Result := weight < other.weight
				end
			end
		end

feature -- Access: book

	weight: INTEGER
			-- Associated weight used for sorting sub pages.

	parent_key: STRING
			-- Key identifying a parent page.
			-- utf8 encoded.
			-- note: this is related to book structure.

	pages: detachable ARRAYED_LIST [WIKI_PAGE]
			-- Sub pages.

feature -- Status report: book

	is_index_page: BOOLEAN
			-- Is Current an index page?
		do
			Result :=
						(attached path as p and then attached p.entry as e and then e.name.is_case_insensitive_equal ("index.wiki"))
						or else	title.is_case_insensitive_equal_general ("index")
						or else title.is_case_insensitive_equal_general (parent_key) -- Same as parent page name.
		end

	has_page: BOOLEAN
			-- Has any sub page?
		do
			Result := attached pages as lst and then not lst.is_empty
		end

	pages_sorted: BOOLEAN
			-- Are `pages' sorted?

feature -- Query: book		

	page (a_title: READABLE_STRING_GENERAL): detachable WIKI_PAGE
			-- Sub page titled `a_title' if any.
		do
			if attached pages as l_pages then
				across
					l_pages as ic
				until
					Result /= Void
				loop
					Result := ic.item
					if not Result.title.is_case_insensitive_equal_general (a_title) then
						Result := Void
					end
				end
			end
		end

	page_by_key (k: READABLE_STRING_GENERAL): detachable WIKI_PAGE
			-- Sub page with key `k' if any.	
		do
			if attached pages as l_pages then
				across
					l_pages as ic
				until
					Result /= Void
				loop
					Result := ic.item
					if not Result.key.is_case_insensitive_equal_general (k) then
						Result := Void
					end
				end
			end
		end

feature -- Element change

	set_path (p: PATH)
			-- Set associated `path' to `p'.
		do
			path := p
		end

	set_src (a_src: like src)
			-- Set associated uri `src' to `a_src'.
		do
			src := a_src
		end

feature -- Element change: book		

	set_parent (a_page: WIKI_PAGE)
			-- Set optional parent page.
		do
			parent_key := a_page.key
		end

	set_weight (a_weight: like weight)
			-- Set optional weight `a_weight'.
		do
			weight := a_weight
		end

	extend (a_page: WIKI_PAGE)
		require
			not_current: a_page /= Current
			not_same_title_as_current: not title.is_case_insensitive_equal (a_page.title)
		local
			l_pages: like pages
		do
			l_pages := pages
			if l_pages = Void then
				create l_pages.make (3)
				pages := l_pages
			end
			l_pages.extend (a_page)
			pages_sorted := l_pages.count <= 1
		end

	add_page (a_page: WIKI_PAGE)
		obsolete
			"Use `extend' [Oct-2014]"
		require
			not_current: a_page /= Current
			not_same_title_as_current: not title.is_case_insensitive_equal (a_page.title)
		do
			extend (a_page)
		end

	add_page_with_weight (a_page: WIKI_PAGE; a_weight: INTEGER)
		obsolete
			"Use `extend' and set weight on `a_page' directly [Oct-2014]"
		require
			not_current: a_page /= Current
			not_same_title_as_current: not title.is_case_insensitive_equal (a_page.title)
		do
			a_page.set_weight (a_weight)
			extend (a_page)
		end

feature -- Basic operations	

	sort
			-- Sort `pages' by `title' and `weight'.
		local
			l_sorter: QUICK_SORTER [WIKI_PAGE]
		do
			if
				not pages_sorted and
				attached pages as l_pages and then not l_pages.is_empty
			then
				create l_sorter.make (create {COMPARABLE_COMPARATOR [WIKI_PAGE]})
				l_sorter.sort (l_pages)
				pages_sorted := True
			end
		end

	recursive_sort
			-- Sort `pages' by `title' and `weight', and then recursively sort the sub pages.
		local
			l_sorter: QUICK_SORTER [WIKI_PAGE]
		do
			if
				not pages_sorted and
				attached pages as l_pages and then not l_pages.is_empty
			then
				create l_sorter.make (create {COMPARABLE_COMPARATOR [WIKI_PAGE]})
				l_sorter.sort (l_pages)
				across
					l_pages as ic
				loop
					ic.item.recursive_sort
				end
				pages_sorted := True
			end
		end

	get_structure (a_filename: PATH)
			-- Get structure from file at `a_filename'.
		do
			path := a_filename
			internal_structure := Void
		end

feature -- Visitor

	process (a_visitor: WIKI_VISITOR)
		do
			a_visitor.visit_page (Current)
		end

feature {NONE} -- Implementation

	internal_structure: detachable like structure
			-- Internal structure value.		

	structure_from_path (fn: PATH): like structure
		local
			f: RAW_FILE
			t: STRING
			ln, p: INTEGER
			s: STRING
			in_header: BOOLEAN
			h: detachable STRING_TABLE [STRING]
		do
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
				create Result.make (h, t)
			else
				create Result.make (Void, "!!ERROR!!")
			end
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
			if is_index_page then
				Result.append_string (" !#")
			else
				Result.append_string (" #")
			end
			Result.append_integer (weight)
		end

note
	copyright: "2011-2014, Jocelyn Fiat and Eiffel Software"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Jocelyn Fiat
			Contact: http://about.jocelynfiat.net/
		]"
end

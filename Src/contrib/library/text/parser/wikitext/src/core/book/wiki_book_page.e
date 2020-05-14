note
	description: "[
			Wiki page inside a WIKI_BOOK
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	WIKI_BOOK_PAGE

inherit
	WIKI_PAGE
		rename
			make as old_make
		redefine
			debug_output,
			process,
			page,
			set_path
		end

create
	make,
	make_from_page

feature {NONE} -- Make

	make (a_page_id: READABLE_STRING_8; a_parent_key: READABLE_STRING_8)
			-- Create wiki page with page id `a_page_id', and parent key `a_parent_key'.
		do
			page_id := a_page_id
			make_with_title (a_page_id)
			parent_key := a_parent_key
			set_src (a_parent_key + "/" + a_page_id)

			is_index_page :=	a_page_id.is_case_insensitive_equal_general ("index")
								or else a_page_id.is_case_insensitive_equal_general (parent_key) -- Same as parent page name.
		end

	make_from_page (a_page: WIKI_PAGE; a_parent_key: READABLE_STRING_8)
			-- Create a book page from a page `a_page'.
		do
			if attached {WIKI_BOOK_PAGE} a_page as l_book_page then
				make (l_book_page.page_id, a_parent_key)
			else
				make (a_page.title, a_parent_key)
			end
			set_title (a_page.title)
			weight := a_page.weight
			text := a_page.text
			if attached a_page.pages as l_pages then
				across
					l_pages as ic
				loop
					if attached {WIKI_BOOK_PAGE} ic.item as l_book_page then
						extend (l_book_page)
					else
						extend (create {WIKI_BOOK_PAGE}.make_from_page (ic.item, a_parent_key))
					end
				end
				pages_sorted := a_page.pages_sorted
			end
			if attached a_page.path as p then
				set_path (p)
			end
			if attached metadata_table as tb then
				across
					tb as ic
				loop
					set_metadata (ic.item, ic.key)
				end
			end
			if attached {WIKI_BOOK_PAGE} a_page as l_book_page then
				set_src (create {STRING}.make_from_string (l_book_page.src))
			end
		end

feature -- Access

	src: READABLE_STRING_8
			-- Relative URI from wiki book root directory.

feature -- Access

	key: READABLE_STRING_8
			-- Unique key identifier in a book structure.
			-- utf8 encoded.
		local
			k: like internal_key
			l_src: like src
			p,q: INTEGER
		do
			k := internal_key
			if k = Void then
				l_src := src
				p := l_src.count + 1
				q := l_src.last_index_of ('/', p - 1)
				if q > 0 then
					k := l_src.substring (q + 1, p - 1)
					if k.is_case_insensitive_equal ("index") then
						p := q - 1
						q := l_src.last_index_of ('/', p)
						if q > 0 then
							k := l_src.substring (q + 1, p)
						end
					end
				else
					k := l_src
				end
				internal_key := k
			end
			Result := k
		end

feature {NONE} -- Implementation

	internal_key: detachable like key
			-- Cached value for `key'

feature -- Access: book

	page_id: READABLE_STRING_8
			-- Id , related to `key' and `parent_key'
			-- utf8 encoded.
			-- note: this is related to book structure.

	parent_key: READABLE_STRING_8
			-- Key identifying a parent page.
			-- utf8 encoded.
			-- note: this is related to book structure.

feature -- Status report: book

	is_index_page: BOOLEAN
			-- Is Current an index page?

feature -- Query: book	

	page (a_title: READABLE_STRING_GENERAL): detachable WIKI_BOOK_PAGE
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

	page_by_key (k: READABLE_STRING_GENERAL): detachable WIKI_BOOK_PAGE
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

	set_is_index_page (b: BOOLEAN)
			-- Set `is_index_page' to `b'.
		do
			is_index_page := b
		end

	set_src (a_src: like src)
			-- Set associated uri `src' to `a_src'.
		do
			internal_key := Void
			src := a_src
		end

	set_path (p: PATH)
		do
			Precursor (p)
			is_index_page := (attached p.entry as e and then e.name.is_case_insensitive_equal ("index.wiki"))
								or else	page_id.is_case_insensitive_equal_general ("index")
								or else page_id.is_case_insensitive_equal_general (parent_key) -- Same as parent page name.
		end

feature -- Element change: book		

	set_parent (a_page: WIKI_BOOK_PAGE)
			-- Set optional parent page.
		do
			parent_key := a_page.key
		end

feature -- Visitor

	process (a_visitor: WIKI_VISITOR)
		do
			a_visitor.visit_page (Current)
		end

feature -- Status report

	debug_output: STRING
			-- String that should be displayed in debugger to represent `Current'.
		do
			create Result.make_from_string (parent_key)
			Result.append_character (':')
			Result.append_string (Precursor)
			if is_index_page then
				Result.append_string ("!")
			end
		end

note
	copyright: "2011-2018, Jocelyn Fiat and Eiffel Software"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Jocelyn Fiat
			Contact: http://about.jocelynfiat.net/
		]"
end

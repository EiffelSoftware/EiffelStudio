note
	description: "Summary description for {WIKI_BOOK}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	WIKI_BOOK

inherit
	COMPARABLE

	DEBUG_OUTPUT
		undefine
			is_equal
		end

create
	make

feature {NONE} -- Initialization

	make (n: READABLE_STRING_8; p: like path)
		do
			name := n
			path := p
			create pages.make (50)
		end

feature -- Visitor

	process (a_visitor: WIKI_VISITOR)
		do
			a_visitor.visit_book (Current)
		end

	analyze
		do
			across
				pages as c
			loop
				c.item.get_structure (page_path (c.item))
			end
		end

feature -- Comparison

	is_less alias "<" (other: like Current): BOOLEAN
			-- Is current object less than `other'?
		do
			if weight = other.weight then
				Result := name < other.name
			else
				Result := weight < other.weight
			end
		end

feature -- Sorting operation		

	sort
			-- Sort `pages' and sub pages.
		local
			l_sorter: QUICK_SORTER [WIKI_BOOK_PAGE]
		do
			create l_sorter.make (create {COMPARABLE_COMPARATOR [WIKI_BOOK_PAGE]})
			l_sorter.sort (pages)
			across
				pages as ic
			loop
				ic.item.sort
			end
			if attached root_page as rp then
				check root_page_sorted: rp.pages_sorted end
			end
		end

feature -- Access

	path: PATH

	name: READABLE_STRING_8

	pages: ARRAYED_LIST [WIKI_BOOK_PAGE]

	weight: INTEGER
		do
			if attached root_page as rp then
				Result := rp.weight
			end
		end

	root_page: detachable WIKI_BOOK_PAGE
			-- Page representing the book if any.
		local
			wp: WIKI_BOOK_PAGE
			l_book_name: READABLE_STRING_8
			l_index_page,l_book_page: detachable WIKI_BOOK_PAGE
		do
			Result := internal_root_page
			if Result = Void then
				l_book_name := name
				across
					pages as ic
				until
					Result /= Void
				loop
					wp := ic.item
					if wp.key.is_case_insensitive_equal_general ("index") then
						l_index_page := wp
						Result := wp
					elseif wp.key.is_case_insensitive_equal_general (l_book_name) then
						l_book_page := wp
					end
				end
				if Result = Void then
					Result := l_book_page
				end
				internal_root_page := Result
			end
		end

	top_pages: LIST [WIKI_BOOK_PAGE]
			-- Top pages of the book, or the immediate children of the root_page.
			-- The root_page is not a top page.
		local
			wp: WIKI_BOOK_PAGE
			l_key: READABLE_STRING_8
			l_book_name: like name
			l_index_page,l_book_page: detachable WIKI_BOOK_PAGE
		do
			if attached root_page as rp and then attached rp.pages as rp_pages then
				create {ARRAYED_LIST [WIKI_BOOK_PAGE]} Result.make (rp_pages.count)
				across
					rp_pages as ic
				loop
					Result.force (ic.item)
				end
			else
				l_book_name := name
				create {ARRAYED_LIST [WIKI_BOOK_PAGE]} Result.make (0)
				across
					pages as ic
				loop
					wp := ic.item
					l_key := wp.key
					if l_key.is_case_insensitive_equal_general (l_book_name) then
						l_book_page := wp
						--Result.force (wp)
					elseif l_key.is_case_insensitive_equal_general ("index") then
						l_index_page := wp
						--Result.force (wp)
					elseif wp.parent_key.is_case_insensitive_equal_general (l_book_name) then
						Result.force (wp)
					end
				end
			end
		end

	page (a_title: READABLE_STRING_GENERAL): detachable WIKI_BOOK_PAGE
			-- Page with title `a_title'.
		do
			across
				pages as ic
			until
				Result /= Void
			loop
				Result := ic.item
				if not Result.title.is_case_insensitive_equal_general (a_title) then
					Result := Void
				end
			end
		end

	page_by_metadata (a_metadata_name: READABLE_STRING_GENERAL; a_metadata_value: READABLE_STRING_GENERAL; is_caseless: BOOLEAN): detachable like page
			-- Page with metadata `a_metadata_name' matching value `a_metadata_value'.
		do
			across
				pages as ic
			until
				Result /= Void
			loop
				Result := ic.item
				if attached Result.metadata (a_metadata_name) as md then
					if is_caseless then
						if a_metadata_value.is_case_insensitive_equal (md) then
							-- Found caseless
						else
							Result := Void
						end
					else
						check is_not_caseless: not is_caseless end
						if a_metadata_value.same_string (md) then
							-- Found case sensitive.
						else
							Result := Void
						end
					end
				else
					Result := Void
				end
			end
		end

	page_by_key (a_key: READABLE_STRING_GENERAL): detachable like page
			-- Page identified with key `a_key'.
		local
			l_index_pages: ARRAYED_LIST [attached like page]
		do
			create l_index_pages.make (10)
			across
				pages as ic
			until
				Result /= Void
			loop
				Result := ic.item
				if not Result.key.is_case_insensitive_equal_general (a_key) then
					if Result.is_index_page then
						l_index_pages.force (Result)
					end
					Result := Void
				end
			end
			if Result = Void then
				across
					l_index_pages as ic
				until
					Result /= Void
				loop
					Result := ic.item
					check Result.is_index_page end
					if
						Result.parent_key.is_case_insensitive_equal_general (a_key)
					then
							-- Find it.
					else
						Result := Void
					end
				end			
			end
		end

	page_path (a_page: WIKI_BOOK_PAGE): PATH
		local
			lst: LIST [READABLE_STRING_8]
			l_name: READABLE_STRING_8
		do
			l_name := name
			Result := path
			lst := a_page.src.split ('/')
			from
				lst.start
				if
					not lst.off and then
					l_name.same_string_general (lst.item) -- FIXME: #unicode  url decoded ?
				then
					lst.forth
				end
			until
				lst.after
			loop
				Result := Result.extended (lst.item)
				lst.forth
			end
			Result := Result.appended_with_extension ("wiki")
		end

feature {NONE} -- Internal

	internal_root_page: detachable like root_page

feature -- Element change

	add_page (a_page: WIKI_BOOK_PAGE)
			-- Add page `a_page' to current book.
		do
			internal_root_page := Void
			pages.extend (a_page)
		end

feature -- Status report

	debug_output: STRING
			-- String that should be displayed in debugger to represent `Current'.
		do
			create Result.make_from_string (name)
			Result.append_character (':')
			Result.append_character (' ')
			Result.append_integer (pages.count)
			Result.append_string (" pages")
			Result.append_string (" #")
			Result.append_integer (weight)
		end

note
	copyright: "2011-2018, Jocelyn Fiat and Eiffel Software"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Jocelyn Fiat
			Contact: http://about.jocelynfiat.net/
		]"
end

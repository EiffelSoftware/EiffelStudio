note
	description: "Summary description for {WIKI_BOOK}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	WIKI_BOOK

inherit
	DEBUG_OUTPUT

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

feature -- Access

	path: PATH

	name: READABLE_STRING_8

	pages: ARRAYED_LIST [WIKI_PAGE]

	root_page: detachable WIKI_PAGE
			-- Page representing the book if any.
		local
			wp: WIKI_PAGE
			l_book_name: like name
			l_index_page,l_book_page: detachable WIKI_PAGE
		do
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
		end		

	top_pages: ARRAYED_LIST [WIKI_PAGE]
			-- Top pages of the book, or the immediate children of the root_page.
			-- The root_page is not a top page.
		local
			wp: WIKI_PAGE
			l_key: READABLE_STRING_8
			l_book_name: like name
			l_index_page,l_book_page: detachable WIKI_PAGE
		do
			create Result.make (0)
			l_book_name := name
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

	page (a_title: READABLE_STRING_GENERAL): detachable WIKI_PAGE
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

	page_by_key (a_key: READABLE_STRING_GENERAL): detachable WIKI_PAGE
			-- Page identified with key `a_key'.
		do
			across
				pages as ic
			until
				Result /= Void
			loop
				Result := ic.item
				if not Result.key.is_case_insensitive_equal_general (a_key) then
					Result := Void
				end
			end
		end		

	page_path (a_page: WIKI_PAGE): PATH
		local
			lst: LIST [READABLE_STRING_8]
		do
			Result := path
			lst := a_page.src.split ('/')
			from
				lst.start
				if
					not lst.off and then
					lst.item.same_string (name)
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

feature -- Element change

	add_page (a_page: WIKI_PAGE)
			-- Add page `a_page' to current book.
		do
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
		end

note
	copyright: "2011-2014, Jocelyn Fiat and Eiffel Software"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Jocelyn Fiat
			Contact: http://about.jocelynfiat.net/
		]"
end

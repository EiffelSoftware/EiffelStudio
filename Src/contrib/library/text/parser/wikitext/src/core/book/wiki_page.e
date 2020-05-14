note
	description: "[
				Interface for a wiki page.
			]"
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
	make,
	make_with_title

feature {NONE} -- Make

	make (a_title: READABLE_STRING_8; a_unused_arg: READABLE_STRING_8)
			-- Create wiki page with title `a_title'.
		obsolete
			"Use make_with_title (a_title) [2017-05-31]"
		do
			make_with_title (a_title)
		end

	make_with_title (a_title: READABLE_STRING_8)
			-- Create wiki page with title `a_title'.
		do
			set_title (a_title)
			create {WIKI_CONTENT_TEXT} text.make_from_string ("")
			pages_sorted := True
		end

feature -- Access

	title: READABLE_STRING_8
			-- Page's title.

	weight: INTEGER
			-- Associated weight used for sorting sub pages.			

	text: WIKI_TEXT
			-- Associated wiki text.

	path: detachable PATH
			-- Optional associated path
		do
			if attached {WIKI_FILE_TEXT} text as f then
				Result := f.path
			end
		end

	pages: detachable ARRAYED_LIST [attached like page]
			-- Sub pages.

	metadata_table: detachable STRING_TABLE [READABLE_STRING_32]
			-- Optional metadata used to hold data associated with Current page.

feature -- status report

	has_page: BOOLEAN
			-- Has any sub page?
		do
			Result := attached pages as lst and then not lst.is_empty
		end

	pages_sorted: BOOLEAN
			-- Are `pages' sorted?	

feature -- Query		

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

	has_metadata (a_name: READABLE_STRING_GENERAL): BOOLEAN
			-- Has metadata associated with name `a_name'.
		do
			if attached metadata_table as tb then
				Result := tb.has_key (a_name)
			end
		end

	metadata (a_name: READABLE_STRING_GENERAL): detachable READABLE_STRING_32 assign set_metadata
			-- Metadata value associated with name `a_name'.
		do
			if attached metadata_table as tb then
				Result := tb.item (a_name)
			end
		end

	metadata_count: INTEGER
			-- Number of metadata items.
		do
			if attached metadata_table as tb then
				Result := tb.count
			end
		end

feature -- Access

	new_cursor: ITERATION_CURSOR [WIKI_ITEM]
			-- Fresh cursor associated with current structure
		do
			Result := structure.new_cursor
		end

	structure: WIKI_STRUCTURE
			-- Associated wiki structure.
		do
			Result := text.structure
		end

feature -- Comparison

	is_less alias "<" (other: like Current): BOOLEAN
			-- Is current object less than `other'?
			--| index page are always on top, then depends on `weight', and then on `title'.
		do
			if weight = other.weight then
				Result := title < other.title
			else
				Result := weight < other.weight
			end
		end

feature -- Element change

	update_from_metadata
			-- Update Current attribute with value from `metadata'.
		do
			if attached metadata ("title") as l_title then
				set_title (l_title)
			end
			if
				attached metadata ("weight") as l_weight and then
				l_weight.is_integer
			then
				set_weight (l_weight.to_integer)
			end
		end

	update_metadata
			-- Update metadata values, from specific attributes of Current.
		do
			set_metadata (title.to_string_32, "title")
			set_metadata (weight.out, "weight")
		end

	set_title (a_title: READABLE_STRING_GENERAL)
			-- Set `title' to `a_title'.
		local
			utf: UTF_CONVERTER
		do
			if attached {READABLE_STRING_8} a_title as l_title then
				title := l_title
			else
				title := utf.escaped_utf_32_string_to_utf_8_string_8 (a_title)
			end
		end

	set_path (p: PATH)
			-- Set associated `path' to `p'.
		do
			create {WIKI_FILE_TEXT} text.make_from_path (p)
		end

	set_weight (a_weight: like weight)
			-- Set optional weight `a_weight'.
		do
			weight := a_weight
		end

	set_text (a_text: like text)
			-- Set `text' to `a_text'.
		do
			text := a_text
		end

	extend (a_page: attached like page)
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

	add_page (a_page: attached like page)
		obsolete
			"Use `extend' [2017-05-31]"
		require
			not_current: a_page /= Current
			not_same_title_as_current: not title.is_case_insensitive_equal (a_page.title)
		do
			extend (a_page)
		end

	add_page_with_weight (a_page: attached like page; a_weight: INTEGER)
		obsolete
			"Use `extend' and set weight on `a_page' directly [2017-05-31]"
		require
			not_current: a_page /= Current
			not_same_title_as_current: not title.is_case_insensitive_equal (a_page.title)
		do
			a_page.set_weight (a_weight)
			extend (a_page)
		end

	set_metadata (a_value: detachable READABLE_STRING_32; a_name: READABLE_STRING_GENERAL)
			-- Associate `a_name' with value `a_value'.
			-- If `a_value' is Void, remove association if any.
		local
			tb: like metadata_table
		do
			tb := metadata_table
			if a_value = Void then
				if tb /= Void then
					tb.remove (a_name)
					if tb.is_empty then
						metadata_table := Void
					end
				end
			else
				if tb = Void then
					create tb.make (1)
					metadata_table := tb
				end
				tb.force (a_value, a_name)
			end
		end

feature -- Basic operations	

	get_structure (a_filename: PATH)
			-- Get structure from file at `a_filename'.
		do
			set_path (a_filename)
		end

feature -- Basic operations	

	sort
			-- Sort `pages' by `title' and `weight'.
		local
			l_sorter: QUICK_SORTER [attached like page]
		do
			if
				not pages_sorted and
				attached pages as l_pages and then not l_pages.is_empty
			then
				create l_sorter.make (create {COMPARABLE_COMPARATOR [attached like page]})
				l_sorter.sort (l_pages)
				pages_sorted := True
			end
		end

	recursive_sort
			-- Sort `pages' by `title' and `weight', and then recursively sort the sub pages.
		local
			l_sorter: QUICK_SORTER [attached like page]
		do
			if
				not pages_sorted and
				attached pages as l_pages and then not l_pages.is_empty
			then
				create l_sorter.make (create {COMPARABLE_COMPARATOR [attached like page]})
				l_sorter.sort (l_pages)
				across
					l_pages as ic
				loop
					ic.item.recursive_sort
				end
				pages_sorted := True
			end
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
			create Result.make_from_string (title)
			if attached pages as l_pages then
				Result.append_character (':')
				Result.append_character (' ')
				Result.append_integer (l_pages.count)
				Result.append_string (" pages")
			end
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

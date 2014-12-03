note
	description: "Summary description for {WIKI_BOOK_JSON_SERIALIZER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	WIKI_BOOK_JSON_SERIALIZER

inherit
	WIKI_ITERATOR

feature -- Conversion

	book_to_json (a_book: WIKI_BOOK): JSON_OBJECT
		do
			create Result.make_empty
			Result.put_string (a_book.name, "name")
			Result.put_string (a_book.path.name, "path")
			if attached a_book.pages as l_pages then
				Result.put (pages_to_json (l_pages), "pages")
			end
		end

	pages_to_json (a_pages: LIST [WIKI_BOOK_PAGE]): JSON_ARRAY
		do
			create Result.make (a_pages.count)
			across
				a_pages as ic
			loop
				Result.extend (page_to_json (ic.item))
			end
		end

	page_to_json (a_page: WIKI_BOOK_PAGE): JSON_OBJECT
		local
			obj: JSON_OBJECT
		do
			create Result.make_empty
			Result.put_string (a_page.page_id, "id")
			Result.put_string (a_page.parent_key, "parent_key")
			
			Result.put_string (a_page.title, "title")
			if a_page.weight > 0 then
				Result.put_integer (a_page.weight, "weight")
			end
			if attached a_page.path as p then
				Result.put_string (p.name, "path")
			end
			Result.put_string (a_page.src, "src")
			if
				attached a_page.metadata_table as tb and then
				not tb.is_empty
			then
				create obj.make_with_capacity (tb.count)
				across
					tb as ic
				loop
					obj.put_string (ic.item, ic.key)
				end
				Result.put (obj, "metadata")
			end

			if attached a_page.pages as l_pages then
				Result.put (pages_to_json (l_pages), "pages")
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

note
	description: "Summary description for {WIKI_BOOK_JSON_DESERIALIZER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	WIKI_BOOK_JSON_DESERIALIZER

feature -- Conversion

	book (a_json: READABLE_STRING_8): detachable WIKI_BOOK
		local
			p: JSON_PARSER
			l_path: PATH
		do
			create p.make_with_string (a_json)
			p.parse_content
			if attached p.parsed_json_object as obj then
				if attached {JSON_STRING} obj.item ("name") as j_name then
					if attached {JSON_STRING} obj.item ("path") as j_path then
						create l_path.make_from_string (j_path.unescaped_string_32)
					else
						create l_path.make_from_string (j_name.unescaped_string_32)
					end
					create Result.make (j_name.unescaped_string_8, l_path)
					if attached {JSON_ARRAY} obj.item ("pages") as j_pages then
						across
							j_pages as ic
						loop
							if
								attached {JSON_OBJECT} ic.item as j_page and then
								attached page_from_json (j_page) as l_page
							then
								Result.add_page (l_page)
							end
						end
					end
				end
			end
		end

	page_from_json (obj: JSON_OBJECT): detachable WIKI_BOOK_PAGE
		local
			s: READABLE_STRING_GENERAL
		do
			if attached {JSON_STRING} obj.item ("id") as j_id then
				if attached {JSON_STRING} obj.item ("parent_key") as j_parent_key then
					create Result.make (j_id.unescaped_string_8, j_parent_key.unescaped_string_8)
				else
					create Result.make (j_id.unescaped_string_8, j_id.unescaped_string_8)
				end

				if attached {JSON_STRING} obj.item ("title") as j_title then
					Result.set_title (j_title.unescaped_string_32)
				end
				if attached {JSON_NUMBER} obj.item ("weight") as j_weight then
					Result.set_weight (j_weight.integer_64_item.to_integer_32)
				elseif attached {JSON_STRING} obj.item ("weight") as j_weight then
					s := j_weight.unescaped_string_32
					if s.is_integer then
						Result.set_weight (s.to_integer_32)
					end
				end
				if attached {JSON_STRING} obj.item ("path") as j_path then
					Result.set_path (create {PATH}.make_from_string (j_path.unescaped_string_32))
				end
				if attached {JSON_STRING} obj.item ("src") as j_src then
					Result.set_src (j_src.unescaped_string_8)
				end
				if attached {JSON_OBJECT} obj.item ("metadata") as j_metadata then
					across
						j_metadata as ic
					loop
						if attached {JSON_STRING} ic.item as j_metadata_item then
							Result.set_metadata (j_metadata_item.unescaped_string_32, ic.key.unescaped_string_32)
						else
							check is_metadata: False end
						end
					end
				end

				if attached {JSON_ARRAY} obj.item ("pages") as j_pages then
					across
						j_pages as ic
					loop
						if
							attached {JSON_OBJECT} ic.item as j_page and then
							attached page_from_json (j_page) as l_page
						then
							Result.extend (l_page)
						end
					end
				end
			end
		end

end

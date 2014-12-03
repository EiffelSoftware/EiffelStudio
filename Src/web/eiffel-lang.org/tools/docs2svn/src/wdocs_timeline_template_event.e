note
	description: "Summary description for {WDOCS_TIMELINE_TEMPLATE_EVENT}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	WDOCS_TIMELINE_TEMPLATE_EVENT

inherit
	WDOCS_TIMELINE_PATH_EVENT
		redefine
			relative_path
		end

create
	make

feature {NONE} -- Initialization

	make (a_base_dir: PATH; a_tpl_name: READABLE_STRING_GENERAL; a_tpl_path: PATH; a_book_id: READABLE_STRING_GENERAL; a_rev: WDOCS_REVISION_INFO; a_date: DATE_TIME)
		do
			base_dir := a_base_dir
			location := a_tpl_path
			name := a_tpl_name
			create book.make_from_string_general (a_book_id)
			revision := a_rev
			date := a_date
		end

feature -- Access

	title: STRING_32
		do
			create Result.make_empty
			Result.append_string_general (book)
			Result.append_character ('/')
			Result.append_string_general (name)
		end

	name: READABLE_STRING_GENERAL

	book: STRING_32

feature -- Conversion

	relative_path: STRING_32
		local
			i: INTEGER
			b: STRING_32
			p: PATH
		do
			Result := Precursor
			if book.is_whitespace then
				if Result.starts_with ("_templates") then
					-- Keep it as it is
				else
					i := Result.substring_index ("_templates", 1)
					if i > 0 then
						Result.remove_head (i - 1)  -- remove until end of "^(.*)_templates"
					else
							-- should not occur
					end
				end
			else
					-- specific book
				if Result.starts_with (book) then
						-- Keep it as it is
				else
						-- update path, to be under related book location
					i := Result.substring_index ("_images", 1)
					if i > 1 then
						Result.remove_head (i - 2) -- remove until end of "^(.*)/_images"
						Result.prepend (book)
					end
				end
			end
		end

end

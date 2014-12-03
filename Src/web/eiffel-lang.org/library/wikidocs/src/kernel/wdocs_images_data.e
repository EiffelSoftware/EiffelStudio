note
	description: "Summary description for {WDOCS_IMAGES_DATA}."
	date: "$Date$"
	revision: "$Revision$"

class
	WDOCS_IMAGES_DATA

inherit
	WDOCS_DATA_I
	
	WDOCS_HELPER

create
	make

feature {NONE} -- Initialization

	make
		do
			create images_path_by_title_and_book.make_caseless (0)
		end

feature -- Access

	images_path_by_title_and_book: STRING_TABLE [STRING_TABLE [PATH]]
			-- Wiki image path indexed by title for each book.			

feature -- Element change

	record_image_path (a_path: PATH; a_image_name: READABLE_STRING_GENERAL; a_book_name: READABLE_STRING_GENERAL)
		local
			ht: detachable STRING_TABLE [PATH]
		do
			ht := images_path_by_title_and_book.item (a_book_name)
			if ht = Void then
				create ht.make (1)
				images_path_by_title_and_book.force (ht, a_book_name)
			end
			ht.force (a_path, a_image_name)
		end

end

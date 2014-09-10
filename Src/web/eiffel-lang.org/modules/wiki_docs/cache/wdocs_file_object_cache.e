note
	description: "Summary description for {WDOCS_FILE_OBJECT_CACHE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	WDOCS_FILE_OBJECT_CACHE [G -> ANY]

inherit
	WDOCS_FILE_CACHE [G]

create
	make

feature {NONE} -- Implementation

	file_to_item (f: FILE): detachable G
		do
			if attached {G} f.retrieved as l_data then
				Result := l_data
			end
		end

	item_to_file (a_data: G; f: FILE)
		do
			f.basic_store (a_data)
		end


end

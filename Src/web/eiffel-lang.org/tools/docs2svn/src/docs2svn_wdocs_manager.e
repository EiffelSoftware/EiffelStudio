note
	description: "Summary description for {DOCS2SVN_WDOCS_MANAGER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	DOCS2SVN_WDOCS_MANAGER

inherit
	WDOCS_MANAGER
		redefine
			get_all_data,
			book_from_index_file
		end

create
	make,
	make_clear

feature {NONE} -- Initialization

	make_clear (a_wiki_dir: PATH; a_version_id: like version_id; a_tmp_dir: PATH)
		do
			clear_cache_requested := True
			make (a_wiki_dir, a_version_id, a_tmp_dir)
		end

feature -- Access

	book_from_index_file (a_book_id: READABLE_STRING_GENERAL; p: PATH): detachable WIKI_BOOK
			-- <Precursor>
		do
			-- Do not use book.index for this purpose.
		end

feature -- Settings

	clear_cache_requested: BOOLEAN
			-- Request trigger to clear cache?		

feature {NONE} -- Implementation: data		

	get_all_data
		do
			if clear_cache_requested then
				reset_data
				clear_cache_requested := False
			end
			Precursor
		end

end

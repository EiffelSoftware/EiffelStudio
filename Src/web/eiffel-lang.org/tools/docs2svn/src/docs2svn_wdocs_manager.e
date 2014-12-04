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
			initialize
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

feature -- Settings

	metadata_extension: STRING
		do
			if attached {WDOCS_FS_STORAGE} storage as fs then
				Result := fs.metadata_extension
			else
				Result := "data"
			end
		end

	clear_cache_requested: BOOLEAN
			-- Request trigger to clear cache?		

feature {NONE} -- Implementation: data		

	initialize
		do
			Precursor
			if clear_cache_requested then
				refresh_data
				clear_cache_requested := False
			end
		end

end

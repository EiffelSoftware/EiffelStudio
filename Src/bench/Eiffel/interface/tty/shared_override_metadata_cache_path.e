indexing
	description: "Shell pattern used to store overridden metadata cache path%
					% set via command line parameters."
	date: "$Date$"
	revision: "$Revision$"

class
	SHARED_OVERRIDDEN_METADATA_CACHE_PATH

feature -- Access

	overridden_metadata_cache_path: STRING is
			-- Overridden metadata cache path if any
		do
			Result := omcp_cell.item
		end

feature -- Element Settings

	set_overridden_metadata_cache_path (a_path: STRING) is
			-- Set `overridden_metadata_cache_path' with `a_path'.
		do
			omcp_cell.replace (a_path)
		ensure
			overridden_metadata_cache_path_set: overridden_metadata_cache_path = a_path
		end

feature {NONE} -- Implementation
	
	omcp_cell: CELL [STRING] is
			-- Once cell used for shell pattern
		once
			create Result.put (Void)
		end

end -- class SHARED_OVERRIDDEN_METADATA_CACHE_PATH

indexing
	description: "Global cache settings"
	date: "$Date$"
	revision: "$Revision$"

class
	CACHE_SETTINGS

feature -- Access

	short_cache_name: STRING is "md_test"
			-- Short cache name.
			-- Note: this should be as short as possible given file name
			-- length restriction on Windows. This is name used when
			-- running in `conservative_mode'
			
	cache_name: STRING is "MetadataConsumer"
			-- Cache name.
			
	conservative_mode: BOOLEAN is True
			-- State to indicate if cache should be conservative when creating paths
			-- to cached contents	

end -- class CACHE_SETTINGS

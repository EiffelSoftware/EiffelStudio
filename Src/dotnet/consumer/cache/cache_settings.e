indexing
	description: "Global cache settings"
	date: "$Date$"
	revision: "$Revision$"

class
	CACHE_SETTINGS

feature -- Access

	short_cache_name: STRING is "md"
			-- Short cache name.
			-- Note: this should be as short as possible given file name
			-- length restriction on Windows. This is name used when
			-- running in `concervative_mode'
			
	cache_name: STRING is "MetadataConsumer"
			-- Cache name.
			
	concervative_mode: BOOLEAN is True
			-- State to indicate if cache should be concervative when creating paths
			-- to cached contents	

end -- class CACHE_SETTINGS

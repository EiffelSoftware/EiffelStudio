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
			-- running in `conservative_mode'
			
	cache_name: STRING is "MetadataConsumer"
			-- Cache name.
			
	conservative_mode: BOOLEAN is True
			-- State to indicate if cache should be conservative when creating paths
			-- to cached contents
			
	cache_lock_id: SYSTEM_STRING is "{73C34FFF-4F38-4c28-8D61-1DD6F44D4E57}"
			-- id used to lock cache.
			-- Note: if `short_cache_name' and `cache_name' change this should
			-- also change.

end -- class CACHE_SETTINGS

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
			
	cache_lock_id: SYSTEM_STRING is
			-- id used to lock cache.
			-- Note: This has to be unique per user since accessing a Mutex created by
			-- a different user causes a security exception. This means that concurrent
			-- cache access by different users is not supported.
		once
			Result := feature {SYSTEM_STRING}.concat (cache_name.to_cil,  feature {ENVIRONMENT}.user_name)
		end

end -- class CACHE_SETTINGS

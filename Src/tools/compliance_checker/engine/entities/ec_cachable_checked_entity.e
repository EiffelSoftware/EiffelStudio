indexing
	description: "[
		Implemented by checked entities that want to permit or vito placing themselves in a global cache.
		Note: Creators on checked entities should pay attention to implementing entities and perform
		      requested caching.
	]"
	author     : "$Author$"
	date       : "$Date$"
	revision   : "$Revision$"

deferred class
	EC_CACHABLE_CHECKED_ENTITY

inherit
	EC_CHECKED_ENTITY
	
feature -- Query

	cache_checked_entity: BOOLEAN is
			-- Can `Current' be cached?	
		once
			Result := True
		end

end -- class EC_CACHABLE_CHECKED_ENTITY

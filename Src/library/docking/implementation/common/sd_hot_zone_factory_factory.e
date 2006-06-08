indexing
	description: "Factory for SD_HOT_ZONE_ABSTRACT_FACTORY"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	SD_HOT_ZONE_FACTORY_FACTORY

feature -- Hot zone factory

	hot_zone_factory: SD_HOT_ZONE_ABSTRACT_FACTORY is
			-- Hot zone factory which current os should use.
		deferred
		ensure
			not_void: Result /= Void
		end
end

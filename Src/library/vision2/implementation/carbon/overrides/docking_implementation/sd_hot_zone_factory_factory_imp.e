note
	description: "Carbon implementation for SD_HOT_ZONE_ABSTRACT_FACTORY"
	date: "$Date$"
	revision: "$Revision$"

class
	SD_HOT_ZONE_FACTORY_FACTORY_IMP

inherit
	SD_HOT_ZONE_FACTORY_FACTORY

feature -- Hot zone factory

	hot_zone_factory: SD_HOT_ZONE_ABSTRACT_FACTORY
			-- Hot zone factory which current os should use.
		do
			create {SD_HOT_ZONE_OLD_FACTORY} Result
		end

end

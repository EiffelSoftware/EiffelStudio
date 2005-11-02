indexing
	description: "Classes which is dockable should inherit this class. It used by SD_DOCKER_MEDIATOR"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	SD_DOCKER_SOURCE

feature -- 
	
	add_hot_zones (a_docker_mediator: SD_DOCKER_MEDIATOR; a_hot_zones: ARRAYED_LIST [SD_HOT_ZONE]) is
			-- 
		local
			l_zone: SD_ZONE
		do
			l_zone ?= Current
			check l_zone /= Void end
			a_hot_zones.extend (internal_shared.hot_zone_factory.hot_zone (l_zone))
		end
	
feature {NONE} -- Implementation

	internal_shared: SD_SHARED
			-- All singletons

end

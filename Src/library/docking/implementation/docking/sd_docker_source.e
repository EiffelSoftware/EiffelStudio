note
	description: "SD_ZONE which dockable SD_ZONE should inherited, used by SD_DOCKER_MEDIATOR"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	SD_DOCKER_SOURCE

feature -- Key feature

	add_hot_zones (a_docker_mediator: SD_DOCKER_MEDIATOR; a_hot_zones: ARRAYED_LIST [SD_HOT_ZONE])
			-- Add hot zones
		require
			a_docker_mediator_not_void: a_docker_mediator /= Void
			a_hot_zones_not_void: a_hot_zones /= Void
		do
			if attached {SD_ZONE} Current as l_zone then
				if attached internal_shared.hot_zone_factory as f then
					a_hot_zones.extend (f.hot_zone (l_zone))
				end
			else
				check not_possible: False end
			end
		end

feature {NONE}  -- Implementation

	internal_shared: SD_SHARED
			-- All singletons
		deferred
		end

invariant

	internal_shared_not_void: internal_shared /= Void

note
	library:	"SmartDocking: Library of reusable components for Eiffel."
	copyright:	"Copyright (c) 1984-2016, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end

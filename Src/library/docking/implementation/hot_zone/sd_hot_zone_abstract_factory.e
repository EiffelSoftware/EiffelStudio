note
	description: "Factory produces different feedback styles hot zone families."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	SD_HOT_ZONE_ABSTRACT_FACTORY

feature {NONE} -- Creation

	make (m: SD_DOCKER_MEDIATOR)
			-- Set `docker_mediator' to `m'.
		do
			docker_mediator := m
		ensure
			docker_mediator_set: docker_mediator = m
		end

feature -- Factory Methods

	hot_zone (a_zone: SD_ZONE): SD_HOT_ZONE
			-- Facotry method
		require
			a_zone_not_void: a_zone /= Void
			valid: (attached {SD_DOCKING_ZONE} a_zone) or (attached {SD_TAB_ZONE} a_zone)
		deferred
		ensure
			not_void: Result /= Void
		end

	hot_zone_main (a_zone: SD_ZONE; a_docking_manager: SD_DOCKING_MANAGER): SD_HOT_ZONE
			-- Hot zone for SD_MULTI_DOCK_AREA.
		require
			not_void: a_zone /= Void
			not_void: a_docking_manager /= Void
		deferred
		ensure
			not_void: Result /= Void
		end

feature {NONE} -- Docker mediator.

	docker_mediator: SD_DOCKER_MEDIATOR
			-- Docker mediator.

;note
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

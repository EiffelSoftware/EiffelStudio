indexing
	description: "Factory produces different feedback styles hot zone families."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	SD_HOT_ZONE_ABSTRACT_FACTORY

feature -- Factory Methods

	hot_zone (a_zone: SD_ZONE): SD_HOT_ZONE is
			-- Facotry method
		require
			a_zone_not_void: a_zone /= Void
		deferred
		ensure
			not_void: Result /= Void
		end

	hot_zone_main (a_zone: SD_ZONE; a_docking_manager: SD_DOCKING_MANAGER): SD_HOT_ZONE is
			-- Hot zone for SD_MULTI_DOCK_AREA.
		require
			not_void: a_zone /= Void
			not_void: a_docking_manager /= Void
		deferred
		ensure
			not_void: Result /= Void
		end

feature -- Docker mediator.

	docker_mediator: SD_DOCKER_MEDIATOR
			-- Docker mediator.

	set_docker_mediator (a_mediator: like docker_mediator) is
			-- Set `docker_mediator'.
		require
			a_mediator_not_void: a_mediator /= Void
		do
			docker_mediator := a_mediator
		ensure
			set: docker_mediator = a_mediator
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end

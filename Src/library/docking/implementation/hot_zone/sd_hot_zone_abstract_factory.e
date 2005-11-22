indexing
	description: "Factory produces different feedback styles hot zone families."
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

	hot_zone_main: SD_HOT_ZONE is
			-- Hot zone for SD_MULTI_DOCK_AREA.
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

end

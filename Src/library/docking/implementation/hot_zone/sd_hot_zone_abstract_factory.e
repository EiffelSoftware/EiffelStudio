indexing
	description: "Objects that represent different feedback styles class families."
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
		end

	hot_zone_main: SD_HOT_ZONE is
			-- Hot zone which is at outermost.
		deferred
		end

feature --

	docker_mediator: SD_DOCKER_MEDIATOR

	set_docker_mediator (a_mediator: like docker_mediator) is
			--
		do
			docker_mediator := a_mediator
		end

end

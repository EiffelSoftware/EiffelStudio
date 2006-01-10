indexing
	description: "SD_HOT_ZONE for editor type zone."
	date: "$Date$"
	revision: "$Revision$"

class
	SD_HOT_ZONE_MAIN_EDITOR

inherit
	SD_HOT_ZONE

create
	make

feature {NONE}  -- Initlization

	make (a_docker_mediator: SD_DOCKER_MEDIATOR) is
			-- Creation method
		require
			not_void: a_docker_mediator /= Void
		do
			create internal_shared
			internal_mediator := a_docker_mediator
		ensure
			set: internal_mediator = a_docker_mediator
		end

feature {NONE} -- Implementation

	apply_change (a_screen_x, a_screen_y: INTEGER; caller: SD_ZONE): BOOLEAN is
			-- Redefine
		do

		end

	update_for_pointer_position_feedback (a_screen_x, a_screen_y: INTEGER): BOOLEAN is
			-- Redefine
		do
			internal_shared.feedback.clear
		end

	update_for_pointer_position_indicator (a_screen_x, a_screen_y: INTEGER): BOOLEAN is
			-- Redefine
		do

		end

	update_for_pointer_position_indicator_clear (a_screen_x, a_screen_y: INTEGER) is
			-- Redefine
		do

		end

	clear_indicator is
			-- Redefine
		do

		end

end

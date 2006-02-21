indexing
	description: "SD_HOT_ZONE for editor type zone"
	date: "$Date$"
	revision: "$Revision$"

class
	SD_HOT_ZONE_OLD_MAIN_EDITOR

inherit
	SD_HOT_ZONE

create
	make

feature {NONE} -- Initlization

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

feature -- Redefine

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

	apply_change (a_screen_x, a_screen_y: INTEGER): BOOLEAN is
			-- Redefine
		do

		end

	update_for_pointer_position_feedback (a_screen_x, a_screen_y: INTEGER; a_dockable: BOOLEAN): BOOLEAN is
			-- Redefine
		local
--			l_pixmaps: EV_STOCK_PIXMAPS
		do
			internal_shared.feedback.clear
--			create l_pixmaps
--			internal_mediator.docking_manager.main_window.set_pointer_style (l_pixmaps.ibeam_cursor)
		end

end

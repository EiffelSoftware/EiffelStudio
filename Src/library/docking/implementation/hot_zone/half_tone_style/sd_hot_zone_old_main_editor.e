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

	make (a_docker_mediator: SD_DOCKER_MEDIATOR; a_docking_manager: SD_DOCKING_MANAGER) is
			-- Creation method
		require
			not_void: a_docker_mediator /= Void
			not_void: a_docking_manager /= Void
		do
			create internal_shared
			internal_mediator := a_docker_mediator
			internal_docking_manager := a_docking_manager
		ensure
			set: internal_mediator = a_docker_mediator
			set: internal_docking_manager = a_docking_manager
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
			internal_docking_manager.main_window.set_pointer_style ((create {EV_STOCK_PIXMAPS}).standard_cursor)
		end

	apply_change (a_screen_x, a_screen_y: INTEGER): BOOLEAN is
			-- Redefine
		do

		end

	update_for_pointer_position_feedback (a_screen_x, a_screen_y: INTEGER; a_dockable: BOOLEAN): BOOLEAN is
			-- Redefine
		local
			l_pixmaps: EV_STOCK_PIXMAPS
		do
			internal_shared.feedback.clear
			create l_pixmaps
			internal_mediator.docking_manager.main_window.set_pointer_style (l_pixmaps.ibeam_cursor)
		end

feature {NONE} -- Implementation

	internal_docking_manager: SD_DOCKING_MANAGER
			-- Docking manger which Current belong to.

end

note
	description: "SD_HOT_ZONE for editor type zone"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SD_HOT_ZONE_OLD_MAIN_EDITOR

inherit
	SD_HOT_ZONE

create
	make

feature {NONE} -- Initlization

	make (a_docker_mediator: SD_DOCKER_MEDIATOR; a_docking_manager: SD_DOCKING_MANAGER)
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

feature -- Command

	update_for_indicator (a_screen_x, a_screen_y: INTEGER): BOOLEAN
			-- <Precursor>
		do

		end

	update_for_indicator_clear (a_screen_x, a_screen_y: INTEGER)
			-- <Precursor>
		do

		end

	clear_indicator
			-- <Precursor>
		do
			internal_docking_manager.main_window.set_pointer_style ((create {EV_STOCK_PIXMAPS}).standard_cursor)
		end

	build_indicator
			-- <Precursor>
		do

		end

	apply_change (a_screen_x, a_screen_y: INTEGER): BOOLEAN
			-- <Precursor>
		do

		end

	update_for_feedback (a_screen_x, a_screen_y: INTEGER; a_dockable: BOOLEAN): BOOLEAN
			-- <Precursor>
		local
			l_pixmaps: EV_STOCK_PIXMAPS
		do
			internal_shared.feedback.clear
			create l_pixmaps
			internal_mediator.docking_manager.main_window.set_pointer_style (l_pixmaps.no_cursor)
		end

feature {NONE} -- Implementation

	internal_docking_manager: SD_DOCKING_MANAGER;
			-- Docking manger which Current belong to.

note
	library:	"SmartDocking: Library of reusable components for Eiffel."
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

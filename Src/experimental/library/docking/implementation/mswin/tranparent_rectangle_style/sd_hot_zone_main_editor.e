note
	description: "SD_HOT_ZONE for editor type zone."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SD_HOT_ZONE_MAIN_EDITOR

inherit
	SD_HOT_ZONE

create
	make

feature {NONE}  -- Initlization

	make (a_docker_mediator: SD_DOCKER_MEDIATOR)
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

	apply_change (a_screen_x, a_screen_y: INTEGER): BOOLEAN
			-- <Precursor>
		do

		end

	update_for_feedback (a_screen_x, a_screen_y: INTEGER; a_dockable: BOOLEAN): BOOLEAN
			-- <Precursor>
		do
			-- There is no operation available in this case,
			-- so we should clear the feedback
			internal_shared.feedback.clear
		end

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

		end

	build_indicator
			-- <Precursor>
		do

		end

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

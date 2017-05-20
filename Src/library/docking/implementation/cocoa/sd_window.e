note
	description: "Windows for SD_FLOATING_ZONE"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SD_WINDOW

inherit
	EV_WINDOW
		redefine
			create_implementation,
			initialize,
			show_relative_to_window
		end

	EV_SHARED_APPLICATION
		undefine
			copy, default_create
		end

feature {NONE} -- Implementation

	create_implementation
			-- Redefine
		do
			create {SD_WINDOW_IMP} implementation.make
		end

	make_with_shadow
			-- Feature place holder for Windows version {SD_WINDOW}
			-- On Linux, it do nothing since Linux doesn't support Window shadow by default
			-- On Windows, because {SD_WINDOW} inherit {EV_POPUP_WINDOW}, so it set shadow on Current window			
		do
			default_create
		end

	initialize
			-- Redefine
		do
			Precursor {EV_WINDOW}

				-- We do it later to make sure contract `is_in_default_state' not borken.
			if attached {EV_APPLICATION} ev_application as l_app then
				l_app.do_once_on_idle (agent
													do
														if not is_destroyed then
															disable_border
															disable_user_resize
														end
													end
												)
			end
		end

feature -- Command

	show_relative_to_window (a_parent: EV_WINDOW)
			-- Redefine.
		do
				-- After `disable_border', x,y position will be forgot. We restore it manually..
			set_position (screen_x, screen_y)
			Precursor {EV_WINDOW} (a_parent)
		end

note
	library:	"SmartDocking: Library of reusable components for Eiffel."
	copyright:	"Copyright (c) 1984-2017, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end

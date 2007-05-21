indexing
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

feature {NONE} -- Implementation

	create_implementation is
			-- Redefine
		do
			create {SD_WINDOW_IMP} implementation.make (Current)
		end

	initialize is
			-- Redefine
		local
			l_env: EV_ENVIRONMENT
		do
			Precursor {EV_WINDOW}

			-- We do it later to make sure contract `is_in_default_state' not borken.
			create l_env
			l_env.application.do_once_on_idle (agent
													do
														if not is_destroyed then
															disable_border
															disable_user_resize
														end
													end
												)
		end

feature -- Command

	show_relative_to_window (a_parent: EV_WINDOW) is
			--
		local
			l_box: EV_VERTICAL_BOX
		do
			-- On GTK, border state can't be remembered after hide, so we set it everytime when showing.
			disable_border
			Precursor {EV_WINDOW} (a_parent)
		end

indexing
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

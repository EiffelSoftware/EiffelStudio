note
	description: "Carbon implementation of SD_WINDOW."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SD_WINDOW_IMP

inherit
	EV_WINDOW_IMP
		redefine
			make
		end

create
	make

feature {NONE} -- Initlization

	make (a_interface: like interface)
			-- Redefine
		do
			Precursor {EV_WINDOW_IMP} (a_interface)

			-- Don't show window tab in system task bar.
--			{EV_GTK_EXTERNALS}.gtk_window_set_skip_taskbar_hint (c_object, True)
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

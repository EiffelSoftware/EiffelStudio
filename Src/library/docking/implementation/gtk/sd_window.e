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
			initialize
		end

feature {NONE} -- Implementation

	create_implementation is
			-- Redefine
		do
			create {SD_WINDOW_IMP} implementation.make (Current)
		end

	initialize is
			-- Redefine
		do
			Precursor {EV_WINDOW}
			disable_border
			disable_user_resize
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

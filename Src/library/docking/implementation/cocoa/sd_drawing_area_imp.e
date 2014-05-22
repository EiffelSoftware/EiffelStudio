note
	description:"[
 					Object that to export update_for_pick_and_drop feature
					which is in implementation.
																				]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SD_DRAWING_AREA_IMP

inherit
	EV_DRAWING_AREA_IMP
		redefine
			interface,
			initialize
		end

	EV_SHARED_APPLICATION
		export
			{NONE} all
		end

create
	make

feature -- Initialize

	initialize
			-- Initialize `Current'.
		do
			Precursor
		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	interface: detachable SD_DRAWING_AREA note option: stable attribute end;
			-- Redefine

note
	library:	"SmartDocking: Library of reusable components for Eiffel."
	copyright:	"Copyright (c) 1984-2014, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"


end


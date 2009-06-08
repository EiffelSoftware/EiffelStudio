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
			update_for_pick_and_drop,
			interface,
			class_style
		end

	EV_SHARED_APPLICATION
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	class_style: INTEGER
			-- Standard style used to create the window class.
			-- Can be redefined to return a user-defined style.
		once
			Result := Cs_dblclks
			| Cs_hredraw --| FIXME: IEK This line should not be needed.
			--| If resized smaller then drawing area should perform a full redraw where required.
		end

feature {NONE} -- Implementation

	update_for_pick_and_drop (a_starting: BOOLEAN)
			-- <Precursor>
		local
			l_app_imp: EV_APPLICATION_IMP
			l_src: EV_PICK_AND_DROPABLE_IMP
		do
			l_app_imp ?= ev_application.implementation
			check not_void: l_app_imp /= Void end
			l_src := l_app_imp.pick_and_drop_source
			-- Sometime l_src maybe void ?
			if l_src /= Void then
				interface.update_for_pick_and_drop (a_starting, l_src.pebble)
			end
		end

	interface: detachable SD_DRAWING_AREA note option: stable attribute end;
			-- <Precursor>

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

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
			gdk_events_mask,
			make
		end

	EV_SHARED_APPLICATION
		export
			{NONE} all
		end

create
	make

feature -- Initialize

	make
			-- Initialize `Current'
		do
			Precursor
			enable_double_buffering
			{GTK2}.gtk_widget_set_redraw_on_allocate (c_object, False)
		end

feature {NONE} -- Implementation

	Gdk_events_mask: INTEGER
			-- Mask of all the gdk events the gdkwindow shall receive
		once
			Result := Precursor | {GTK}.GDK_POINTER_MOTION_HINT_MASK_ENUM
				-- This is needed so that we only retrieve motion events when requested.
		end

	update_for_pick_and_drop (a_starting: BOOLEAN)
			-- <Precursor>
		local
			l_app_imp: detachable EV_APPLICATION_IMP
			l_src: detachable EV_PICK_AND_DROPABLE_IMP
		do
			l_app_imp ?= ev_application.implementation
			check not_void: l_app_imp /= Void end
			l_src := l_app_imp.pick_and_drop_source
			-- Sometime l_src maybe void?
			if l_src /= Void and then attached interface as l_interface then
				l_interface.update_for_pick_and_drop (a_starting, l_src.pebble)
			else
				check False end -- When updaing for pick and drop, interface cannot be void
			end
		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	interface: detachable SD_DRAWING_AREA note option: stable attribute end
			-- <Precursor>

;note
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


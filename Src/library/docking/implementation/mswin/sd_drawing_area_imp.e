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
			class_style,
			set_focus
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

feature -- Query

	interface: detachable SD_DRAWING_AREA note option: stable attribute end
			-- <Precursor>

feature {NONE} -- Implementation

	update_for_pick_and_drop (a_starting: BOOLEAN)
			-- <Precursor>
		do
			if attached interface as l_interface then
				if attached {EV_APPLICATION_IMP} ev_application.implementation as l_app_imp then
					if attached l_app_imp.pick_and_drop_source as l_src then
						l_interface.update_for_pick_and_drop (a_starting, l_src.pebble)
					else
						-- Sometime l_src maybe void ?
					end
				end
			else
				check False end -- When updating for pick and drop, interface cannot be void
			end
		end

	set_focus
			-- <Precursor>
		do
			-- When separate two editor tabs from a notebook to two editor zones (drag
			-- a tab out of notebook), after operation, when destroying
			-- {SD_FEEDBACK_INDICATOR}, the focus would set to the hidden
			-- "destroyed" notebook's tab box {SD_NOTEBOOK_TAB_BOX}.
			-- The {SD_NOTEBOOK_TAB_BOX} would be destroyed soon. It would make
			-- main window lose focus which is annoying.
			-- We prevent the hidden notebook tab box getting focus here
			if is_displayed then
				cwin_set_focus (wel_item)
			end
		end

note
	library:	"SmartDocking: Library of reusable components for Eiffel."
	copyright:	"Copyright (c) 1984-2012, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"


end

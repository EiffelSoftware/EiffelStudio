note
	description: "Eiffel Vision menu bar. GTK+ implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_MENU_BAR_IMP

inherit
	EV_MENU_BAR_I
		redefine
			interface
		end

	EV_MENU_ITEM_LIST_IMP
		export
			{EV_WINDOW_IMP}
				list_widget
		redefine
			interface
		end

	EV_ANY_IMP
		redefine
			interface
		end

create
	make

feature {NONE} -- Initialization

	make (an_interface: like interface)
		do
			base_make (an_interface)
			set_c_object ({EV_GTK_EXTERNALS}.gtk_menu_bar_new)
			{EV_GTK_EXTERNALS}.gtk_widget_show (c_object)
		end

feature -- Measurement

	x_position: INTEGER
			-- Horizontal offset relative to parent `x_position' in pixels.
		do
		end

	y_position: INTEGER
			-- Vertical offset relative to parent `y_position' in pixels.
		do
		end

	screen_x: INTEGER
			-- Horizontal offset relative to screen.
		do
		end

	screen_y: INTEGER
			-- Vertical offset relative to screen.
		do
		end

	width: INTEGER
			-- Horizontal size in pixels.
		do
		end

	height: INTEGER
			-- Vertical size in pixels.
		do
		end

	minimum_width: INTEGER
			-- Minimum horizontal size in pixels.
		do
		end

	minimum_height: INTEGER
			-- Minimum vertical size in pixels.
		do
		end

feature {EV_WINDOW_IMP} -- Implementation

	set_parent_window_imp (a_wind: EV_WINDOW_IMP)
			-- Set `parent_window' to `a_wind'.
		require
			a_wind_not_void: a_wind /= Void
		do
			parent_imp := a_wind
		end

	parent: EV_WINDOW
			-- Parent window of Current.
		do
			if parent_imp /= Void then
				Result := parent_imp.interface
			end
		end

	remove_parent_window
			-- Set `parent_window' to Void.
		do
			parent_imp := Void
		end

	parent_imp: EV_WINDOW_IMP

feature {EV_ANY_I} -- Implementation

	interface: EV_MENU_BAR;

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class EV_MENU_BAR_IMP


indexing

	description: 
		"EiffelVision dialog, gtk implementation."
	status: "See notice at end of class"
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"
	
class
	EV_DIALOG_IMP
	
inherit
	EV_DIALOG_I

	EV_WINDOW_IMP
		rename
			set_parent as old_set_parent
export {NONE}
	vbox
		undefine
			set_default_options
		redefine
			make,
			make_with_owner,
			initialize
		select
			old_set_parent
		end

create
	make,
	make_with_owner

feature {NONE} -- Initialization
	
	make is
			-- Create a window.
			-- Redefined because we want another type of window (GTK_WINDOW_DIALOG).
		do
			widget := gtk_window_new (GTK_WINDOW_DIALOG)
			gtk_window_set_position (GTK_WINDOW (widget), WINDOW_POSITION_CENTER)

			-- set the events to be handled by the window
			c_gtk_widget_set_all_events (widget)

			initialize

		end

        make_with_owner (par: EV_WINDOW) is
			-- Create a window with `par' as parent.
			-- The life of the window will depend on
			-- the one of `par'.
			-- Redefined because we want another type of window (GTK_WINDOW_DIALOG).
		local
			par_imp: EV_WINDOW_IMP
		do
			make
			par_imp ?= par.implementation

			-- Attach the window to `par'.
			gtk_window_set_transient_for (widget, par_imp.widget)
		end

feature -- Element change

	set_parent (par: EV_CONTAINER) is
			-- Make `par' the new parent of the widget.
			-- `par' can be Void then the parent is the screen.
			-- Redefined because we now allow container as parent.
		local
			win: EV_WINDOW
		do
			win ?= par
			old_set_parent (win)
		end

feature {NONE} -- Implementation

	initialize is
			-- Create the horizontal box `hbox'
			-- to put in the window.
			-- We do not need the `vbox' anymore. We have to keep `hbox'
			-- because of the EV_DIALOG_I implementation.
			--! FIXME: Alex 09191999. See with the windows platform, if
			--! we can change EV_DIALOG_I to avoid using `hbox'.
		do
			hbox := gtk_hbox_new (False, 0)
			gtk_container_add (GTK_CONTAINER (widget), hbox)
			gtk_widget_show (hbox)
		end

end -- class EV_DIALOG_IMP

--!----------------------------------------------------------------
--! EiffelVision2: library of reusable components for ISE Eiffel.
--! Copyright (C) 1986-1999 Interactive Software Engineering Inc.
--! All rights reserved. Duplication and distribution prohibited.
--! May be used only with ISE Eiffel, under terms of user license. 
--! Contact ISE for any other use.
--!
--! Interactive Software Engineering Inc.
--! ISE Building, 2nd floor
--! 270 Storke Road, Goleta, CA 93117 USA
--! Telephone 805-685-1006, Fax 805-685-6869
--! Electronic mail <info@eiffel.com>
--! Customer support e-mail <support@eiffel.com>
--! For latest info see award-winning pages: http://www.eiffel.com
--!----------------------------------------------------------------

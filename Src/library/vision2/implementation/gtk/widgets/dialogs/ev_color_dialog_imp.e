indexing 
	description: "EiffelVision color selection dialog."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_COLOR_DIALOG_IMP

inherit
	EV_COLOR_DIALOG_I

	EV_SELECTION_DIALOG_IMP
		redefine
			which_event_id
		end

creation
	make

feature {NONE} -- Initialization

	make (par: EV_CONTAINER) is
			-- Create a directory selection dialog with `par' as
			-- parent.
		local
			a: ANY
			s: STRING
			par_imp: EV_CONTAINER_IMP
		do
			s := "Color selection dialog"
			a := s.to_c
			par_imp ?= par.implementation

			-- Create the gtk object.
			widget := c_gtk_color_selection_dialog_new ($a)

			-- Attach the window to `par'.
			gtk_window_set_transient_for (widget, par_imp.widget)
			-- Set it as modal (nothing can be done
			-- until the window is closed).
			gtk_window_set_modal (widget, True)

			-- Make it appear where the mouse is.
			gtk_window_set_position (GTK_WINDOW (widget), 0)

			-- Connect destroy command to `OK' and `Cancel' buttons.
			add_dialog_close_command (cancel_widget)		
		end

feature -- Access

	color: EV_COLOR is
			-- Current selected color
		local
			r, g, b: INTEGER
		do
			c_gtk_color_selection_get_color (widget, $r, $g, $b)
			!!Result.make_rgb (r, g, b)
		end

	ok_widget: POINTER is
			-- Pointer to the gtk_button `OK' of the dialog.
		do
			Result := c_gtk_color_selection_get_ok_button (widget)
		end

	cancel_widget: POINTER is
			-- Pointer to the gtk_button `Cancel' of the dialog.
		do
			Result := c_gtk_color_selection_get_cancel_button (widget)
		end

	help_widget: POINTER is
			-- Pointer to the gtk_button `Cancel' of the dialog.
		do
			Result := c_gtk_color_selection_get_help_button (widget)
		end

feature -- Element change

	select_color (a_color: EV_COLOR) is
			-- Select `a_color'.
		do
			c_gtk_color_selection_set_color (widget, color.red, color.green, color.blue)
		end

feature -- Event - command association

	add_ok_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is
			-- Add `cmd' to the list of commands to be executed when
			-- the "OK" button is pressed.
		do
			add_command (ok_widget, "clicked", cmd, arg)
		end

	add_help_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is
			-- Add `cmd' to the list of commands to be executed when
			-- the "Help" button is pressed.
		do
			add_command (help_widget, "clicked", cmd, arg)
		end

feature -- Event -- removing command association

	remove_ok_commands is
			-- Empty the list of commands to be executed when
			-- "OK" button is pressed.
		do
			remove_commands (ok_widget, ok_clicked_id)
		end

	remove_help_commands is
			-- Empty the list of commands to be executed when
			-- "Help" button is pressed.
		do
			remove_commands (help_widget, help_clicked_id)
		end

feature {NONE} -- Implementation - Event handling -

	which_event_id (wid: POINTER; ev_str: STRING; mouse_but: INTEGER; double_clic: BOOLEAN): INTEGER is
			-- Gives the event_id number corresponding to the `event' string.
			-- We need to redefine this feature to be able to store commands associated
			-- to "clicked" event for `ok' and `cancel' button in separate location
			-- in `event_command_array'.
		do
			Result := {EV_SELECTION_DIALOG_IMP} Precursor (wid, ev_str, mouse_but, double_clic)
			if (ev_str.is_equal ("clicked")) then
				if (wid = help_widget) then
					-- "clicked" event for `help' button.
					Result := help_clicked_id
				end
			end
		end

end -- class EV_COLOR_DIALOG_IMP

--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

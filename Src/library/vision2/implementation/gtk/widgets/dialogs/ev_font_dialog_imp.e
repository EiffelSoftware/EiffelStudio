indexing
	description: "EiffelVision font selection dialog, implementation."
	status: "See notice at end of class"
	description: "Objects that ..."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_FONT_DIALOG_IMP

inherit
	EV_FONT_DIALOG_I

	EV_SELECTION_DIALOG_IMP

create
	make


feature {NONE} -- Initialization

	make (par: EV_CONTAINER) is
			-- Create a directory selection dialog with `par' as
			-- parent.
		do
		end

feature -- Access

	ok_widget: POINTER is
			-- Pointer to the gtk_button `OK' of the dialog.
		do
		end

	cancel_widget: POINTER is
			-- Pointer to the gtk_button `Cancel' of the dialog.
		do
		end


	character_format: EV_CHARACTER_FORMAT is
			-- Current selected character format.
		do
			check
				to_be_implemented: False
			end
		end

	font: EV_FONT is
			-- Current selected font.
		do
			check
				to_be_implemented: False
			end
		end

feature -- Element change

	select_font (a_font: EV_FONT) is
			-- Select `a_font'.
		do
			check
				not_yet_implemented: False
			end
		end

feature -- Event - command association

	add_ok_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is
			-- Add `cmd' to the list of commands to be executed when
			-- the "OK" button is pressed.
		do
		end

feature -- Event -- removing command association

	remove_ok_commands is
			-- Empty the list of commands to be executed when
			-- "OK" button is pressed.
		do
			remove_commands (ok_widget, ok_clicked_id)
		end

end -- class EV_FONT_DIALOG_IMP

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

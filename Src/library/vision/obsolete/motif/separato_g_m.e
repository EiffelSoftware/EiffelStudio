indexing

	description: "Motif implementation of separator gadget";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class 
	SEPARATO_G_M 

inherit

	SEPARATO_G_I;

	WIDGET_IMP
		rename
			is_shown as shown
		redefine
			set_action, remove_action,
			set_background_color, set_background_pixmap
		end;

	MEL_SEPARATOR_GADGET
		rename
			make as mel_sep_make,
			destroy as mel_destroy,
			set_insensitive as mel_set_insensitive,
			screen as mel_screen,
			set_horizontal as mel_set_horizontal,
			is_shown as shown
		end


creation

	make

feature {NONE} -- Creation

	make (a_separator_gadget: SEPARATOR_G; man: BOOLEAN; oui_parent: COMPOSITE) is
			-- Create a motif separator gadget.
		local
			mc: MEL_COMPOSITE
		do
			mc ?= oui_parent.implementation;
			widget_index := widget_manager.last_inserted_position;
			mel_sep_make (a_separator_gadget.identifier, mc, man)
		end;

feature -- Access

	is_stackable: BOOLEAN is
			-- Is the Current widget stackable?
		do
			Result := True
		end;

feature -- Status setting

	set_horizontal (flag: BOOLEAN) is
			-- Set orientation of the scale to horizontal if `flag',
			-- to vertical otherwise.
		do
			if flag then
				mel_set_horizontal
			else
				set_vertical
			end
		end;

feature {NONE} -- Implementation

	foreground_color: COLOR is
			-- Foreground color of gadget (Is Void)
		do
		end;

	remove_action (a_translation: STRING) is
			-- Remove the command executed when `a_translation' occurs.
			-- Do nothing if no command has been specified.
		do
		end; 

	set_action (a_translation: STRING; a_command: COMMAND; argument: ANY) is
			-- Set `a_command' to be executed when `a_translation' occurs.
			-- `a_translation' is specified with Xtoolkit convention.
		do
		end; 

	set_background_color (new_color: COLOR) is
			-- Set background color to `new_color'.
		do
		end; 

	set_background_pixmap (new_pixmap: PIXMAP) is
			-- Set background_pixmap to `new_color'.
		do
		end

	set_foreground_color (new_color: COLOR) is
			-- Set foreground_color color to `new_color'.
		do
		end;

	update_foreground_color is
			-- Do nothing.
		do
		end;

end -- class SEPARATO_G_M


--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------


indexing
	description:
		"EiffelVision message dialog. Dialogs that always consist of %N%
		%a pixmap, a text and one or more buttons."
	status: "See notice at end of class"
	keywords: "dialog, standard, pixmap, text, button, modal"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_MESSAGE_DIALOG

inherit
	EV_DIALOG
		redefine
			initialize
		end

create
	default_create,
	make

feature {NONE} -- Initialization

	initialize is
			-- Initialize to default state.
		local
			hb: EV_HORIZONTAL_BOX
			vb: EV_VERTICAL_BOX
		do
			Precursor
			create buttons.make (5)
			create vb
			extend (vb)
			create hb
			vb.extend (hb)
			create pixmap_box
			hb.extend (pixmap_box)
			hb.disable_child_expand (pixmap_box)
			create label
			label.align_text_center
			hb.extend (label)
			hb.set_border_width (20)
			create button_box
			vb.extend (button_box)
			button_box.extend (create {EV_CELL})
			vb.disable_child_expand (button_box)
			button_box.set_padding (5)
			button_box.set_border_width (10)

			set_title ("Dialog")
			set_text ("Your message.")
			set_buttons (<<"OK", "Cancel">>)
		end

	make (a_title, a_text: STRING; but_texts: ARRAY [STRING]; a_pixmap: EV_PIXMAP) is
			-- Initialize.
		do
			default_create
			set_title (a_title)
			set_text (a_text)
			set_buttons (but_texts)
			set_pixmap (a_pixmap)
		end

feature -- Access

	pixmap: EV_PIXMAP
			-- Icon associated with dialog.

	text: STRING is
			-- Text associated with dialog.
		do
			Result := label.text
		end

feature -- Status setting

	set_pixmap (a_pixmap: EV_PIXMAP) is
			-- Set icon associated with dialog.
		do
			if pixmap_box.full then
				pixmap_box.wipe_out
			end
			if a_pixmap /= Void then
				pixmap_box.extend (a_pixmap)
			end
		end

	set_text (a_text: STRING) is
			-- Set the message of the dialog.
		require
			a_text_not_void: a_text /= Void
		do
			label.set_text (a_text)
		ensure
			assigned: text.is_equal (a_text)
		end

	set_buttons (but_texts: ARRAY [STRING]) is
			-- Set the buttons by label.
		local
			i: INTEGER
		do
			button_box.wipe_out
			buttons.clear_all
			button_box.extend (create {EV_CELL})
			from i := 1 until i > but_texts.count loop
				add_button (but_texts @ i)
				i := i + 1
			end
			button_box.extend (create {EV_CELL})
		end

feature -- Status report

	has_button (a_label: STRING): BOOLEAN is
			-- Does button with `a_label' exist in the dialog?
		require
			a_label_not_void: a_label /= Void
		do
			Result := buttons.has (a_label)
		end

	button (a_label: STRING): EV_BUTTON is
			-- Get the button object with `a_label'.
		require
			a_label_not_void: a_label /= Void
			has_button_with_a_label: has_button (a_label)
		do
			Result := buttons.item (a_label)
		ensure
			not_void: Result /= Void
		end

feature {NONE} -- Implementation

	buttons: HASH_TABLE [EV_BUTTON, STRING]
			-- Lookup-table for the buttons on the dialog based on
			-- their captions.

	button_box: EV_HORIZONTAL_BOX
			-- Bar with all buttons of the dialog.

	label: EV_LABEL
			-- Text label where `text' is displayed.

	pixmap_box: EV_CELL
			-- Container to display pixmap in.

	add_button (s: STRING) is
			-- An item has been added to `buttons'.
		local
			new_button: EV_BUTTON
		do
			create new_button.make_with_text (s)

			--| We now put the button in the hash-table to give the
			--| user access to it.
			buttons.extend (new_button, s)

			new_button.press_actions.extend (~on_button_press (s))
			button_box.extend (new_button)
			button_box.disable_child_expand (new_button)
			new_button.set_minimum_width (60)
			new_button.align_text_center
		end

	on_button_press (a_button_text: STRING) is
			-- A button with label `a_button_text' has been pressed.
		do
			selected_button := a_button_text
			hide
		end

feature -- Status report

	selected_button: STRING
			-- Label of the last clicked button.

end -- class EV_MESSAGE_DIALOG

--!-----------------------------------------------------------------------------
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
--!-----------------------------------------------------------------------------

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.13  2000/02/14 20:38:36  oconnor
--| mergerd from HACK-O-RAMA
--|
--| Revision 1.11.6.8  2000/02/14 20:09:01  brendel
--| Added features `has_button' and `button'.
--| Before, the user did not have access to the buttons created with `set_buttons'.
--|
--| Revision 1.11.6.7  2000/01/28 22:24:23  oconnor
--| released
--|
--| Revision 1.11.6.6  2000/01/27 19:30:50  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.11.6.5  2000/01/27 01:05:11  brendel
--| Buttons are now centered.
--| Text always fits in the label.
--| Can be created using `default_create'.
--|
--| Revision 1.11.6.4  2000/01/26 16:47:00  brendel
--| Finished except for pixmap.
--|
--| Revision 1.11.6.1  1999/11/24 17:30:50  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.11.2.3  1999/11/04 23:10:54  oconnor
--| updates for new color model, removed exists: not destroyed
--|
--| Revision 1.11.2.2  1999/11/02 17:20:12  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------

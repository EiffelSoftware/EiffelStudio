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
	make_with_text

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
			hb.disable_item_expand (pixmap_box)
			create label
			label.align_text_center
			hb.extend (label)
			hb.set_border_width (10)
			hb.set_padding (10)
			create button_box
			vb.extend (button_box)
			vb.disable_item_expand (button_box)
			button_box.set_padding (10)
			button_box.set_border_width (10)
			
			set_title ("EiffelVision2 Generic Message Dialog")
			set_text ("Your message.")
			set_pixmap (Default_pixmaps.Information_pixmap)
			
			set_buttons (<<"OK", "Cancel">>)
			set_default_push_button(button ("OK"))
			set_default_cancel_button(button ("Cancel"))
		end

	make_with_text (a_text: STRING) is
			-- Create dialog with `a_text'.
		do
			default_create
			set_text (a_text)
		end

	make_with_text_and_actions (
		a_text: STRING;
		actions: ARRAY [PROCEDURE [ANY, TUPLE []]]
	) is
			-- Create dialog with `a_text' and `actions'.
			-- (`actions' are added to `buttons' in order.)
		require
			actions_not_void: actions /= Void
			actions_not_empty: actions.count > 0
		local
			i: INTEGER
			c: CURSOR
		do
			default_create
			set_text (a_text)
			c := buttons.cursor
			from
				buttons.start
				i := 1
			until
				i > actions.count or
				buttons.after
			loop
				buttons.item_for_iteration.select_actions.extend (actions @ i)
				buttons.forth
				i := i + 1
			end
			buttons.go_to (c)
		end

feature -- Access

	pixmap: EV_PIXMAP
			-- Icon displayed by dialog.

	text: STRING is
			-- Message displayed by dialog.
		do
			Result := label.text
		end

feature -- Status setting

	set_pixmap (a_pixmap: EV_PIXMAP) is
			-- Set icon associated with dialog.
		do
			pixmap := a_pixmap
			pixmap_box.put (a_pixmap)
			pixmap_box.set_minimum_size (a_pixmap.width, a_pixmap.height)
		end

	set_text (a_text: STRING) is
			-- Assign `a_text' to `text'.
		require
			a_text_not_void: a_text /= Void
		do
			label.set_text (a_text)
		ensure
			assigned: text.is_equal (a_text)
		end

	set_buttons (button_labels: ARRAY [STRING]) is
			-- Assign new buttons with `button_labels' to `buttons'.
		local
			i: INTEGER
		do
			clean_buttons
			button_box.extend (create {EV_CELL})
			from i := 1 until i > button_labels.count loop
				add_button (button_labels @ i)
				i := i + 1
			end
			button_box.extend (create {EV_CELL})
			button_box.enable_homogeneous
		end

	set_buttons_and_actions (
		button_labels	: ARRAY [STRING]
		actions			: ARRAY [PROCEDURE [ANY, TUPLE []]]
	) is
			-- Assign new buttons with `button_labels' to `buttons'.
		local
			i: INTEGER
			c: CURSOR
		do
			clean_buttons
			button_box.extend (create {EV_CELL})
			from i := 1 until i > button_labels.count loop
				add_button_with_action (
					button_labels @ i,
					actions @ i
				)
				i := i + 1
			end
			button_box.extend (create {EV_CELL})
		end

feature -- Status report

	has_button (a_label: STRING): BOOLEAN is
			-- Is there a button that has `a_label'?
		require
			a_label_not_void: a_label /= Void
		do
			Result := buttons.has (a_label)
		end

	button (a_label: STRING): EV_BUTTON is
			-- Button that has `a_label'.
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

	clean_buttons is
			-- Remove all buttons from the dialog
		do
			if has_default_push_button then
				remove_default_push_button
			end
			if has_default_cancel_button then
				remove_default_cancel_button
			end
			button_box.wipe_out
			buttons.clear_all
		end

	add_button (s: STRING) is
			-- An item has been added to `buttons'.
		local
			new_button: EV_BUTTON
		do
			create new_button.make_with_text (s)

			--| We now put the button in the hash-table to give the
			--| user access to it.
			buttons.put (new_button, s)

			new_button.select_actions.extend (~on_button_press (s))
			button_box.extend (new_button)
			button_box.disable_item_expand (new_button)
			new_button.set_minimum_width (new_button.minimum_width.max(75))
			new_button.align_text_center
		end

	add_button_with_action (
		s			: STRING
		action		: PROCEDURE [ANY, TUPLE []]
	) is
			-- An item has been added to `buttons'.
		do
			add_button (s)
			button (s).select_actions.extend (action)
		end

	on_button_press (a_button_text: STRING) is
			-- A button with label `a_button_text' has been pressed.
		do
			selected_button := a_button_text
			hide
			close_actions.call ([])
		end

feature -- Status report

	selected_button: STRING
			-- Label of the last clicked button.

feature {EV_MESSAGE_DIALOG} -- Constants

	Default_pixmaps: EV_DEFAULT_PIXMAPS is
		once
			create Result
		end

end -- class EV_MESSAGE_DIALOG

--!-----------------------------------------------------------------------------
--! EiffelVision2: library of reusable components for ISE Eiffel.
--! Copyright (C) 1986-2000 Interactive Software Engineering Inc.
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
--| Revision 1.23  2000/04/29 03:37:24  pichery
--| Changed Dialogs. Added default & cancel
--| buttons, Default pixmaps, ...
--|
--| Revision 1.22  2000/04/19 00:45:05  brendel
--| Minor changes.
--|
--| Revision 1.21  2000/03/27 18:29:54  brendel
--| Replaced obsolete call.
--|
--| Revision 1.20  2000/03/09 16:42:20  rogers
--| Replaced all disable_child_expand with disable_item_expand.
--|
--| Revision 1.19  2000/03/08 17:18:26  brendel
--| Replaced `extend' with `put'.
--|
--| Revision 1.18  2000/03/06 19:48:11  oconnor
--| renamed but_texts -> button_labels
--|
--| Revision 1.17  2000/03/06 19:32:02  oconnor
--| removed stray comma
--|
--| Revision 1.16  2000/03/06 19:25:55  oconnor
--| removed make_with_text_and_actions from
--| create clause, it only makes sense for decendants.
--|
--| Revision 1.15  2000/03/06 19:17:42  oconnor
--| Added make_with_text_and_actions,
--| moved make_with_text from decendants to EV_MESSAGE_DIALOG.
--|
--| Revision 1.14  2000/02/22 18:39:50  oconnor
--| updated copyright date and formatting
--|
--| Revision 1.13  2000/02/14 20:38:36  oconnor
--| mergerd from HACK-O-RAMA
--|
--| Revision 1.11.6.8  2000/02/14 20:09:01  brendel
--| Added features `has_button' and `button'.
--| Before, the user did not have access to the buttons created with
--| `set_buttons'.
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

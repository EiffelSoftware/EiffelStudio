indexing
	description:
		"EiffelVision message dialog. Dialogs that always consist of %N%
		%a pixmap, a text and one or more buttons."
	status: "See notice at end of class"
	keywords: "dialog, standard, pixmap, text, button, modal"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_MESSAGE_DIALOG

inherit
	EV_DIALOG
		redefine
			initialize,
			set_background_color,
			set_foreground_color,
			foreground_color,
			background_color
		end
		
	EV_DIALOG_CONSTANTS
		export
			{NONE} all
		undefine
			default_create, copy
		end

feature {NONE} -- Initialization

	make_with_text (a_text: STRING) is
			-- Create `Current' and assign `a_text' to `text'.
		require
			a_text_not_void: a_text /= Void
		do
			default_create
			set_text (a_text)
		end

	make_with_text_and_actions (
		a_text: STRING;
		actions: ARRAY [PROCEDURE [ANY, TUPLE []]]
	) is
			-- Create `Current', assign `a_text' to `text' and `actions' to `select_actions'
			-- of `buttons'.
			-- (`actions' are added to `buttons' in order.)
		require
			a_text_not_void: a_text /= Void
			actions_not_void: actions /= Void
			actions_not_empty: actions.count > 0
		local
			i: INTEGER
			c: CURSOR
			b: EV_BUTTON
		do
			default_create
			set_text (a_text)
			c := button_box.cursor
			from
					--| We loop through `button_box' instead of `buttons', as
					--| if we were to loop through `buttons', we would not get
					--|  the buttons in the order they are displayed.
				button_box.start
				i := 1
			until
				i > actions.count or
				button_box.after
			loop
				b ?= button_box.item
				check
					button_box_contains_only_buttons: b /= Void
				end
				b.select_actions.extend (actions @ i)
				button_box.forth
				i := i + 1
			end
			button_box.go_to (c)
		end
		
	initialize is
			-- Initialize `Current' to default state.
		local
			hb: EV_HORIZONTAL_BOX
			vb: EV_VERTICAL_BOX
			hb2: EV_HORIZONTAL_BOX
			vb2: EV_VERTICAL_BOX
		do
			Precursor

			create buttons.make (5)
			create vb
			create button_box
			create hb
			create pixmap_box
			create hb2
			create vb2
			create label

			vb2.extend (pixmap_box)
			vb2.disable_item_expand (pixmap_box)
			vb2.extend (create {EV_CELL})
	
			hb.extend (vb2)
			hb.extend (label)
			hb.set_padding (10)

			hb2.extend (create {EV_CELL})
			hb2.extend (button_box)
			hb2.disable_item_expand (button_box)
			hb2.extend (create {EV_CELL})

			vb.extend (hb)
			vb.extend (hb2)
			vb.disable_item_expand (hb2)
			vb.set_padding (14)
			vb.set_border_width (10)
			
			label.align_text_left

			button_box.set_padding (10)
			extend (vb)

			set_text ("Use `set_text' to modify this message.")
		
			foreground_color := implementation.foreground_color
			background_color := implementation.background_color
		end

feature -- Access

	pixmap: EV_PIXMAP is
			-- Icon displayed by `Current'.
		require
			not_destroyed: not is_destroyed
		do
			if pixmap_box.readable then
				Result ?= pixmap_box.item
				check
					Result_not_void: Result /= Void
				end
			end
		end

	text: STRING is
			-- Message displayed by `Current'.
		require
			not_destroyed: not is_destroyed
		do
			Result := label.text
		end

	foreground_color: EV_COLOR
			-- Foreground color of `Current'.

	background_color: EV_COLOR
			-- Background color of `Current'.

feature -- Status setting

	set_background_color (a_color: EV_COLOR) is
			-- Assign `a_color' to `background_color'.
		local
			dialog_box: EV_CONTAINER
		do
			item.set_background_color (a_color)
			dialog_box ?= item
			if dialog_box /= Void then
				dialog_box.propagate_background_color
			end
			background_color.copy (a_color)
		end

	set_foreground_color (a_color: EV_COLOR) is
			-- Assign `a_color' to `foreground_color'.
		local
			dialog_box: EV_CONTAINER
		do
			item.set_foreground_color (a_color)
			dialog_box ?= item
			if dialog_box /= Void then
				dialog_box.propagate_foreground_color
			end
			foreground_color.copy (a_color)
		end

	set_pixmap (a_pixmap: EV_PIXMAP) is
			-- Assign `a_pixmap' to `pixmap'.
		require
			not_destroyed: not is_destroyed
			a_pixmap_not_void: a_pixmap /= Void
		local
			pixmap_clone: EV_PIXMAP
		do
			if pixmap /= Void then
				remove_pixmap
			end
			create pixmap_clone
			pixmap_clone.copy (a_pixmap)
			pixmap_box.extend (pixmap_clone)
			pixmap_box.set_minimum_size
				(pixmap_clone.width, pixmap_clone.height)
		ensure
			pixmap_assigned: pixmap.is_equal (a_pixmap)
		end

	remove_pixmap is
			-- Assign `Void' to `pixmap'.
		require
			not_destroyed: not is_destroyed
		do
			pixmap_box.wipe_out
		ensure
			pixmap_void: pixmap = Void
		end

	set_text (a_text: STRING) is
			-- Assign `a_text' to `text'.
		require
			not_destroyed: not is_destroyed
			a_text_not_void: a_text /= Void
			a_text_not_empty: not a_text.is_empty
		do
			label.set_text (a_text)
		ensure
			assigned: text.is_equal (a_text)
		end

	remove_text is
			-- Assign `Void' to `text'.
		require
			not_destroyed: not is_destroyed
		do
			label.remove_text
		ensure
			text_void: text = Void
		end

	set_buttons (button_labels: ARRAY [STRING]) is
			-- Assign new buttons with `button_labels' to `buttons'.
		require
			not_destroyed: not is_destroyed
			button_labels_not_void: button_labels /= Void
			all_button_labels_items_not_void:
				button_labels.occurrences (Void) = 0
		local
			i: INTEGER
		do
			clean_buttons
			from i := 1 until i > button_labels.count loop
				add_button (button_labels @ i)
				i := i + 1
			end
			button_box.enable_homogeneous
		end

	set_buttons_and_actions (
		button_labels: ARRAY [STRING]
		actions: ARRAY [PROCEDURE [ANY, TUPLE []]]
	) is
			-- Assign new buttons with `button_labels' and `actions' to `buttons'.
		require
			not_destroyed: not is_destroyed
			button_labels_not_void: button_labels /= Void
			actions_not_void: actions /= Void
			all_button_labels_items_not_void:
				button_labels.occurrences (Void) = 0
			enough_actions_for_labels: actions.count >= button_labels.count
		local
			i: INTEGER
		do
			clean_buttons
			from i := 1 until i > button_labels.count loop
				if (actions @ i) = Void then
					add_button (button_labels @ i)
				else
					add_button_with_action (
						button_labels @ i,
						actions @ i
					)
				end
				i := i + 1
			end
		end

feature -- Status report

	has_button (a_text: STRING): BOOLEAN is
			-- Does `Current' contain a button with `text' `a_text'?
		require
			not_destroyed: not is_destroyed
			a_text_not_void: a_text /= Void
		do
			Result := buttons.has (a_text)
		end

	button (a_text: STRING): EV_BUTTON is
			-- Button that has `a_text'.
		require
			not_destroyed: not is_destroyed
			a_text_not_void: a_text /= Void
			has_button_with_a_text: has_button (a_text)
		do
			Result := buttons.item (a_text)
		ensure
			not_void: Result /= Void
		end
		
	selected_button: STRING
			-- Label of last clicked button.

feature {NONE} -- Implementation

	button_box: EV_HORIZONTAL_BOX
			-- Bar with all buttons of the dialog.

	label: EV_LABEL
			-- Text label where `text' is displayed.

	pixmap_box: EV_CELL
			-- Container to display pixmap in.

	buttons: HASH_TABLE [EV_BUTTON, STRING]
			-- Lookup-table for the buttons in `Current' based on
			-- their captions.

	clean_buttons is
			-- Remove all buttons from `Current'.
		require
			not_destroyed: not is_destroyed
		do
			if default_push_button /= Void then
				remove_default_push_button
			end
			if default_cancel_button /= Void then
				remove_default_cancel_button
			end
			button_box.wipe_out
			buttons.clear_all
		end

	add_button (a_text: STRING) is
			-- An item has been added to `buttons'.
		require
			not_destroyed: not is_destroyed
			a_text_not_void: a_text /= Void
		local
			new_button: EV_BUTTON
		do
			create new_button.make_with_text (a_text)

			--| We now put the button in the hash-table to give the
			--| user access to it.
			buttons.put (new_button, a_text)

			new_button.select_actions.extend (~on_button_press (a_text))
			button_box.extend (new_button)
			button_box.disable_item_expand (new_button)
			new_button.set_minimum_width (new_button.minimum_width.max (75))
			new_button.align_text_center
		end

	add_button_with_action
		(a_text: STRING; a_action: PROCEDURE [ANY, TUPLE []]) is
			-- An item has been added to `buttons'.
		require
			not_destroyed: not is_destroyed
			a_text_not_void: a_text /= Void
			a_action_not_void: a_action /= Void
		do
			add_button (a_text)
			button (a_text).select_actions.extend (a_action)
		end

	on_button_press (a_button_text: STRING) is
			-- A button with text `a_button_text' has been pressed.
		require
			not_destroyed: not is_destroyed
		do
			selected_button := a_button_text
			destroy
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

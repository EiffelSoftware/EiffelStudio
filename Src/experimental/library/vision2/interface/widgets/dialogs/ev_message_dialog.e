note
	description:
		"EiffelVision message dialog. Dialogs that always consist of %N%
		%a pixmap, a text and one or more buttons."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "dialog, standard, pixmap, text, button, modal"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_MESSAGE_DIALOG

inherit
	EV_DIALOG
		redefine
			initialize,
			create_interface_objects,
			set_background_color,
			set_foreground_color,
			foreground_color,
			background_color,
			default_identifier_name,
			user_can_resize_default_state
		end

	EV_DIALOG_CONSTANTS
		export
			{NONE} all
		undefine
			default_create, copy
		end

create
	default_create,
	make_with_text,
	make_with_text_and_actions

feature {NONE} -- Initialization

	make_with_text (a_text: READABLE_STRING_GENERAL)
			-- Create `Current' and assign `a_text' to `text'.
		require
			a_text_not_void: a_text /= Void
		do
			default_create
			set_text (a_text)
		end

	make_with_text_and_actions (
		a_text: READABLE_STRING_GENERAL;
		actions: ARRAY [PROCEDURE [ANY, TUPLE]]
	)
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
			b: detachable EV_BUTTON
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

	create_interface_objects
			-- <Precursor>
		local
			l_stock_colors: EV_STOCK_COLORS
		do
			create buttons.make (5)
			create button_box
			create pixmap_box
			create scrollable_area
			create label
			create l_stock_colors
			foreground_color := l_stock_colors.default_foreground_color
			background_color := l_stock_colors.default_background_color
		end

	initialize
			-- Initialize `Current' to default state.
		local
			hb: EV_HORIZONTAL_BOX
			vb: EV_VERTICAL_BOX
			hb2: EV_HORIZONTAL_BOX
			vb2: EV_VERTICAL_BOX
			l_screen: EV_SCREEN
		do
			foreground_color := implementation.foreground_color
			background_color := implementation.background_color
			create hb
			create vb
			create hb2
			create vb2

			Precursor

			create l_screen
			maximum_label_width := l_screen.width - 200
			maximum_label_height := l_screen.height - 200

			vb2.extend (pixmap_box)
			vb2.disable_item_expand (pixmap_box)
			vb2.extend (create {EV_CELL})

			hb.extend (vb2)
--			hb.disable_item_expand (vb2)

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

			key_press_actions.extend (agent on_key_press)
			disable_user_resize
		end

feature -- Access

	pixmap: detachable EV_PIXMAP
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

	text: STRING_32
			-- Message displayed by `Current'.
		require
			not_destroyed: not is_destroyed
		do
			Result := label.text
		ensure
			not_void: Result /= Void
		end

	foreground_color: EV_COLOR
			-- Foreground color of `Current'.

	background_color: EV_COLOR
			-- Background color of `Current'.

	default_identifier_name: STRING_32
			-- Default identifier name if no specific name is set.
		do
			if title.is_empty then
				Result := Precursor {EV_DIALOG}
			else
				Result := title.as_lower
				Result.prune_all ('.')
			end
		end

feature -- Status setting

	set_background_color (a_color: EV_COLOR)
			-- Assign `a_color' to `background_color'.
		local
			dialog_box: detachable EV_CONTAINER
		do
			item.set_background_color (a_color)
			dialog_box ?= item
			if dialog_box /= Void then
				dialog_box.propagate_background_color
			end
			background_color.copy (a_color)
		end

	set_foreground_color (a_color: EV_COLOR)
			-- Assign `a_color' to `foreground_color'.
		local
			dialog_box: detachable EV_CONTAINER
		do
			item.set_foreground_color (a_color)
			dialog_box ?= item
			if dialog_box /= Void then
				dialog_box.propagate_foreground_color
			end
			foreground_color.copy (a_color)
		end

	set_pixmap (a_pixmap: EV_PIXMAP)
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
			pixmap_assigned: attached pixmap as l_pixmap and then l_pixmap.is_equal (a_pixmap)
		end

	remove_pixmap
			-- Assign `Void' to `pixmap'.
		require
			not_destroyed: not is_destroyed
		do
			pixmap_box.wipe_out
		ensure
			pixmap_void: pixmap = Void
		end

	set_text (a_text: READABLE_STRING_GENERAL)
			-- Assign `a_text' to `text'.
		require
			not_destroyed: not is_destroyed
			a_text_not_void: a_text /= Void
		local
			l_label_width, l_label_height: INTEGER
			l_scrollbar_needed: BOOLEAN
			l_dialog_parent: detachable EV_CONTAINER
		do
				-- Unparent scrollable area
			if attached scrollable_area.parent as l_scroll_parent then
				l_scroll_parent.prune (scrollable_area)
				scrollable_area.prune (label)
				l_dialog_parent := l_scroll_parent
			elseif attached label.parent as l_label_parent then
				l_label_parent.prune (label)
				l_dialog_parent := l_label_parent
			end

			label.set_text (a_text)
			l_label_width := label.width
			l_label_height := label.height
			if l_label_width > maximum_label_width then
				l_scrollbar_needed := True
				scrollable_area.show_horizontal_scroll_bar
				l_label_width := maximum_label_width
			else
				scrollable_area.hide_vertical_scroll_bar
			end
			if l_label_height > maximum_label_height then
				l_scrollbar_needed := True
				scrollable_area.show_vertical_scroll_bar
				l_label_height := maximum_label_height
			else
				scrollable_area.hide_vertical_scroll_bar
			end
			scrollable_area.set_minimum_width (l_label_width)
			scrollable_area.set_minimum_height (l_label_height)

			if l_scrollbar_needed then
				scrollable_area.extend (label)
				if l_dialog_parent /= Void then
					l_dialog_parent.extend (scrollable_area)
				end
			else
				if l_dialog_parent /= Void then
					l_dialog_parent.extend (label)
				end
			end
		ensure
			assigned: text.same_string_general (a_text)
			cloned: text /= a_text
		end

	remove_text
			-- Make `text' empty.
		require
			not_destroyed: not is_destroyed
		do
			set_text ("")
		ensure
			text_not_void: text /= Void and text.is_empty
		end

	set_buttons (button_labels: ARRAY [READABLE_STRING_GENERAL])
			-- Assign new buttons with `button_labels' to `buttons'.
		require
			not_destroyed: not is_destroyed
			button_labels_not_void: button_labels /= Void
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
		button_labels: ARRAY [READABLE_STRING_GENERAL]
		actions: ARRAY [detachable PROCEDURE [ANY, TUPLE]]
	)
			-- Assign new buttons with `button_labels' and `actions' to `buttons'.
		require
			not_destroyed: not is_destroyed
			button_labels_not_void: button_labels /= Void
			actions_not_void: actions /= Void
			enough_actions_for_labels: actions.count >= button_labels.count
		local
			i: INTEGER
		do
			clean_buttons
			from i := 1 until i > button_labels.count loop
				if attached actions [i] as l_action then
					add_button_with_action (button_labels [i], l_action)
				else
					add_button (button_labels [i])
				end
				i := i + 1
			end
		end

feature -- Status report

	has_button (a_text: READABLE_STRING_GENERAL): BOOLEAN
			-- Does `Current' contain a button with `text' `a_text'?
		require
			not_destroyed: not is_destroyed
			a_text_not_void: a_text /= Void
		do
			Result := buttons.has (a_text.as_string_32)
		end

	button (a_text: READABLE_STRING_GENERAL): EV_BUTTON
			-- Button that has `a_text'.
		require
			not_destroyed: not is_destroyed
			a_text_not_void: a_text /= Void
			has_button_with_a_text: has_button (a_text)
		local
			l_result: detachable EV_BUTTON
		do
			l_result := buttons.item (a_text.as_string_32)
			check l_result /= Void end
			Result := l_result
		ensure
			not_void: Result /= Void
		end

	selected_button: detachable STRING_32
			-- Label of last clicked button.

feature {NONE} -- Implementation

	maximum_label_width: INTEGER
			-- Maximum width the label can be before scrollbar is enabled.

	maximum_label_height: INTEGER
			-- Maximum height the label can be before scrollbar is enabled.

	user_can_resize_default_state: BOOLEAN = False
		-- <Precursor>

	button_box: EV_HORIZONTAL_BOX
			-- Bar with all buttons of the dialog.

	scrollable_area: EV_SCROLLABLE_AREA
			-- Scrollable area in which `label' resides.

	label: EV_LABEL
			-- Text label where `text' is displayed.

	pixmap_box: EV_CELL
			-- Container to display pixmap in.

	buttons: HASH_TABLE [EV_BUTTON, STRING_32]
			-- Lookup-table for the buttons in `Current' based on
			-- their captions.

	clean_buttons
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
			buttons.wipe_out
		end

	add_button (a_text: READABLE_STRING_GENERAL)
			-- An item has been added to `buttons'.
		require
			not_destroyed: not is_destroyed
			a_text_not_void: a_text /= Void
		local
			new_button: EV_BUTTON
			l_default_button: BOOLEAN
		do
			create new_button.make_with_text (a_text)

			--| We now put the button in the hash-table to give the
			--| user access to it.
			buttons.put (new_button, a_text.as_string_32)

			l_default_button := button_box.is_empty

			new_button.select_actions.extend (agent on_button_press (a_text))
			button_box.extend (new_button)
			button_box.disable_item_expand (new_button)
			new_button.set_minimum_width (new_button.minimum_width.max (75))
			new_button.align_text_center

			if l_default_button then
				set_default_push_button (new_button)
			end
		end

	add_button_with_action
		(a_text: READABLE_STRING_GENERAL; a_action: PROCEDURE [ANY, TUPLE])
			-- An item has been added to `buttons'.
		require
			not_destroyed: not is_destroyed
			a_text_not_void: a_text /= Void
			a_action_not_void: a_action /= Void
		do
			add_button (a_text)
			button (a_text).select_actions.extend (a_action)
		end

	on_button_press (a_button_text: READABLE_STRING_GENERAL)
			-- A button with text `a_button_text' has been pressed.
		do
			selected_button := a_button_text.as_string_32
			if not is_destroyed then
				destroy
			end
		end

	on_key_press (a_key: EV_KEY)
			-- Called when user presses a key on the dialog.
		do
			if a_key.code = {EV_KEY_CONSTANTS}.key_left then
				move_to_next_button (-1)
			elseif a_key.code = {EV_KEY_CONSTANTS}.key_right then
				move_to_next_button (1)
			end
		end

	move_to_next_button (a_delta: INTEGER)
			-- Moves focus to next or previous button based on `a_delta'.
		require
			valid_delta: a_delta = -1 or a_delta = 1
		local
			l_buttons: like button_box
			l_cursor: CURSOR
			l_focused_widget: detachable EV_WIDGET
			l_focused: BOOLEAN
		do
			l_buttons := button_box
			if l_buttons.count > 1 then
				l_cursor := l_buttons.cursor
				from l_buttons.start until l_buttons.after or l_focused loop
					l_focused_widget := l_buttons.item
					l_focused := l_focused_widget.has_focus
					if not l_focused then
						l_buttons.forth
					end
				end
				if l_focused then
					if l_focused_widget /= Void then
						if a_delta = -1 then
							if l_buttons.first = l_focused_widget then
								l_buttons.last.set_focus
							else
								l_buttons.back
								l_buttons.item.set_focus
							end
						else
							if l_buttons.last = l_focused_widget then
								l_buttons.first.set_focus
							else
								l_buttons.forth
								l_buttons.item.set_focus
							end
						end
					end
				else
					l_buttons.first.set_focus
				end
				l_buttons.go_to (l_cursor)
			end
		end

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




end -- class EV_MESSAGE_DIALOG












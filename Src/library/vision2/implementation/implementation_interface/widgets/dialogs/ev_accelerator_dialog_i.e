indexing
	description:
		"EiffelVision accelerator selection dialog, implementation interface."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_ACCELERATOR_SELECTION_DIALOG_I

inherit
	EV_STANDARD_DIALOG_I

creation
	make,
	make_with_text,
	make_with_actions,
	make_with_all

feature {NONE} -- Initialization

	make (par: EV_CONTAINER) is
			-- Create a message dialog with `par' as parent.
		do
			create window.make_top_level
			set_title ("Accelerator Selector")
			position_composants
			window.forbid_resize
		end

	make_with_text (par: EV_CONTAINER; txt: STRING) is
			-- Create a message dialog with `par' as parent.
		do
			make (par)
			set_title ("txt")
		end

	make_with_actions (par: EV_CONTAINER; actions: LINKED_LIST [STRING]) is
			-- Create a message_dialog with `par' as parent and
			-- `actions' as action to fill with an accelerator.
		require
			valid_parent: is_valid (par)
			valid_actions: actions /= Void
			actions_not_empty: not actions.empty
		do
			make (par)
			create_actions (actions)
		end

	make_with_all (par: EV_CONTAINER; txt: STRING; actions: LINKED_LIST [STRING]) is
			-- Create a message_dialog with `par' as parent, 
			-- `txt' as title and `actions' as list item.
		require
			valid_parent: is_valid (par)
			valid_text: txt /= Void
			valid_actions: actions /= Void
			actions_not_empty: not actions.empty
		do
			make (par)
			set_title (txt)
			create_actions (actions)
		end

feature -- Access

	window: EV_WINDOW
			-- Current dialog

	OK, Cancel: EV_BUTTON
			-- Push buttons

	list: EV_LIST
			-- A list to display the actions

	combo: EV_COMBO_BOX
			-- A combo box for the accelerator's key

	alt, shift, control: EV_CHECK_BUTTON
			-- Three check buttons for the accelerator's modifiers

	accelerators: LINKED_LIST [EV_ACCELERATOR]
			-- Accelerators choosen by the user

feature -- Status report

	destroyed: BOOLEAN is
			-- Is Current object destroyed?
		do
			Result := window = Void
		end

feature -- Status setting

	destroy is
			-- Destroy actual screen object of Current
			-- widget and of all children.
		do
			window.destroy
			window := Void
		end


	show is
			-- Show the window.
			-- As the window is modal, nothing can be done
			-- until the user closed the window.
		do
			window.show
		end

feature -- Element change

	set_title (txt: STRING) is
			-- Make `txt' the title of the dialog.
		require
			valid_title: txt /= Void
		do
			window.set_title (txt)
		end

	set_parent (par: EV_CONTAINER) is
			-- Make `par' the new parent of the dialog.
		do
			-- Do nothing
		end

feature -- Basic operations

	set_default_accelerators (acc: LINKED_LIST [EV_ACCELERATOR]) is
			-- Make `acc' the default accelerators linked to the
			-- user actions. They must be given in the same order
			-- than the actions at the creation of the dialog.
			-- Initialize the `acc.count' first actions of the
			-- dialogs.
		require
			exists: not destroyed
			valid_accelerators: acc /= Void
		local
			stop: INTEGER
			cur: CURSOR
		do
			stop := list.count.min (acc.count)
			from
				cur := acc.cursor
				acc.start
			until
				acc.index = stop
			loop
				(list.get_item (acc.index)).set_data (acc.item)
				acc.forth
			end
			acc.go_to (cur)
		end

feature {NONE} -- Implementation

	position_composants is
			-- Set all the component inside the window
		local
			label: EV_LABEL
			hbox: EV_HORIZONTAL_BOX
			main_box, vbox: EV_VERTICAL_BOX
			frame: EV_FRAME
			cmd: EV_ROUTINE_COMMAND
		do
			create main_box.make (window)
			main_box.set_spacing (10)
			main_box.set_border_width (10)

			create hbox.make (main_box)
			hbox.set_spacing (10)
			create list.make (hbox)
			list.set_minimum_width (160)

			create vbox.make (hbox)
			vbox.set_spacing (5)
			vbox.set_expand (False)
			create_keys (vbox)
			create frame.make_with_text (vbox, "Modifiers")
			create vbox.make (frame)
			create cmd.make (~changed_execute)
			create alt.make_with_text (vbox, "Alt Key")
			alt.add_toggle_command (cmd, Void)
			create shift.make_with_text (vbox, "Shift Key")
			shift.add_toggle_command (cmd, Void)
			create control.make_with_text (vbox, "Control Key")
			control.add_toggle_command (cmd, Void)

			create hbox.make (main_box)
			hbox.set_spacing (10)
			create label.make (hbox)
			create ok.make_with_text (hbox, "OK")
			ok.set_expand (False)
			ok.set_minimum_width (70)
			create cmd.make (~ok_execute)
			ok.add_click_command (cmd, Void)
			create cancel.make_with_text (hbox, "Cancel")
			cancel.set_expand (False)
			cancel.set_minimum_width (70)
			create cmd.make (~cancel_execute)
			cancel.add_click_command (cmd, Void)

			-- We set the accelerator selector part insensitive because
			-- nothing is selected yet.
			combo.set_insensitive (True)
			shift.set_insensitive (True)
			alt.set_insensitive (True)
			control.set_insensitive (True)
		end

	create_actions (actions: LINKED_LIST [STRING]) is
			-- Fill the list with the given actions.
		local
			cur: CURSOR
			litem: EV_LIST_ITEM
			cmd: EV_ROUTINE_COMMAND
		do
			from
				create cmd.make (~list_item_execute)
				cur := actions.cursor
				actions.start
			until
				actions.after
			loop
				create litem.make_with_text (list, actions.item)
				litem.add_select_command (cmd, Void)
				actions.forth
			end
			actions.go_to (cur)
		end

	create_keys (par: EV_CONTAINER) is
			-- Create and fill the combo-box that display the
			-- choice of keys for the accelerators.
		local
			cmd: EV_ROUTINE_COMMAND
			arg: EV_ARGUMENT1 [INTEGER]
			key: EV_KEY_CODE
			litem: EV_LIST_ITEM
		do
			create combo.make (par)
			combo.set_editable (False)
			create cmd.make (~changed_execute)
			combo.add_selection_command (cmd, Void)
			create key.make

			-- The NONE item
			create litem.make_with_text (combo, "NONE")
			litem.set_data(0)
			litem.set_selected (True)
			
			-- F keys
			create litem.make_with_text (combo, "F1")
			litem.set_data(key.key_f1)
			create litem.make_with_text (combo, "F2")
			litem.set_data(key.key_f2)
			create litem.make_with_text (combo, "F3")
			litem.set_data(key.key_f3)
			create litem.make_with_text (combo, "F4")
			litem.set_data(key.key_f4)
			create litem.make_with_text (combo, "F5")
			litem.set_data(key.key_f5)
			create litem.make_with_text (combo, "F6")
			litem.set_data(key.key_f6)
			create litem.make_with_text (combo, "F7")
			litem.set_data(key.key_f7)
			create litem.make_with_text (combo, "F8")
			litem.set_data(key.key_f8)
			create litem.make_with_text (combo, "F9")
			litem.set_data(key.key_f9)
			create litem.make_with_text (combo, "F10")
			litem.set_data(key.key_f10)
			create litem.make_with_text (combo, "F11")
			litem.set_data(key.key_f11)
			create litem.make_with_text (combo, "F12")
			litem.set_data(key.key_f12)

			-- Special keys
			create litem.make_with_text (combo, "Space")
			litem.set_data(key.key_space)
			create litem.make_with_text (combo, "Back Space")
			litem.set_data(key.key_back_space)
			create litem.make_with_text (combo, "Enter")
			litem.set_data(key.key_enter)
			create litem.make_with_text (combo, "Escape")
			litem.set_data(key.key_escape)
			create litem.make_with_text (combo, "Tab")
			litem.set_data(key.key_tab)
			create litem.make_with_text (combo, "Pause")
			litem.set_data(key.key_pause)
			create litem.make_with_text (combo, "Caps Lock")
			litem.set_data(key.key_caps_lock)
			create litem.make_with_text (combo, "Scroll Lock")
			litem.set_data(key.key_scroll_lock)

			-- Numpad
			create litem.make_with_text (combo, "Numpad0")
			litem.set_data(key.key_Numpad0)
			create litem.make_with_text (combo, "Numpad1")
			litem.set_data(key.key_Numpad1)
			create litem.make_with_text (combo, "Numpad2")
			litem.set_data(key.key_Numpad2)
			create litem.make_with_text (combo, "Numpad3")
			litem.set_data(key.key_Numpad3)
			create litem.make_with_text (combo, "Numpad4")
			litem.set_data(key.key_Numpad4)
			create litem.make_with_text (combo, "Numpad5")
			litem.set_data(key.key_Numpad5)
			create litem.make_with_text (combo, "Numpad6")
			litem.set_data(key.key_Numpad6)
			create litem.make_with_text (combo, "Numpad7")
			litem.set_data(key.key_Numpad7)
			create litem.make_with_text (combo, "Numpad8")
			litem.set_data(key.key_Numpad8)
			create litem.make_with_text (combo, "Numpad9")
			litem.set_data(key.key_Numpad9)
			create litem.make_with_text (combo, "Add")
			litem.set_data(key.key_num_add)
			create litem.make_with_text (combo, "Divide")
			litem.set_data(key.key_num_divide)
			create litem.make_with_text (combo, "Multiply")
			litem.set_data(key.key_num_multiply)
			create litem.make_with_text (combo, "Num Lock")
			litem.set_data(key.key_num_lock)
			create litem.make_with_text (combo, "Subtract")
			litem.set_data(key.key_num_subtract)
			create litem.make_with_text (combo, "Decimal")
			litem.set_data(key.key_num_decimal)

			-- Special Character
			create litem.make_with_text (combo, ",")
			litem.set_data(key.key_comma)
			create litem.make_with_text (combo, "=")
			litem.set_data(key.key_equals)
			create litem.make_with_text (combo, ".")
			litem.set_data(key.key_period)
			create litem.make_with_text (combo, ";")
			litem.set_data(key.key_semicolon)
			create litem.make_with_text (combo, "[")
			litem.set_data(key.key_open_bracket)
			create litem.make_with_text (combo, "]")
			litem.set_data(key.key_close_bracket)
			create litem.make_with_text (combo, "/")
			litem.set_data(key.key_slash)
			create litem.make_with_text (combo, "\")
			litem.set_data(key.key_back_slash)
			create litem.make_with_text (combo, "'")
			litem.set_data(key.key_quote)
			create litem.make_with_text (combo, "`")
			litem.set_data(key.key_back_quote)
			create litem.make_with_text (combo, "-")
			litem.set_data(key.key_dash)

			-- Position keys
			create litem.make_with_text (combo, "Arrow Up")
			litem.set_data(key.key_up)
			create litem.make_with_text (combo, "Arrow Down")
			litem.set_data(key.key_down)
			create litem.make_with_text (combo, "Arrow Left")
			litem.set_data(key.key_left)
			create litem.make_with_text (combo, "Arrow Right")
			litem.set_data(key.key_right)
			create litem.make_with_text (combo, "Page Up")
			litem.set_data(key.key_page_up)
			create litem.make_with_text (combo, "Page Down")
			litem.set_data(key.key_page_down)
			create litem.make_with_text (combo, "Home")
			litem.set_data(key.key_home)
			create litem.make_with_text (combo, "end")
			litem.set_data(key.key_end)
			create litem.make_with_text (combo, "Insert")
			litem.set_data(key.key_insert)
			create litem.make_with_text (combo, "Delete")
			litem.set_data(key.key_delete)

			-- Alphabetical keys
			create litem.make_with_text (combo, "a")
			litem.set_data(key.key_a)
			create litem.make_with_text (combo, "b")
			litem.set_data(key.key_b)
			create litem.make_with_text (combo, "c")
			litem.set_data(key.key_c)
			create litem.make_with_text (combo, "d")
			litem.set_data(key.key_d)
			create litem.make_with_text (combo, "e")
			litem.set_data(key.key_e)
			create litem.make_with_text (combo, "f")
			litem.set_data(key.key_f)
			create litem.make_with_text (combo, "g")
			litem.set_data(key.key_g)
			create litem.make_with_text (combo, "h")
			litem.set_data(key.key_h)
			create litem.make_with_text (combo, "i")
			litem.set_data(key.key_i)
			create litem.make_with_text (combo, "j")
			litem.set_data(key.key_j)
			create litem.make_with_text (combo, "k")
			litem.set_data(key.key_k)
			create litem.make_with_text (combo, "l")
			litem.set_data(key.key_l)
			create litem.make_with_text (combo, "m")
			litem.set_data(key.key_m)
			create litem.make_with_text (combo, "n")
			litem.set_data(key.key_n)
			create litem.make_with_text (combo, "o")
			litem.set_data(key.key_o)
			create litem.make_with_text (combo, "p")
			litem.set_data(key.key_p)
			create litem.make_with_text (combo, "q")
			litem.set_data(key.key_q)
			create litem.make_with_text (combo, "r")
			litem.set_data(key.key_r)
			create litem.make_with_text (combo, "s")
			litem.set_data(key.key_s)
			create litem.make_with_text (combo, "t")
			litem.set_data(key.key_t)
			create litem.make_with_text (combo, "u")
			litem.set_data(key.key_u)
			create litem.make_with_text (combo, "v")
			litem.set_data(key.key_v)
			create litem.make_with_text (combo, "w")
			litem.set_data(key.key_w)
			create litem.make_with_text (combo, "x")
			litem.set_data(key.key_x)
			create litem.make_with_text (combo, "y")
			litem.set_data(key.key_y)
			create litem.make_with_text (combo, "z")
			litem.set_data(key.key_z)

			-- Numbers
			create litem.make_with_text (combo, "0")
			litem.set_data(key.key_0)
			create litem.make_with_text (combo, "1")
			litem.set_data(key.key_1)
			create litem.make_with_text (combo, "2")
			litem.set_data(key.key_2)
			create litem.make_with_text (combo, "3")
			litem.set_data(key.key_3)
			create litem.make_with_text (combo, "4")
			litem.set_data(key.key_4)
			create litem.make_with_text (combo, "5")
			litem.set_data(key.key_5)
			create litem.make_with_text (combo, "6")
			litem.set_data(key.key_6)
			create litem.make_with_text (combo, "7")
			litem.set_data(key.key_7)
			create litem.make_with_text (combo, "8")
			litem.set_data(key.key_8)
			create litem.make_with_text (combo, "9")
			litem.set_data(key.key_9)
		end

feature {EV_ACCELERATOR_SELECTION_DIALOG_IMP} -- Execution features

	changed_execute (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Executed each time the user change a parameter of the accelerator.
		do
			changed := True
		end

	ok_execute (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Executed when the user select an item in the combo-box.
		local
			i: INTEGER
			acc: EV_ACCELERATOR
		do
			list_item_execute (Void, Void)
			create accelerators.make
			from
				i := 1
			until
				i > list.count
			loop
				acc ?= (list.get_item(i)).data
				accelerators.extend (acc)
				i := i + 1
			end			
			window.hide
		end

	cancel_execute (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Executed when the user select an item in the combo-box.
		do
			window.hide
		end

	list_item_execute (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Executed when the user select an item in the combo-box.
		local
			accelerator: EV_ACCELERATOR
			item: EV_LIST_ITEM
			value: INTEGER_REF
		do
			-- First, we set the selected accelerator to the
			-- previously selected item
			if old_item = Void then
				combo.set_insensitive (False)
				shift.set_insensitive (False)
				alt.set_insensitive (False)
				control.set_insensitive (False)
			elseif changed then
				if combo.text.is_equal ("NONE") then
					old_item.set_data (Void)
				else
					value ?= combo.selected_item.data
					create accelerator.make (value.item, shift.state, alt.state, control.state)
					old_item.set_data (accelerator)
				end
				changed := False
			end

			-- Then, we set the currently selected item as the old item
			-- And we set the parameters if something has been selected
			old_item := list.selected_item
			accelerator ?= old_item.data
			if accelerator /= Void then
				item := combo.find_item_by_data (accelerator.keycode)
				item.set_selected (True)
				shift.set_state (accelerator.shift_key)
				alt.set_state (accelerator.alt_key)
				control.set_state (accelerator.control_key)
			else
				item := combo.get_item (1)
				item.set_selected (True)
				shift.set_state (False)
				alt.set_state (False)
				control.set_state (False)
			end
		end

	old_item: EV_LIST_ITEM
			-- The previously selected item of the list.

	changed: BOOLEAN
			-- Did something changed in the user choice?

end -- class EV_ACCELERATOR_SELECTION_DIALOG_I

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

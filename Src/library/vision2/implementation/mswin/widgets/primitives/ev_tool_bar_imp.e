indexing
	description: "EiffelVision toolbar, mswindows implementation."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_TOOL_BAR_IMP

inherit
	EV_TOOL_BAR_I

	EV_PRIMITIVE_IMP
		undefine
			set_default_options
		redefine
			on_first_display
		end

	EV_ITEM_HOLDER_IMP

	WEL_CONTROL_WINDOW
		rename
			make as wel_make,
			parent as wel_parent,
			set_parent as wel_set_parent,
			destroy as wel_destroy,
			destroy_item as wel_destroy_item
		undefine
			set_width,
			set_height,
			remove_command,
			background_brush,
			on_left_button_down,
			on_mouse_move,
			on_left_button_up,
			on_right_button_down,
			on_right_button_up,
			on_left_button_double_click,
			on_right_button_double_click,
			on_key_up,
			on_key_down,
			on_kill_focus,
			on_set_focus,
			on_set_cursor,
			on_accelerator_command
		redefine
			on_size,
			move_and_resize,
			on_wm_erase_background,
			on_control_id_command
		end

creation
	make,
	make_with_size

feature -- Initialization

	make is
			-- Create the tool-bar with `par' as parent.
 		do
			wel_make (default_parent.item, "EV_TOOL_BAR_IMP")
			create toolbar.make (Current, 0)
			create ev_children.make (1)
		end

	make_with_size (w, h: INTEGER) is
			-- Create the tool-bar with `par' as parent.
		do
			make
			toolbar.set_bitmap_size (w, h)
		end

feature -- Access

	toolbar: EV_INTERNAL_TOOL_BAR_IMP
			-- The tool bar of the container.

	ev_children: HASH_TABLE [EV_TOOL_BAR_BUTTON_IMP, INTEGER]
			-- The buttons of the tool-bar.

	separator_count: INTEGER is
			-- Number of separators in the toolbar.
			-- Necessary for the implementation of the minimum_width
			-- of the toolbar. As soon as the message Tb_getmaxsize
			-- is available, this feature should not be so usefull.
		local
			list: HASH_TABLE [EV_TOOL_BAR_BUTTON_IMP, INTEGER]
		do
			from
				list := ev_children
				list.start
			until
				list.after
			loop
				if list.item_for_iteration.type = 5 then
					Result := Result + 1
				end
				list.forth
			end
		end

feature -- Status report

	count: INTEGER is
			-- Current number of buttons in the tool-bar.
		do
			Result := toolbar.button_count
		end

feature -- Element change

	add_button (button: EV_TOOL_BAR_BUTTON_IMP) is
			-- Add `but' to the toolbar.
		require
			valid_button: button /= Void and then not button.destroyed
		do
			insert_button (button, count + 1)
		end

	insert_button (button: EV_TOOL_BAR_BUTTON_IMP; index: INTEGER) is
			-- Insert `button' at the `index' position in the tool-bar.
		require
			valid_button: button /= Void and then not button.destroyed
			valid_index: index >= 1 and then index <= count + 1
		local
			bmp: WEL_TOOL_BAR_BITMAP
			but: WEL_TOOL_BAR_BUTTON
			tool: EV_INTERNAL_TOOL_BAR_IMP
			num: INTEGER
		do
			-- We create the button
			tool := toolbar
			inspect button.type
			when 1 then -- Usual button
				create but.make_button (-1, button.id)
			when 2 then -- Check button
				create but.make_check (-1, button.id)
			when 3 then -- Radio button
				create but.make_check (-1, button.id)
			when 4 then -- Option button
				create but.make_button (-1, button.id)
			when 5 then -- Separator
				create but.make_separator
				but.set_command_id (button.id)
			end
	
			-- First, we take care of the pixmap,
			if button.pixmap_imp /= Void then
				create bmp.make_from_bitmap (button.pixmap_imp.bitmap)
				tool.add_bitmaps (bmp, 1)
				but.set_bitmap_index (tool.last_bitmap_index)
			end

			-- Then, the text of the button.
			if button.text /= Void and then text /= "" then
				tool.add_strings (<<button.text>>)
				but.set_string_index (tool.last_string_index)
			end

			-- Finally, we insert the button
			tool.insert_button (index - 1, but)
			ev_children.put (button, button.id)

			-- We reset the minimum size it case it changed.
			if already_displayed then
				internal_update_minsize
			end
		end

	move_button (button: EV_TOOL_BAR_BUTTON_IMP; index: INTEGER) is
			-- Move `button' to the `index' position.
		do
			remove_button (button)
			insert_button (button, index)
		end

	remove_button (button: EV_TOOL_BAR_BUTTON_IMP) is
			-- Remove button from the toolbar.
		do
			toolbar.delete_button (internal_index (button.id))
			ev_children.remove (button.id)
			if already_displayed then
				internal_update_minsize
			end
		end

feature -- Basic operation

	internal_index (id: INTEGER): INTEGER is
			-- Retrieve the current index of `but'.
		do
			Result := toolbar.internal_index (id)
		end

	internal_update_minsize is
			-- Update the minimum-size of the tool-bar.
		local
			num: INTEGER
			tool: EV_INTERNAL_TOOL_BAR_IMP
		do
			tool := toolbar

			set_minimum_height (tool.button_height + 6)
			num := separator_count
			num := (tool.button_count - num) * tool.button_width
					+ num * tool.separator_width
			set_minimum_width (num)
		end

	internal_reset_button (but: EV_TOOL_BAR_BUTTON_IMP) is
			-- XX To update XX
			-- This function is used each we change an attribute of a button as the
			-- text or the pixmap. Yet, it should only be a Temporary implementation.
			-- For now, no message is available to change the text of a button.
			-- But this implementation should be changes as soon as windows allow
			-- a more direct way to change an attribute.
		local
			index: INTEGER
		do
			index := internal_index (but.id) + 1
			remove_button (but)
			insert_button (but, index)
		end

feature {NONE} -- Inapplicable

	next_dlgtabitem (hdlg, hctl: POINTER; previous: BOOLEAN): POINTER is
			-- Encapsulation of the SDK GetNextDlgTabItem,
			-- because we cannot do a deferred feature become an
			-- external feature.
		do
			check
				Inapplicable: False
			end
		end

	next_dlggroupitem (hdlg, hctl: POINTER; previous: BOOLEAN): POINTER is
			-- Encapsulation of the SDK GetNextDlgGroupItem,
			-- because we cannot do a deferred feature become an
			-- external feature.
		do
			check
				Inapplicable: False
			end
		end

feature {NONE} -- Implementation

	already_displayed: BOOLEAN
			-- Has the toolbar been already displayed

	on_first_display is
			-- Called by the top_level window when it is displayed
			-- for the first time.
		do
			internal_update_minsize
		end

	move_and_resize (a_x, a_y, a_width, a_height: INTEGER; repaint: BOOLEAN) is
			-- We must not resize the height of the combo-box.
		do
			cwin_move_window (item, a_x, a_y, a_width, toolbar.height, repaint)
		end

feature {NONE} -- WEL Implementation

   	background_brush: WEL_BRUSH is
   			-- Current window background color used to refresh the window when
   			-- requested by the WM_ERASEBKGND windows message.
   			-- By default there is no background  
		do
 			if exists and background_color_imp /= void then
 				!! Result.make_solid (background_color_imp)
 			end
 		end

	on_size (size_type, a_width, a_height: INTEGER) is
			-- Wm_size message
		do
			toolbar.reposition
		end

	on_wm_erase_background (wparam: INTEGER) is
			-- Wm_erasebkgnd message.
			-- Ne need to erase the background because this
			-- containers has always the same size than the
			-- tool-bar.
		do
			disable_default_processing
		end

	on_control_id_command (control_id: INTEGER) is
			-- A command has been received from `control_id'.
		do
			(ev_children @ control_id).on_activate
		end

end -- class EV_TOOL_BAR_IMP

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

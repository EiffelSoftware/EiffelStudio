--| FIXME NOT_REVIEWED this file has not been reviewed
 indexing
	description: "Eiffel Vision list. Mswindows implementation."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_LIST_IMP

inherit
	EV_LIST_I
		rename
			selected_items as old_selected_items
		redefine
			interface
		end
		
	EV_LIST_I
		redefine
			interface,
			selected_items
		select
			selected_items
		end
		
	EV_LIST_ITEM_LIST_IMP
		redefine
			initialize,
			interface
		end
	
	EV_PRIMITIVE_IMP
		undefine
			set_default_colors,
			on_right_button_down,
			on_left_button_down,
			on_middle_button_down,
			pnd_press
		redefine
			make,
			on_key_down,
			on_mouse_move,
			initialize,
			interface
		end

	WEL_LBS_CONSTANTS
		export
			{NONE} all
		end

creation
	make

feature {NONE} -- Implementation
	
	single_selection_list: EV_WEL_SS_LISTBOX
	multiple_selection_list:  EV_WEL_MS_LISTBOX
	current_list: EV_WEL_LISTBOX
	
feature {NONE} -- Initialization
	
	make (an_interface: like interface) is         
			-- Create list as single selection.
		do
			base_make (an_interface)
			create single_selection_list.make (default_parent, 0, 0, 1, 1, 0)
			current_list := single_selection_list
			create ev_children.make (2)
		end	

	initialize is
		do
			{EV_PRIMITIVE_IMP} Precursor
			{EV_LIST_ITEM_LIST_IMP} Precursor
		end

feature -- Delegated feature

	wel_width: INTEGER is
			-- Window width
		do
			Result := current_list.width
		end

	insert_string_at (a_string: STRING; an_index: INTEGER) is
			-- Add `a_string' at the zero-based `index'.
		do
			current_list.insert_string_at (a_string, an_index)
		end	

	add_string (a_string: STRING) is
			-- Add `a_string' in the list box.
			-- If the list box does not have the
			-- `Lbs_sort' style, `a_string' is added
			-- to the end of the list otherwise it is
			-- inserted into the list and the list is
			-- sorted.
		do
			current_list.add_string (a_string)
		end

	exists: BOOLEAN is
			-- Does the window exist?
		do
			Result := current_list.exists
		end

	enable is
			-- Enable mouse and keyboard input.
		do
			current_list.enable
		end

	on_wm_show_window (wparam, lparam: INTEGER) is
			-- Wm_showwindow message
		do
			current_list.on_wm_show_window (wparam, lparam)
		end

	on_wm_notify (wparam, lparam: INTEGER) is
			-- Wm_notify message
		do
			current_list.on_wm_notify (wparam, lparam)
		end

	on_timer (timer_id: INTEGER) is
			-- Wm_timer message.
		do
			current_list.on_timer (timer_id)
		end

	set_style (a_style: INTEGER) is
		do
			current_list.set_style (a_style)
		end

	item_height: INTEGER is
			-- Height in pixels of each list item.
		do
			Result := current_list.item_height
		end

	wel_destroy is
		do
			current_list.destroy
		end	

	invalidate is
		do
			current_list.invalidate
		end

	wel_item: POINTER is
		do
			Result := current_list.item
		end

	disable_default_processing is
		do
			current_list.disable_default_processing
		end

	delete_string (an_index: INTEGER) is
			-- Delete the zero-based `index' item.
		do
			current_list.delete_string (an_index)
		end

	windows: HASH_TABLE [WEL_WINDOW, POINTER] is
		do
			Result := current_list.windows
		end

	top_index: INTEGER is
			-- Index of item at displayed at top of list.
		do
			Result := current_list.top_index
		end

	wel_height: INTEGER is
		do
			Result := current_list.height
		end

	disable is
		do
			current_list.disable
		end

	on_move (x_pos: INTEGER; y_pos: INTEGER) is
		do
			current_list.on_move (x_pos, y_pos)
		end

	on_wm_destroy is
		do
			current_list.on_wm_destroy
		end

	default_process_message (msg: INTEGER; wparam: INTEGER; lparam: INTEGER) is
		do
			current_list.default_process_message (msg, wparam, lparam)
		end

	wel_set_parent (a_parent: WEL_WINDOW) is
		do
			current_list.set_parent (a_parent)
		end

	style: INTEGER is
		do
			Result := current_list.style
		end

	client_rect: WEL_RECT is
		do
			Result := current_list.client_rect
		end

	set_message_return_value (v: INTEGER) is
		do
			current_list.set_message_return_value (v)
		end

	x_position: INTEGER is
		do
			Result := current_list.x
		end

	y_position: INTEGER is
		do
			Result := current_list.y
		end

	wel_move (a_x_position: INTEGER; a_y_position: INTEGER) is
		do
			current_list.move (a_x_position, a_y_position)
		end

	wel_move_and_resize (a_x_position: INTEGER; a_y_position: INTEGER; a_width: INTEGER; a_height: INTEGER; repaint: BOOLEAN) is
		do
			current_list.move_and_resize (a_x_position, a_y_position, a_width, a_height, repaint)
		end

	wel_resize (a_width: INTEGER; a_height: INTEGER) is
		do
			current_list.resize (a_width, a_height)
		end

	is_sensitive: BOOLEAN is
		do
			Result := current_list.enabled
		end

	is_displayed: BOOLEAN is
		do
			Result := current_list.shown
		end

	has_focus: BOOLEAN is
		do
			Result := current_list.has_focus
		end

	set_focus is
		do
			current_list.set_focus
		end

	set_heavy_capture is
		do
			current_list.set_heavy_capture
		end

	release_heavy_capture is
		do
			current_list.release_heavy_capture
		end

	set_capture is
		do
			current_list.set_capture
		end

	release_capture is
		do
			current_list.release_capture
		end

	wel_parent: WEL_WINDOW is
		do
			Result := current_list.parent
		end

feature -- Access

	multiple_selection_enabled: BOOLEAN
			-- Can more than one item be selected?

	selected_items: LINKED_LIST [EV_LIST_ITEM] is
			-- Currently selected items.
		local
			i: INTEGER
			wel_selected_items: ARRAY [INTEGER]
		do
			create Result.make
			if multiple_selection_enabled then
				wel_selected_items := multiple_selection_list.selected_items
				from
					i := wel_selected_items.lower
				until
					i > wel_selected_items.upper
				loop
					Result.extend (i_th(wel_selected_items @ i + 1))
					Result.finish
					i := i + 1
				end
			elseif single_selection_list.selected then
				Result.extend (i_th(single_selection_list.selected_item + 1))
			end
		ensure then
			valid_implementation: validate_selected_items (Result)
		end

feature -- Status setting

	select_item (an_index: INTEGER) is
			-- Select item at `an_index'.
		do
			if multiple_selection_enabled then
				multiple_selection_list.select_item (an_index - 1)
			else
				single_selection_list.select_item (an_index - 1)
			end
		end

	deselect_item (an_index: INTEGER) is
			-- Deselect item at `an_index'.
		do
			if multiple_selection_enabled then
				multiple_selection_list.unselect_item (index - 1)
			else
				if single_selection_list.selected and then single_selection_list.selected_item = an_index - 1 then
					single_selection_list.unselect
				end
			end
		end

	clear_selection is
			-- Ensure there are no `selected_items'.
		do
			if multiple_selection_enabled then
				multiple_selection_list.unselect_all
			else
				single_selection_list.unselect
			end
		end

	enable_multiple_selection is
			-- Allow more than one item to be selected.
		do
			if not multiple_selection_enabled then
				multiple_selection_enabled := True
				last_selected_item := Void
				recreate_list
			end
		end

	disable_multiple_selection is
			-- Allow only one item to be selected.
		do
			if multiple_selection_enabled then
				multiple_selection_enabled := False
				recreate_list
			end
		end

feature {NONE} -- Implementation

	recreate_list is
			-- Re-initialize object.
			--| enable_multiple_selection has been changed.
		local
			wel_win: WEL_WINDOW
			old_x_position, old_y_position, old_width, old_height: INTEGER
		do
				-- We store existing attributes required to re-create `Current'.
			wel_win ?= parent_imp
			old_x_position := x_position
			old_y_position := y_position
			old_width := width
			old_height := height

				-- Destroy the old windows object.
			wel_destroy

				-- Create a new windows object with the stored attributes.
			if multiple_selection_enabled then
				create multiple_selection_list.make (
					Default_parent,
					old_x_position, 
					old_y_position, 
					old_width, 
					old_height,
					0
					)
				current_list := multiple_selection_list
				single_selection_list := Void
			else
				create single_selection_list.make (
					Default_parent,
					old_x_position, 
					old_y_position, 
					old_width, 
					old_height,
					0
					)
				current_list := multiple_selection_list
				multiple_selection_list := Void
			end
				
				-- Update the contents of the new windows object.
			internal_copy_list

				-- Set the parent.
				--| Note ARNAUD - April 2000.
				--| Do not use `wel_win' in `internal_window_make' because
				--| Windows may not be able to register the window.
			wel_set_parent (wel_win)
		end

feature {EV_LIST_ITEM_IMP} -- Implementation

	is_item_imp_selected (li_imp: EV_LIST_ITEM_IMP): BOOLEAN is
			-- Is `li_imp' selected?
		local
			pos: INTEGER
		do
			pos := index_of_item_imp (li_imp)
			if multiple_selection_enabled then
				if multiple_selection_list.selected then
					Result := multiple_selection_list.selected_items.has (pos - 1)
				end
			else
				if single_selection_list.selected then
					Result := single_selection_list.selected_item = (pos - 1)
				end
			end
		end

	select_item_imp (li_imp: EV_LIST_ITEM_IMP) is
			-- Set `li_imp' selected.
		local
			pos: INTEGER
		do
			pos := index_of_item_imp (li_imp)
			if multiple_selection_enabled then
				multiple_selection_list.select_item (pos - 1)
			else
				single_selection_list.select_item (pos - 1)
			end
		end

	deselect_item_imp (li_imp: EV_LIST_ITEM_IMP) is
			-- Set `li_imp' deselected.
		local
			pos: INTEGER
		do
			pos := index_of_item_imp (li_imp)
			if multiple_selection_enabled then
				multiple_selection_list.unselect_items (pos - 1, pos - 1)
			else
				single_selection_list.unselect
			end
		end

	set_item_imp_text (li_imp: EV_LIST_ITEM_IMP; a_text: STRING) is
			-- Set `li_imp'.`text' to `a_text'.
		local
			pos: INTEGER
		do
			pos := index_of_item_imp (li_imp)
			delete_string (pos - 1)
			insert_string_at (a_text, pos - 1)
		ensure then
			a_text_set:
				a_text.is_equal (current_list.i_th_text (index_of_item_imp (li_imp) - 1))
		end

	internal_propagate_pointer_press (keys, x_pos, y_pos, button: INTEGER) is
			-- Propagate `keys', `x_pos' and `y_pos' to the appropriate
			-- item event.
		local
			it: EV_LIST_ITEM_IMP
			pt: WEL_POINT
		do
			it := find_item_at_position (x_pos, y_pos)
			pt := client_to_screen (x_pos, y_pos)
				if it /= Void and it.is_transport_enabled and not
						parent_is_pnd_source then
					it.pnd_press (x_pos, y_pos, button, pt.x, pt.y)
				elseif pnd_item_source /= Void then 
					pnd_item_source.pnd_press (x_pos, y_pos, button, pt.x, pt.y)
				end
			if it /= Void then
				it.interface.pointer_button_press_actions.call ([x_pos,y_pos -
					it.relative_y, button, 0.0, 0.0, 0.0, pt.x, pt.y])
			end
		end

feature {EV_ANY_I} -- Implementation

	validate_selected_items (new_result: like selected_items): BOOLEAN is
		local
			old_result: like selected_items
		do
			old_result := old_selected_items

				-- by default, the new implementation is correct if the
				-- list have the same size
			Result := (old_result.count = new_result.count)

				-- Validate the new algorithm
			from
				old_result.start
				new_result.start
			until
				(not Result) or (old_result.after and new_result.after)
			loop
				if not old_result.item.is_equal(new_result.item) then
					Result := False
				end
				old_result.forth
				new_result.forth
			end
			new_result.start
		end

	find_item_at_position (x_pos, y_pos: INTEGER): EV_LIST_ITEM_IMP is
			-- Result is list item at pixel position `x_pos', `y_pos'.
		local
			temporary_position: INTEGER
		do
			temporary_position := (y_pos // item_height) + 1
			if top_index > 0 then
				temporary_position := top_index + temporary_position
			end
			if temporary_position <= count and temporary_position > 0 then
				Result := ev_children @ temporary_position
			end
		end

	default_style: INTEGER is
			-- Default style of the list.
		do
			check
				not_called: False
			end
			Result := Lbs_hasstrings + Lbs_nointegralheight
		end

	default_ex_style: INTEGER is
			-- Default extended style of the list.
		do
			Result := Ws_ex_clientedge
		end

	last_selected_item: EV_LIST_ITEM_IMP
			-- Item was last selected as notified by `on_lbn_selchange'.

	on_lbn_selchange is
			-- The selection is about to change.
		local
			li_imp: EV_LIST_ITEM_IMP
		do
			if multiple_selection_enabled then
				li_imp := ev_children @ (multiple_selection_list.caret_index + 1)
				if li_imp.is_selected then
					notify_select (li_imp.interface)
				else
					notify_deselect (li_imp.interface)
				end
			else
				if single_selection_list.selected then
					li_imp := ev_children @ (single_selection_list.selected_item + 1)
					if last_selected_item /= Void and then li_imp /=
							last_selected_item then
						notify_deselect (last_selected_item.interface)
					end
					notify_select (li_imp.interface)
					last_selected_item := li_imp
				else
					if last_selected_item /= Void then
						notify_deselect (last_selected_item.interface)
						last_selected_item := Void
					end
				end
			end
		end

	on_lbn_selcancel is
			-- Cancel the selection.
		do
			if not multiple_selection_enabled then
				notify_deselect (last_selected_item.interface)
				last_selected_item := Void
			end
		end

	notify_deselect (i: EV_LIST_ITEM) is
			-- Call action sequences related to deselection of `i'.
		require
			i_not_void: i /= Void
		do
			i.deselect_actions.call ([])
			interface.deselect_actions.call ([i])
		end

	notify_select (i: EV_LIST_ITEM) is
			-- Call action sequences related to selection of `i'.
		require
			i_not_void: i /= Void
		do
			i.select_actions.call ([])
			interface.select_actions.call ([i])
		end

	on_key_down (virtual_key, key_data: INTEGER) is
			-- A key has been pressed
		do
			{EV_PRIMITIVE_IMP} Precursor (virtual_key, key_data)
			process_tab_key (virtual_key)
		end

	on_size (size_type, a_height, a_width: INTEGER) is
			-- List resized.
		do
			current_list.on_size (size_type, a_height, a_width)
			interface.resize_actions.call ([screen_x, screen_y, a_width,
				height])
		end

	on_mouse_move (keys, x_pos, y_pos: INTEGER) is
			-- Executed when the mouse move.
		local
			it: EV_LIST_ITEM_IMP
			pt: WEL_POINT
			offets: TUPLE [INTEGER, INTEGER]
		do
			it := find_item_at_position (x_pos, y_pos)
			pt := client_to_screen (x_pos, y_pos)
			if it /= Void then
				it.interface.pointer_motion_actions.call ([x_pos, y_pos -
					it.relative_y, 0.0, 0.0, 0.0, pt.x, pt.y])
			end
			if pnd_item_source /= Void then
				pnd_item_source.pnd_motion (x_pos, y_pos, pt.x, pt.y)
			end
			{EV_PRIMITIVE_IMP} Precursor (keys, x_pos, y_pos)
		end 

	wel_background_color: WEL_COLOR_REF is
		do
			Result := background_color_imp
		end

	wel_foreground_color: WEL_COLOR_REF is
		do
			Result := foreground_color_imp
		end

feature {NONE} -- Feature that should be directly implemented by externals

	next_dlgtabitem (hdlg, hctl: POINTER; previous: BOOLEAN): POINTER is
			-- Encapsulation of the SDK GetNextDlgTabItem,
			-- because we cannot do a deferred feature become an
			-- external feature.
		do
			Result := current_list.cwin_get_next_dlgtabitem (hdlg, hctl, previous)
		end

	next_dlggroupitem (hdlg, hctl: POINTER; previous: BOOLEAN): POINTER is
			-- Encapsulation of the SDK GetNextDlgGroupItem,
			-- because we cannot do a deferred feature become an
			-- external feature.
		do
			check
				Never_called: False
			end
		end

	mouse_message_x (lparam: INTEGER): INTEGER is
			-- Encapsulation of the c_mouse_message_x function of
			-- WEL_WINDOW. Normaly, we should be able to have directly
			-- c_mouse_message_x deferred but it does not wotk because
			-- it would be implemented by an external.
		do
			Result := current_list.c_mouse_message_x (lparam)
		end

	mouse_message_y (lparam: INTEGER): INTEGER is
			-- Encapsulation of the c_mouse_message_x function of
			-- WEL_WINDOW. Normaly, we should be able to have directly
			-- c_mouse_message_x deferred but it does not wotk because
			-- it would be implemented by an external.
		do
			Result := current_list.c_mouse_message_y (lparam)
		end

	show_window (hwnd: POINTER; cmd_show: INTEGER) is
			-- Encapsulation of the cwin_show_window function of
			-- WEL_WINDOW. Normaly, we should be able to have directly
			-- c_mouse_message_x deferred but it does not wotk because
			-- it would be implemented by an external.
		do
			current_list.cwin_show_window (hwnd, cmd_show)
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_LIST

end -- class EV_LIST_IMP

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
--| Revision 1.67  2000/04/18 02:30:19  pichery
--| Refactored class. Replaced Inheritance by Delegation.
--| Inheriting from WEL_SINGLE_SELECTION_LIST_BOX
--| and WEL_MULTIPLE_SELECTION_LIST_BOX at the
--| same time in not possible due to invariant conflict.
--|
--| Revision 1.66  2000/04/17 23:32:02  rogers
--| Fixed bug in find_item_at_position.
--|
--| Revision 1.65  2000/04/11 23:56:03  brendel
--| Fixed cut/paste error.
--|
--| Revision 1.64  2000/04/11 19:01:25  brendel
--| Removed resolved FIXME's.
--| Formatted for 80 columns.
--|
--| Revision 1.63  2000/04/11 16:59:51  rogers
--| Removed direct inheritance from EV_PICK_AND_DROPABLE_ITEM_HOLDER_IMP.
--|
--| Revision 1.62  2000/04/05 21:16:12  brendel
--| Merged changes from LIST_REFACTOR_BRANCH.
--|
--| Revision 1.61  2000/04/05 20:06:57  rogers
--| Added temporary compiler bug fix.
--|
--| Revision 1.60  2000/04/05 18:35:07  rogers
--| Recreate_list now correctly stores the existing attributes
--| of the windows object before destroying it, and then creating
--| a new object with these attributes.
--|
--| Revision 1.59  2000/03/31 19:07:44  rogers
--| Remove FIXME as it has been fixed.
--| Internal_propagate_pointer_press now propagates correct button.
--|
--| Revision 1.58  2000/03/31 00:26:11  rogers
--| Removed on_left_button_down, on_middle_button_down and
--| on_right_button_down as they are now inherited from
--| EV_PICK_AND_DROPABLE_ITEM_HOLDER_IMP
--|
--| Revision 1.57  2000/03/30 19:58:02  rogers
--| Now inherits from EV_PICK_AND_DROPABLE_ITEM_HOLDER_IMP.
--| Removed features and attributes associated with source of PND as
--| these are now inherited, and fixed references to these.
--|
--| Revision 1.56.2.2  2000/04/05 19:57:16  brendel
--| Added compiler hack. See code.
--|
--| Revision 1.56.2.1  2000/04/03 18:24:40  brendel
--| Renamed count as wel_count.
--|
--| Revision 1.56  2000/03/30 17:43:56  brendel
--| Moved common features with EV_COMBO_BOX up to EV_LIST_ITEM_LIST_IMP.
--|
--| Revision 1.55  2000/03/29 22:12:11  brendel
--| Added `set_item_imp_text'.
--| Improved contracts.
--|
--| Revision 1.54  2000/03/29 20:31:03  brendel
--| Added is_item_imp_selected, select_item_imp and deselect_item_imp.
--|
--| Revision 1.53  2000/03/29 02:20:47  brendel
--| Revised. Cleaned up.
--| Now inherits from WEL_SINGLE_SELECTION_LIST_BOX and
--| WEL_MULTIPLE_SELECTION_LIST_BOX. Features applying to multiple selection
--| start with ms_* and single sel. with ss_*.
--|
--| Revision 1.52  2000/03/24 19:14:52  rogers
--| Redefined initialize from EV_LIST_ITEM_HOLDER_IMP.
--|
--| Revision 1.51  2000/03/21 01:25:54  rogers
--| Renamed child_source -> pnd_child_source, set_child_source ->
--| set_pnd_child_source. Added pnd_press.
--|
--| Revision 1.50  2000/03/17 23:40:34  rogers
--| Added the following features: list_is_pnd_source, child_source,
--| set_child_Source, set_source_true, set_source_false. These fatures are
--| now being reviewed and will be modified further. Implemented on_mouse_move
--| and pnd_press.
--|
--| Revision 1.49  2000/03/15 17:06:36  rogers
--| Removed commented code. Added internal_propagate_pointer_press,
--| on_left_button_down, on_middle_button_down, on_right_button_down.
--| Removed on_lbn_dblclick.
--|
--| Revision 1.47  2000/03/14 23:53:09  rogers
--| Redefined on_mouse_move from EV_PRIMITIVE_IMP so items events can be
--| called. Added find_item_at_position.
--|
--| Revision 1.46  2000/03/14 19:24:14  rogers
--| renamed
--| 	move -> wel_move
--| 	height -> wel_height
--| 	x -> x_position
--| 	y -> y_position
--| 	resize -> wel_resize
--| 	move_and_resize -> wel_move_and_resize
--|
--| Revision 1.45  2000/03/07 17:53:53  rogers
--| Redefined on_size from WEL_LIST_BOX, so the resize_actions can be called.
--|
--| Revision 1.44  2000/03/07 00:11:56  rogers
--| The select actions are now always called on the child first before the
--| list
--|
--| Revision 1.43  2000/03/06 20:47:36  rogers
--| The list select and deselect action sequences now only return the selected
--| item, so any calls to these action sequences have been modified.
--|
--| Revision 1.42  2000/02/29 23:13:24  rogers
--| Removed selected_item as it is no longer platform dependent, it now comes
--| from EV_LIST_I.
--|
--| Revision 1.41  2000/02/29 19:35:21  rogers
--| Selected item now returns the first item that is selected in the list when
--| multiple selection is enabled.
--|
--| Revision 1.40  2000/02/25 21:41:12  rogers
--| In on_lbn_selchange, added code to handle the possibility of an item
--| being destroyed within an action sequence.
--|
--| Revision 1.39  2000/02/25 00:34:41  rogers
--| Clear selection, will only now call on_lbn_selchange when not in
--| multiple_selection mode when there was an item selected. Fixes bug where
--| an attempt to call the events on last_selected_item when it is Void
--| last.interface.deselect_actions.call ([])
--|
--| Revision 1.38  2000/02/24 21:18:58  rogers
--| Connected the select and de-select events to the list when in single
--| selection mode. Multiple selection mode still needs connecting.
--|
--| Revision 1.37  2000/02/19 05:45:01  oconnor
--| released
--|
--| Revision 1.36  2000/02/14 11:40:44  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.35.6.9  2000/02/10 18:01:12  rogers
--| Removed the old command association. Implemented part of the new event
--| system calls.
--|
--| Revision 1.35.6.8  2000/02/09 17:36:49  rogers
--| Altered inheritence of interface. Now redefined and selected from
--| EV_LIST_I, redefined from EV_LIST_ITEM_HOLDER_IMP, and renamed to
--| ev_primitive_imp_interface from EV_PRIMITIVE_IMP.
--|
--| Revision 1.35.6.7  2000/02/02 20:49:50  rogers
--| Altered the inheritcance of interfaces slightly. See diff.
--|
--| Revision 1.35.6.6  2000/01/27 19:30:27  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.35.6.5  2000/01/25 17:37:52  brendel
--| Removed code associated with old events.
--| Implementation and more removal is needed.
--|
--| Revision 1.35.6.4  2000/01/18 23:32:45  rogers
--| Renamed
--| 	set_single_selection -> disable_multiple_selection
--| 	set_multiple_selection -> enable_multiple_selection
--| 	is_multiple_selection -> multiple_selection_enabled
--|
--| Revision 1.35.6.3  2000/01/15 01:47:40  rogers
--| Modified to comply with the major vision2 changes. For redefinitions, see
--| diff. Implemanted interface.
--|
--| Revision 1.35.6.2  1999/12/17 00:38:43  rogers
--| Altered to fit in with the review branch. Basic alterations, redefinitaions
--| of name clashes etc. Make now takes an interface.
--|
--| Revision 1.35.6.1  1999/11/24 17:30:32  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.35.2.2  1999/11/02 17:20:09  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------

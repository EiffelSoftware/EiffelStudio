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
		redefine
			interface,
			selected_item,
			selected_items
		end
		
	EV_ITEM_LIST_IMP [EV_LIST_ITEM]
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

 	WEL_LIST_VIEW
		rename
			make as wel_make,
			parent as wel_window_parent,
			destroy as wel_destroy,
			shown as is_displayed,
			set_parent as wel_set_parent,
			font as wel_font,
			set_font as wel_set_font,
			move as wel_move,
			item as wel_item,
			enabled as is_sensitive,
			width as wel_width,
			height as wel_height,
			x as x_position,
			y as y_position,
			resize as wel_resize,
			move_and_resize as wel_move_and_resize,
			count as wel_count,
			selected_items as wel_selected_items,
			selected_item as wel_selected_item,
			insert_item as wel_insert_item
		undefine
			window_process_message,
			remove_command,
			set_width,
			set_height,
			on_left_button_down,
			on_right_button_down,
			on_left_button_up,
			on_right_button_up,
			on_left_button_double_click,
			on_right_button_double_click,
			on_mouse_move,
			on_key_down,
			on_key_up,
			on_set_focus,
			on_kill_focus,
			on_set_cursor,
			show,
			hide
		redefine
			on_lvn_itemchanged,
			on_size,
			default_ex_style,
			default_style
		end

	WEL_LVHT_CONSTANTS
		export
			{NONE} all
		end

creation
	make
	
feature {NONE} -- Initialization
	
	make (an_interface: like interface) is         
			-- Create list as single selection.
		local
			wel_lv_column: WEL_LIST_VIEW_COLUMN
		do
			base_make (an_interface)
			create ev_children.make (2)
			create internal_selected_items.make (2)

				-- Create the WEL LISTVIEW.
			wel_make (Default_parent, 0, 0, 0, 0, 0)
			create wel_lv_column.make
			append_column (wel_lv_column)
		end	

	initialize is
		do
			{EV_PRIMITIVE_IMP} Precursor
			{EV_ITEM_LIST_IMP} Precursor
		end

feature -- Access

	wel_parent: WEL_WINDOW is
			--|---------------------------------------------------------------
			--| FIXME ARNAUD
			--|---------------------------------------------------------------
			--| Small hack in order to avoid a SEGMENTATION VIOLATION
			--| with Compiler 4.6.008. To remove the hack, simply remove
			--| this feature and replace "parent as wel_window_parent" with
			--| "parent as wel_parent" in the inheritance clause of this class
			--|---------------------------------------------------------------
		do
			Result := wel_window_parent
		end

	multiple_selection_enabled: BOOLEAN
			-- Can more than one item be selected?

	selected_item: EV_LIST_ITEM is
			-- Currently selected item.
			-- Topmost selected item if multiple items are selected.
			-- (For multiple selections see `selected_items')
			--
			-- Void if there is no selection
		local
			local_selected_index: INTEGER
		do
			local_selected_index := wel_selected_item
			if local_selected_index > 0 then
				Result := (ev_children @ (local_selected_index + 1)).interface
			end
		end

	selected_items: ARRAYED_LIST [EV_LIST_ITEM] is
			-- Currently selected items.
		do
			Result := clone (internal_selected_items)
		ensure then
			internal_selected_items_uptodate implies 
				Result.is_equal (retrieve_selected_items)
		end

feature -- Status setting

	select_item (an_index: INTEGER) is
			-- Select item at `an_index'.
		do
			(ev_children @ an_index).enable_select
		end

	deselect_item (an_index: INTEGER) is
			-- Deselect item at `an_index'.
		do
			(ev_children @ an_index).disable_select
		end

	clear_selection is
			-- Make `selected_items' empty.
		local
			local_selected_items: like selected_items
		do
			local_selected_items := internal_selected_items
			from 
			until
				local_selected_items.empty
			loop
				local_selected_items.first.disable_select
			end
		end

	enable_multiple_selection is
			-- Allow more than one item to be selected.
		do
			if not multiple_selection_enabled then
				set_style (default_style - Lvs_singlesel)
				multiple_selection_enabled := True
			end
		end

	disable_multiple_selection is
			-- Allow only one item to be selected.
		local
			old_selected_item: EV_LIST_ITEM
		do
			if multiple_selection_enabled then
					-- Unselect all selected and remember the top
					-- most selected item.
				old_selected_item := selected_item
				clear_selection

					-- Set the new style
				set_style (default_style)
				multiple_selection_enabled := False

					-- Reselect the top most item
				if old_selected_item /= Void then
					old_selected_item.enable_select
				end
			end
		end

feature {EV_LIST_ITEM_IMP} -- Implementation

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

feature {EV_LIST_ITEM_I} -- Implementation

	insert_item (item_imp: EV_LIST_ITEM_IMP; an_index: INTEGER) is
			-- Insert `item_imp' at `an_index'.
		local
			list: LINKED_LIST [STRING]
			litem: WEL_LIST_VIEW_ITEM
			rw: INTEGER
			first_string: STRING
		do
			create litem.make
			litem.set_text (item_imp.text)
			litem.set_iitem (an_index - 1)
			wel_insert_item (litem)
			set_column_width (-1, 0) -- Autosize
		end

	remove_item (item_imp: EV_LIST_ITEM_IMP) is
			-- Remove `item' from the list
		local
			an_index: INTEGER
		do
			an_index := ev_children.index_of (item_imp, 1) - 1
			delete_item (an_index)
			set_column_width (-1, 0) -- Autosize
		end

	internal_get_index (item_imp: EV_LIST_ITEM_IMP): INTEGER is
			-- Return the index of `item' in the list.
		do
			Result := ev_children.index_of (item_imp, 1)
		end

	internal_is_selected (item_imp: EV_LIST_ITEM_IMP): BOOLEAN is
			-- Is `item_imp' selected in the list?
		local
			i: INTEGER
		do
			i := ev_children.index_of (item_imp, 1) - 1
			i := get_item_state (i, Lvis_selected)
			Result := flag_set (i, Lvis_selected)
		end

	internal_select (item_imp: EV_LIST_ITEM_IMP) is
			-- Select `item_imp' in the list.
		local
			i, flags: INTEGER
			litem: WEL_LIST_VIEW_ITEM
		do
			i := ev_children.index_of (item_imp, 1) - 1
			create litem.make_with_attributes (Lvif_state, i, 0, 0, "")
			litem.set_state (Lvis_selected)
			litem.set_statemask (Lvis_selected)	
			cwin_send_message (wel_item, Lvm_setitemstate, i,
				litem.to_integer)
		end

	internal_deselect (item_imp: EV_LIST_ITEM_IMP) is
			-- Deselect `item_imp' in the list.
		local
			i, flags: INTEGER
			litem: WEL_LIST_VIEW_ITEM
		do
			i := ev_children.index_of (item_imp, 1) - 1
			create litem.make_with_attributes (Lvif_state, i, 0, 0, "")
			litem.set_state (0)
			litem.set_statemask (Lvis_selected)	
			cwin_send_message (wel_item, Lvm_setitemstate, i,
				litem.to_integer)
		end

feature {EV_ANY_I} -- Implementation

	find_item_at_position (x_pos, y_pos: INTEGER): EV_LIST_ITEM_IMP is
			-- Result is list item at pixel position `x_pos', `y_pos'.
		local
			pt: WEL_POINT
			info: WEL_LV_HITTESTINFO
		do
			create pt.make (x_pos, y_pos)
			create info.make_with_point (pt)
			cwin_send_message (wel_item, Lvm_hittest, 0, info.to_integer)
			if flag_set (info.flags, Lvht_onitemlabel)
			or flag_set (info.flags, Lvht_onitemicon)
			then
				Result := ev_children @ (info.iitem + 1)
			end
		end

	default_style: INTEGER is
			-- Default style of the list.
		once
			Result := Ws_visible + Ws_child + Ws_group + Ws_tabstop
				+ Ws_border + Ws_clipchildren + Lvs_showselalways
				+ Lvs_nocolumnheader
				+ Lvs_report
				+ Lvs_singlesel
		end

	default_ex_style: INTEGER is
			-- Default extended style of the list.
		do
			Result := Ws_ex_clientedge
		end

	on_lvn_itemchanged (info: WEL_NM_LIST_VIEW) is
			-- An item has changed
		local
			item_imp: EV_LIST_ITEM_IMP
			item_interface: EV_LIST_ITEM
		do
			internal_selected_items_uptodate := False
			if info.uchanged = Lvif_state and info.isubitem = 0 then
				if flag_set(info.unewstate, Lvis_selected) and
						not flag_set(info.uoldstate, Lvis_selected) then
						-- Item is being selected
					item_imp := ev_children @ (info.iitem + 1)
					item_interface := item_imp.interface
					internal_selected_items.extend (item_interface)
					item_imp.interface.select_actions.call ([])
					interface.select_actions.call ([item_interface])

				elseif flag_set(info.uoldstate, Lvis_selected) and
					not flag_set(info.unewstate, Lvis_selected) then
						-- Item is being unselected
					item_imp := ev_children @ (info.iitem + 1)
					item_interface := item_imp.interface
					internal_selected_items.prune_all (item_interface)
					item_imp.interface.deselect_actions.call ([])
					interface.deselect_actions.call ([item_interface])
				end

			end
			internal_selected_items_uptodate := True
		end

	on_key_down (virtual_key, key_data: INTEGER) is
			-- A key has been pressed
		do
			{EV_PRIMITIVE_IMP} Precursor (virtual_key, key_data)
			process_tab_key (virtual_key)
		end

	on_size (size_type, a_width, a_height: INTEGER) is
			-- List resized.
		do
				-- Resize the first and only column.
			Precursor (size_type, a_width, a_height)
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

feature {NONE} -- Implementation

	internal_selected_items_uptodate: BOOLEAN
			-- Is `internal_selected_items' up-to-date?

	internal_selected_items: like selected_items
			-- Cached version of all selected items.

	retrieve_selected_items: like selected_items is
			-- Current selected items (non cached version)
		local
			i: INTEGER
			interf: EV_LIST_ITEM
			c: like ev_children
		do
			create Result.make (selected_count)
			c := ev_children
			from
				i := 0
			until
				i = selected_count
			loop
				interf ?= (c @ (wel_selected_items @ i + 1)).interface
				Result.extend (interf)
				Result.finish
				i := i + 1
			end		
		end

feature {NONE} -- Feature that should be directly implemented by externals

	next_dlgtabitem (hdlg, hctl: POINTER; previous: BOOLEAN): POINTER is
			-- Encapsulation of the SDK GetNextDlgTabItem,
			-- because we cannot do a deferred feature become an
			-- external feature.
		do
			Result := cwin_get_next_dlgtabitem (hdlg, hctl, previous)
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
			Result := c_mouse_message_x (lparam)
		end

	mouse_message_y (lparam: INTEGER): INTEGER is
			-- Encapsulation of the c_mouse_message_x function of
			-- WEL_WINDOW. Normaly, we should be able to have directly
			-- c_mouse_message_x deferred but it does not wotk because
			-- it would be implemented by an external.
		do
			Result := c_mouse_message_y (lparam)
		end

	show_window (hwnd: POINTER; cmd_show: INTEGER) is
			-- Encapsulation of the cwin_show_window function of
			-- WEL_WINDOW. Normaly, we should be able to have directly
			-- c_mouse_message_x deferred but it does not wotk because
			-- it would be implemented by an external.
		do
			cwin_show_window (hwnd, cmd_show)
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
--| Revision 1.71  2000/04/19 02:03:57  pichery
--| Fixed a small display bug
--|
--| Revision 1.69  2000/04/18 21:22:45  pichery
--| MAJOR CHANGE:
--| - Changed the implementation of EV_LIST_IMP. It now
--| inherit from WEL_LIST_VIEW instead of WEL_LIST_BOX.
--|
--| - fixed all waiting problems.
--|
--| --> Ready for review
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

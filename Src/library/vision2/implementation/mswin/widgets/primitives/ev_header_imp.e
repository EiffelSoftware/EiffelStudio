indexing
	description: "Objects that represent an EiffelVision header control. Mswin Implementation."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_HEADER_IMP
	
inherit
	EV_HEADER_I
		redefine
			interface
		end
		
	EV_ITEM_LIST_IMP [EV_HEADER_ITEM, EV_HEADER_ITEM_IMP]
		redefine
			interface,
			initialize
		end
	
	EV_PRIMITIVE_IMP
		redefine
			interface,
			initialize,
			destroy
		end
		
	EV_FONTABLE_IMP
		redefine
			interface,
			initialize
		end
		
	WEL_HEADER_CONTROL
		rename
			make as wel_make,
			parent as wel_parent,
			set_parent as wel_set_parent,
			shown as is_displayed,
			destroy as wel_destroy,
			item as wel_item,
			enabled as is_sensitive,
			width as wel_width,
			height as wel_height,
			x as x_position,
			y as y_position,
			move as wel_move,
			resize as wel_resize,
			move_and_resize as wel_move_and_resize,
			text as wel_text,
			set_text as wel_set_text,
			font as wel_font,
			set_font as wel_set_font,
			has_capture as wel_has_capture
		undefine
			set_width,
			set_height,
			on_left_button_down,
			on_middle_button_down,
			on_right_button_down,
			on_left_button_up,
			on_middle_button_up,
			on_right_button_up,
			on_left_button_double_click,
			on_middle_button_double_click,
			on_right_button_double_click,
			on_mouse_move,
			on_mouse_wheel,
			on_set_focus,
			on_desactivate,
			on_kill_focus,
			on_key_down,
			on_key_up,
			on_char,
			on_set_cursor,
			on_size,
			show,
			hide,
			x_position,
			y_position,
			on_sys_key_down,
			on_sys_key_up,
			default_process_message
		redefine
			on_hdn_begin_track,
			on_hdn_track,
			on_hdn_end_track,
			on_hdn_item_changed,
			on_hdn_item_changing
		end
		
	EV_HEADER_ACTION_SEQUENCES_IMP
		export
			{NONE} all
		end
		
	EV_SHARED_IMAGE_LIST_IMP
		export
			{NONE} all
		end
	
create
	make

feature {NONE} -- Initialization

	make (an_interface: like interface) is
			-- Create `Current' with interface `an_interface'.
		do
			base_make (an_interface)
			wel_make (default_parent, 0, 0, 0, 0, 0)
			create ev_children.make (2)
			initialize_pixmaps
		end
		
	initialize is
			-- Initialize `Current'.
		do
			Precursor {EV_PRIMITIVE_IMP}
			Precursor {EV_ITEM_LIST_IMP}
			set_default_font
		end
		
feature -- Status report
		
	ev_children: ARRAYED_LIST [EV_HEADER_ITEM_IMP]
			-- List of the children.

feature -- Status setting

	refresh_item (item_imp: EV_HEADER_ITEM_IMP) is
			-- Refresh `item_imp'.
		require
			item_not_void: item_imp /= Void
		do
				-- Note that one is subtracted as the wel index is zero based.
			set_header_item (ev_children.index_of (item_imp, 1) - 1, item_imp)
		end

feature -- Element change

	insert_item (item_imp: EV_HEADER_ITEM_IMP; an_index: INTEGER) is
			-- Insert `item_imp' at `an_index'.
		do
			insert_header_item (item_imp, an_index - 1)
			if item_imp.pixmap /= Void then
				set_item_pixmap (item_imp, item_imp.pixmap)
			end
		end
		
feature -- Removal

	remove_item (item_imp: EV_HEADER_ITEM_IMP) is
			-- Remove `item' from the list
		local
			an_index: INTEGER
		do
			an_index := ev_children.index_of (item_imp, 1) - 1			
			delete_header_item (an_index)
		end

feature -- Miscellaneous

	find_item_at_position (x_pos, y_pos: INTEGER): EV_HEADER_ITEM_IMP is
			-- `Result' is list item at pixel position `x_pos', `y_pos'.
		local
		do
		end

feature {EV_ANY_I}

	interface: EV_HEADER
	
feature {EV_HEADER_ITEM_IMP} -- Implementation

	image_list: EV_IMAGE_LIST_IMP
		-- Image list associated with `Current'.
		-- `Void' if none.
		
	set_item_pixmap (v: EV_HEADER_ITEM_IMP; a_pixmap: EV_PIXMAP) is
			-- Assign `a_text' to the label for `an_item'.
		require else
			has_an_item: has (v.interface)
		do
			if a_pixmap /= Void then
				if image_list = Void then
						-- If no image list is associated with `Current', retrieve
						-- and associate one.
					image_list := get_imagelist_with_size (pixmaps_width, pixmaps_height)
					set_image_list (image_list)
				end
				image_list.add_pixmap (a_pixmap)
					-- Set the `iimage' to the index of the image to be used
					-- from the image list.
				v.set_iimage (image_list.last_position)
			else
				v.set_mask (clear_flag (v.mask, feature {WEL_HDI_CONSTANTS}.hdi_image))
				v.set_format (clear_flag (v.format, feature {WEL_HDF_CONSTANTS}.hdf_image))
			end
			refresh_item (v)
		end
		
	pixmaps_size_changed is
			-- The size of the displayed pixmaps has just
			-- changed.
		local
			l_cursor: CURSOR
			l_item: EV_HEADER_ITEM_IMP
		do
			if image_list /= Void then
				set_image_list (Void)
				image_list := Void
			end
			l_cursor := ev_children.cursor
			from
				ev_children.start
			until
				ev_children.off
			loop
				l_item := ev_children.item	
				if l_item.pixmap_imp /= Void then
					set_item_pixmap (l_item, l_item.pixmap_imp.interface)
				else
					set_item_pixmap (l_item, Void)
				end
				ev_children.forth
			end
			ev_children.go_to (l_cursor)
		end
	
feature {NONE} -- Implementation

	destroy is
			-- Destroy `Current'.
		do
			interface.wipe_out
			Precursor {EV_PRIMITIVE_IMP}
		end

	on_hdn_begin_track (info: WEL_HD_NOTIFY) is
			-- The user has begun dragging a divider in the control 
			-- (that is, the user has pressed the left mouse button while 
			-- the mouse cursor is on a divider in the header control). 
		local
			header_item: EV_HEADER_ITEM_IMP
		do
			if item_resize_start_actions_internal /= Void then
				header_item := ev_children @ (info.item_index + 1)
				item_resize_start_actions_internal.call ([header_item.interface])
			end
		end

	on_hdn_track (info: WEL_HD_NOTIFY) is
			-- The user is dragging a divider in the header control. 
		local
			header_item: EV_HEADER_ITEM_IMP
		do
			if item_resize_actions_internal /= Void then
				header_item := ev_children @ (info.item_index + 1)
				item_resize_actions_internal.call ([header_item.interface])
			end
		end

	on_hdn_end_track (info: WEL_HD_NOTIFY) is
			-- The user has finished dragging a divider. 
		local
			header_item: EV_HEADER_ITEM_IMP
		do
			if item_resize_end_actions_internal /= Void then
				header_item := ev_children @ (info.item_index + 1)
				item_resize_end_actions_internal.call ([header_item.interface])
			end
		end
	
	on_hdn_item_changing (info: WEL_HD_NOTIFY) is
			-- The attributes of a header are changing.
			-- (from WEL_HEADER_CONTROL)
		do
			
		end
		
	on_hdn_item_changed (info: WEL_HD_NOTIFY) is
			-- The attributes of a header item have changed.
			-- (from WEL_HEADER_CONTROL)
		do
			(ev_children.i_th (info.item_index + 1)).set_item (info.header_item.item)
		end

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

	show_window (hwnd: POINTER; cmd_show: INTEGER) is
			-- Encapsulation of the cwin_show_window function of
			-- WEL_WINDOW. Normaly, we should be able to have directly
			-- c_mouse_message_x deferred but it does not wotk because
			-- it would be implemented by an external.
		do
			cwin_show_window (hwnd, cmd_show)
		end

invariant
	invariant_clause: True -- Your invariant here

end -- class EV_HEADER_IMP

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
--| Copyright (C) 1985-2004 Eiffel Software. All rights reserved.
--| Duplication and distribution prohibited.  May be used only with
--| ISE Eiffel, under terms of user license.
--| Contact Eiffel Software for any other use.
--|
--| Interactive Software Engineering Inc.
--| dba Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Contact us at: http://www.eiffel.com/general/email.html
--| Customer support: http://support.eiffel.com
--| For latest info on our award winning products, visit:
--|	http://www.eiffel.com
--|----------------------------------------------------------------

indexing
	description: "A header control is a window that is usually positioned%
					 %above columns of text or numbers. It contains a title for%
					 %each column, and it can be divided into parts. The user%
					 %can drag the dividers that separate the parts to set the%
					 %width of each column."
	note: "The common controls dll (WEL_COMMON_CONTROLS_DLL) needs to %
		%be loaded to use this control."
		
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_HEADER_CONTROL

inherit
	WEL_CONTROL
		redefine
			process_notification_info
		end

	WEL_BIT_OPERATIONS

	WEL_HDI_CONSTANTS
		export
			{NONE} all
		end

	WEL_HDF_CONSTANTS
		export
			{NONE} all
		end
		
	WEL_HDM_CONSTANTS
		export
			{NONE} all
		end

	WEL_HDS_CONSTANTS
		export
			{NONE} all
		end

	WEL_HDN_CONSTANTS
		export
			{NONE} all
		end

creation
	make,
	make_by_id

feature {NONE} -- Initialization

	make (a_parent: WEL_WINDOW; a_x, a_y, a_width, a_height,
				an_id: INTEGER) is
			-- Make a header control.
			-- `a_x', `a_y', `a_width', `a_height' will not neccesarily
			-- determine the the size of the control. Rather the
			-- operating system will be asked which size the control
			-- should have, given `a_x', etc. is the client rectangle of
			-- the controls parent window
		require
			a_parent_not_void: a_parent /= Void
		local
			a_rect: WEL_RECT
		do

				-- Creating the window
				-- Note: The creation is done in 2 steps.
				-- First the window is created invisible,
				-- then the system is beeing asked for the
				-- size of the control. Thus we temporarily
				-- remove Ws_visible from default_style if
				-- present. In the second step the window
				-- will be made visible in case default_style
				-- includes Ws_visible.
			internal_window_make (a_parent, Void,
										 clear_flag (default_style, Ws_visible), 
										 0, 0, 0, 0,
										 an_id, default_pointer)
			id := an_id
			
			create a_rect.make (a_x, a_y, a_x + a_width, a_y + a_height)

				-- Let the operating system determine the exact window position and size
			retrieve_and_set_windows_pos (a_rect)
		ensure
			exists: exists
			parent_set: parent = a_parent
			id_set: id = an_id
		end

feature -- Status report
	item_count: INTEGER is
			-- Retrieves the number of items that are in the header control
		require
			exists: exists
		do
			Result := cwin_send_message_result(item, Hdm_get_item_count, 0, 0); 
			check
				successfull: Result /= -1
			end
		ensure
			positive_result: Result >= 0
		end

	valid_index (index: INTEGER): BOOLEAN is
		do
			Result := (index >= 0) and (index < item_count)
		end

	item_info_from_point (a_point: WEL_POINT): WEL_HD_HIT_TEST_INFO is
			-- Tests a point to determine which header item, if any, is at the specified point.
		require
			exists: exists
			a_point_exists: a_point /= Void and then a_point.exists
		local
			i_result: INTEGER
			hit_test_info: WEL_HD_HIT_TEST_INFO
		do
			create hit_test_info.make
			hit_test_info.set_point (a_point)
			i_result := cwin_send_message_result (item, Hdm_hit_test, 0, 
															cwel_pointer_to_integer (hit_test_info.item)); 
		end

feature -- Status setting

feature -- Element change

	insert_text_header_item (a_label: STRING; a_width, a_format: INTEGER; insert_after_item_no: INTEGER) is
			-- Insert a text item to the header control after the
			-- `insert_item_item_no' item. If there is no item in the list
			-- yet, or you want to insert the new item as the first
			-- one, use use 0 for `insert_item'
			-- The item will be `a_width' broad and use 'a_format` as format.
			-- For possible formats please look into WEL_HDF_CONSTANTS.
			-- (Hdf_string will be set automatically)
		require
			exists: exists
			label_not_void: a_label /= Void
			insert_after_item_no_positive: insert_after_item_no >= 0
		local
			hd_item: WEL_HD_ITEM
		do
			create hd_item.make
			hd_item.set_text (a_label)
			hd_item.set_width (a_width)
			hd_item.set_format (a_format)

			insert_header_item (hd_item, insert_after_item_no)
		ensure
			item_count_increased: item_count = old item_count + 1			
		end

	insert_header_item (hd_item: WEL_HD_ITEM; insert_after_item_no: INTEGER) is
			-- Insert an item to the header control after the
			-- `insert_item_item_no' item. If there is no item in the list
			-- yet, or you want to insert the new item as the first
			-- one, use use 0 for `insert_item'
		require
			exists: exists
			hd_item_not_void: hd_item /= Void
			insert_after_item_no_positive: insert_after_item_no >= 0
		local
			i_result: INTEGER
		do
			i_result := cwin_send_message_result(item, Hdm_insert_item, insert_after_item_no, cwel_pointer_to_integer (hd_item.item)); 
			check
				successfull: i_result /= -1
			end
		ensure
			item_count_increased: item_count = old item_count + 1			
		end
		
	delete_header_item (index: INTEGER) is
			-- delete item from header control at index `index'
		require
			exists: exists
			valid_index: valid_index (index)
		local
			i_result: INTEGER
		do
			i_result := cwin_send_message_result(item, Hdm_delete_item, index, 0); 
			check
				successfull: i_result /= -1
			end
		ensure
			item_count_decreased: item_count = old item_count - 1			
		end
		
	set_header_item (index: INTEGER; hd_item: WEL_HD_ITEM) is
			-- This windows message sets the attributes of the specified item in a header control. 
		require
			exists: exists
			hd_item_exists: hd_item /= Void and then hd_item.exists
			valid_index: valid_index (index)
		local
			i_result: INTEGER
		do
			i_result := cwin_send_message_result(item, Hdm_set_item, index, cwel_pointer_to_integer (hd_item.item))
			check
				successfull: i_result /= 0
			end
		end

	retrieve_and_set_windows_pos (parent_client_rect: WEL_RECT) is
			-- Asks the OS for the window position and size,
			-- given the parents client area is `parent_client_rect' 
		require
			exists: exists
			rect_exists: parent_client_rect /= Void and then parent_client_rect.exists
		local
			window_handle_insert_after: POINTER
			a_window_style: INTEGER
		do
			send_layout_message (parent_client_rect)

				-- Set the size we got from windows
				-- Only use the `window_insert_after' field if it is not Void
			if
				last_retrieved_window_pos.window_insert_after /= Void
			then
				window_handle_insert_after := last_retrieved_window_pos.window_insert_after.item
			end

			a_window_style :=	last_retrieved_window_pos.flags
				--	If Ws_visible is set in `default_style' make the window now
				-- visible.
			if
				flag_set (default_style, Ws_visible)
			then
				a_window_style := set_flag (a_window_style, Swp_showwindow)
			end

				-- Set the initial window position				
			cwin_set_window_pos (item, window_handle_insert_after,
										last_retrieved_window_pos.x, last_retrieved_window_pos.y,
										last_retrieved_window_pos.width, last_retrieved_window_pos.height,
										a_window_style)
		end

feature -- Notifications

	on_hdn_begin_track (info: WEL_HD_NOTIFY) is
			-- The user has begun dragging a divider in the control 
			-- (that is, the user has pressed the left mouse button while 
			-- the mouse cursor is on a divider in the header control). 
		require
			exists: exists
			info_exists: info /= Void and then info.exists
		do
		end

	on_hdn_track (info: WEL_HD_NOTIFY) is
			-- The user is dragging a divider in the header control. 
		require
			exists: exists
			info_exists: info /= Void and then info.exists
		do
		end

	on_hdn_end_track (info: WEL_HD_NOTIFY) is
			-- The user has finished dragging a divider. 
		require
			exists: exists
			info_exists: info /= Void and then info.exists
		do
		end

	on_hdn_divider_dbl_click (info: WEL_HD_NOTIFY) is
			-- The user double-clicked the divider area of the control.
		require
			exists: exists
			info_exists: info /= Void and then info.exists
		do
		end

	on_hdn_item_changed (info: WEL_HD_NOTIFY) is
			-- The attributes of a header item have changed.
		require
			exists: exists
			info_exists: info /= Void and then info.exists
		do
		end

	on_hdn_item_changing (info: WEL_HD_NOTIFY) is
			-- The attributes of a header item are about to change.
		require
			exists: exists
			info_exists: info /= Void and then info.exists
		do
		end

	on_hdn_item_click (info: WEL_HD_NOTIFY) is
			-- The user clicked the control. 
		require
			exists: exists
			info_exists: info /= Void and then info.exists
		do
		end

	on_hdn_item_dbl_click (info: WEL_HD_NOTIFY) is
			-- The user double-clicked the control. 
		require
			exists: exists
			info_exists: info /= Void and then info.exists
		do
		end

feature {WEL_COMPOSITE_WINDOW} -- Implementation

	process_notification_info (notification_info: WEL_NMHDR) is
			-- Process a `notification_code' sent by Windows
			-- through the Wm_notify message
		local
			hd_notify: WEL_HD_NOTIFY
			code: INTEGER
		do
			code := notification_info.code 
  
			if code = Hdn_begin_track then
				create hd_notify.make_by_nmhdr (notification_info)
				on_hdn_begin_track (hd_notify)
			elseif code = Hdn_divider_dbl_click then
				create hd_notify.make_by_nmhdr (notification_info)
				on_hdn_divider_dbl_click (hd_notify)
			elseif code = Hdn_end_track then
				create hd_notify.make_by_nmhdr (notification_info)
				on_hdn_end_track (hd_notify)
			elseif code = Hdn_item_changed then
				create hd_notify.make_by_nmhdr (notification_info)
				on_hdn_item_changed (hd_notify)
			elseif code = Hdn_item_changing then
				create hd_notify.make_by_nmhdr (notification_info)
				on_hdn_item_changing (hd_notify)
			elseif code = Hdn_item_click then
				create hd_notify.make_by_nmhdr (notification_info)
				on_hdn_item_click (hd_notify)
			elseif code = Hdn_item_dbl_click then
				create hd_notify.make_by_nmhdr (notification_info)
				on_hdn_item_dbl_click (hd_notify)
			elseif code = Hdn_track then
				create hd_notify.make_by_nmhdr (notification_info)
				on_hdn_track (hd_notify)
			end
		end


feature {NONE} -- Implementation

	last_retrieved_window_pos: WEL_WINDOW_POS

	send_layout_message (a_rect: WEL_RECT) is
			-- This Windows message retrieves the size and position of a header control 
			-- within a given rectangle. This message is used to determine the appropriate 
			-- dimensions for a new header control that is to occupy the given rectangle. 
			-- The resulting window position will be stored in `last_retrieved_window_pos'
		require
			exists: exists
			rect_exists: a_rect /= Void and then a_rect.exists
		local
			hd_layout: WEL_HD_LAYOUT
			i_result: INTEGER
		do
			create hd_layout.make
			hd_layout.set_rectangle (a_rect)
			i_result := cwin_send_message_result(item, Hdm_layout, 0, cwel_pointer_to_integer (hd_layout.item))
			check
				successfull: i_result /= 0
			end
			last_retrieved_window_pos := hd_layout.window_pos
		ensure
			last_retrieved_window_pos_not_void: last_retrieved_window_pos /= Void
		end

	class_name: STRING is
			-- Window class name to create
		once
			create Result.make (0)
			Result.from_c (cwin_wc_header)
		end

	default_style: INTEGER is
			-- Default style used to create the control
		once
			Result := Ws_child + Ws_border + 
						 Hds_Buttons + Hds_horz + Ws_visible
		end
		
feature {NONE} -- Externals

	cwin_wc_header: POINTER is
		external
			"C [macro %"cctrl.h%"] : EIF_POINTER"
		alias
			"WC_HEADER"
		end

end -- class WEL_LIST_VIEW


--|----------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
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


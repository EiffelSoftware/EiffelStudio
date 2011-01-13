note
	description: "[
		A header control is a window that is usually positioned
		above columns of text or numbers. It contains a title for
		each column, and it can be divided into parts. The user
		can drag the dividers that separate the parts to set the
		width of each column.
		
		Note: The common controls dll (WEL_COMMON_CONTROLS_DLL) needs to
			be loaded to use this control.
		]"
	legal: "See notice at end of class."
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

create
	make,
	make_by_id

feature {NONE} -- Initialization

	make (a_parent: WEL_WINDOW; a_x, a_y, a_width, a_height,
				an_id: INTEGER)
			-- Make a header control.
			-- `a_x', `a_y', `a_width', `a_height' will not neccesarily
			-- determine the the size of the control. Rather the
			-- operating system will be asked which size the control
			-- should have, given `a_x', etc. is the client rectangle of
			-- the controls parent window
		require
			a_parent_not_void: a_parent /= Void
			a_parent_exists: a_parent.exists
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
				 0, 0, 0, 0, an_id, default_pointer)
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

	item_count: INTEGER
			-- Retrieves the number of items that are in the header control
		require
			exists: exists
		do
			Result := {WEL_API}.send_message_result_integer (item, Hdm_get_item_count,
				to_wparam (0), to_lparam (0))
			check
				successfull: Result /= -1
			end
		ensure
			positive_result: Result >= 0
		end

	valid_index (index: INTEGER): BOOLEAN
		do
			Result := (index >= 0) and (index < item_count)
		end

	item_info_from_point (a_point: WEL_POINT): WEL_HD_HIT_TEST_INFO
			-- Tests a point to determine which header item, if any, is at the specified point.
		require
			exists: exists
			a_point_exists: a_point /= Void and then a_point.exists
		do
			create Result.make
			Result.set_point (a_point)
			{WEL_API}.send_message (item, Hdm_hit_test, to_wparam (0), Result.item)
		end

	get_image_list: detachable WEL_IMAGE_LIST
			-- Get the image list associated with `Current'
			-- or `Void' if none.
		local
       		handle: POINTER
       	do
       		handle := {WEL_API}.send_message_result (item, hdm_get_image_list, to_wparam (0), to_lparam (0))
       		if handle /= default_pointer then
       			create Result.make_by_pointer(handle)
       		end
		end

feature -- Status setting

feature -- Element change

	insert_text_header_item (a_label: READABLE_STRING_GENERAL; a_width, a_format: INTEGER; insert_after_item_no: INTEGER)
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

	insert_header_item (hd_item: WEL_HD_ITEM; insert_after_item_no: INTEGER)
			-- Insert an item to the header control after the
			-- `insert_item_item_no' item. If there is no item in the list
			-- yet, or you want to insert the new item as the first
			-- one, use use 0 for `insert_item'
		require
			exists: exists
			hd_item_not_void: hd_item /= Void
			hd_item_exists: hd_item.exists
			insert_after_item_no_positive: insert_after_item_no >= 0
		local
			i_result: INTEGER
		do
			i_result := {WEL_API}.send_message_result_integer (item, Hdm_insert_item, to_wparam (insert_after_item_no), hd_item.item)
			check
				successfull: i_result /= -1
			end
		ensure
			item_count_increased: item_count = old item_count + 1
		end

	delete_header_item (index: INTEGER)
			-- delete item from header control at index `index'
		require
			exists: exists
			valid_index: valid_index (index)
		local
			i_result: INTEGER
		do
			i_result := {WEL_API}.send_message_result_integer (item, Hdm_delete_item, to_wparam (index), to_lparam (0))
			check
				successfull: i_result /= -1
			end
		ensure
			item_count_decreased: item_count = old item_count - 1
		end

	set_header_item (index: INTEGER; hd_item: WEL_HD_ITEM)
			-- This windows message sets the attributes of the specified item in a header control.
		require
			exists: exists
			hd_item_exists: hd_item /= Void and then hd_item.exists
			valid_index: valid_index (index)
		local
			i_result: INTEGER
		do
			i_result := {WEL_API}.send_message_result_integer (item, Hdm_set_item, to_wparam (index), hd_item.item)
			check
				successfull: i_result /= 0
			end
		end

	retrieve_and_set_windows_pos (parent_client_rect: WEL_RECT)
			-- Asks the OS for the window position and size,
			-- given the parents client area is `parent_client_rect'
		require
			exists: exists
			rect_exists: parent_client_rect /= Void and then parent_client_rect.exists
		local
			window_handle_insert_after: POINTER
			a_window_style: INTEGER
			l_success: BOOLEAN
			l_window_pos: WEL_WINDOW_POS
			l_window: detachable WEL_WINDOW
		do
			l_window_pos := retrieved_window_position (parent_client_rect)

				-- Set the size we got from windows
				-- Only use the `window_insert_after' field if it is not Void
			l_window := l_window_pos.window_insert_after
			if l_window /= Void then
				window_handle_insert_after := l_window.item
			end

			a_window_style :=	l_window_pos.flags
				--	If Ws_visible is set in `default_style' make the window now
				-- visible.
			if
				flag_set (default_style, Ws_visible)
			then
				a_window_style := set_flag (a_window_style, Swp_showwindow)
			end

				-- Set the initial window position				
			l_success := {WEL_API}.set_window_pos (item, window_handle_insert_after,
										l_window_pos.x, l_window_pos.y,
										l_window_pos.width, l_window_pos.height,
										a_window_style)
		end

	set_image_list (image_list: detachable WEL_IMAGE_LIST)
			-- Associate `image_list' with `Current'.
			-- If `image_list' is `Void', removes the currently associated
			-- image list (if any).
		require
			image_list_valid: image_list /= Void implies image_list.exists
		do
			if image_list = Void then
				{WEL_API}.send_message (item, hdm_set_image_list, to_wparam (0), to_lparam (0))
			else
				{WEL_API}.send_message (item, hdm_set_image_list, to_wparam (0), image_list.item)
			end
		end

feature -- Notifications

	on_hdn_begin_track (info: WEL_HD_NOTIFY)
			-- The user has begun dragging a divider in the control
			-- (that is, the user has pressed the left mouse button while
			-- the mouse cursor is on a divider in the header control).
		require
			exists: exists
			info_exists: info /= Void and then info.exists
		do
		end

	on_hdn_track (info: WEL_HD_NOTIFY)
			-- The user is dragging a divider in the header control.
		require
			exists: exists
			info_exists: info /= Void and then info.exists
		do
		end

	on_hdn_end_track (info: WEL_HD_NOTIFY)
			-- The user has finished dragging a divider.
		require
			exists: exists
			info_exists: info /= Void and then info.exists
		do
		end

	on_hdn_divider_dbl_click (info: WEL_HD_NOTIFY)
			-- The user double-clicked the divider area of the control.
		require
			exists: exists
			info_exists: info /= Void and then info.exists
		do
		end

	on_hdn_item_changed (info: WEL_HD_NOTIFY)
			-- The attributes of a header item have changed.
		require
			exists: exists
			info_exists: info /= Void and then info.exists
		do
		end

	on_hdn_item_changing (info: WEL_HD_NOTIFY)
			-- The attributes of a header item are about to change.
		require
			exists: exists
			info_exists: info /= Void and then info.exists
		do
		end

	on_hdn_item_click (info: WEL_HD_NOTIFY)
			-- The user clicked the control.
		require
			exists: exists
			info_exists: info /= Void and then info.exists
		do
		end

	on_hdn_item_dbl_click (info: WEL_HD_NOTIFY)
			-- The user double-clicked the control.
		require
			exists: exists
			info_exists: info /= Void and then info.exists
		do
		end

feature {WEL_COMPOSITE_WINDOW} -- Implementation

	process_notification_info (notification_info: WEL_NMHDR)
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

	retrieved_window_position (a_rect: WEL_RECT): WEL_WINDOW_POS
			-- This Windows message retrieves the size and position of a header control
			-- within a given rectangle. This message is used to determine the appropriate
			-- dimensions for a new header control that is to occupy the given rectangle.
		require
			exists: exists
			rect_exists: a_rect /= Void and then a_rect.exists
		local
			hd_layout: WEL_HD_LAYOUT
			i_result: INTEGER
		do
			create hd_layout.make
			hd_layout.set_rectangle (a_rect)
			i_result := {WEL_API}.send_message_result_integer (item, Hdm_layout, to_wparam (0), hd_layout.item)
			check
				successfull: i_result /= 0
			end
			Result := hd_layout.window_pos
		ensure
			last_retrieved_window_pos_not_void: Result /= Void
		end

	class_name: STRING_32
			-- Window class name to create
		once
			Result := (create {WEL_STRING}.share_from_pointer (cwin_wc_header)).string
		end

	default_style: INTEGER
			-- Default style used to create the control
		once
			Result := Ws_child + Ws_border +
						 Hds_Buttons + Hds_horz + Ws_visible
		end

feature {NONE} -- Externals

	cwin_wc_header: POINTER
		external
			"C [macro %"cctrl.h%"] : EIF_POINTER"
		alias
			"WC_HEADER"
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




end -- class WEL_LIST_VIEW


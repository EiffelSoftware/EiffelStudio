indexing
	description:
		" WEL Combo Box Ex. A more powerfull combo-box%
		% that handles bitmaps."
	note: "To use this control you need to create a%
		% WEL_INIT_COMMON_CONTROLS with the flag%
		% Icc_userex_classes in your application class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	WEL_COMBO_BOX_EX

inherit
	WEL_COMBO_BOX
		redefine
			process_notification_info,
			insert_string_at,
			default_style,
			find_string,
			add_string,
			class_name,
			add_files
		end

	WEL_CBS_CONSTANTS
		export
			{NONE} all
		end

	WEL_CBES_CONSTANTS
		export
			{NONE} all
		end

	WEL_CBEM_CONSTANTS
		export
			{NONE} all
		end

	WEL_CBEN_CONSTANTS
		export
			{NONE} all
		end

	WEL_CBEIF_CONSTANTS
		export
			{NONE} all
		end

feature -- Status report

	get_item_info (index: INTEGER): WEL_COMBO_BOX_EX_ITEM is
			-- Retrieves the information about the zero-based
			-- `index' item.
		require
			exists: exists
			index_large_enough: index >= 0
			index_small_enough: index < count
		local
			buffer: STRING
		do
			create Result.make_with_index (index)
			Result.set_mask (Cbeif_text + Cbeif_image
				+ Cbeif_selectedimage + Cbeif_overlay
				+ Cbeif_indent + Cbeif_lparam)
			create buffer.make (buffer_size)
			buffer.fill_blank
			Result.set_text (buffer)
			Result.set_cchtextmax (buffer_size)
			cwin_send_message (item, Cbem_getitem, 0, Result.to_integer)
		end

	list_shown: BOOLEAN is
			-- Is the drop down list shown?
		require
			exists: exists
		do
			Result := cwin_send_message_result (item,
				Cb_getdroppedstate, 0, 0) = 1
		end

	get_image_list: WEL_IMAGE_LIST is
       		-- Get the image list associated with this combination box.
       		-- Returns Void if none.\
       	local 
       		handle: POINTER
       	do
       		handle := cwel_integer_to_pointer ( cwin_send_message_result (item, Cbem_getimagelist, 0, 0) )
       		if handle /= default_pointer then
       			create Result.make_by_pointer(handle)
       		end
       	end

feature -- Status setting

	set_item_info (index: INTEGER; an_item: WEL_COMBO_BOX_EX_ITEM) is
			-- Sets the information about the zero-based
			-- `index' item.
		require
			exists: exists
			index_large_enough: index >= 0
			index_small_enough: index < count
		do
			cwin_send_message (item, Cbem_setitem, 0, an_item.to_integer)
		end

	show_list is
			-- Show the drop down list.
		require
			exists: exists
		do
			cwin_send_message (item, Cb_showdropdown, 1, 0)
		ensure
			list_shown: list_shown
		end

	hide_list is
			-- Hide the drop down list.
		require
			exists: exists
		do
			cwin_send_message (item, Cb_showdropdown, 0, 0)
		ensure
			list_not_shown: not list_shown
		end

	set_image_list(an_imagelist: WEL_IMAGE_LIST) is
    		-- Set the current image list to `an_imagelist'.
       		-- If `an_imagelist' is set to Void, it removes
       		-- the current associated image list (if any).
       	do
       		-- Then, associate the image list to the combination box.
       		if an_imagelist /= Void then
       			cwin_send_message (item, Cbem_setimagelist, 0, cwel_pointer_to_integer (an_imagelist.item))
       		else
       			cwin_send_message (item, Cbem_setimagelist, 0, 0)
       			-- 0 correspond to NULL.
       		end
       	end

feature -- Element change

	add_string (a_string: STRING) is
			-- Add `a_string' in the combo box.
		do
			insert_string_at (a_string, count)
		end

	insert_string_at (a_string: STRING; index: INTEGER) is
			-- Add `a_string' at the zero-based `index'.
		local
			citem: WEL_COMBO_BOX_EX_ITEM
		do
			create citem.make_with_index (index)
			citem.set_text (a_string)
			insert_item (citem)
		end

	insert_item (an_item: WEL_COMBO_BOX_EX_ITEM) is
			-- Insert `an_item' in the combo-box.
		require
			exists: exists
			an_item_not_void: an_item /= Void
			an_item_exists: an_item.exists
			index_large_enough: an_item.index >= 0
			index_small_enough: an_item.index <= count
		do
			cwin_send_message (item, Cbem_insertitem, 0, an_item.to_integer)
		ensure
			new_count: count = old count + 1
		end

	delete_item (index: INTEGER) is
			-- Delete the zero-based `index' item.
		require
			exists: exists
			index_large_enough: index >= 0
			index_small_enough: index < count
		do
			cwin_send_message (item, Cbem_deleteitem, index, 0)
		ensure
			new_count: count = old count - 1
		end

feature -- Notification

	on_cben_beginedit_item is
			-- The user activated the drop-down list or clicked in the
			-- control's edit box.
		do
		end

	on_cben_endedit_item (info: WEL_NM_COMBO_BOX_EX_ENDEDIT) is
			-- The user has concluded an operation within the edit box
			-- or has selected an item from the control's drop-down list.
		do
		end

 	on_cben_insert_item (an_item: WEL_COMBO_BOX_EX_ITEM) is
 			-- An item has been inserted in the control.
		do
 		end
 
 	on_cben_delete_item (an_item: WEL_COMBO_BOX_EX_ITEM) is
 			-- An item has been deleted from the control.
		do
 		end

feature -- Inapplicable

	find_string (index: INTEGER; a_string: STRING): INTEGER is
			-- Find the first string that contains the
			-- prefix `a_string'. `index' specifies the
			-- zero-based index of the item before the first
			-- item to be searched.
			-- Returns -1 if the search was unsuccessful.
		do
			check
				Inapplicable: False
			end
		end

	add_files (attribut: INTEGER; files: STRING) is
			-- Add `files' to the combo box. `files' may contain
			-- wildcards (?*). See class WEL_DDL_CONSTANTS for
			-- `attribut' values.
			-- To check
		do
			check
				Inapplicable: False
			end
		end

feature {WEL_COMPOSITE_WINDOW} -- Implementation

	process_notification_info (notification_info: WEL_NMHDR) is
			-- Process a `notification_code' sent by Windows
			-- through the Wm_notify message
		local
			code: INTEGER
			nm_info: WEL_NM_COMBO_BOX_EX
			nm_end_info: WEL_NM_COMBO_BOX_EX_ENDEDIT
		do
			code := notification_info.code
			if code = Cben_insertitem then
				create nm_info.make_by_nmhdr (notification_info)
				on_cben_insert_item (nm_info.comboboxex_item)
			elseif code = Cben_deleteitem then
				create nm_info.make_by_nmhdr (notification_info)
				on_cben_delete_item (nm_info.comboboxex_item)
			elseif code = Cben_beginedit then
				on_cben_beginedit_item
			elseif code = Cben_endedit then
				create nm_end_info.make_by_nmhdr (notification_info)
				on_cben_endedit_item (nm_end_info)
			end
		end

feature {NONE} -- Implementation

	buffer_size: INTEGER is 30
			-- Windows text retrieval buffer size

	combo_item: POINTER is
			-- Return the child combo-box that composes the
			-- current control. Corresponds to a WEL_COMBO_BOX.
		require
			exists: exists
		do
			Result := cwel_integer_to_pointer (cwin_send_message_result (item, Cbem_getcombocontrol, 0, 0))
		end

	class_name: STRING is
			-- Window class name to create
		once
			create Result.make (0)
			Result.from_c (cwin_comboex_class)
		end

feature {NONE} -- Externals

	cwin_comboex_class: POINTER is
		external
			"C [macro %"cctrl.h%"] : EIF_POINTER"
		alias
			"WC_COMBOBOXEX"
		end

end -- class WEL_COMBO_BOX_EX


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


indexing
	description	: "Enhancement of the toolbar. This toolbar appears flat %
				  %and use imagelist to store bitmaps - Win95+IE3 required"
	note		: "The common controls dll (WEL_COMMON_CONTROLS_DLL)     %
				  %needs to be loaded to use this control and IE3 or 	 %
				  %above installed"
	author		: "Arnaud PICHERY [ aranud@mail.dotcom.fr ]"
	date		: "$Date$"
	revision	: "$Revision$"

class
	WEL_IMAGELIST_TOOL_BAR

inherit
	WEL_TOOL_BAR
		redefine
			default_style
		end

	WEL_WINDOWS_VERSION
		export
			{NONE} all
		end

creation
	make

feature -- Access

	bitmaps_width: INTEGER is
			-- width of all bitmaps located in this imageList
		local
			loc_imagelist: WEL_IMAGE_LIST
		do
			loc_imagelist := get_image_list
			Result := loc_imagelist.bitmaps_width
			loc_imagelist.destroy
		end
	
	bitmaps_height: INTEGER is
			-- height of all bitmaps located in this imageList
		local
			loc_imagelist: WEL_IMAGE_LIST
		do
			loc_imagelist := get_image_list
			Result := loc_imagelist.bitmaps_height
			loc_imagelist.destroy
		end
	
	buttons_width: INTEGER is
			-- Width of the buttons in the toolbar.
		do
			Result := get_button_width
		end

	buttons_height: INTEGER is
			-- Height of the buttons in the toolbar.
		do
			Result := get_button_height
		end

feature -- Status report

	find_button (a_x, a_y: INTEGER): INTEGER is
			-- Determines where a point lies in a toolbar control. 
			--
			-- Returns an integer value. If the return value is zero or a positive value,
			-- it is the zero-based index of the nonseparator item in which the point lies. 
			-- If the return value is negative, the point does not lie within a button.
			-- The absolute value of the return value is the index of a separator item 
			-- or the nearest nonseparator item. 
		local
			coordinates: WEL_POINT
		do
			create coordinates.make(a_x, a_y)
			Result := cwin_send_message_result (item, Tb_hittest, 0, cwel_pointer_to_integer(coordinates.item))
		end
	
	get_max_width: INTEGER is
			-- Retrieves the total width of all of the visible buttons and separators in the toolbar. 
		do
			Result := get_max_size.width
		end

	get_max_height: INTEGER is
			-- Retrieves the common height of all of the visible buttons and separators in the toolbar. 
		do
			Result := get_max_size.height
		end

	get_max_size: WEL_SIZE is
			-- Retrieves the total size of all of the visible buttons and separators in the toolbar
		local
			error_code: INTEGER
		do
			create Result
			error_code := cwin_send_message_result (item, Tb_getmaxsize, 0, cwel_pointer_to_integer(Result.item))
			check
				no_error: error_code /= 0
			end
		end

feature -- Resizing

	get_button_width: INTEGER  is
			-- Get the width of the buttons.
		do
			Result := cwin_lo_word(cwin_send_message_result (item, Tb_getbuttonsize, 0, 0))
		end

	get_button_height: INTEGER  is
			-- Get the height of the buttons.
		do
			Result := cwin_hi_word(cwin_send_message_result (item, Tb_getbuttonsize, 0, 0))
		end

feature -- Element change

	set_image_list (an_image_list: WEL_IMAGE_LIST) is
			-- Set the default imageList to `an_image_list'.
			--
			-- To remove the imagelist, set `an_image_list' to Void.
		do
			if an_image_list = Void then
				cwin_send_message (item, Tb_setimagelist, 0, 0)
			else
				cwin_send_message (item, Tb_setimagelist, 0, cwel_pointer_to_integer (an_image_list.item))
			end
		end

	get_image_list: WEL_IMAGE_LIST is
		local
			imagelist_pointer: INTEGER
		do
			imagelist_pointer := cwin_send_message_result (item, Tb_getimagelist, 0, 0)
			create Result.make_by_pointer(cwel_integer_to_pointer (imagelist_pointer))
		end

	set_hot_image_list (an_image_list: WEL_IMAGE_LIST) is
			-- Set the hot imageList to `an_image_list'.
			--
			-- To remove the imagelist, set `an_image_list' to Void.
		do
			if an_image_list = Void then
				cwin_send_message (item, Tb_sethotimagelist, 0, 0)
			else
				cwin_send_message (item, Tb_sethotimagelist, 0, cwel_pointer_to_integer (an_image_list.item))
			end
		end

feature {NONE} -- Implementation

	default_style: INTEGER is
			-- Default style used to create the control
		once
			Result := Ws_visible + Ws_child + Tbstyle_tooltips + Tbstyle_flat
		end

end -- class WEL_IMAGELIST_TOOL_BAR


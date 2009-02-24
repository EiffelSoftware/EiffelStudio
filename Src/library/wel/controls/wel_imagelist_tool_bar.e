note
	description	: "[
		Enhancement of the toolbar. This toolbar appears flat
		and use imagelist to store bitmaps - Win95+IE3 required

		Note: The common controls dll (WEL_COMMON_CONTROLS_DLL)
			needs to be loaded to use this control and IE3 or
			above installed.
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
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

create
	make

feature -- Access

	bitmaps_width: INTEGER
			-- width of all bitmaps located in this imageList
		require
			exists: exists
		local
			loc_imagelist: WEL_IMAGE_LIST
		do
			loc_imagelist := get_image_list
			Result := loc_imagelist.bitmaps_width
			loc_imagelist.destroy
		end

	bitmaps_height: INTEGER
			-- height of all bitmaps located in this imageList
		require
			exists: exists
		local
			loc_imagelist: WEL_IMAGE_LIST
		do
			loc_imagelist := get_image_list
			Result := loc_imagelist.bitmaps_height
			loc_imagelist.destroy
		end

	buttons_width: INTEGER
			-- Width of the buttons in the toolbar.
		require
			exists: exists
		do
			Result := get_button_width
		end

	buttons_height: INTEGER
			-- Height of the buttons in the toolbar.
		require
			exists: exists
		do
			Result := get_button_height
		end

feature -- Status report

	find_button (a_x, a_y: INTEGER): INTEGER
			-- Determines where a point lies in a toolbar control.
			--
			-- Returns an integer value. If the return value is zero or a positive value,
			-- it is the zero-based index of the nonseparator item in which the point lies.
			-- If the return value is negative, the point does not lie within a button.
			-- The absolute value of the return value is the index of a separator item
			-- or the nearest nonseparator item.
		require
			exists: exists
		local
			coordinates: WEL_POINT
		do
			create coordinates.make(a_x, a_y)
			Result := {WEL_API}.send_message_result_integer (item, Tb_hittest, to_wparam (0), coordinates.item)
		end

	get_max_width: INTEGER
			-- Retrieves the total width of all of the visible buttons and separators in the toolbar.
		require
			exists: exists
		local
			l_rect: WEL_RECT
			l_count: INTEGER
		do
			-- If there is drop down button which is wider than normal button, we should calculate the max
			-- Width of tool bar button.
			-- Use get_max_size is not correct, because it always return the size include text width even
			-- it is hiding.
			from
			until
				l_count >= button_count
			loop
				l_rect := button_rect (l_count)
				if Result < l_rect.right then
					Result := l_rect.right
				end
				l_count := l_count + 1
			end
		end

	get_max_height: INTEGER
			-- Retrieves the common height of all of the visible buttons and separators in the toolbar.
		require
			exists: exists
		local
			l_rect: WEL_RECT
		do
			-- If we use get_max_size here, it'll return a larger size. (Sometimes it's a smaller size.)
			-- The larger size ( = button_count * max button width) is not correct.
			-- So we query last button rect instead.
			if button_count /= 0 then
				l_rect := button_rect (button_count - 1)
				Result := l_rect.bottom
			end
		end

	get_max_size: WEL_SIZE
			-- Retrieves the total size of all of the visible buttons and separators in the toolbar
		require
			exists: exists
		local
			error_code: INTEGER
		do
			create Result
			error_code := {WEL_API}.send_message_result_integer (item, Tb_getmaxsize, to_wparam (0), Result.item)
			check
				no_error: error_code /= 0
			end
		end

feature -- Resizing

	get_button_width: INTEGER
			-- Get the width of the buttons.
		require
			exists: exists
		do
			Result := cwin_lo_word({WEL_API}.send_message_result (item, Tb_getbuttonsize, to_wparam (0), to_lparam (0)))
		end

	get_button_height: INTEGER
			-- Get the height of the buttons.
		require
			exists: exists
		do
			Result := cwin_hi_word({WEL_API}.send_message_result (item, Tb_getbuttonsize, to_wparam (0), to_lparam (0)))
		end

feature -- Element change

	set_image_list (an_image_list: detachable WEL_IMAGE_LIST)
			-- Set the default imageList to `an_image_list'.
			--
			-- To remove the imagelist, set `an_image_list' to Void.
		require
			exists: exists
		do
			if an_image_list = Void then
				{WEL_API}.send_message (item, Tb_setimagelist, to_wparam (0), to_lparam (0))
			else
				{WEL_API}.send_message (item, Tb_setimagelist, to_wparam (0), an_image_list.item)
			end
		end

	get_image_list: WEL_IMAGE_LIST
		require
			exists: exists
		do
			create Result.make_by_pointer(
				{WEL_API}.send_message_result (item, Tb_getimagelist, to_wparam (0), to_lparam (0)))
		end

	set_hot_image_list (an_image_list: detachable WEL_IMAGE_LIST)
			-- Set the hot imageList to `an_image_list'.
			--
			-- To remove the imagelist, set `an_image_list' to Void.
		require
			exists: exists
		do
			if an_image_list = Void then
				{WEL_API}.send_message (item, Tb_sethotimagelist, to_wparam (0), to_lparam (0))
			else
				{WEL_API}.send_message (item, Tb_sethotimagelist, to_wparam (0), an_image_list.item)
			end
		end

feature {NONE} -- Implementation

	default_style: INTEGER
			-- Default style used to create the control
		once
			Result := Ws_visible + Ws_child + Tbstyle_tooltips + Tbstyle_flat
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

end -- class WEL_IMAGELIST_TOOL_BAR


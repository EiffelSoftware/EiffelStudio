note
	description: "This class represents the MCI digitalvideo device."
	status: "See notice at end of class."
	author: "Robin van Ommeren"
	date: "$Date$"
	revision: "$Revision$"

class
	WEX_MCI_DIGITAL_VIDEO

inherit
	WEX_MCI_DEVICE

	WEL_WS_CONSTANTS
		export
			{NONE} all
		end

	WEX_MCI_DGV_CONSTANTS
		export
			{NONE} all
		end

	WEX_MCI_DGV_REALIZE_CONSTANTS
		export
			{NONE} all
		end

	WEX_MCI_DGV_WHERE_CONSTANTS
		export
			{NONE} all
		end

create
	make

feature -- Basic operations

	realize_palette_as_background
			-- Realizes the palette as background into the
			-- device context.
			--| Your application should call
			--| `realize_palette_as_background' or
			--| `realize_palette_normal' in the on_query_new_palette
			--| routine.
		require
			opened: opened
		local
			generic_parms: WEX_MCI_GENERIC_PARMS
		do
			create generic_parms.make (parent)
			realize_device (generic_parms, Mci_dgv_realize_bkgd)
		end

	realize_palette_normal
			-- Realizes the palette normal into the device context.
			--| Your application should call
			--| `realize_palette_as_background' or
			--| `realize_palette_normal' in the on_query_new_palette
			--| routine.
		require
			opened: opened
		local
			generic_parms: WEX_MCI_GENERIC_PARMS
		do
			create generic_parms.make (parent)
			realize_device (generic_parms, Mci_dgv_realize_norm)
		end

	cue_play_back
			-- Cue video for play back.
			--| After cueing the device starts with minimum delay.
		require
			opened: opened
		local
			generic_parms: WEX_MCI_GENERIC_PARMS
		do
			create generic_parms.make (parent)
			cue_device (generic_parms, Mci_dgv_cue_output)
		end

	seek_to (a_position: INTEGER)
			-- Position the video file at `position' in frames.
		require
			opened: opened
			positive_position: a_position >= 0
			meaningful_position: a_position <= media_length
		local
			seek_parms: WEX_MCI_SEEK_PARMS
		do
			create seek_parms.make (parent, position)
			seek_device (seek_parms, Mci_to)
		end

	open (file: PATH)
			-- Open a Mci device to play a video file.
		require
			not_opened: not opened
			file_not_void: file /= Void
			file_meaningful: not file.is_empty
		local
			open_parms: WEX_MCI_DGV_OPEN_PARMS
		do
			create open_parms.make (parent, device_name)
			open_parms.set_open_style (Ws_child)
			open_parms.set_element_name (file.utf_8_name)
			open_parms.set_parent_handle (parent.item)
			open_device (open_parms, Mci_open_element)
		end

feature -- Status setting

	set_window (window: WEL_COMPOSITE_WINDOW)
			-- Set a window to the device for playback
		require
			opened: opened
			window_not_void: window /= Void
			window_exists: window.exists
		local
			window_parms: WEX_MCI_DGV_WINDOW_PARMS
		do
			current_window := window
			create window_parms.make (parent)
			window_parms.set_display_window (window)
			window_device (window_parms, Mci_dgv_window_hwnd)
		end

feature -- Status report

	source_rectangle: WEL_RECT
			-- Retrieve the dimensions used to display video and
			-- images in the client area of the current window.
			--| The returned rectangle is reformatted to
			--| a true Windows rectangle.
		require
			opened: opened
		local
			dgv_rect_parms: WEX_MCI_DGV_RECT_PARMS
		do
			create dgv_rect_parms.make (parent)
			where_device (dgv_rect_parms, Mci_dgv_where_source)
			Result := dgv_rect_parms.rect
		ensure
			result_not_void: Result /= Void
			result_exists: Result.exists
		end

	maximum_source_rectangle: WEL_RECT
			-- Retrieve the max dimensions used to display video
			-- and images in the client area of the current window.
			--| The returned rectangle is reformatted to
			--| a true Windows rectangle.
		require
			opened: opened
		local
			dgv_rect_parms: WEX_MCI_DGV_RECT_PARMS
		do
			create dgv_rect_parms.make (parent)
			where_device (dgv_rect_parms, Mci_dgv_where_source +
				Mci_dgv_where_max)
			Result := dgv_rect_parms.rect
		ensure
			result_not_void: Result /= Void
			result_exists: Result.exists
		end

	destination_rectangle: WEL_RECT
			-- Retrieve the dimensions used to display video
			-- and images in the client area of the current window.
			--| The returned rectangle is reformatted to
			--| a true Windows rectangle.
		require
			opened: opened
		local
			dgv_rect_parms: WEX_MCI_DGV_RECT_PARMS
		do
			create dgv_rect_parms.make (parent)
			where_device (dgv_rect_parms, Mci_dgv_where_destination)
			Result := dgv_rect_parms.rect
		ensure
			result_not_void: Result /= Void
			result_exists: Result.exists
		end

	maximum_destination_rectangle: WEL_RECT
			-- Retrieve the dimensions used to display video
			-- and images in the client area of the current window.
			--| The returned rectangle is reformatted to
			--| a true Windows rectangle.
		require
			opened: opened
		local
			dgv_rect_parms: WEX_MCI_DGV_RECT_PARMS
		do
			create dgv_rect_parms.make (parent)
			where_device (dgv_rect_parms, Mci_dgv_where_destination
				+ Mci_dgv_where_max)
			Result := dgv_rect_parms.rect
		ensure
			result_not_void: Result /= Void
			result_exists: Result.exists
		end

	window_rectangle: WEL_RECT
			-- Retrieve the dimensions of the display-window frame.
			--| The returned rectangle is reformatted to
			--| a true Windows rectangle.
		require
			opened: opened
		local
			dgv_rect_parms: WEX_MCI_DGV_RECT_PARMS
		do
			create dgv_rect_parms.make (parent)
			where_device (dgv_rect_parms, Mci_dgv_where_window)
			Result := dgv_rect_parms.rect
		ensure
			result_not_void: Result /= Void
			result_exists: Result.exists
		end

	maximum_window_rectangle: WEL_RECT
			-- Retrieve the max dimensions of the
			-- display-window frame.
			--| The returned rectangle is reformatted to
			--| a true Windows rectangle.
		require
			opened: opened
		local
			dgv_rect_parms: WEX_MCI_DGV_RECT_PARMS
		do
			create dgv_rect_parms.make (parent)
			where_device (dgv_rect_parms, Mci_dgv_where_window +
				Mci_dgv_where_max)
			Result := dgv_rect_parms.rect
		ensure
			result_not_void: Result /= Void
			result_exists: Result.exists
		end

	frame_rectangle: WEL_RECT
			-- Retrieve the dimensions of the frame buffer into
			-- which images from the video rectangle are scaled.
			--| The returned rectangle is reformatted to
			--| a true Windows rectangle.
		require
			opened: opened
		local
			dgv_rect_parms: WEX_MCI_DGV_RECT_PARMS
		do
			create dgv_rect_parms.make (parent)
			where_device (dgv_rect_parms, Mci_dgv_where_frame)
			Result := dgv_rect_parms.rect
		ensure
			result_not_void: Result /= Void
			result_exists: Result.exists
		end

	video_rectangle: WEL_RECT
			-- Retrieve the dimensions of the rectangular region
			-- cropped from the presentation source to fill the
			-- frame rectangle in the frame buffer
			--| The returned rectangle is reformatted to
			--| a true Windows rectangle.
		require
			opened: opened
		local
			dgv_rect_parms: WEX_MCI_DGV_RECT_PARMS
		do
			create dgv_rect_parms.make (parent)
			where_device (dgv_rect_parms, Mci_dgv_where_video)
			Result := dgv_rect_parms.rect
		ensure
			result_not_void: Result /= Void
			result_exists: Result.exists
		end

feature {NONE} -- Implementation

	realize_device (parms: WEX_MCI_GENERIC_PARMS; realize_flags: INTEGER)
			-- Perform MCI_REALIZE command on device.
		require
			opened: opened
			parms_not_void: parms /= Void
			parms_exists: parms.exists
		do
			send_command (Mci_realize, realize_flags +
				command_flags, parms)
		end

	window_device (parms: WEX_MCI_GENERIC_PARMS; window_flags: INTEGER)
			-- Assign a window to a device.
		require
			opened: opened
			parms_not_void: parms /= Void
			parms_exists: parms.exists
		do
			send_command (Mci_window, window_flags +
				command_flags, parms)
		end

	where_device (parms: WEX_MCI_GENERIC_PARMS; where_flags: INTEGER)
			-- Assign a window to a device.
		require
			opened: opened
			parms_not_void: parms /= Void
			parms_exists: parms.exists
		do
			send_command (Mci_where, where_flags +
				command_flags, parms)
		end

	current_window: WEL_COMPOSITE_WINDOW
			-- Current window used for device.
			--| Prevents garbage collecting if user specified the
			--| window as a local attribute.

	device_name: STRING
			-- Device name
		once
			Result := "digitalvideo"
		end

end

--|-------------------------------------------------------------------------
--| WEX, Windows Eiffel library eXtension
--| Copyright (C) 1998  Robin van Ommeren, Andreas Leitner
--| Copyright (C) 2017  Eiffel Software, Alexander Kogtenkov
--| See the file forum.txt included in this package for licensing info.
--|
--| Comments, Questions, Additions to this library? please contact:
--|
--| Robin van Ommeren						Andreas Leitner
--| Eikenlaan 54M								Arndtgasse 1/3/5
--| 7151 WT Eibergen							8010 Graz
--| The Netherlands							Austria
--| email: robin.van.ommeren@wxs.nl		email: andreas.leitner@teleweb.at
--| web: http://home.wxs.nl/~rommeren	web: about:blank
--|-------------------------------------------------------------------------

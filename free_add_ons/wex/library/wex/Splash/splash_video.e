note
	description: "Splash containing a video."
	author: "Robin van Ommeren"
	date: "$Date$"
	revision: "$Revision$"

class
	WEX_SPLASH_VIDEO

inherit
	WEX_SPLASH_WINDOW
		rename
			pop_up as window_pop_up,
			pop_down as window_pop_down
		redefine
			valid,
			default_process_message,
			class_name,
			on_query_new_palette
		end

	WEX_MMCI_CONSTANTS
		export
			{NONE} all
		end

create
	make

feature -- Basic operations

	set_video (a_file_name: STRING)
		require
			a_file_name_not_void: a_file_name /= Void
			a_file_name_meaningful: not a_file_name.empty
		local
			rect: WEL_RECT
		do
			stop_and_close_video_device
			video_device.open (a_file_name)
			if valid then
				rect := video_device.source_rectangle
				resize (rect.width, rect.height)
				video_window.move_and_resize(0,0,rect.width,rect.height,True)
				center_on_screen
				video_device.set_window (video_window)
			end
		end

	pop_up
			-- Popup the splash window.
		do
			if popped_up then
				pop_down
			end
			video_device.enable_notify
			window_pop_up
			video_device.play
			video_device.disable_notify
		end

	pop_down
			-- popdown the splash window.
		do
			window_pop_down
			stop_and_close_video_device
		end

feature -- Status report

	valid: BOOLEAN
			-- Can the video window pop up?
		do
			Result := video_device.opened
		end

feature {NONE} -- Behavior

	default_process_message (a_msg, wparam, lparam: INTEGER)
		do
			if a_msg = Mm_mcinotify then
				pop_down
			end
		end


feature {NONE} -- implementation

	stop_and_close_video_device
		do
			if video_device.opened then
				if video_device.playing then
					video_device.stop
				end
				video_device.close
			end
		ensure
			not_valid: not valid
		end

	video_window: WEX_CONTROL_WINDOW_NO_BACKGROUND
		once 
			create Result.make(Current, "SplashVideoSubWindowRWC")
		end

	on_query_new_palette
			-- Adjust the palette on the video if palette
			-- is changing.
		do
			video_device.realize_palette_as_background
		end

	class_name: STRING
			-- Class name
		once
			Result := "SplashVideoWindowRWC"
		end

	video_device: WEX_MCI_DIGITAL_VIDEO
			-- device to play an AVI
		once 
			create Result.make (Current)
			Result.set_strict (True)
		end

end -- class WEX_SPLASH_VIDEO

--|-------------------------------------------------------------------------
--| WEX, Windows Eiffel library eXtension
--| Copyright (C) 1998  Robin van Ommeren, Andreas Leitner
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

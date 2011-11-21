note
	description: "General notions of a splash."
	author: "Robin van Ommeren"
	date: "$Date$"
	revision: "$Revision$"

class
	WEX_SPLASH_WINDOW

inherit
	WEX_REGION_WINDOW_CAPABILITY

	WEL_CONTROL_WINDOW
		rename
			make as wel_make,
			make_with_coordinates as wel_make_with_coordinates
		export {NONE}
			wel_make,
			wel_make_with_coordinates
		redefine
			class_name,
			on_timer,
			default_style,
			default_ex_style
		end

	WEL_SYSTEM_METRICS
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make
		do
			make_top("")
		end

feature -- Basic operations

	exclusive_activate (milli_seconds: INTEGER)
			-- Activate splash window for `milli_seconds'.
			-- "Do not return control" to the application.
		do
			pop_up
			set_timer (splash_timer_id, milli_seconds)
			from
			until
				not popped_up
			loop
				msg.peek_all
				if msg.last_boolean_result then
					msg.translate
					msg.dispatch
				end
			end
		end

	activate (milli_seconds: INTEGER)
			-- Activate splash window for `milli_seconds'.
			-- Return control to the application.
		require
			positive_milli_seconds: milli_seconds > 0
		do
			pop_up
			set_timer (splash_timer_id, milli_seconds)
		ensure
			is_popped_up: popped_up
		end

	center_on_screen
		local
			splash_x: INTEGER
			splash_y: INTEGER
		do
			splash_x := (full_screen_client_area_width - width) // 2
			splash_y := (full_screen_client_area_height - height) // 2
			move (splash_x, splash_y)
		end

	pop_up
			-- Pop up the splash window.
		require
			valid: valid
		do
			set_z_order (Hwnd_topmost)
			show
			popped_up := True
		ensure
			popped_up: popped_up
		end

	pop_down
			-- pop down the splash window.
		do
			hide
			popped_up := False
		ensure
			not_popped_up: not popped_up
		end

feature -- Status report

	popped_up: BOOLEAN
			-- Is the splash window popped up?

	valid: BOOLEAN
			-- Can the splash be popped up?
		do
			Result := exists
		end
		
feature {NONE} -- Behavior

	on_timer (timer_id: INTEGER)
			-- Wm_timer message.
			-- A Wm_timer has been received from `timer_id'
		do
			if timer_id = splash_timer_id then
				kill_timer (timer_id)
				pop_down
			end
		end

feature {NONE} -- Implementation

	splash_timer_id: INTEGER = unique
			-- Id for timer

	msg: WEL_MSG
			-- Wel message
		once 
			create Result.make
		end

	default_style: INTEGER
			-- Popup window style (no title bar)
		once
			Result := Ws_popupwindow
		end

	default_ex_style: INTEGER
			-- Tool window style (not in taskbar)
		once
			Result := Ws_ex_toolwindow 
		end

	Ws_ex_toolwindow: INTEGER
		external
			"C [macro <windows.h>]"
		alias
			"WS_EX_TOOLWINDOW"
		end

	class_name: STRING
			-- Class name
		once
			Result := "SplashWindowWEX"
		end

end -- class WEX_SPLASH_WINDOW

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

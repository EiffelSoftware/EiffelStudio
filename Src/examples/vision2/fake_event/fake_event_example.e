indexing
	description	: "Example demonstrating the fake events "
	author		: "Arnaud PICHERY [ aranud@mail.dotcom.fr ]"
	date		: "$Date$"
	revision	: "$Revision$"

class
	FAKE_EVENT_EXAMPLE

inherit
	EV_APPLICATION

create
	make_and_launch

feature -- Initialization

	prepare is
			-- Initialization.
		local
			timer: EV_TIMEOUT
		do
			create ev_screen
			create timer
			timer.actions.extend (~on_timer)
			timer.set_interval (1000)
		end

	first_window: EV_TITLED_WINDOW is
			-- The window with the drawable area.
		once
			create Result
			Result.set_title ("Vision2 Fake Event Example.. look at your keyboard leds")
			Result.set_size (500, 100)
		end

feature {NONE} -- Implementation

	ev_screen: EV_SCREEN
			-- Object representing the screen.

	on_timer is
			-- Wm_timer message.
		do
			inspect state
			when 0 then -- Numlock activated
					-- Deactivate numlock				
				ev_screen.fake_key_press (Key_num_lock)
				ev_screen.fake_key_release (Key_num_lock)
					-- Activate Capslock
				ev_screen.fake_key_press (Key_caps_lock)
				ev_screen.fake_key_release (Key_caps_lock)
			when 1 then -- Capslock activated
					-- Deactivate Capslock
				ev_screen.fake_key_press (Key_caps_lock)
				ev_screen.fake_key_release (Key_caps_lock)
					-- Activate Scroll lock.
				ev_screen.fake_key_press (Key_scroll_lock)
				ev_screen.fake_key_release (Key_scroll_lock)
			when 2 then
					-- Deactivate Scroll lock.
				ev_screen.fake_key_press (Key_scroll_lock)
				ev_screen.fake_key_release (Key_scroll_lock)
					-- Activate numlock				
				ev_screen.fake_key_press (Key_num_lock)
				ev_screen.fake_key_release (Key_num_lock)
			end

				-- Prepare next iteration
			led_state := led_state + 1
			if led_state >= 3 then led_state := 0; end
		end

	led_state: INTEGER
		-- Current Led state: 
		--	0 = NumLock activated
		--	1 = CapsLocl activated
		--	2 = ScrollLock activated
	
feature {NONE} -- Constants

	Key_constants: EV_KEY_CONSTANTS is
			-- Available keys.
		once
			create Result
		end

	Key_num_lock: EV_KEY is
			-- NumLock key.
		once
			create Result.make_with_code (Key_constants.Key_num_lock)
		end

	Key_caps_lock: EV_KEY is
			-- CapsLock key.
		once
			create Result.make_with_code (Key_constants.Key_caps_lock)
		end

	Key_scroll_lock: EV_KEY is
			-- ScroollLock key.
		once
			create Result.make_with_code (Key_constants.Key_scroll_lock)
		end

end -- class FAKE_EVENT_EXAMPLE

class
	EV_SIMPLE_EVENT_TEST

inherit
	EV_APPLICATION

creation

	make_and_launch


feature -- Access

	first_window: EV_TITLED_WINDOW is
		once
			create Result
		end

	selected, pressed, released: BOOLEAN

	on_select is
		do
			selected := True
			print ("select")
		end

	on_press is
		do
			pressed := True
			print ("press")
		end

	on_release is
		do
			released := True
			print ("release")
		end

	do_test (wgt: EV_WIDGET) is
		local
			s: EV_SCREEN
			x, y: INTEGER
			w, h: INTEGER
		do
			create s
			x := wgt.screen_x
			y := wgt.screen_y
			w := wgt.width
			h := wgt.height
			
			s.set_pointer_position (
				(x+(w/2)).truncated_to_integer,
				(y+(h/2)).truncated_to_integer
			)
			sleep (1000)
			s.fake_pointer_button_press (1)
			sleep (1000)
			s.fake_pointer_button_release (1)
			sleep (2000)
			if
				selected and
				pressed and
				released
			then
				destroy
			else
				exit_one
			end
		end

	prepare is
		local
			t: EV_TIMEOUT
			b: EV_BUTTON
		do
			create t
			create b.make_with_text ("Test button")
			b.select_actions.extend (~on_select)
			b.pointer_button_press_actions.force_extend (~on_press)
			b.pointer_button_release_actions.force_extend (~on_release)
			first_window.extend (b)
			t.actions.extend (~do_test (b))
			t.set_interval (10000)
		end

    exit_one is
        external
            "C [macro <stdio.h>]"
        alias
            "exit(1)"
        end

end -- class ROOT_CLASS

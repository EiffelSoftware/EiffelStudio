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

	on_select is do selected := True end
	on_press is do pressed := True end
	on_release is do released := True end

	
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
				(y+(h/2))).truncated_to_integer
			)
			sleep (1)
			s.fake_pointer_button_press (1)
			sleep (1)
			s.fake_pointer_button_release (1)
			sleep (2)
			if
				selected and
				pressed and
				reelased
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
			b.press_actions.extend (~on_press)
			b.release_actions.extend (~on_release)
			first_window.extend (b)
			t.actions.extend (~do_test)
			t.set_interval (5000)
		end

    exit_one is
        external
            "C [macro <stdio.h>]"
        alias
            "exit(1)"
        end

end -- class ROOT_CLASS

class
	EV_SIMPLE_EVENT_TEST

inherit
	EV_APPLICATION

creation

	make_and_launch

feature -- Access

	make_and_launch is
		do
			default_create
			prepare
			launch
		end

	first_window: EV_TITLED_WINDOW

	selected, pressed, released: BOOLEAN

	on_select  is do selected := True end
	on_press   is do pressed  := True end
	on_release is do released := True end

	do_test (wgt: EV_WIDGET) is
		local
			s: EV_SCREEN
		do
			create s
			wgt.center_pointer
			process_events
			sleep (1000)
			process_events
			s.fake_pointer_button_press (1)
			process_events
			sleep (1000)
			process_events
			s.fake_pointer_button_release (1)
			process_events
			sleep (2000)
			process_events
			if
				selected and
				pressed and
				released
			then
				print ("success%N")
				destroy
			else
				print ("failure%N")
				exit_one
			end
		end

	prepare is
		local
			t: EV_TIMEOUT
			b: EV_BUTTON
		do
			create first_window
			first_window.show
			create t
			create b.make_with_text ("Test button")
			b.select_actions.extend (~on_select)
			b.select_actions.extend (~print ("select%N"))
			b.pointer_button_press_actions.force_extend (~on_press)
			b.pointer_button_press_actions.force_extend (~print ("press%N"))
			b.pointer_button_release_actions.force_extend (~on_release)
			b.pointer_button_release_actions.force_extend (~print ("release%N"))
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

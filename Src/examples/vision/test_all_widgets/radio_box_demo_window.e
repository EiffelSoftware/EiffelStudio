class RADIO_BOX_DEMO_WINDOW

inherit

	DEMO_WINDOW

creation

	make

feature

	toggle_b1: TOGGLE_B

	toggle_b2: TOGGLE_B

	toggle_b3: TOGGLE_B

	main_widget: WIDGET is
		once
			!RADIO_BOX!Result.make ("Radio_box", Current)
		end

	set_widgets is
		local
			radio_widget: RADIO_BOX
		do
			set_size (160, 200)
			main_widget.set_x_y (30, 30)
			radio_widget ?= main_widget
			radio_widget.set_size (100, 35)
			!!toggle_b1.make ("toggle_b1", radio_widget)
			!!toggle_b2.make ("toggle_b2", radio_widget)
			!!toggle_b3.make ("toggle_b3", radio_widget)
			toggle_b1.set_text ("toggle_b1")
			toggle_b2.set_text ("toggle_b2")
			toggle_b3.set_text ("toggle_b3")
		end

	work (arg: INTEGER_REF) is
		do
		end

end -- class RADIO_BOX_DEMO_WINDOW

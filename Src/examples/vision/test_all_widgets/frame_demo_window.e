class FRAME_DEMO_WINDOW

inherit

	DEMO_WINDOW

creation

	make

feature

	button: PUSH_B

	main_widget: WIDGET is
		once
			!FRAME!Result.make ("Frame", Current)
		end

	set_widgets is
		local
			f_widget: FRAME
		do
			set_size (230, 130)
			main_widget.set_x_y (30, 30)
			f_widget ?= main_widget
			f_widget.set_size (170, 70)
			!!button.make ("button", f_widget)
			button.set_text ("Button")
			button.forbid_recompute_size
			button.set_size (100, 35)
			button.set_x_y (35, 17)
		end

	work (arg: INTEGER_REF) is
		do
		end

end -- class FRAME_DEMO_WINDOW

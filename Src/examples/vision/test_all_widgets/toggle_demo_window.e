class TOGGLE_DEMO_WINDOW

inherit

	DEMO_WINDOW

creation

	make

feature

	main_widget: WIDGET is
		once
			!TOGGLE_B!Result.make ("Toggle_b", Current)
		end

	set_widgets is
		local
			toggle_widget: TOGGLE_B
		do
			set_size (160, 100)
			main_widget.set_x_y (30, 30)
			toggle_widget ?= main_widget
			toggle_widget.forbid_recompute_size
			toggle_widget.set_size (100, 35)
			toggle_widget.set_text ("Toggle_b")
		end

	work (arg: INTEGER_REF) is
		do
		end

end

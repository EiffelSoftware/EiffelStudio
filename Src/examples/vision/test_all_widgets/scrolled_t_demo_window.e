class SCROLLED_T_DEMO_WINDOW

inherit

	DEMO_WINDOW

creation

	make

feature

	main_widget: WIDGET is
		once
			!SCROLLED_T!Result.make ("Scrolled_t", Current)
		end

	set_widgets is
		local
			st_widget: SCROLLED_T
		do
			set_size (200, 250)
			main_widget.set_x_y (30, 30)
			st_widget ?= main_widget
			st_widget.set_size (140, 190)
		end

	work (arg: INTEGER_REF) is
		do
		end

end

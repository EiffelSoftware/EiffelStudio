class TEXT_DEMO_WINDOW

inherit

	DEMO_WINDOW

creation

	make

feature

	main_widget: WIDGET is
		once
			!TEXT!Result.make ("Text", Current)
		end

	set_widgets is
		local
			t_widget: TEXT
		do
			set_size (250, 300)
			main_widget.set_x_y (30, 30)
			t_widget ?= main_widget
			t_widget.set_size (200, 250)
		end

	work (arg: INTEGER_REF) is
		do
		end

end

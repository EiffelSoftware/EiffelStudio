class SEPARATOR_DEMO_WINDOW

inherit

	DEMO_WINDOW

creation

	make

feature

	main_widget: WIDGET is
		once
			!SEPARATOR!Result.make ("Separator", Current)
		end

	set_widgets is
		local
			separator: SEPARATOR
		do
			set_size (160, 100)
			main_widget.set_x_y (20, 20)
			separator ?= main_widget
			separator.set_size (100, 20)
			separator.set_horizontal (True)
			separator.set_single_line
		end

	work (arg: INTEGER_REF) is
		do
		end

end

class PICT_COL_B_DEMO_WINDOW

inherit

	DEMO_WINDOW

creation

	make

feature

	main_widget: WIDGET is
		once
			!PICT_COLOR_B!Result.make ("Pict_col_b", Current)
		end

	set_widgets is
		local
			pcb: PICT_COLOR_B
		do
			set_size (110, 110)
			main_widget.set_x_y (30, 30)
			pcb ?= main_widget
			pcb.set_size (50, 50)
		end

	work (arg: INTEGER_REF) is
		do
		end

end

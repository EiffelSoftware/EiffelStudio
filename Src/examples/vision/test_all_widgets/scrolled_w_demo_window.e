class SCROLLED_W_DEMO_WINDOW

inherit

	DEMO_WINDOW

creation

	make

feature

	main_widget: WIDGET is
		once
			!SCROLLED_W!Result.make ("Scrolled_w", Current)
		end

	set_widgets is
		local
		do
			set_size (160, 100)
			main_widget.set_x_y (30, 30)
			main_widget.set_size (100, 35)
		end

	work (arg: INTEGER_REF) is
		do
		end

end -- class SCROLLED_W_DEMO_WINDOW

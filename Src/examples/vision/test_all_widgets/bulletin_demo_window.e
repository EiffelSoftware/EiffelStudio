class BULLETIN_DEMO_WINDOW

inherit

	DEMO_WINDOW

creation

	make

feature

	main_widget: WIDGET is
		once
			!BULLETIN!Result.make ("bulletin", Current)
		end

	set_widgets is
		do
			set_size (200, 200)
			main_widget.set_x_y (10, 10)
			main_widget.set_size (180, 180)
		end

	work (arg: INTEGER_REF) is
		do
		end

end -- class BULLETIN_DEMO_WINDOW

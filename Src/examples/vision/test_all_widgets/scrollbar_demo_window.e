class SCROLLBAR_DEMO_WINDOW

inherit

	DEMO_WINDOW

creation

	make

feature

	main_widget: WIDGET is
		once
			!SCROLLBAR!Result.make ("Scrollbar", Current)
		end

	set_widgets is
		local
			scrollbar: SCROLLBAR
		do
			set_size (160, 100)
			main_widget.set_x_y (30, 30)
			scrollbar ?= main_widget
			scrollbar.set_horizontal (True)
			scrollbar.set_size (100, 35)
		end

	work (arg: INTEGER_REF) is
		do
		end

end

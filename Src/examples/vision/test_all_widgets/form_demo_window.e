class FORM_DEMO_WINDOW

inherit

	DEMO_WINDOW

creation

	make

feature

	main_widget: WIDGET is
		once
			!FORM!Result.make ("Form", Current)
		end

	set_widgets is
		local
			form_widget: FORM
		do
			set_size (250, 100)
			main_widget.set_x_y (0, 0)
			form_widget ?= main_widget
			form_widget.set_size (width, height)
		end

	work (arg: INTEGER_REF) is
		do
		end

end -- class FORM_DEMO_WINDOW

class TEXT_FIELD_DEMO_WINDOW

inherit

	DEMO_WINDOW

creation

	make

feature

	main_widget: WIDGET is
		once
			!TEXT_FIELD!Result.make ("Text_field", Current)
		end

	set_widgets is
		local
			tf_widget: TEXT_FIELD
		do
			set_size (160, 100)
			main_widget.set_x_y (30, 30)
			tf_widget ?= main_widget
			tf_widget.set_size (100, 35)
		end

	work (arg: INTEGER_REF) is
		do
		end

end

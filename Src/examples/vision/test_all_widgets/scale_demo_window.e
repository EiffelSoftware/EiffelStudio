class SCALE_DEMO_WINDOW

inherit

	DEMO_WINDOW

creation

	make

feature

	main_widget: WIDGET is
		once
			!SCALE!Result.make ("Scale", Current)
		end

	set_widgets is
		local
			scale: SCALE
		do
			set_size (160, 100)
			main_widget.set_x_y (30, 30)
			scale ?= main_widget
			scale.set_horizontal (True)
			scale.set_size (100, 35)
		end

	work (arg: INTEGER_REF) is
		do
		end

end

class LABEL_DEMO_WINDOW

inherit

	DEMO_WINDOW

creation

	make

feature

	main_widget: WIDGET is
		once
			!LABEL!Result.make ("Label", Current)
		end

	set_widgets is
		local
			label_widget: LABEL
		do
			set_size (160, 100)
			main_widget.set_x_y (30, 30)
			label_widget ?= main_widget
			label_widget.forbid_recompute_size
			label_widget.set_size (100, 35)
			label_widget.set_text ("Label")
		end

	work (arg: INTEGER_REF) is
		do
		end

end -- class LABEL_DEMO_WINDOW

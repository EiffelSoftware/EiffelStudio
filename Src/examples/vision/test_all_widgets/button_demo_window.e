class BUTTON_DEMO_WINDOW

inherit

	DEMO_WINDOW

creation

	make

feature

	main_widget: WIDGET is
		once
			!PUSH_B!Result.make ("Button", Current)
		end

	set_widgets is
		local
			button_widget: PUSH_B
		do
			set_size (160, 100)
			main_widget.set_x_y (30, 30)
			button_widget ?= main_widget
			button_widget.forbid_recompute_size
			button_widget.manage
			button_widget.set_size (100, 35)
			button_widget.set_text ("Button")
		end

	work (arg: INTEGER_REF) is
		do
		end

end -- class BUTTON_DEMO_WINDOW

class SCROLL_LIST_DEMO_WINDOW

inherit

	DEMO_WINDOW

creation

	make

feature

	main_widget: WIDGET is
		once
			!SCROLL_LIST!Result.make ("Scroll_list", Current)
		end

	set_widgets is
		local
			sl: SCROLL_LIST
		do
			set_size (200, 300)
			main_widget.set_x_y (30, 30)
			main_widget.manage
			sl ?= main_widget
		end

	work (arg: INTEGER_REF) is
		do
		end

end

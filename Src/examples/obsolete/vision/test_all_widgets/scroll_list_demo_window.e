indexing
	legal: "See notice at end of class."
	status: "See notice at end of class."
class SCROLL_LIST_DEMO_WINDOW

inherit

	DEMO_WINDOW

create

	make

feature

	main_widget: WIDGET is
		once
			create {SCROLLABLE_LIST} Result.make ("Scroll_list", Current)
		end

	set_widgets is
		local
			sl: SCROLLABLE_LIST
		do
			set_size (200, 300)
			main_widget.set_x_y (30, 30)
			main_widget.manage
			sl ?= main_widget
		end

	work (arg: INTEGER_REF) is
		do
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"


end


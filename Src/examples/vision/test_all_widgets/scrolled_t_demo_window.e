indexing
	legal: "See notice at end of class."
	status: "See notice at end of class."
class SCROLLED_T_DEMO_WINDOW

inherit

	DEMO_WINDOW

create

	make

feature

	main_widget: WIDGET is
		once
			create {SCROLLED_T} Result.make ("Scrolled_t", Current)
		end

	set_widgets is
		local
			st_widget: SCROLLED_T
		do
			set_size (200, 250)
			main_widget.set_x_y (30, 30)
			st_widget ?= main_widget
			st_widget.set_size (140, 190)
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


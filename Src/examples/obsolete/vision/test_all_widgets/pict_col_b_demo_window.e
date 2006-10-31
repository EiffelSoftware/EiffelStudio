indexing
	legal: "See notice at end of class."
	status: "See notice at end of class."
class PICT_COL_B_DEMO_WINDOW

inherit

	DEMO_WINDOW

create

	make

feature

	main_widget: WIDGET is
		once
			create {PICT_COLOR_B} Result.make ("Pict_col_b", Current)
		end

	set_widgets is
		local
			pcb: PICT_COLOR_B
		do
			set_size (110, 110)
			main_widget.set_x_y (30, 30)
			pcb ?= main_widget
			pcb.set_size (50, 50)
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


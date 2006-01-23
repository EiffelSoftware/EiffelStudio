indexing
	legal: "See notice at end of class."
	status: "See notice at end of class."
class SEPARATOR_DEMO_WINDOW

inherit

	DEMO_WINDOW

create

	make

feature

	main_widget: WIDGET is
		once
			create {SEPARATOR} Result.make ("Separator", Current)
		end

	set_widgets is
		local
			separator: SEPARATOR
		do
			set_size (160, 100)
			main_widget.set_x_y (20, 20)
			separator ?= main_widget
			separator.set_size (100, 20)
			separator.set_horizontal (True)
			separator.set_single_line
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


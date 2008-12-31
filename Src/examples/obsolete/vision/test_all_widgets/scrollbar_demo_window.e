note
	legal: "See notice at end of class."
	status: "See notice at end of class."
class SCROLLBAR_DEMO_WINDOW

inherit

	DEMO_WINDOW

create

	make

feature

	main_widget: WIDGET
		once
			create {SCROLLBAR} Result.make ("Scrollbar", Current)
		end

	set_widgets
		local
			scrollbar: SCROLLBAR
		do
			set_size (160, 100)
			main_widget.set_x_y (30, 30)
			scrollbar ?= main_widget
			scrollbar.set_horizontal (True)
			scrollbar.set_size (100, 35)
		end

	work (arg: INTEGER_REF)
		do
		end

note
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


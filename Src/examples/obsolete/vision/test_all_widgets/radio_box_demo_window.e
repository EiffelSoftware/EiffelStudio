indexing
	legal: "See notice at end of class."
	status: "See notice at end of class."
class RADIO_BOX_DEMO_WINDOW

inherit

	DEMO_WINDOW

create

	make

feature

	toggle_b1: TOGGLE_B

	toggle_b2: TOGGLE_B

	toggle_b3: TOGGLE_B

	main_widget: WIDGET is
		once
			create {RADIO_BOX} Result.make ("Radio_box", Current)
		end

	set_widgets is
		local
			radio_widget: RADIO_BOX
		do
			set_size (160, 200)
			main_widget.set_x_y (30, 30)
			radio_widget ?= main_widget
			radio_widget.set_size (100, 35)
			create toggle_b1.make ("toggle_b1", radio_widget)
			create toggle_b2.make ("toggle_b2", radio_widget)
			create toggle_b3.make ("toggle_b3", radio_widget)
			toggle_b1.set_text ("toggle_b1")
			toggle_b2.set_text ("toggle_b2")
			toggle_b3.set_text ("toggle_b3")
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


end -- class RADIO_BOX_DEMO_WINDOW


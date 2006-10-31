indexing
	legal: "See notice at end of class."
	status: "See notice at end of class."
class FRAME_DEMO_WINDOW

inherit

	DEMO_WINDOW

create

	make

feature

	button: PUSH_B

	main_widget: WIDGET is
		once
			create {FRAME} Result.make ("Frame", Current)
		end

	set_widgets is
		local
			f_widget: FRAME
		do
			set_size (230, 130)
			main_widget.set_x_y (30, 30)
			f_widget ?= main_widget
			f_widget.set_size (170, 70)
			create button.make ("button", f_widget)
			button.set_text ("Button")
			button.forbid_recompute_size
			button.set_size (100, 35)
			button.set_x_y (35, 17)
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


end -- class FRAME_DEMO_WINDOW


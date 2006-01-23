indexing
	legal: "See notice at end of class."
	status: "See notice at end of class."
class LABEL_DEMO_WINDOW

inherit

	DEMO_WINDOW

create

	make

feature

	main_widget: WIDGET is
		once
			create {LABEL} Result.make ("Label", Current)
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


end -- class LABEL_DEMO_WINDOW


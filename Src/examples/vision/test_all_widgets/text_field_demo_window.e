indexing
	legal: "See notice at end of class."
	status: "See notice at end of class."
class TEXT_FIELD_DEMO_WINDOW

inherit

	DEMO_WINDOW

create

	make

feature

	main_widget: WIDGET is
		once
			create {TEXT_FIELD} Result.make ("Text_field", Current)
		end

	set_widgets is
		local
			tf_widget: TEXT_FIELD
		do
			set_size (160, 100)
			main_widget.set_x_y (30, 30)
			tf_widget ?= main_widget
			tf_widget.set_size (100, 35)
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


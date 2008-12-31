note
	legal: "See notice at end of class."
	status: "See notice at end of class."
class FONT_BOX_D_DEMO_WINDOW

inherit

	ANY_DEMO_WINDOW

	FONT_BOX_D
		rename
			make as font_box_d_make
		end

create

	make

feature

	main_widget: WIDGET
		do
			Result:=Current
		end

	make(a_name: STRING; a_parent: COMPOSITE)
		do
			font_box_d_make (a_name, a_parent)
			set_widgets
		end

	set_widgets
		do
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


end -- class FONT_BOX_D_DEMO_WINDOW


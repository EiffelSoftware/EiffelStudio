class FONT_BOX_D_DEMO_WINDOW

inherit

	ANY_DEMO_WINDOW

	FONT_BOX_D
		rename
			make as font_box_d_make
		end

creation

	make

feature

	main_widget: WIDGET is
		do
			Result:=Current
		end

	make(a_name: STRING; a_parent: COMPOSITE) is
		do
			font_box_d_make (a_name, a_parent)
			set_widgets
		end

	set_widgets is
		do
		end

	work (arg: INTEGER_REF) is
		do
		end

end -- class FONT_BOX_D_DEMO_WINDOW

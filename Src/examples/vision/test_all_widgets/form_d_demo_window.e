class FORM_D_DEMO_WINDOW

inherit

	DEMO_WINDOW

creation

	make

feature

	main_widget: WIDGET is
		do
			Result:=Current
		end

	set_widgets is
		do
			set_size (250, 100)
			allow_resize
		end

	work (arg: INTEGER_REF) is
		do
		end

end -- class FORM_D_DEMO_WINDOW

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

--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------


class FRAME_DEMO_WINDOW

inherit

	DEMO_WINDOW

creation

	make

feature

	button: PUSH_B

	main_widget: WIDGET is
		once
			!FRAME!Result.make ("Frame", Current)
		end

	set_widgets is
		local
			f_widget: FRAME
		do
			set_size (230, 130)
			main_widget.set_x_y (30, 30)
			f_widget ?= main_widget
			f_widget.set_size (170, 70)
			!!button.make ("button", f_widget)
			button.set_text ("Button")
			button.forbid_recompute_size
			button.set_size (100, 35)
			button.set_x_y (35, 17)
		end

	work (arg: INTEGER_REF) is
		do
		end

end -- class FRAME_DEMO_WINDOW

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


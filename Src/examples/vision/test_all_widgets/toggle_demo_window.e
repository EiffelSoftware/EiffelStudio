class TOGGLE_DEMO_WINDOW

inherit

	DEMO_WINDOW

creation

	make

feature

	main_widget: WIDGET is
		once
			!TOGGLE_B!Result.make ("Toggle_b", Current)
		end

	set_widgets is
		local
			toggle_widget: TOGGLE_B
		do
			set_size (160, 100)
			main_widget.set_x_y (30, 30)
			toggle_widget ?= main_widget
			toggle_widget.forbid_recompute_size
			toggle_widget.set_size (100, 35)
			toggle_widget.set_text ("Toggle_b")
		end

	work (arg: INTEGER_REF) is
		do
		end

end

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


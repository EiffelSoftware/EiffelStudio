class OPT_PULL_DEMO_WINDOW

inherit

	DEMO_WINDOW

creation

	make

feature

	menu_entry1: MENU_B
	menu_entry2: MENU_B
	menu_entry3: MENU_B
	menu_entry4: MENU_B

	main_widget: WIDGET is
		once
			!OPT_PULL!Result.make ("Opt_pull", Current)
		end

	set_widgets is
		local
			opt_pull: OPT_PULL
		do
			set_size (160, 200)
			main_widget.set_x_y (30, 30)
			opt_pull ?= main_widget
			opt_pull.set_title ("Option pull")

			!!menu_entry1.make ("menu_entry1", opt_pull)
			menu_entry1.set_text ("Menu_entry1")
			!!menu_entry2.make ("menu_entry2", opt_pull)
			menu_entry2.set_text ("Menu_entry2")
			!!menu_entry3.make ("menu_entry3", opt_pull)
			menu_entry3.set_text ("Menu_entry3")
			!!menu_entry4.make ("menu_entry4", opt_pull)
			menu_entry4.set_text ("Menu_entry4")
		end

	work (arg: INTEGER_REF) is
		do
		end

end -- class OPT_PULL_DEMO_WINDOW

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


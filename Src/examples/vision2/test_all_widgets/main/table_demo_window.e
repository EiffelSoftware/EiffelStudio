indexing

	description:
		"";
	date: "$Date$";
	revision: "$Revision$"

class
	TABLE_DEMO_WINDOW

inherit

	DEMO_WINDOW
		redefine
			main_widget,
			set_widgets,
			set_values
		end

creation

	make

feature -- Access

	main_widget: EV_TABLE is
		once
			!!Result.make (Current)
			Result.set_minimum_size(300,300)
		end
	
feature -- Access
	
	note: EV_NOTEBOOK
	text: EV_TEXT_FIELD
	button: EV_BUTTON

feature -- Status setting
	
	set_widgets is
		do
			!! button.make_with_text (main_widget, "OK")
			main_widget.set_child_position (button, 0, 0, 3, 1)

			!! note.make (main_widget)
			!! button.make_with_text (note, "Press me")
			note.append_page (button, "Page 1")
			!! button.make_with_text (note, "Me too")
			note.append_page (button, "Page 2")
			main_widget.set_child_position (note, 1, 1, 3, 3)
			!! text.make (main_widget)
			main_widget.set_child_position (text, 0, 1, 1, 3)
		end
	
feature -- Status setting
	
	set_values is
		do
			set_title ("Dynamic table demo")
			main_widget.set_homogeneous (False)
		end

end -- class TABLE_DEMO_WINDOW

--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

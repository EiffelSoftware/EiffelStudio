indexing
	description: 
	"WINDOW1, main window for the application. Belongs to EiffelVision example."
	status: "See notice at end of class"
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"
	
class 
	MAIN_WINDOW

inherit
	EV_WINDOW
		redefine	
			make_top_level
		end

creation
	make_top_level

feature --Access

	box, box1: EV_VERTICAL_BOX
	box2, box3: EV_HORIZONTAL_BOX
	
	but: EV_BUTTON
	lab: EV_LABEL

feature -- Initialization
	
	make_top_level is
			-- Only one child allowed in the Current window
		do
			Precursor
			!! box.make (Current)	-- vertical
			box.set_spacing (5)
			box.set_homogeneous (False)
	
			!! box2.make (box)		-- horizontal
			box2.set_spacing (5)
			box2.set_homogeneous (False)

			!! but.make (box)
			but.set_text ("A button")
			box.set_child_expandable (but, False)

			!! box3.make (box)		-- horizontal
			box3.set_spacing (5)
			box3.set_homogeneous (False)
			!! but.make (box)
			but.set_text ("Another button")
			box.set_child_expandable (but, False)

			set_one (box2)
			set_two (box3)
			!! box1.make (box2)
			set_three (box1)
	end
	
feature -- Status setting
	
	set_one (par: EV_CONTAINER) is
			-- Create four button
		do
			!! but.make_with_text (par, "Hello World")
			!! but.make_with_text (par, "Bonjour monde")
			!! but.make_with_text (par, "Ola o mundo")
			!! but.make_with_text (par, "Hola el mundo")
		end

	set_two (par: EV_CONTAINER) is
			-- Create four button
		do
			!! but.make_with_text (par, "Hello World")
			!! but.make_with_text (par, "Bonjour monde")
			!! but.make_with_text (par, "Ola o mundo")
			!! but.make_with_text (par, "Hola el mundo")
		end


	set_three (par: EV_CONTAINER) is
		do
			!! lab.make_with_text (par, "Hy my friend")
			!! lab.make_with_text (par, "Salut mon pote")
			!! lab.make_with_text (par, "Ola o meu amigo")
			!! lab.make_with_text (par, "Hola amigo")
		end

end -- class MAIN_WINDOW

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
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


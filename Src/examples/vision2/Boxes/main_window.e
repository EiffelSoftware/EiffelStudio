indexing
	description: 
	"WINDOW1, main window for the application. Belongs to EiffelVision example."
	legal: "See notice at end of class."
	status: "See notice at end of class."
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

create
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
			create box.make (Current)	-- vertical
			box.set_spacing (5)
			box.set_homogeneous (False)
	
			create box2.make (box)		-- horizontal
			box2.set_spacing (5)
			box2.set_homogeneous (False)

			create but.make (box)
			but.set_text ("A button")
			box.set_child_expandable (but, False)

			create box3.make (box)		-- horizontal
			box3.set_spacing (5)
			box3.set_homogeneous (False)
			create but.make (box)
			but.set_text ("Another button")
			box.set_child_expandable (but, False)

			set_one (box2)
			set_two (box3)
			create box1.make (box2)
			set_three (box1)
	end
	
feature -- Status setting
	
	set_one (par: EV_CONTAINER) is
			-- Create four button
		do
			create but.make_with_text (par, "Hello World")
			create but.make_with_text (par, "Bonjour monde")
			create but.make_with_text (par, "Ola o mundo")
			create but.make_with_text (par, "Hola el mundo")
		end

	set_two (par: EV_CONTAINER) is
			-- Create four button
		do
			create but.make_with_text (par, "Hello World")
			create but.make_with_text (par, "Bonjour monde")
			create but.make_with_text (par, "Ola o mundo")
			create but.make_with_text (par, "Hola el mundo")
		end


	set_three (par: EV_CONTAINER) is
		do
			create lab.make_with_text (par, "Hy my friend")
			create lab.make_with_text (par, "Salut mon pote")
			create lab.make_with_text (par, "Ola o meu amigo")
			create lab.make_with_text (par, "Hola amigo")
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


end -- class MAIN_WINDOW


note
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
	EV_TITLED_WINDOW

create
	make_top_level

feature --Access

	box, box1: EV_VERTICAL_BOX
	box2, box3: EV_HORIZONTAL_BOX

	but: EV_BUTTON
	lab: EV_LABEL

feature -- Initialization

	make_top_level
			-- Only one child allowed in the Current window
		do
			make_with_title ("test")
			create box
			box.set_padding (5)
			box.disable_homogeneous
			extend (box)

			create box2		-- horizontal
			box.extend (box2)
			box2.set_padding (5)
			box2.disable_homogeneous

			create but
			box.extend (but)
			but.set_text ("A button")
			box.disable_item_expand (but)

			create box3		-- horizontal
			box.extend (box3)
			box3.set_padding (5)
			box3.disable_homogeneous
			create but
			box.extend (but)
			but.set_text ("Another button")
			box.disable_item_expand (but)

			set_one (box2)
			set_two (box3)
			create box1
			box2.extend (box1)
			set_three (box1)
	end

feature -- Status setting

	set_one (par: EV_CONTAINER)
			-- Create four button
		do
			create but.make_with_text ("Hello World")
			par.extend (but)
			create but.make_with_text ("Bonjour monde")
			par.extend (but)
			create but.make_with_text ("Ola o mundo")
			par.extend (but)
			create but.make_with_text ("Hola el mundo")
			par.extend (but)
		end

	set_two (par: EV_CONTAINER)
			-- Create four button
		do
			create but.make_with_text ("Hello World")
			par.extend (but)
			create but.make_with_text ("Bonjour monde")
			par.extend (but)
			create but.make_with_text ("Ola o mundo")
			par.extend (but)
			create but.make_with_text ("Hola el mundo")
			par.extend (but)
		end


	set_three (par: EV_CONTAINER)
		do
			create lab.make_with_text ("Hy my friend")
			par.extend (lab)
			create lab.make_with_text ("Salut mon pote")
			par.extend (lab)
			create lab.make_with_text ("Ola o meu amigo")
			par.extend (lab)
			create lab.make_with_text ("Hola amigo")
			par.extend (lab)
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


end -- class MAIN_WINDOW


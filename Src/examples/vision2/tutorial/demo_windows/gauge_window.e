indexing
	description:
		"The demo that goes with the gauge demo"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	GAUGE_WINDOW

inherit
	DEMO_WINDOW

	EV_TABLE
		redefine
			make
		end

create
	make

feature {NONE} -- Initialization

	make (par: EV_CONTAINER) is
			-- Create the demo in `par'.
			-- We create the box first without parent because it
			-- is faster.
		do
			Precursor {EV_TABLE} (Void)

			create g1.make(Current)
			set_child_position(g1,0,1,1,2)
			create g2.make(Current)
			set_child_position(g2,0,2,1,3)
			create s1.make(Current)
			set_child_position(s1,1,0,2,3)
			create g3.make(Current)
			set_child_position(g3,2,1,3,3)
			create s2.make(Current)
			set_child_position(s2,3,0,4,3)
			create g4.make(Current)
			set_child_position(g4,4,1,5,2)
			create g5.make(Current)
			set_child_position(g5,4,2,5,3)
			create t1.make_with_text(Current,"Range")
			set_child_position(t1,0,0,1,1)
			create t2.make_with_text(Current,"Spin Button")
			set_child_position(t2,2,0,3,1)
			create t3.make_with_text(Current,"Scroll Bar")
			set_child_position(t3,4,0,5,1)
			t1.set_vertical_resize(false)
			t1.set_horizontal_resize(false)
			t2.set_vertical_resize(false)
			t2.set_horizontal_resize(false)
			t3.set_vertical_resize(false)
			t3.set_horizontal_resize(false)

			set_parent(par)
		end

	set_tabs is
			-- Set the tabs for the action window.
		do
		end

feature -- Access

	g1: EV_HORIZONTAL_RANGE
	g2: EV_VERTICAL_RANGE
	g3: EV_SPIN_BUTTON
	g4: EV_HORIZONTAL_SCROLL_BAR
	g5: EV_VERTICAL_SCROLL_BAR
	s1: EV_HORIZONTAL_SEPARATOR
	s2: EV_HORIZONTAL_SEPARATOR
	t1: EV_LABEL
	t2: EV_LABEL
	t3: EV_LABEL;
	
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


end -- class BUTTON_WINDOW


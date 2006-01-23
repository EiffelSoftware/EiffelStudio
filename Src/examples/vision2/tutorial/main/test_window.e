indexing
	description:
		"The demo that goes with the button demo"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	TEST_WINDOW
inherit

	--DEMO_WINDOW
	--	rename
	--		make as demo_make
	--	end
		
	EV_HORIZONTAL_BOX
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
			Precursor {EV_HORIZONTAL_BOX} (Void)

			set_homogeneous (False)
			create test_but.make_with_text (Current,"TEST BUTTON")
			create test_but2.make_with_text (Current,"TEST BUTTON")

			set_parent (par)
		end

feature -- Access

	test_but ,test_but2: EV_BUTTON;

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

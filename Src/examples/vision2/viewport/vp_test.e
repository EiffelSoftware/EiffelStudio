indexing
	description: "Viewport example."
	author: "Vincent Brendel", "brendel@eiffel.com"
	date: "$Date$"
	revision: "$Revision$"

class
	VP_TEST

inherit
	EV_APPLICATION

create
	make_and_launch

feature -- Initialization

	prepare is
			-- Pack `first_window'.
		local
			vb: EV_VERTICAL_BOX
			vp: EV_VIEWPORT
			sa: EV_SCROLLABLE_AREA
		do
			create vb
			first_window.extend (vb)
			vb.extend (create {EV_LABEL}.make_with_text ("EV_VIEWPORT"))
			vb.disable_item_expand (vb.last)
			create vp.make_for_test
			vb.extend (vp)
			vb.extend (create {EV_LABEL}.make_with_text ("EV_SCROLLABLE_AREA"))
			vb.disable_item_expand (vb.last)
			create sa.make_for_test
			vb.extend (sa)
		end

	first_window: EV_TITLED_WINDOW is
			-- Window containing viewport and scr. area.
		once
			create Result.make_with_title ("Viewport example")
		end

end -- class VP_TEST

indexing
	description: "Viewport example."
	author: "Vincent Brendel", "brendel@eiffel.com"
	date: "$Date$"
	revision: "$Revision$"

class
	SA_TEST

inherit
	EV_APPLICATION

create
	make_and_launch

feature -- Initialization

	prepare is
			-- Pack `first_window'.
		local
			vsa: EV_VERTICAL_SPLIT_AREA
			hsa1: EV_HORIZONTAL_SPLIT_AREA
			hsa2: EV_HORIZONTAL_SPLIT_AREA
			hsa3: EV_HORIZONTAL_SPLIT_AREA
		do
			create vsa
			create hsa1
			create hsa2
			create hsa3
			first_window.extend (vsa)
			vsa.extend (hsa1)
			vsa.extend (hsa2)
			hsa1.extend (create {EV_BUTTON}.make_with_text ("Button1"))
			hsa1.extend (create {EV_BUTTON}.make_with_text ("Button2"))
			hsa2.extend (hsa3)
			hsa2.extend (create {EV_BUTTON}.make_with_text ("Button3"))
			hsa3.extend (create {EV_BUTTON}.make_with_text ("Button4"))
			hsa3.extend (create {EV_BUTTON}.make_with_text ("Button5"))
		end

	first_window: EV_TITLED_WINDOW is
			-- Window containing split areas.
		once
			create Result.make_with_title ("Split area example")
		end

end -- class SA_TEST

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


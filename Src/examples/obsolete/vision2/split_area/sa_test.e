indexing
	description: "Viewport example."
	legal: "See notice at end of class."
	status: "See notice at end of class."
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


end -- class SA_TEST


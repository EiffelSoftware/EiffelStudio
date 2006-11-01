indexing
	description: "Demo for polygons."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	Id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"

class
	POLYGON_ITEM

inherit
	FIGURE_ITEM

create
	make_with_title

feature -- Access

	figure: EV_POLYGON is
		local
			pt: EV_POINT
		do
			create Result.make
			Result.path.set_line_width (2)
			create pt.set (30, 50)
			Result.add (pt)
			create pt.set (150, 46)
			Result.add (pt)
			create pt.set (205, 209)
			Result.add (pt)
			create pt.set (64, 90)
			Result.add (pt)
			create pt.set (10, 60)
			Result.add (pt)
			create pt.set (40, 65)
			Result.add (pt)
			create pt.set (178, 34)
			Result.add (pt)
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


end -- class POLYGON_ITEM


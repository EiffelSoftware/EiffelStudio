indexing
	description: "Demo for pictures."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	Id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"

class
	PICTURE_ITEM

inherit
	FIGURE_ITEM

create
	make

feature {NONE} -- Initialization

	make (par: EV_TREE_ITEM_HOLDER) is
			-- Create the item and the demo that
			-- goes with it.
		do
			make_with_title (par, "EV_PICTURE")
		end

feature -- Access

	figure: EV_PICTURE is
		local
			pict: EV_PIXMAP
		do
			create Result.make
			create pict.make_from_file ("c:\winnt\winnt256.bmp")
			Result.set_pixmap (pict)
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


end -- class PICTURE_ITEM


note
	description: "This class represents the MCI_DGV_RECT_PARMS structure."
	status: "See notice at end of class."
	author: "Robin van Ommeren"
	date: "$Date$"
	revision: "$Revision$"

class
	WEX_MCI_DGV_RECT_PARMS

inherit
	WEX_MCI_GENERIC_PARMS
		rename
			make as generic_make
		redefine
			structure_size
		end

create
	make,
	make_by_pointer

feature {NONE} -- Initialization

	make (a_parent: WEL_COMPOSITE_WINDOW)
			-- Create object and fill structure.
		require
			a_parent_not_void: a_parent /= Void
			a_parent_exists: a_parent.exists
		do
			if not exists then
				structure_make
			end
			generic_make (a_parent)
		ensure
			exists: exists
		end

feature -- Status report

	rect: WEL_RECT
			-- Retrieved rectangle.
		require
			exists: exists
		local
			r: WEL_RECT
		do 
			create r.make_by_pointer (cwex_mci_dgv_rect_get_rect (item)) 

			--| The `right' member of the retrieved rectangle
			--| contains the width and the `bottom' member of the
			--| retrieved rectangle contains the height.
			create Result.make (r.left, r.top, r.right + r.left,
				r.bottom + r.top)
		ensure
			result_not_void: Result /= Void
			result_exists: Result.exists
		end

feature {WEL_STRUCTURE}

	structure_size: INTEGER
			-- Size to allocate (in bytes)
		once
			Result := c_size_of_mci_dgv_rect_parms
		end

feature {NONE} -- Externals

	c_size_of_mci_dgv_rect_parms: INTEGER
		external
			"C [macro <dgv_rect.h>]"
		alias
			"sizeof (MCI_DGV_RECT_PARMS)"
		end

	cwex_mci_dgv_rect_get_rect (ptr: POINTER): POINTER
		external
			"C [macro <dgv_rect.h>]"
		end

end -- class WEX_MCI_DGV_RECT_PARMS

--|-------------------------------------------------------------------------
--| WEX, Windows Eiffel library eXtension
--| Copyright (C) 1998  Robin van Ommeren, Andreas Leitner
--| See the file forum.txt included in this package for licensing info.
--|
--| Comments, Questions, Additions to this library? please contact:
--|
--| Robin van Ommeren						Andreas Leitner
--| Eikenlaan 54M								Arndtgasse 1/3/5
--| 7151 WT Eibergen							8010 Graz
--| The Netherlands							Austria
--| email: robin.van.ommeren@wxs.nl		email: andreas.leitner@teleweb.at
--| web: http://home.wxs.nl/~rommeren	web: about:blank
--|-------------------------------------------------------------------------
note
	description: "This class represents the MCI_DGV_WINDOW_PARMS structure."
	status: "See notice at end of class."
	author: "Robin van Ommeren"
	date: "$Date$"
	revision: "$Revision$"

class
	WEX_MCI_DGV_WINDOW_PARMS

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

feature -- Status setting

	set_display_window (a_display_window: WEL_COMPOSITE_WINDOW)
			-- Set the window for display.
		require
			exists: exists
			a_display_window_not_void: a_display_window /= Void
			a_display_window_exists: a_display_window.exists
		do
			cwex_mci_dgv_window_set_display_window (item,
				cwel_pointer_to_integer (a_display_window.item))
		end

	set_display_style (a_style: INTEGER)
			-- Set the style of display.
		require
			exists: exists
		do
			cwex_mci_dgv_window_set_display_style (item, a_style)
		end

	set_caption (a_caption: STRING)
			-- Set the caption for the display window.
		require
			exists: exists
			a_caption_not_void: a_caption /= Void
		local
			a: ANY
		do
			a := a_caption.to_c
			cwex_mci_dgv_window_set_caption (item, $a)
		end

feature {WEL_STRUCTURE}

	structure_size: INTEGER
			-- Size to allocate (in bytes)
		once
			Result := c_size_of_mci_dgv_window_parms
		end

feature {NONE} -- Externals

	c_size_of_mci_dgv_window_parms: INTEGER
		external
			"C [macro <dgv_win.h>]"
		alias
			"sizeof (MCI_DGV_WINDOW_PARMS)"
		end

	cwex_mci_dgv_window_set_display_window (ptr: POINTER; value: INTEGER)
		external
			"C [macro <dgv_win.h>]"
		end

	cwex_mci_dgv_window_set_display_style (ptr: POINTER; value: INTEGER)
		external
			"C [macro <dgv_win.h>]"
		end

	cwex_mci_dgv_window_set_caption (ptr: POINTER; value: POINTER)
		external
			"C [macro <dgv_win.h>]"
		end

	cwex_mci_dgv_window_get_display_window (ptr: POINTER): INTEGER
		external
			"C [macro <dgv_win.h>]"
		end

end -- class WEX_MCI_DGV_WINDOW_PARMS

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
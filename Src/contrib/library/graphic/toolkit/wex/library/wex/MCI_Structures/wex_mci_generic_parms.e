note
	description: "This class represents the MCI_GENERIC_PARMS structure."
	status: "See notice at end of class."
	author: "Robin van Ommeren"
	date: "$Date$"
	revision: "$Revision$"

class
	WEX_MCI_GENERIC_PARMS

inherit
	WEL_STRUCTURE
		rename
			make as structure_make
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
			set_call_back (a_parent.item)
		ensure
			exists: exists
		end

feature -- Status report

	call_back: POINTER
			-- Window used for notifications.
		require
			exists: exists
		do
			Result := cwex_mci_generic_get_callback (item)
		end

feature -- Status setting

	set_call_back (a_call_back: POINTER)
			-- Set window used for notifications.
		require
			exists: exists
		do
			cwex_mci_generic_set_callback (item, a_call_back)
		ensure
			call_back_set: call_back = a_call_back
		end

feature -- Measurements

	structure_size: INTEGER
			-- Size to allocate (in bytes)
		once
			Result := c_size_of_mci_generic_parms
		end

feature {NONE} -- Externals

	c_size_of_mci_generic_parms: INTEGER
		external
			"C [macro <generic.h>]"
		alias
			"sizeof (MCI_GENERIC_PARMS)"
		end

	cwex_mci_generic_set_callback (ptr: POINTER; value: POINTER)
		external
			"C [macro <generic.h>]"
		end

	cwex_mci_generic_get_callback (ptr: POINTER): POINTER
		external
			"C [macro <generic.h>]"
		end

end -- class WEX_MCI_GENERIC_PARMS

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

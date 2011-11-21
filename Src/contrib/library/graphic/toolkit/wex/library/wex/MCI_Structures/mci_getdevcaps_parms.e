note
	description: "This class represents the MCI_GETDEVCAPS_PARMS structure."
	status: "See notice at end of class."
	author: "Robin van Ommeren"
	date: "$Date$"
	revision: "$Revision$"

class
	WEX_MCI_GETDEVCAPS_PARMS

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

	query_result: INTEGER
			-- Result of query.
		require
			exists: exists
		do
			Result := cwex_mci_devcaps_get_result (item)
		end

feature -- Status setting

	set_devcap_item (value: INTEGER)
			-- Set item to query about.
		require
			exists: exists
		do
			cwex_mci_devcaps_set_item (item, value)
		end

feature {WEL_STRUCTURE}

	structure_size: INTEGER
			-- Size to allocate (in bytes)
		once
			Result := c_size_of_mci_devcaps_parms
		end

feature {NONE} -- Externals

	c_size_of_mci_devcaps_parms: INTEGER
		external
			"C [macro <devcaps.h>]"
		alias
			"sizeof (MCI_GETDEVCAPS_PARMS)"
		end

	cwex_mci_devcaps_set_item (ptr: POINTER; value: INTEGER)
		external
			"C [macro <devcaps.h>]"
		end

	cwex_mci_devcaps_get_result (ptr: POINTER): INTEGER
		external
			"C [macro <devcaps.h>]"
		end

end -- class WEX_MCI_GETDEVCAPS_PARMS

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
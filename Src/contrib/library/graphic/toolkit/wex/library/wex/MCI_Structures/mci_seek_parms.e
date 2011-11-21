note
	description: "This class represents the MCI_SEEK_PARMS structure."
	status: "See notice at end of class."
	author: "Robin van Ommeren"
	date: "$Date$"
	revision: "$Revision$"

class
	WEX_MCI_SEEK_PARMS

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

	make (a_parent: WEL_COMPOSITE_WINDOW; to_pos: INTEGER)
			-- Create object and fill structure.
		require
			a_parent_not_void: a_parent /= Void
			a_parent_exists: a_parent.exists
			positive_to_position: to_pos >= 0
		do
			if not exists then
				structure_make
			end
			generic_make (a_parent)
			set_position (to_pos)
		ensure
			exists: exists
		end

feature -- Status report

	position: INTEGER
			-- Position to seek to.
		require
			exists: exists
		do
			Result := cwex_mci_seek_get_to (item)
		end

feature -- Status setting

	set_position (pos: INTEGER)
			-- Set position to seek to.
		require
			exists: exists
		do
			cwex_mci_seek_set_to (item, pos)
		ensure
			position_set: position = pos
		end

feature -- Measurements

	structure_size: INTEGER
			-- Size to allocate (in bytes)
		once
			Result := c_size_of_mci_seek_parms
		end

feature {NONE} -- Externals

	c_size_of_mci_seek_parms: INTEGER
		external
			"C [macro <seek.h>]"
		alias
			"sizeof (MCI_SEEK_PARMS)"
		end

	cwex_mci_seek_set_to (ptr: POINTER; value: INTEGER)
		external
			"C [macro <seek.h>]"
		end

	cwex_mci_seek_get_to (ptr: POINTER): INTEGER
		external
			"C [macro <seek.h>]"
		end

end -- class WEX_MCI_SEEK_PARMS

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

note
	description: "This class represents the MCI_SAVE_PARMS structure."
	status: "See notice at end of class."
	author: "Robin van Ommeren"
	date: "$Date$"
	revision: "$Revision$"

class
	WEX_MCI_SAVE_PARMS

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

	set_file (file: STRING)
			-- Set filename to save to.
		require
			exists: exists
			file_not_void: file /= Void
			file_meaningful: not file.is_empty
		local
			a: ANY
		do
			a := file.to_c
			cwex_mci_save_set_file_name (item, $a)
		end

feature -- Measurements

	structure_size: INTEGER
			-- Size to allocate (in bytes)
		once
			Result := c_size_of_mci_save_parms
		end

feature {NONE} -- Externals

	c_size_of_mci_save_parms: INTEGER
		external
			"C [macro <save.h>]"
		alias
			"sizeof (MCI_SAVE_PARMS)"
		end

	cwex_mci_save_set_file_name (p, value: POINTER)
		external
			"C [macro <save.h>]"
		end

end -- class WEX_MCI_SAVE_PARMS

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

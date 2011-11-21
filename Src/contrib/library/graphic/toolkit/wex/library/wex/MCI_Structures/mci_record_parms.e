note
	description: "The class represents the MCI_RECORD_PARMS structure."
	status: "See notice at end of class."
	author: "Robin van Ommeren"
	date: "$Date$"
	revision: "$Revision$"

class
	WEX_MCI_RECORD_PARMS

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

	make (a_parent: WEL_COMPOSITE_WINDOW; from_pos, to_pos: INTEGER)
			-- Create object and fill structure.
		require
			a_parent_not_void: a_parent /= Void
			a_parent_exists: a_parent.exists
			positive_from_pos: from_pos >= 0
			positive_to_pos: to_pos >= 0
			consistent_pos: to_pos >= from_pos
		do
			if not exists then
				structure_make
			end
			generic_make (a_parent)
			set_record_start (from_pos)
			set_record_end (to_pos)
		ensure
			exists: exists
		end

feature -- Status report

	record_start: INTEGER
			-- Position to start recording.
		require
			exists: exists
		do
			Result := cwex_mci_record_get_from (item)
		end

	record_end: INTEGER
			-- Position to end recording.
		require
			exists: exists
		do
			Result := cwex_mci_record_get_to (item)
		end

feature -- Status setting

	set_record_start (start_pos: INTEGER)
			-- Set position to start recording from.
		require
			exists: exists
		do
			cwex_mci_record_set_from (item, start_pos)
		ensure
			record_start_position_set: record_start = start_pos
		end

	set_record_end (end_pos: INTEGER)
			-- Set position to end recording to.
		require
			exists: exists
		do
			cwex_mci_record_set_to (item, end_pos)
		ensure
			record_end_position_set: record_end = end_pos
		end

feature -- Measurements

	structure_size: INTEGER
			-- Size to allocate (in bytes)
		once
			Result := c_size_of_mci_record_parms
		end

feature {NONE} -- Externals

	c_size_of_mci_record_parms: INTEGER
		external
			"C [macro <record.h>]"
		alias
			"sizeof (MCI_RECORD_PARMS)"
		end

	cwex_mci_record_set_from (ptr: POINTER; value: INTEGER)
		external
			"C [macro <record.h>]"
		end

	cwex_mci_record_set_to (ptr: POINTER; value: INTEGER)
		external
			"C [macro <record.h>]"
		end

	cwex_mci_record_get_from (ptr: POINTER): INTEGER
		external
			"C [macro <record.h>]"
		end

	cwex_mci_record_get_to (ptr: POINTER): INTEGER
		external
			"C [macro <record.h>]"
		end

end -- class WEX_MCI_RECORD_PARMS

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

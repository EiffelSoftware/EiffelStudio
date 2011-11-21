note
	description: "This class represents the MCI_PLAY_PARMS structure."
	status: "See notice at end of class."
	author: "Robin van Ommeren"
	date: "$Date$"
	revision: "$Revision$"

class
	WEX_MCI_PLAY_PARMS

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

	make (a_parent: WEL_COMPOSITE_WINDOW; a_play_from, a_play_to: INTEGER)
			-- Make object and fill structure.
		require
			a_parent_not_void: a_parent /= Void
			a_parent_exists: a_parent.exists
			positive_play_from: a_play_from >= 0
			positive_play_to: a_play_from >= 0
		do
			if not exists then
				structure_make
			end
			generic_make (a_parent)
			set_play_from (a_play_from)
			set_play_to (a_play_to)
		ensure
			exists: exists
		end

feature -- Status report

	play_from: INTEGER
			-- Postion to play from.
		require
			exists: exists
		do
			Result := cwex_mci_play_get_from (item)
		ensure
			positive_result: Result >= 0
		end

	play_to: INTEGER
			-- Position to play to.
		require
			exists: exists
		do
			Result := cwex_mci_play_get_to (item)
		ensure
			positive_result: Result >= 0
		end

feature -- Status setting

	set_play_from (a_play_from: INTEGER)
			-- Set postion to play from.
		require
			exists: exists
			positive_position: a_play_from >= 0
		do
			cwex_mci_play_set_from (item, a_play_from)
		ensure
			play_from_set: play_from = a_play_from
		end

	set_play_to (a_play_to: INTEGER)
			-- Set position to play to.
		require
			exists: exists
			positive_position: a_play_to >= 0
		do
			cwex_mci_play_set_to (item, a_play_to)
		ensure
			play_to_set: play_to = a_play_to
		end
		
feature {WEL_STRUCTURE}

	structure_size: INTEGER
			-- Size to allocate (in bytes)
		once
			Result := c_size_of_mci_play_parms
		end

feature {NONE} -- Externals

	c_size_of_mci_play_parms: INTEGER
		external
			"C [macro <play.h>]"
		alias
			"sizeof (MCI_PLAY_PARMS)"
		end

	cwex_mci_play_set_from (p: POINTER; value: INTEGER)
		external
			"C [macro <play.h>]"
		end

	cwex_mci_play_set_to (p: POINTER; value: INTEGER)
		external
			"C [macro <play.h>]"
		end


	cwex_mci_play_get_from (p: POINTER): INTEGER
		external
			"C [macro <play.h>]"
		end

	cwex_mci_play_get_to (p: POINTER): INTEGER
		external
			"C [macro <play.h>]"
		end

end -- class WEX_MCI_PLAY_PARMS

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
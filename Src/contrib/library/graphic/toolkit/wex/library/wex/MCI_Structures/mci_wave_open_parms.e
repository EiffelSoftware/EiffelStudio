note
	description: "This class represents the MCI_WAVE_OPEN_PARMS structure."
	status: "See notice at end of class."
	author: "Robin van Ommeren"
	date: "$Date$"
	revision: "$Revision$"

class
	WEX_MCI_WAVE_OPEN_PARMS

inherit
	WEX_MCI_OPEN_PARMS
		rename
			make as open_make
		redefine
			structure_size
		end

create
	make,
	make_by_pointer

feature -- Initialization

	make (a_parent: WEL_COMPOSITE_WINDOW; a_device: STRING)
			-- Create object and fill structure.
		require
			a_device_not_void: a_device /= Void
			a_device_not_empty: not a_device.empty
			a_parent_not_void: a_parent /= Void
			a_parent_exists: a_parent.exists
		do
			if not exists then
				structure_make
			end
			open_make (a_parent, a_device)
		ensure
			exists: exists
		end

feature -- Status report

	buffer_size: INTEGER
			-- Buffer size
		require
			exists: exists
		do
			Result := cwex_mci_wave_open_get_buffer_seconds (item)
		end

feature -- Status setting

	set_buffer_size (size: INTEGER)
			-- Set buffer size in seconds.
		require
			exists: exists
		do
			cwex_mci_wave_open_set_buffer_seconds (item,
				size)
		ensure
			buffer_size_set: buffer_size = size
		end

feature {WEL_STRUCTURE}

	structure_size: INTEGER
			-- Size to allocate (in bytes)
		once
			Result := c_size_of_mci_wave_open_parms
		end

feature {NONE} -- Externals

	c_size_of_mci_wave_open_parms: INTEGER
		external
			"C [macro <wave_open.h>]"
		alias
			"sizeof (MCI_WAVE_OPEN_PARMS)"
		end

	cwex_mci_wave_open_set_buffer_seconds (ptr: POINTER; value: INTEGER)
		external
			"C [macro <wave_open.h>]"
		end

	cwex_mci_wave_open_get_buffer_seconds (ptr: POINTER): INTEGER
		external
			"C [macro <wave_open.h>]"
		end

end -- class WEX_MCI_WAVE_OPEN_PARMS

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
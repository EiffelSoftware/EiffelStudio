note
	description: "This class represents the MCI sequencer device."
	status: "See notice at end of class."
	author: "Robin van Ommeren"
	date: "$Date$"
	revision: "$Revision$"

class
	WEX_MCI_SEQUENCER

inherit
	WEX_MCI_DEVICE

create
	make

feature -- Access

	seek_to (a_position: INTEGER)
			-- Position the MIDI file at `position' in milliseconds.
		require
			opened: opened
			a_positive_position: a_position >= 0
			a_meaningful_position: a_position <= media_length
		local
			seek_parms: WEX_MCI_SEEK_PARMS
		do 
			create seek_parms.make (parent, a_position)
			seek_device (seek_parms, Mci_to)
		end

	open (a_file: STRING)
			-- Open a Mci device to play a MIDI file.
		require
			not_opened: not opened
			a_file_not_void: a_file /= Void
			a_file_meaningful: not a_file.empty
		local
			open_parms: WEX_MCI_OPEN_PARMS
		do 
			create open_parms.make (parent, device_name)
			open_parms.set_element_name (a_file)
			open_device (open_parms, Mci_open_element +
				Mci_open_type)
		end

feature {NONE} -- Implementation

	device_name: STRING
			-- Device name
		once
			Result := "sequencer"
		end

end -- class WEX_MCI_SEQUENCER

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
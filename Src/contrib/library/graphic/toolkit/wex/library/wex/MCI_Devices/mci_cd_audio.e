note
	description: "This class represents the cdaudio MCI device."
	status: "See notice at end of class."
	author: "Robin van Ommeren"
	date: "$Date$"
	revision: "$Revision$"

Class
	WEX_MCI_CD_AUDIO

inherit
	WEX_MCI_DEVICE

	WEX_MCI_MACROS
		export
			{NONE} all
		end

	WEX_MCI_STATUS_CD_AUDIO_CONSTANTS
		export
			{NONE} all
		end

	WEX_MCI_FORMAT_CONSTANTS
		export
			{NONE} all
		end

create
	make

feature -- Access

	media_present: BOOLEAN
			-- Is there a CD in the drive?
		require
			opened: opened
		do
			Result := query_status_item (Mci_status_media_present) /= 0
		end

	is_audio_track (track: INTEGER): BOOLEAN
			-- Is `track' an audio track?
		require
			opened: opened
		do
			Result := query_track (track, Mci_cda_status_type_track) =
				Mci_cda_track_audio
		end

	seek_to (a_position: INTEGER)
			-- Position current track at `to'.
		require
			opened: opened
			a_positive_position: a_position >= 0
			a_valid_position: a_position <= number_of_tracks
		local
			seek_parms: WEX_MCI_SEEK_PARMS
		do 
			create seek_parms.make (parent, a_position)
			seek_device (seek_parms, Mci_to)
		end

	open
			-- Open the cdaudio device.
		require
			not_opened: not opened
		local
			open_parms: WEX_MCI_OPEN_PARMS
		do 
			create open_parms.make (parent, device_name)
			open_device (open_parms, Mci_open_type)
		end

	open_shared
			-- Open the cdaudio device shared.
		local
			open_parms: WEX_MCI_OPEN_PARMS
		do 
			create open_parms.make (parent, device_name)
			open_device (open_parms, Mci_open_type +
				Mci_open_shareable)
		end

	set_format_tmsf
			-- Set time format to tracks/minutes/seconds/frames.
		require
			opened: opened
		local
			set_parms: WEX_MCI_SET_PARMS
		do 
			create set_parms.make (parent)
			set_parms.set_time_format (Mci_format_tmsf)
			set_device (set_parms, Mci_set_time_format)
		ensure
			tmsf_format: tmsf_format
		end

	play_track (track: INTEGER)
			-- Start playback of track `track'.
		require
			opened: opened
			tmsf_format: tmsf_format
			track_minimum: track > 0
			track_maximum: track <= number_of_tracks
		local
			play_parms: WEX_MCI_PLAY_PARMS
			from_pos: INTEGER
			to_pos: INTEGER
		do
			from_pos := cwin_mci_make_tmsf (track, 0, 0, 0)
			to_pos := cwin_mci_make_tmsf (track + 1, 0, 0, 0) 
			create play_parms.make (parent, from_pos, to_pos)
			if not (track = number_of_tracks) then
				play_device (play_parms, Mci_from + Mci_to)
			else
				play_device (play_parms, Mci_from)
			end
		end

	play_track_continue (track: INTEGER)
			-- Start playback of track `track' and play any
			-- tracks after `track'.
		require
			opened: opened
			tmsf_format: tmsf_format
			track_minimum: track > 0
			track_maximum: track <= number_of_tracks
		local
			play_parms: WEX_MCI_PLAY_PARMS
			from_pos: INTEGER
		do
			from_pos := cwin_mci_make_tmsf (track, 0, 0, 0) 
			create play_parms.make (parent, from_pos, 0)
			play_device (play_parms, Mci_from)
		end

feature {NONE} -- Implementation

	device_name: STRING
			-- Device name
		once
			Result := "cdaudio"
		end

end -- class WEX_MCI_CD_AUDIO

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
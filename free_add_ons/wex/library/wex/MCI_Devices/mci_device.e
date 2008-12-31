note
	description: "Abstract notions of a MCI device."
	status: "See notice at end of class."
	author: "Robin van Ommeren"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	WEX_MCI_DEVICE

inherit
	WEL_ANY
		redefine
			destroy_item
		end

	WEL_MESSAGE_BOX
		export
			{NONE} all
		end

	WEL_MB_CONSTANTS
		export
			{NONE} all
		end

	WEL_ID_CONSTANTS
		export
			{NONE} all
		end

	WEX_MCI_MACROS
		export
			{NONE} all
		end

	WEX_MCI_DEVICE_TYPES_CONSTANTS
		export
			{NONE} all
		end

	WEX_MCI_FORMAT_CONSTANTS
		export
			{NONE} all
		end

	WEX_MCI_STATUS_CONSTANTS
		export
			{NONE} all
		end

	WEX_MCI_MODE_CONSTANTS
		export
			{NONE} all
		end

	WEX_MCI_GETDEVCAPS_CONSTANTS
		export
			{NONE} all
		end

	WEX_MCI_SEEK_CONSTANTS
		export
			{NONE} all
		end

	WEX_MCI_SET_CONSTANTS
		export
			{NONE} all
		end

	WEL_WORD_OPERATIONS
		export
			{NONE} all
		end

	WEL_BIT_OPERATIONS
		export
			{NONE} all
		end

	WEX_MCI_CONSTANTS
		export
			{NONE} all
		end

feature {NONE} -- Initialization

	make (a_parent: like parent)
			-- Set the parent for notifications.
		do
			parent := a_parent
		end

feature -- Basic operations

	seek_start
			-- Position at beginning of the media / track.
		require
			opened: opened
		local
			seek_parms: WEX_MCI_SEEK_PARMS
		do 
			create seek_parms.make (parent, 0)
			seek_device (seek_parms, Mci_seek_to_start)
		end

	seek_end
			-- Position at end of the media / track.
		require
			opened: opened
		local
			seek_parms: WEX_MCI_SEEK_PARMS
		do 
			create seek_parms.make (parent, 0)
			seek_device (seek_parms, Mci_seek_to_end)
		end

	close
			-- Close the device.
		require
			opened: opened
		local
			generic_parms: WEX_MCI_GENERIC_PARMS
		do 
			create generic_parms.make (parent)
			close_device (generic_parms, 0)
		end

	play
			-- Play from current position to the
			-- end of the media / track
		require
			opened: opened
			can_play: can_play
		local
			play_parms: WEX_MCI_PLAY_PARMS
		do 
			create play_parms.make (parent, 0, 0)
			play_device (play_parms, 0)
		end

	stop
			-- Stop playback or recording.
		require
			opened: opened
		local
			generic_parms: WEX_MCI_GENERIC_PARMS
		do 
			create generic_parms.make (parent)
			stop_device (generic_parms, 0)
		end

	pause
			-- Pause playback.
		require
			opened: opened
		local
			generic_parms: WEX_MCI_GENERIC_PARMS
		do 
			create generic_parms.make (parent)
			pause_device (generic_parms, 0)
		end

	resume
			-- Resume playback.
			--| Although CD audio, MIDI sequencer, and videodisc
			--| devices also recognize this command, the MCICDA,
			--| MCISEQ, and MCIPIONR device drivers do not
			--| support it.
		require
			opened: opened
		local
			generic_parms: WEX_MCI_GENERIC_PARMS
		do 
			create generic_parms.make (parent)
			resume_device (generic_parms, 0)
		end

	disable_left_audio_channel
			-- Silence the left audio channel.
		require
			opened: opened
			has_audio: has_audio
		local
			set_parms: WEX_MCI_SET_PARMS
		do 
			create set_parms.make (parent)
			set_parms.set_audio_channel (Mci_set_audio_left)
			set_device (set_parms, Mci_set_audio + Mci_set_off)
		end

	disable_right_audio_channel
			-- Silence the right audio channel.
		require
			opened: opened
			has_audio: has_audio
		local
			set_parms: WEX_MCI_SET_PARMS
		do 
			create set_parms.make (parent)
			set_parms.set_audio_channel (Mci_set_audio_right)
			set_device (set_parms, Mci_set_audio + Mci_set_off)
		end

	enable_left_audio_channel
			-- Enable the left audio channel.
		require
			opened: opened
			has_audio: has_audio
		local
			set_parms: WEX_MCI_SET_PARMS
		do 
			create set_parms.make (parent)
			set_parms.set_audio_channel (Mci_set_audio_left)
			set_device (set_parms, Mci_set_audio + Mci_set_on)
		end

	enable_right_audio_channel
			-- Enable the right audio channel.
		require
			opened: opened
			has_audio: has_audio
		local
			set_parms: WEX_MCI_SET_PARMS
		do 
			create set_parms.make (parent)
			set_parms.set_audio_channel (Mci_set_audio_right)
			set_device (set_parms, Mci_set_audio + Mci_set_on)
		end

	disable_all_audio_channels
			-- Disable left and right audio channel.
		require
			opened: opened
			has_audio: has_audio
		local
			set_parms: WEX_MCI_SET_PARMS
		do 
			create set_parms.make (parent)
			set_parms.set_audio_channel (Mci_set_audio_all)
			set_device (set_parms, Mci_set_audio + Mci_set_off)
		end

	enable_all_audio_channels
			-- Enable left and right audio channel.
		require
			opened: opened
			has_audio: has_audio
		local
			set_parms: WEX_MCI_SET_PARMS
		do 
			create set_parms.make (parent)
			set_parms.set_audio_channel (Mci_set_audio_all)
			set_device (set_parms, Mci_set_audio + Mci_set_on)
		end		

feature -- Status report

	opened: BOOLEAN
			-- Is the device opened?

	device_id: INTEGER
			-- Identifier of opened device
		do
			Result := cwel_pointer_to_integer (item)
		end

	command_success: BOOLEAN
			-- Did the last command succeed?
		do
			Result := error = 0
		end

	last_error: STRING
			-- Text of last error occured.
		local
			a: ANY
			success: BOOLEAN
		do 
			create Result.make (Maximum_error_buffer)
			Result.fill_blank
			a := Result.to_c
			success := cwin_mci_get_error_string (error, $a,
				Maximum_error_buffer)
			if not success then
				Result := "Unidentified error"
			end
			Result.right_adjust
			Result.head (Result.count - 1)
		ensure
			result_not_void: Result /= Void
		end

	error: INTEGER
			-- Identifier of last error.

	compound_device: BOOLEAN
			-- Is the device a compound device?
		require
			opened: opened
		do
			Result := query_device_capability (
				Mci_getdevcaps_compound_device) /= 0
		end

	animation_device: BOOLEAN
			-- Is current device a animation device?
		require
			opened: opened
		do
			Result := query_device_capability (
				Mci_getdevcaps_device_type) =
				Mci_devtype_animation
		end

	cd_audio_device: BOOLEAN
			-- Is current device a CD audio device?
		require
			opened: opened
		do
			Result := query_device_capability (
				Mci_getdevcaps_device_type) =
				Mci_devtype_cd_audio
		end

	dat_device: BOOLEAN
			-- Is current device a CD audio device?
		require
			opened: opened
		do
			Result := query_device_capability (
				Mci_getdevcaps_device_type) = Mci_devtype_dat
		end

	digital_video_device: BOOLEAN
			-- Is current device a digital video device?
		require
			opened: opened
		do
			Result := query_device_capability (
				Mci_getdevcaps_device_type) =
				Mci_devtype_digital_video
		end

	other_device: BOOLEAN
			-- Is current device an other device?
		require
			opened: opened
		do
			Result := query_device_capability (
				Mci_getdevcaps_device_type) = Mci_devtype_other
		end

	overlay_device: BOOLEAN
			-- Is current device an overlay device?
		require
			opened: opened
		do
			Result := query_device_capability (
				Mci_getdevcaps_device_type) =
				Mci_devtype_overlay
		end

	scanner_device: BOOLEAN
			-- Is current device a scanner device?
		require
			opened: opened
		do
			Result := query_device_capability (
				Mci_getdevcaps_device_type) =
				Mci_devtype_scanner
		end

	sequencer_device: BOOLEAN
			-- Is current device a sequencer device?
		require
			opened: opened
		do
			Result := query_device_capability (
				Mci_getdevcaps_device_type) =
				Mci_devtype_sequencer
		end

	vcr_device: BOOLEAN
			-- Is current device a vcr device?
		require
			opened: opened
		do
			Result := query_device_capability (
				Mci_getdevcaps_device_type) = Mci_devtype_vcr
		end

	video_disc_device: BOOLEAN
			-- Is current device a digital video device?
		require
			opened: opened
		do
			Result := query_device_capability (
				Mci_getdevcaps_device_type) =
				Mci_devtype_videodisc
		end

	wave_audio_device: BOOLEAN
			-- Is current device a wave audio device?
		require
			opened: opened
		do
			Result := query_device_capability (
				Mci_getdevcaps_device_type) =
				Mci_devtype_waveform_audio
		end

	has_audio: BOOLEAN
			-- Is this device using audio?
		require
			opened: opened
		do
			Result := query_device_capability_item (
				Mci_getdevcaps_item,
				Mci_getdevcaps_has_audio) /= 0
		end

	has_video: BOOLEAN
			-- Is this device using video?
		require
			opened: opened
		do
			Result := query_device_capability_item (
				Mci_getdevcaps_item,
				Mci_getdevcaps_has_video) /= 0
		end

	uses_files: BOOLEAN
			-- Does this device need to use files?
		require
			opened: opened
		do
			Result := query_device_capability (
				Mci_getdevcaps_uses_files) /= 0
		end

	can_eject: BOOLEAN
			-- Can this device eject it's media?
		require
			opened: opened
		do
			Result := query_device_capability_item (
				Mci_getdevcaps_item,
				Mci_getdevcaps_can_eject) /= 0
		end

	can_play: BOOLEAN
			-- Can this device play it's media?
			--| This implies the commands play and
			--| stop are supported by this device.
		require
			opened: opened
		do
			Result := query_device_capability_item (
				Mci_getdevcaps_item,
				Mci_getdevcaps_can_play) /= 0
		end

	can_record: BOOLEAN
			-- Can this device record using it's media?
		require
			opened: opened
		do
			Result := query_device_capability_item (
				Mci_getdevcaps_item,
				Mci_getdevcaps_can_record) /= 0
		end

	can_save: BOOLEAN
			-- Can the device save it's media?
		require
			opened: opened
		do
			Result := query_device_capability_item (
				Mci_getdevcaps_item,
				Mci_getdevcaps_can_save) /= 0
		end

	bytes_format: BOOLEAN
			-- Is the device using bytes as time format?
		require
			opened: opened
		do
			Result := query_status_item (Mci_status_time_format) =
				Mci_format_bytes
		end

	frames_format: BOOLEAN
			-- Is the device using frames as time format?
		require
			opened: opened
		do
			Result := query_status_item (Mci_status_time_format) =
				Mci_format_frames
		end

	hms_format: BOOLEAN
			-- Is the device using hms as time format?
		require
			opened: opened
		do
			Result := query_status_item (Mci_status_time_format) =
				Mci_format_hms
		end

	milliseconds_format: BOOLEAN
			-- Is the device using milliseconds as time format?
		require
			opened: opened
		do
			Result := query_status_item (Mci_status_time_format) =
				Mci_format_milliseconds
		end

	msf_format: BOOLEAN
			-- Is the device using msf as time format?	
		require
			opened: opened
		do
			Result := query_status_item (Mci_status_time_format) =
				Mci_format_msf
		end

	samples_format: BOOLEAN
			-- Is the device using samples as time format?
		require
			opened: opened
		do
			Result := query_status_item (Mci_status_time_format) =
				Mci_format_samples
		end

	tmsf_format: BOOLEAN
			-- Is the device using tmsf as time format?
		require
			opened: opened
		do
			Result := query_status_item (Mci_status_time_format) =
				Mci_format_tmsf
		end

	track_number: INTEGER
			-- Current track number.
			-- |MCI uses continuous track numbers.
		require
			opened: opened
		do
			Result := query_status_item (Mci_status_current_track)
		ensure
			positive_result: Result >= 0
		end

	number_of_tracks: INTEGER
			-- Total number of playable tracks.
		require
			opened: opened
		do
			Result := query_status_item (Mci_status_number_of_tracks)
		end

	position: INTEGER
			-- Current position.
		require
			opened: opened
		do
			Result := query_status_item (Mci_status_position)
		ensure
			result_smaller_equal_media_length: Result <= media_length
			positive_result: Result >= 0
		end

	media_length: INTEGER
			-- Total media length.
		require
			opened: opened
		do
			Result := query_status_item (Mci_status_length)
		ensure
			positive_result: Result >= 0
		end

	ready: BOOLEAN
			-- Is the device ready?
		require
			opened: opened
		do
			Result := query_status_item (Mci_status_ready) /= 0
		end

	track_start (a_track: INTEGER): INTEGER
			-- The starting position of a track.
		require
			opened: opened
		do
			Result := query_track (a_track, Mci_status_position)
		ensure
			positive_result: Result >= 0
		end

	track_length (a_track: INTEGER): INTEGER
			-- The length of a track
		require
			opened: opened
		do
			Result := query_track (a_track, Mci_status_length)
		ensure
			positive_result: Result >= 0
		end

	start_position: INTEGER
			-- The starting position of the media.
		require
			opened: opened
		local
			status_parms: WEX_MCI_STATUS_PARMS
		do 
			create status_parms.make (parent, Mci_status_item +
				Mci_status_start)
			status_device (status_parms, Mci_status_position)
			Result := status_parms.query_result
		ensure
			positive_result: Result >= 0
		end

	paused: BOOLEAN
			-- Is the device paused?
		require
			opened: opened
		do
			Result := query_status_item (Mci_status_mode) =
				Mci_mode_pause
		end

	playing: BOOLEAN
			-- Is the device playing?
		require
			opened: opened
		do
			Result := query_status_item (Mci_status_mode) =
				Mci_mode_play
		end

	stopped: BOOLEAN
			-- Is the device stopped?
		require
			opened: opened
		do
			Result := query_status_item (Mci_status_mode) =
				Mci_mode_stop
		end

	device_opened: BOOLEAN
			-- Is the device physically opened?
		require
			opened: opened
		do
			Result := query_status_item (Mci_status_mode) =
				Mci_mode_open
		end

	recording: BOOLEAN
			-- Is the device recording?
		require
			opened: opened
		do
			Result := query_status_item (Mci_status_mode) =
				Mci_mode_record
		end

	seeking: BOOLEAN
			-- Is the device seeking?
		require
			opened: opened
		do
			Result := query_status_item (Mci_status_mode) =
				Mci_mode_seek
		end

	notify_enabled: BOOLEAN
			-- Is notification enabled?
		do
			Result := flag_set (command_flags, Mci_notify)
		end

	wait_enabled: BOOLEAN
			-- Is waiting for command completion enabled?
		do
			Result := flag_set (command_flags, Mci_wait)
		end

	parent: WEL_COMPOSITE_WINDOW
			-- Parent window to handle the notifications.

	strict: BOOLEAN
			-- Will an exception be raised on a send_command
			-- failure?
			--| Assertion level needs to be `ensure' or `all'

feature -- Status setting

	set_strict (flag: BOOLEAN)
			-- If `flag' is set, an exception will be
			-- raised when a command failes.
			--| Assertion level needs to be `ensure' or `all'
			--| Note: an exception is raised whenever a command
			--| fails, even if the hardware simply doesn't
			--| support the command. This flag is intended to be
			--| used during development.
		do
			strict := flag
		end

	enable_wait
			-- Enable waiting for command completion.
		do
			command_flags := set_flag (command_flags, Mci_wait)
		end

	disable_wait
			-- Disable waiting for command completion.
		do
			command_flags := clear_flag (command_flags, Mci_wait)
		end

	enable_notify
			-- Enable notification to parent on command completion.
		do
			command_flags := set_flag (command_flags, Mci_notify)
		end

	disable_notify
			-- Disable notification to parent on command completion.
		do
			command_flags := clear_flag (command_flags, Mci_notify)
		end

feature {NONE} -- Implementation

	command_flags: INTEGER
			-- Flags used for mci commands.

	old_notify_flag: BOOLEAN

	save_state
		do
			old_notify_flag := notify_enabled
			disable_notify
		end

	restore_state
		do
			if old_notify_flag then
				enable_notify
			end
		end

	status_device (parms: WEX_MCI_STATUS_PARMS; status_flags: INTEGER)
			-- Query the status of an device.
		require
			opened: opened
			parms_not_void: parms /= Void
			parms_exists: parms.exists
		do
			save_state
			send_command (Mci_status, status_flags, parms)
			restore_state
		end

	getdevcaps_device (parms: WEX_MCI_GENERIC_PARMS; devcaps_flags: INTEGER)
			-- Query a device about it's capabilities.
		require
			opened: opened
			parms_not_void: parms /= Void
			parms_exists: parms.exists
		do
			save_state
			send_command (Mci_getdevcaps, devcaps_flags, parms)
			restore_state
		end

	set_device (parms: WEX_MCI_SET_PARMS; set_flags: INTEGER)
			-- Apply settings to a device.
		require
			opened: opened
			parms_not_void: parms /= Void
			parms_exists: parms.exists
		do
			send_command (Mci_set, set_flags, parms)
		end

	cue_device (parms: WEX_MCI_GENERIC_PARMS; cue_flags: INTEGER)
			-- Cue a device for faster response on play or record.
		require
			opened: opened
			parms_not_void: parms /= Void
			parms_exists: parms.exists
		do
			send_command (Mci_cue, cue_flags, parms)
		end

	resume_device (parms: WEX_MCI_GENERIC_PARMS; resume_flags: INTEGER)
			-- Resume playing/recording on a device.
		require
			opened: opened
			parms_not_void: parms /= Void
			parms_exists: parms.exists
		do
			send_command (Mci_resume, resume_flags, parms)
		end

	pause_device (parms: WEX_MCI_GENERIC_PARMS; pause_flags: INTEGER)
			-- Pause a device.
		require
			opened: opened
			parms_not_void: parms /= Void
			parms_exists: parms.exists
		do
			send_command (Mci_pause, pause_flags, parms)
		end

	stop_device (parms: WEX_MCI_GENERIC_PARMS; stop_flags: INTEGER)
			-- Stop a device.
		require
			opened: opened
			parms_not_void: parms /= Void
			parms_exists: parms.exists
		do
			send_command (Mci_stop, stop_flags, parms)
		end

	seek_device (parms: WEX_MCI_SEEK_PARMS; seek_flags: INTEGER)
			-- Seek a device.
		require
			opened: opened
			parms_not_void: parms /= Void
			parms_exists: parms.exists
		do
			send_command (Mci_seek, seek_flags, parms)
		end

	play_device (parms: WEX_MCI_PLAY_PARMS; play_flags: INTEGER)
			-- Start playing on a device.
		require
			opened: opened
			parms_not_void: parms /= Void
			parms_exists: parms.exists
		do
			send_command (Mci_play, play_flags, parms)
		end

	record_device (parms: WEX_MCI_RECORD_PARMS; record_flags: INTEGER)
			-- Start recording on a device.
		require
			opened: opened
			parms_not_void: parms /= Void
			parms_exists: parms.exists
		do
			send_command (Mci_record, record_flags, parms)
		end

	close_device (parms: WEX_MCI_GENERIC_PARMS; close_flags: INTEGER)
			-- Close the device.
		require
			opened: opened
			parms_not_void: parms /= Void
			parms_exists: parms.exists
		local
			wait_was_enabled: BOOLEAN
		do
			if wait_enabled then
				wait_was_enabled := True
			else
				enable_wait
			end
			send_command (Mci_close, close_flags, parms)
			if not wait_was_enabled then
				disable_wait
			end
			if command_success then
				item := default_pointer
				opened := False
			end
		end

	open_device (parms: WEX_MCI_OPEN_PARMS; open_flags: INTEGER)
			-- Open an mci device with `parms'
		require
			parms_not_void: parms /= Void
			parms_exists: parms.exists
		local
			wait_was_enabled: BOOLEAN
		do
			if wait_enabled then
				wait_was_enabled := True
			else
				enable_wait
			end
			send_command (Mci_open, open_flags, parms)
			if not wait_was_enabled then
				disable_wait
			end
			if command_success then
				item := cwel_integer_to_pointer (
					parms.device_id)
				opened := True
			end
		end

	send_command (command, flags: INTEGER; parms: WEX_MCI_GENERIC_PARMS)
			-- Send a command to the device and
			-- save the possible error.
		require
			parms_not_void: parms /= Void
			parms_exists: parms.exists
		do
			error := cwin_mci_send_command_result (
				cwel_pointer_to_integer (item), command,
				flags + command_flags, parms.to_integer)
		ensure
			strictness: strict implies raise_error_on_command_failure
		end

	query_track (a_track, a_item: INTEGER): INTEGER
			-- Query a device about `a_item' for a
			-- specific track `a_track'.
		require
			opened: opened
			a_track_small_enough: a_track <= number_of_tracks
			a_track_large_enough: a_track >= 0
		local
			status_parms: WEX_MCI_STATUS_PARMS
		do 
			create status_parms.make (parent, a_item)
			status_parms.set_track (a_track)
			status_device (status_parms, Mci_status_item + Mci_track)
			if command_success then
				Result := status_parms.query_result
			end
		end

	query_device_capability_item (a_item: INTEGER; a_cap: INTEGER): INTEGER
			-- Query the device capability `a_cap' about
			-- an item `a_item'.
		require
			opened: opened
		local
			devcaps_parms: WEX_MCI_GETDEVCAPS_PARMS
		do 
			create devcaps_parms.make (parent)
			devcaps_parms.set_devcap_item (a_cap)
			getdevcaps_device (devcaps_parms, a_item)
			Result := devcaps_parms.query_result
		end			

	query_device_capability (a_item: INTEGER): INTEGER
			-- Query a device about the capability of `a_item'.
		require
			opened: opened
		local
			devcaps_parms: WEX_MCI_GETDEVCAPS_PARMS
		do 
			create devcaps_parms.make (parent)
			getdevcaps_device (devcaps_parms, a_item)
			Result := devcaps_parms.query_result
		end

	query_status_item (a_item: INTEGER): INTEGER
			-- Query a device's status concerning `a_item'.
		require
			opened: opened
		local
			status_parms: WEX_MCI_STATUS_PARMS
		do 
			create status_parms.make (parent, a_item)
			status_device (status_parms, Mci_status_item)
			Result := status_parms.query_result
		end

	raise_error_on_command_failure: BOOLEAN
			-- Raise an exception if last command failed.
		local
			message_box_string: STRING
		do
			if command_success then
				Result := True
			else
				message_box_string := last_error
				message_box_string.append ("%N%RPress ok to %
					%continue, press cancel to raise an %
					%exception.")
				error_message_box (message_box_string,
					Mb_okcancel)
				Result := message_box_result = Idok
			end
		end

	device_name: STRING
			-- Name of device
		deferred
		end

	Maximum_error_buffer: INTEGER = 128
			-- Maximum buffer length of an error retrieved
			-- by using `cwin_mci_get_error_string'.

feature {NONE} -- Removal

	destroy_item
			-- If the garbage collector needs to clean up an object
			-- which holds a device which is still open, windows is
			-- unable to free the device so the garbage collector
			-- must close the MCI device.
		do
			if opened then
				cwin_mci_send_command (cwel_pointer_to_integer (
					item), Mci_close, Mci_wait, 0)
			end
		end

feature {NONE} -- Externals

	cwin_mci_send_command_result (id, msg, command, wparam: INTEGER): INTEGER
			-- SDK mciSendCommand (with the result)
		external
			"C [macro <wex_mci.h>] (MCIDEVICEID, UINT, %
				%DWORD, DWORD): EIF_INTEGER"
		alias
			"mciSendCommand"
		end

	cwin_mci_send_command (id, msg, command, wparam: INTEGER)
			-- SDK mciSendCommand (without the result)
		external
			"C [macro <wex_mci.h>] (MCIDEVICEID, UINT, %
				%DWORD, DWORD)"
		alias
			"mciSendCommand"
		end

	cwin_mci_get_error_string (code: INTEGER; ptr: POINTER; l: INTEGER): BOOLEAN
		external
			"C [macro <wex_mci.h>] (DWORD, LPTSTR, UINT): EIF_BOOLEAN"
		alias
			"mciGetErrorString"
		end

invariant
	parent_not_void: parent /= Void
	parent_exists: parent.exists
	device_name_not_void: device_name /= Void
	device_name_not_empty: not device_name.empty

end -- class WEX_MCI_DEVICE

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
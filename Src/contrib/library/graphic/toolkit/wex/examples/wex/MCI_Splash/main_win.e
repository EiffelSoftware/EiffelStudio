class
	MAIN_WINDOW

inherit
	WEL_FRAME_WINDOW
		redefine
			on_control_id_command,
			default_ex_style,
			class_background,
			class_name
		end

create
	make

feature {NONE} -- Initialization

	make
			-- Create main window.
		do
			make_top ("WEX - Windows Eiffel library eXtension")
			move_and_resize(0, 0, 370, 385, False)
			create popupbitmap.make (Current, "Popup bitmap",      0  ,  0 , 150, 30, 101)
			create popdownbitmap.make (Current, "Popdown bitmap",  0  ,  40, 150, 30, 102)
			create selbitmap.make (Current, "Select bitmap",       0  ,  80, 150, 30, 103)
			create avisplash.make (Current, "Select AVI", 	     0  , 120, 150, 30, 104)
			create playwave.make (Current, "Play wave", 			0  , 160, 150, 30, 107)
			create playmidi.make (Current, "Play midi", 			0  , 200, 150, 30, 108)
			create stopmidi.make (Current, "Stop midi", 			0  , 240, 150, 30, 109)
			create playcd.make (Current, "Play cd", 			0  , 280, 150, 30, 110)
			create stopcd.make (Current, "stop cd", 			0  , 320, 150, 30, 111)
			create bitmap_region_check.make (Current, "Funny region", 160,   0, 150, 30, 105)
			create video_region_check.make (Current, "Elliptic region",  160, 120, 150, 30, 106)
		end

feature {NONE} -- Behavior

	on_control_id_command (control_id: INTEGER)
			-- A command has been received from `control_id'.
		local
			a_region: WEL_REGION
			sw: INTEGER
			sh: INTEGER
		do
			if control_id = 101 then
				if not splash.popped_up then
					if bitmap_region_check.checked then
						sw := splash.width // 2
						sh := splash.height // 2
						create a_region.make_polygon_alternate (<<sw, 0, splash.width, 0,
							sw, sh, splash.width, splash.height, 0, splash.height, sw, sh, 0, sh, sw, 0>>)
					else
						create a_region.make_rect (0, 0, splash.width, splash.height)
					end
					splash.set_window_region (a_region, False)
					if splash.valid then
						splash.pop_up
					else
						(create {WEL_MSG_BOX}.make).information_message_box (Current, "Select valid bitmap first!", "Splash")
					end
				end
			elseif control_id = 111 then
				stop_any_playing_cd
			elseif control_id = 110 then
				stop_any_playing_cd
				cd_device.open
				if cd_device.opened then
					if cd_device.media_present then
						cd_device.play
						if not cd_device.playing and then not cd_device.is_audio_track(1) then
							(create {WEL_MSG_BOX}.make).information_message_box (Current, "Cannot play first track?", "WEX CD Audio")
							-- TODO Check next track
						end
					end
				else
					(create {WEL_MSG_BOX}.make).information_message_box (Current, "Could not open CD", "WEX CD Audio")
				end
			elseif control_id = 102 then
				if splash.popped_up then
					splash.pop_down
				end
			elseif control_id = 103 then
				file_dialog.activate (current)
				if file_dialog.selected then
					splash.set_bitmap (file_dialog.file_path)
 				end
			elseif control_id = 104 then
				file_dialog.activate (Current)
				if file_dialog.selected then
					splash_video.set_video(file_dialog.file_path)
					if splash_video.valid then
						if video_region_check.checked then
							create a_region.make_elliptic (0, 0, splash_video.width, splash_video.height)
						else
							create a_region.make_rect (0, 0, splash_video.width, splash_video.height)
						end
						splash_video.set_window_region (a_region, False)
						splash_video.pop_up
					else
						(create {WEL_MSG_BOX}.make).information_message_box (Current, "Select valid video please!", "Video")
					end
				end
			elseif control_id = 108 then
				file_dialog.activate (Current)
				if file_dialog.selected then
					stop_any_playing_midi
					midi_device.open (file_dialog.file_path)
					if midi_device.opened then
						midi_device.play
					end
				end
			elseif control_id = 109 then
				stop_any_playing_midi
			elseif control_id = 107 then
				file_dialog.activate (Current)
				if file_dialog.selected then
					if wave_device.opened then
						if wave_device.playing then
							wave_device.stop
						end
						wave_device.close
					end
					wave_device.open (file_dialog.file_path)
					if wave_device.opened then
						wave_device.play
					end
				end
			end
		end

	stop_any_playing_cd
		do
			if cd_device.opened then
				if cd_device.playing then
					cd_device.stop
				end
				cd_device.close
			end
		end

	stop_any_playing_midi
		do
			if midi_device.opened then
				if midi_device.playing then
					midi_device.stop
				end
				midi_device.close
			end
		end

	popupbitmap,
	selbitmap,
	avisplash,
	playmidi,
	stopmidi,
	playcd,
	stopcd,
	playwave,
	popdownbitmap: WEL_PUSH_BUTTON

	video_region_check,
	bitmap_region_check: WEL_CHECK_BOX

	splash: WEX_SPLASH_BITMAP_WINDOW
		once
			create Result.make
		end

	splash_video: WEX_SPLASH_VIDEO
		once
			create Result.make
		end

	file_dialog: WEL_OPEN_FILE_DIALOG
		once
			create Result.make
		end

	class_name: STRING_32
		once
			Result := "MainWindowRWC"
		end

	class_background: WEL_BRUSH
		once
			create Result.make_by_sys_color (Color_btnface + 1)
		end

	default_ex_Style: INTEGER
		once
			Result := 768
		end

	cd_device: WEX_MCI_CD_AUDIO
		once
			create Result.make (Current)
		end

	midi_device: WEX_MCI_SEQUENCER
		once
			create Result.make (Current)
		end

	wave_device: WEX_MCI_WAVE_AUDIO
		once
			create Result.make (Current)
		end

end

--|-------------------------------------------------------------------------
--| WEX, Windows Eiffel library eXtension
--| Copyright (C) 1998  Robin van Ommeren, Andreas Leitner
--| Copyright (C) 2017  Eiffel Software, Alexander Kogtenkov
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

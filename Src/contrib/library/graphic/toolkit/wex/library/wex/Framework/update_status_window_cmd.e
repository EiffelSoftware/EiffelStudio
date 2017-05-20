note
	description: "Command class that handles status window updates (when a menu is selected)"
	status: "See notice at end of class."
	author: "Andreas Leitner"
	date: "$Date$"
	revision: "$Revision$"
class
	UPDATE_STATUS_WINDOW_CMD

inherit
	WEL_COMMAND

	WEL_WINDOWS_ROUTINES
		export
			{NONE} all
		end

feature

	execute (argument: ANY)
		do
			if
				attached {like main_window} argument as w and then
				attached {WEL_MENU_SELECT_MESSAGE} message_information as mi
			then
				main_window := w
				w.status_window.set_text_part (0, get_status_window_text (mi.item) )
			end
		end

feature {NONE}

	get_status_window_text (string_id: INTEGER): STRING
		do
			Result := resource_string_id (string_id)
			if not attached Result then
				create Result.make_empty
			end
			if not Result.is_empty then
				Result.keep_head (Result.index_of ('%N', 1) - 1)
			end
		ensure
			result_not_void: Result /= Void
		end

	main_window: WEX_MAIN_WINDOW

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

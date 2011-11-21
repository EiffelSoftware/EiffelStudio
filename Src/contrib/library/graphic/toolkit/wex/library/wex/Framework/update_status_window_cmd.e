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
		local
			mi: WEL_MENU_SELECT_MESSAGE
		do
			
			main_window ?= argument
			mi ?= message_information

			check
				valid_argument: argument /= Void
				valid_message_information: mi /= Void
			end
			
			main_window.status_window.set_text_part (0, get_status_window_text (mi.item) )				
			
		end
	
	
	
feature {NONE}

	get_status_window_text (string_id: INTEGER): STRING
		local
			text: STRING
		do
			text := resource_string_id (string_id)
			if text = Void then 
				create text.make (0)
			end
			if text.count /= 0 then
				text.head (text.index_of ('%N', 1) - 1)
			end
	
			Result := text
		ensure
			result_not_void: Result /= Void
		end
	main_window: WEX_MAIN_WINDOW

end -- class SHOW_COMMAND_INFORMATION

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
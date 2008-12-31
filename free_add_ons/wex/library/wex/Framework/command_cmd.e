note
	description: "Command class that handles both menu-commands and toolbar-commands"
	status: "See notice at end of class."
	author: "Andreas Leitner"
	date: "$Date$"
	revision: "$Revision$"

class
	COMMAND_CMD

inherit
	WEL_COMMAND

feature

	execute (argument: ANY)
		local
			mi: WEL_COMMAND_MESSAGE
		do
			
			main_window ?= argument
			mi ?= message_information

			check
				valid_argument: argument /= Void
				valid_message_information: mi /= Void
			end

			if mi.from_menu or mi.from_control then
				execute_messages (mi.id)
			end
		end

	check_command (command_id: INTEGER)
		do
			main_window.main_menu.check_item (command_id)
			main_window.tool_bar.check_button (command_id)
		end

	uncheck_command (command_id: INTEGER)
		do
			main_window.main_menu.uncheck_item (command_id)
			main_window.tool_bar.uncheck_button (command_id)
		end

	is_command_checked (command_id: INTEGER): BOOLEAN
		do
			check
				menu_and_tool_bar_consistent: main_window.main_menu.item_checked (command_id) = main_window.tool_bar.button_checked (command_id)
			end
			Result := main_window.main_menu.item_checked (command_id)
		end

	
feature {NONE}

	main_window: WEX_MAIN_WINDOW
	
	execute_messages (command_id: INTEGER)
			-- redefine this routine and place your custom message handling routiens there
		do
		end


end -- class COMMAND_CMD

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
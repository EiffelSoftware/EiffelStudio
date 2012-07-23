note
	description: "WEX Framework Example Menu and Toolbar Commands"
	status: "See notice at end of class."
	author: "Andreas Leitner"
	date: "$Date$"
	revision: "$Revision$"

class
	CUSTOM_COMMAND_CMD

inherit
	COMMAND_CMD
		redefine
			execute_messages
		end		

	APPLICATION_IDS
		export
			{NONE} all
		end
	
feature {NONE}

	execute_messages (command_id: INTEGER)
		do
			inspect
				command_id
			when Cmd_flat_tool_bar then
				toggle_flat_tool_bar_style
			when Cmd_test then
				execute_test
			else
			end
		end

	toggle_flat_tool_bar_style
		do
			if is_command_checked (Cmd_flat_tool_bar) then
				uncheck_command (Cmd_flat_tool_bar)
			else
				check_command (Cmd_flat_tool_bar)
			end
			main_window.tool_bar.set_flat_style (is_command_checked (Cmd_flat_tool_bar))
			main_window.tool_bar.invalidate
		end

	execute_test
		do
			msg_box.information_message_box (main_window, "This is a test (:", "WEX Framework Sample Application")
		end
		
	msg_box: WEL_MSG_BOX 
		once 
			create Result.make
		end

end -- class CUSTOM_COMMAND_CMD

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

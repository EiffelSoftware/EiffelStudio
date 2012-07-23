note
	description: "Main frame-window base class"
	status: "See notice at end of class."
	author: "Andreas Leitner"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	WEX_MAIN_WINDOW

inherit
	WEL_FRAME_WINDOW
		redefine
			class_icon,
			on_size,
			on_control_id_command,
			on_menu_command
		end


feature {NONE} -- Initialization

	make
		do
			make_top (Title)
			set_menu (main_menu)

			make_tool_bar
			make_status_window

			put_command (command_cmd, Wm_command, Current)
			put_command (update_status_window_cmd, Wm_menuselect, Current)

			enable_commands
		end

feature {COMMAND_CMD}

	main_menu: WEL_MENU
			-- Window's menu
		once 
			create Result.make_by_id (Id_main_frame)
		ensure
			result_not_void: Result /= Void
		end
	tool_bar: WEX_TOOL_BAR
		
	command_cmd: COMMAND_CMD
			-- redefine this feature to customize menu and toolbar commands
		once 
			create Result
		end

	update_status_window_cmd: UPDATE_STATUS_WINDOW_CMD
			-- redefine this feature to customize menu and toolbar commands
		once 
			create Result
		end
		

feature {UPDATE_STATUS_WINDOW_CMD}

	status_window: WEL_STATUS_WINDOW


feature {NONE} -- Implementation

	make_tool_bar
		do 
			create tool_bar.make_by_menu_id (Current, Id_main_frame)
		end

	Id_main_frame: INTEGER
			-- redefine this feature with the resource id for your custom menu, icon and toolbar
		deferred
		end
	Cmd_exit: INTEGER
			-- redefine this feature with the resource id for your exit-menu-id and exit-toolbar-id
		deferred
		end

	make_status_window
		do 
			create status_window.make (Current, -1)
			status_window.set_multiple_mode
			status_window.set_parts (<<300, 350, -1>>)
		end

	Title: STRING = "WEX - Application Frame Works"

	on_size (size_type: INTEGER; a_width: INTEGER; a_height: INTEGER)
			-- Reposition the status window and the tool bar when
			-- the window has been resized.
		do
			if status_window /= Void then
				status_window.reposition
			end
			if tool_bar /= Void then
				tool_bar.reposition
			end
		end

	class_icon: WEL_ICON
			-- Window's icon
		once 
			create Result.make_by_id (Id_main_frame)
		end

	on_menu_command (menu_id: INTEGER)
		do
			if menu_id = Cmd_exit and then closeable then
				destroy
			end
		end
	on_control_id_command (control_id: INTEGER)
		do
			on_menu_command (control_id)
		end

end -- class WEX_MAIN_WINDOW

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

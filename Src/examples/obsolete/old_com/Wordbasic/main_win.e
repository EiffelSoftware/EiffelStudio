indexing
	description: "Main window for Wordbasic client"
	legal: "See notice at end of class.";
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"
	
class
	MAIN_WINDOW

inherit

	WEL_FRAME_WINDOW
		redefine
			class_icon,
			on_menu_command,
			on_destroy
		end

	EOLE_ERROR_CODE
		export
			{NONE} all
		end

	APPLICATION_IDS
		export
			{NONE} all
		end
		
	EOLE_CLSCTX
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make is
			-- Initialize OLE and create `wordbasic'.
		local
			error_message: STRING
			init: INTEGER
			box: WEL_MSG_BOX
		do
			make_top (Title)
			set_menu (main_menu)
			main_menu.disable_item (Cmd_save)
			main_menu.disable_item (Cmd_insert_text)
			main_menu.disable_item (Cmd_left)
			main_menu.disable_item (Cmd_center)
			main_menu.disable_item (Cmd_right)
			main_menu.disable_item (Cmd_line_up)
			main_menu.disable_item (Cmd_line_down)
			main_menu.disable_item (Cmd_bold)
			main_menu.disable_item (Cmd_italic)
			main_menu.disable_item (Cmd_underline)
			main_menu.disable_item (Cmd_border_top)
			main_menu.disable_item (Cmd_spelling)
			main_menu.disable_item (Cmd_grammar)	
			resize (350, 150)
			create wordbasic
			wordbasic.initialize (Clsctx_local_server)
			if not wordbasic.is_valid then
				create box.make
				box.error_message_box (Void, "Can not get IDispatch interface", "IDsipatch error")
				on_destroy
			end
			wordbasic.app_show
		end
		
feature -- Access
	
	wordbasic: EOLE_WORDBASIC
				-- Current instance of Word Basic
		
feature {NONE} -- Implementation

	on_menu_command (menu_id: INTEGER) is
			-- Execute command identified by `menu_id'.
		local
			loc: INTEGER
			mess_box: WEL_MSG_BOX
			message: STRING
		do
			inspect
				menu_id
			when Cmd_new then
				wordbasic.file_new_default
				main_menu.enable_item (Cmd_save)
				main_menu.enable_item (Cmd_insert_text)
				main_menu.enable_item (Cmd_left)
				main_menu.enable_item (Cmd_center)
				main_menu.enable_item (Cmd_right)
				main_menu.enable_item (Cmd_line_up)
				main_menu.enable_item (Cmd_line_down)
				main_menu.enable_item (Cmd_bold)
				main_menu.enable_item (Cmd_italic)
				main_menu.enable_item (Cmd_underline)
				main_menu.enable_item (Cmd_border_top)
				main_menu.enable_item (Cmd_spelling)
				main_menu.enable_item (Cmd_grammar)	
			when Cmd_save then				
				wordbasic.file_save
			when Cmd_exit then
				on_destroy
				destroy
			when Cmd_insert_text then
				wordbasic.insert (enter_text)
			when Cmd_left then
				wordbasic.left_para
			when Cmd_center then
				wordbasic.center_para
			when Cmd_right then
				wordbasic.right_para
			when Cmd_line_up then
				wordbasic.line_up (enter_number)
			when Cmd_line_down then
				wordbasic.line_down (enter_number)
			when Cmd_bold then
				wordbasic.bold
			when Cmd_italic then
				wordbasic.italic
			when Cmd_underline then
				wordbasic.underline
			when Cmd_border_line_style then
				loc := enter_number
				if loc < 0 or loc > 11 then
					create mess_box.make
					mess_box.warning_message_box (Current, "Sorry, BorderLineStyle%
					% should be less than 12 and greater than 0", "Input Error")
					on_menu_command (Cmd_border_line_style)
				end
				wordbasic.border_line_style (loc)
			when Cmd_border_top then
				wordbasic.border_top
			when Cmd_spelling then
				wordbasic.tools_spelling
			when Cmd_grammar then
				wordbasic.tools_grammar
			when Cmd_count_windows then
				create message.make (0)
				message.make_from_string ("Number of open document and macro-editing windows: ")
				message.append_integer (wordbasic.count_windows)
				create mess_box.make
				mess_box.information_message_box (Current, message, "Windows count")
			when Cmd_get_id then
				message := enter_text
				create mess_box.make
				loc := wordbasic.get_id (message)
				if loc = -1 then
					mess_box.error_message_box (Current, "Sorry, not a WordBasic command ...", "Get ID Error")
				else
					message.append (": ")
					message.append_integer (loc)
					mess_box.information_message_box (Current, message, "Dispatch Identifier")
				end
			when Cmd_exception then
				create message.make (100)
				message.append ("Last HResult: ")
				message.append_integer (wordbasic.error_code)
				create mess_box.make
				mess_box.information_message_box (Current, message, wordbasic.error_description)
			when Cmd_show then
				wordbasic.app_show
			when Cmd_hide then
				wordbasic.app_hide
			else
			end
		end
		
	on_destroy is
			-- Unitialize OLE before destroying window.
		do
			wordbasic.file_exit
			wordbasic.terminate
		end

	enter_text: STRING is
			-- Text entered by user
		local
			dialog: TEXT_DIALOG
		do
			create dialog.make (Current)
			dialog.activate
			Result := dialog.user_text
		end

	enter_number: INTEGER is
			-- Number entered by user
		local
			dialog: NUMBER_DIALOG
		do
			create dialog.make (Current)
			dialog.activate
			Result := dialog.number
		end

	class_icon: WEL_ICON is
			-- Window's icon
		once
			create Result.make_by_id (Id_ico_application)
		end

	main_menu: WEL_MENU is
			-- Window's menu
		once
			create Result.make_by_id (Id_main_menu)
		ensure
			result_not_void: Result /= Void
		end

	Title: STRING is "Wordbasic client";
			-- Window's title

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"


end -- class MAIN_WINDOW


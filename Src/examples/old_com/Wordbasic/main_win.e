indexing
	description: "Main window for Wordbasic client";
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
		
creation
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
			resize (320, 150)
			!! wordbasic
			wordbasic.create
			if not wordbasic.is_valid then
				!! box.make
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
			when Cmd_save then
				if exist_active_doc then				
					wordbasic.file_save
				else
					!! mess_box.make
					mess_box.error_message_box (Current, "Sorry, no active document ...", "Save Error")
				end
			when Cmd_exit then
				on_destroy
				destroy
			when Cmd_insert_text then
				if exist_active_doc then
					wordbasic.insert (enter_text)
				else
					!! mess_box.make
					mess_box.error_message_box (Current, "Sorry, no active document ...", "Insert Text Error")
				end
			when Cmd_left then
				if exist_active_doc then
					wordbasic.left_para
				else
					!! mess_box.make
					mess_box.error_message_box (Current, "Sorry, no active document ...", "Left Paragraph Error")
				end
			when Cmd_center then
				if exist_active_doc then
					wordbasic.center_para
				else
					!! mess_box.make
					mess_box.error_message_box (Current, "Sorry, no active document ...", "Center Paragraph Error")
				end
			when Cmd_right then
				if exist_active_doc then
					wordbasic.right_para
				else
					!! mess_box.make
					mess_box.error_message_box (Current, "Sorry, no active document ...", "Right Paragraph Error")
				end
			when Cmd_line_up then
				if exist_active_doc then
					wordbasic.line_up (enter_number)
				else
					!! mess_box.make
					mess_box.error_message_box (Current, "Sorry, no active document ...", "Line Up Error")
				end
			when Cmd_line_down then
				if exist_active_doc then
					wordbasic.line_down (enter_number)
				else
					!! mess_box.make
					mess_box.error_message_box (Current, "Sorry, no active document ...", "Line Down Error")
				end
			when Cmd_bold then
				if exist_active_doc then
					wordbasic.bold
				else
					!! mess_box.make
					mess_box.error_message_box (Current, "Sorry, no active document ...", "Bold Error")
				end
			when Cmd_italic then
				if exist_active_doc then
					wordbasic.italic
				else
					!! mess_box.make
					mess_box.error_message_box (Current, "Sorry, no active document ...", "Italic Error")
				end
			when Cmd_underline then
				if exist_active_doc then
					wordbasic.underline
				else
					!! mess_box.make
					mess_box.error_message_box (Current, "Sorry, no active document ...", "Underline Error")
				end
			when Cmd_border_line_style then
				loc := enter_number
				if loc < 0 or loc > 11 then
					!! mess_box.make
					mess_box.warning_message_box (Current, "Sorry, BorderLineStyle%
					% should be less than 12 and greater than 0", "Input Error")
					on_menu_command (Cmd_border_line_style)
				end
				wordbasic.border_line_style (loc)
			when Cmd_border_top then
				if exist_active_doc then
					wordbasic.border_top
				else
					!! mess_box.make
					mess_box.error_message_box (Current, "Sorry, no active document ...", "BorderTop Error")
				end
			when Cmd_spelling then
				if exist_active_doc then
					wordbasic.tools_spelling
				else
					!! mess_box.make
					mess_box.error_message_box (Current, "Sorry, no active document ...", "Spelling Error")
				end
			when Cmd_grammar then
				if exist_active_doc then
					wordbasic.tools_grammar
				else
					!! mess_box.make
					mess_box.error_message_box (Current, "Sorry, no active document ...", "Grammar Error")
				end
			when Cmd_count_windows then
				!! message.make (0)
				message.make_from_string ("Number of open document and macro-editing windows: ")
				message.append_integer (wordbasic.count_windows)
				!! mess_box.make
				mess_box.information_message_box (Current, message, "Windows count")
			when Cmd_get_id then
				message := enter_text
				!! mess_box.make
				loc := wordbasic.get_id (message)
				if loc = -1 then
					mess_box.error_message_box (Current, "Sorry, not a WordBasic command ...", "Get ID Error")
				else
					message.append (": ")
					message.append_integer (loc)
					mess_box.information_message_box (Current, message, "Dispatch Identifier")
				end
			when Cmd_exception then
				!! message.make (100)
				message.append ("Last HResult: ")
				message.append_integer (wordbasic.error_code)
				!! mess_box.make
				mess_box.information_message_box (Current, message, wordbasic.error_description)
			when Cmd_show then
				wordbasic.app_show
			when Cmd_hide then
				wordbasic.app_hide
			else
			end
		end
		
	exist_active_doc: BOOLEAN is
			-- Does an active document exist?
		do
			Result := wordbasic.count_windows > 0
		end
		
	on_destroy is
			-- Unitialize OLE before destroying window.
		do
			wordbasic.file_exit
			wordbasic.destroy
		end

	enter_text: STRING is
			-- Text entered by user
		local
			dialog: TEXT_DIALOG
		do
			!! dialog.make (Current)
			dialog.activate
			Result := dialog.user_text
		end

	enter_number: INTEGER is
			-- Number entered by user
		local
			dialog: NUMBER_DIALOG
		do
			!! dialog.make (Current)
			dialog.activate
			Result := dialog.number
		end

	class_icon: WEL_ICON is
			-- Window's icon
		once
			!! Result.make_by_id (Id_ico_application)
		end

	main_menu: WEL_MENU is
			-- Window's menu
		once
			!! Result.make_by_id (Id_main_menu)
		ensure
			result_not_void: Result /= Void
		end

	Title: STRING is "Wordbasic client"
			-- Window's title

end -- class MAIN_WINDOW

--|-------------------------------------------------------------------------
--| EiffelCOM: library of reusable components for ISE Eiffel.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license.
--| Contact ISE for any other use.
--| Based on WINE library, copyright (C) Object Tools, 1996-1997.
--| Modifications and extensions: copyright (C) ISE, 1997. 
--|
--| Interactive Software Engineering Inc.
--| 270 Storke Road, ISE Building, second floor, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Information e-mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|-------------------------------------------------------------------------

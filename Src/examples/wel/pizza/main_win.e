class
	MAIN_WINDOW

inherit
	WEL_FRAME_WINDOW
		redefine
			class_icon,
			closeable,
			on_menu_command
		end

	APPLICATION_IDS
		export
			{NONE} all
		end

creation
	make

feature {NONE} -- Initialization

	make is
		do
			make_top (Title)
			set_menu (main_menu)
			resize (300, 200)
			!! dialog.make (Current)
		end

feature -- Access

	dialog: DIALOG
			-- Pizza dialog

feature {NONE} -- Implementation

	closeable: BOOLEAN is
		local
			msg_box: WEL_MSG_BOX
		do
			!!msg_box.make
			msg_box.question_message_box(Current, "Do you want to exit?", "Exit")
			Result := msg_box.message_box_result = Idyes
		end

	on_menu_command (menu_id: INTEGER) is
		do
			if menu_id = Cmd_exit then
				if closeable then
					destroy
				end
			elseif menu_id = Cmd_order then
				dialog.activate
			end
		end

	class_icon: WEL_ICON is
			-- Window's icon
		once
			!! Result.make_by_id (Id_ico_application)
		end

	main_menu: WEL_MENU is
		once
			!! Result.make_by_id (Id_main_menu)
		ensure
			result_not_void: Result /= Void
		end

	Title: STRING is "WEL Pizza"
			-- Window's title

end -- class MAIN_WINDOW

--|-------------------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1995, Interactive Software Engineering, Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Information e-mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|-------------------------------------------------------------------------

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
			create dialog.make (Current)
		end

feature -- Access

	dialog: DIALOG
			-- Pizza dialog

feature {NONE} -- Implementation

	closeable: BOOLEAN is
		local
			msg_box: WEL_MSG_BOX
		do
			create msg_box.make
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
			create Result.make_by_id (Id_ico_application)
		end

	main_menu: WEL_MENU is
		once
			create Result.make_by_id (Id_main_menu)
		ensure
			result_not_void: Result /= Void
		end

	Title: STRING is "WEL Pizza"
			-- Window's title

end -- class MAIN_WINDOW

--|----------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------


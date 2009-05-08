note
	legal: "See notice at end of class."
	status: "See notice at end of class."
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

create
	make

feature {NONE} -- Initialization

	make
		do
			make_top (Title)
			set_menu (main_menu)
			resize (300, 200)
		end

feature -- Access

	dialog: detachable DIALOG
			-- Pizza dialog

feature {NONE} -- Implementation

	closeable: BOOLEAN
		local
			msg_box: WEL_MSG_BOX
		do
			create msg_box.make
			msg_box.question_message_box(Current, "Do you want to exit?", "Exit")
			Result := msg_box.message_box_result = Idyes
		end

	on_menu_command (menu_id: INTEGER)
		local
			l_dialog: like dialog
		do
			if menu_id = Cmd_exit then
				if closeable then
					destroy
				end
			elseif menu_id = Cmd_order then
				if l_dialog = Void then
					create l_dialog.make (Current)
					dialog := l_dialog
				end
				l_dialog.activate
			end
		end

	class_icon: WEL_ICON
			-- Window's icon
		once
			create Result.make_by_id (Id_ico_application)
		end

	main_menu: WEL_MENU
		once
			create Result.make_by_id (Id_main_menu)
		ensure
			result_not_void: Result /= Void
		end

	Title: STRING = "WEL Pizza";
			-- Window's title

note
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


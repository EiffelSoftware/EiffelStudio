class
	MAIN_WINDOW

inherit
	WEL_FRAME_WINDOW
		redefine
			class_icon,
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
		local
			on_off: ON_OFF_CONTROL
			static: WEL_STATIC
		do
			make_top (Title)
			set_menu (main_menu)
			resize (300, 200)
			move (100, 100)
			create modal.make (Current)
			create modeless.make (Current)
			create on_off.make (Current, 10, 20)
			create static.make (Current, "This is a custom on/off %
				%control created with WEL. To try it, %
				% click on it.", 40, 20, 200, 200, -1)
		end

feature -- Access

	modal: MODAL
			-- Modal dialog box

	modeless: MODELESS
			-- Modeless dialog box

feature {NONE} -- Implementation

	on_menu_command (menu_id: INTEGER) is
		local
			popup: WEL_POPUP_WINDOW
			static: WEL_STATIC
		do
			inspect
				menu_id
			when Cmd_exit then
				destroy
			when Cmd_modal_dlg then
				modal.activate
			when Cmd_modeless_dlg then
				if not modeless.exists then
					modeless.activate
				else
					modeless.set_focus
				end
			when Cmd_popup_window_with_parent then
				create popup.make_child (Current, "Popup Window with parent")
				create static.make (popup, "This window can be moved %
					%outside to its parent. When the parent is %
					%minimized, this window is minimized as well.",
					10, 10, 300, 300, -1)
				popup.show
				popup.resize (350, 200)
			when Cmd_popup_window_without_parent then
				create popup.make_top ("Popup Window without parent")
				create static.make (popup, "This window can be moved %
					%outside to its parent. When minimized, %
					%the icon resides on the desktop.",
					10, 10, 300, 300, -1)
				popup.show
				popup.resize (350, 200)
			else
			end
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

	Title: STRING is "WEL Windows"
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


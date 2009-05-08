note
	legal: "See notice at end of class."
	status: "See notice at end of class."
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

create
	make

feature {NONE} -- Initialization

	make
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

	modal: detachable MODAL
			-- Modal dialog box

	modeless: detachable MODELESS
			-- Modeless dialog box

feature {NONE} -- Implementation

	on_menu_command (menu_id: INTEGER)
		local
			popup: WEL_POPUP_WINDOW
			static: WEL_STATIC
		do
			inspect
				menu_id
			when Cmd_exit then
				destroy
			when Cmd_modal_dlg then
				if attached modal as l_modal then
					l_modal.activate
				end
			when Cmd_modeless_dlg then
				if attached modeless as l_modeless then
					if not l_modeless.exists then
						l_modeless.activate
					else
						l_modeless.set_focus
					end
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

	class_icon: WEL_ICON
			-- Window's icon
		once
			create Result.make_by_id (Id_ico_application)
		end

	main_menu: WEL_MENU
			-- Window's menu
		once
			create Result.make_by_id (Id_main_menu)
		ensure
			result_not_void: Result /= Void
		end

	Title: STRING = "WEL Windows";
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


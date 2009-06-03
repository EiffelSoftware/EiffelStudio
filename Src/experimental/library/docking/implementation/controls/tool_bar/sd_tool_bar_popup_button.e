note
	description: "Toolbar button for SD_TOOL_BAR which popup a widget after end user pressed."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SD_TOOL_BAR_POPUP_BUTTON

inherit
	SD_TOOL_BAR_BUTTON
		export
			{NONE} select_actions
		redefine
			make,
			width
		end

create
	make

feature {NONE} -- Initlialization

	make
			-- Creation method
		do
			Precursor
			select_actions.extend (agent on_select)
		end

feature -- Command

	set_menu (a_menu: EV_MENU)
			-- Set `menu' with `a_menu'
		do
			menu := a_menu
		ensure
			set: menu = a_menu
		end

	set_menu_function (a_menu_function: like menu_function)
			-- Set `menu_function' with `a_menu_function'
		do
			menu_function := a_menu_function
		ensure
			set: menu_function = a_menu_function
		end

	set_popup_widget (a_widget: like popup_widget)
			-- Set `popup_widget' with `a_widget'
		do
			popup_widget := a_widget
			popup.wipe_out
			popup.extend (popup_widget)
		ensure
			set: popup_widget = a_widget and popup.has (popup_widget)
		end

	set_dropdown_pixel_buffer (a_pixel_buffer: EV_PIXEL_BUFFER)
			-- Set `pixel_buffer_imp' with `a_pixel_buffer'.
		do
			dropdown_pixel_buffer_imp := a_pixel_buffer
		ensure
			set: dropdown_pixel_buffer_imp = a_pixel_buffer
		end

feature -- Query

	width: INTEGER
			-- <Precursor>
		do
			Result := Precursor + gap + dropdrown_width
		end

	menu: EV_MENU
			-- Menu to popup after end user pressed.
			-- Note: `menu' has priority than `popup_widget'.
			-- It means, if `menu' and `popup_widget' both not void,
			-- `menu' will be used.

	menu_function: FUNCTION [ANY, TUPLE, like menu]
			-- Function to compute the menu to popup after end user pressed.
			-- Note: `menu' has priority over menu_function,
			--		which has priority over `popup_widget'.
			-- It means, if `menu' or `menu_function.item (Void)' and `popup_widget' both not void,
			-- `menu' or `menu_function.item (Void)' will be used.

	popup_widget: EV_WIDGET
			-- Widget to popup after end user pressed.

	gap: INTEGER = 2
			-- Gap size between front icon and dropdown icon.

	dropdrown_width: INTEGER
			-- With of the dropdown area.
		do
			Result := dropdown_pixel_buffer.width
		end

	dropdown_pixel_buffer: EV_PIXEL_BUFFER
			-- Dropdown pixel buffer
		do
			if dropdown_pixel_buffer_imp /= Void then
				Result := dropdown_pixel_buffer_imp
			else
				Result := internal_shared.icons.tool_bar_dropdown_buffer
			end
		ensure
			not_void: Result /= Void
		end

	dropdown_left: INTEGER
			--	X position where dropdown button should be drawn.
		do
			if tool_bar /= Void then
				Result := tool_bar.item_x (Current) + width - dropdrown_width - 2
			end
		end

feature -- Basic operations

	perform_select
			-- Performs a selection
		require
			not_is_destroyed: not is_destroyed
			is_displayed: is_displayed
			has_function: menu /= Void or menu_function /= Void or popup_widget /= Void
		do
			on_select
		end

feature {NONE} -- Implementation

	popup: EV_POPUP_WINDOW
			-- Lazy creator of `popup_imp'
		do
			if popup_imp = Void then
				create popup_imp
				popup_imp.focus_out_actions.extend (agent popup_imp.hide)
			end
			Result := popup_imp
		ensure
			not_void: Result /= Void
		end

	popup_imp: EV_POPUP_WINDOW
			-- Popup window which appears after end user pressed.

	on_select
			-- Handle select actions.
		require
			set: menu /= Void or menu_function /= Void or popup_widget /= Void
		local
			l_helper: SD_POSITION_HELPER
			l_x, l_y, l_height: INTEGER
			l_menu: EV_MENU
		do
			if tool_bar /= Void then
				l_menu := menu
				if l_menu = Void and menu_function /= Void then
					l_menu := menu_function.item (Void)
				end
				if l_menu /= Void or popup_widget /= Void then
					create l_helper.make
					l_x := tool_bar.item_x (Current)
					l_y := tool_bar.item_y (Current)
					l_height := tool_bar.height
					if l_menu /= Void then
						if attached {EV_WIDGET} tool_bar as lt_widget then
							l_menu.show_at (lt_widget, l_x, l_y + tool_bar.standard_height)
						else
							check not_possible: False end
						end
					else
						l_helper.set_dialog_position (popup, tool_bar.screen_x + l_x, tool_bar.screen_y + l_y, l_height)
						popup.show
					end
				end
			end
		ensure
			popuped: (menu = Void and (menu_function = Void or else menu_function.item (Void) = Void)) implies popup.is_displayed
		end

	dropdown_pixel_buffer_imp: EV_PIXEL_BUFFER;
			-- Pixel buffer for dropdown button.

note
	library:	"SmartDocking: Library of reusable components for Eiffel."
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"


end

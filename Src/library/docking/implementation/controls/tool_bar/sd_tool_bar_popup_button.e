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
		require
			not_void: a_widget /= Void
		do
			popup_widget := a_widget
			popup.wipe_out
			popup.extend (a_widget)
		ensure
			set: popup_widget = a_widget and popup.has (a_widget)
		end

	set_popup_widget_function (a_popup_widget_function: like popup_widget_function)
			-- Set `popup_widget_function' with `a_popup_widget_function'
		do
			popup_widget_function := a_popup_widget_function
		ensure
			set: popup_widget_function = a_popup_widget_function
		end

	set_dropdown_pixel_buffer (a_pixel_buffer: EV_PIXEL_BUFFER)
			-- Set `pixel_buffer_imp' with `a_pixel_buffer'
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

	menu: detachable EV_MENU
			-- Menu to popup after end user pressed
			-- Note: `menu' has priority than `popup_widget'
			-- It means, if `menu' and `popup_widget' both not void,
			-- `menu' will be used.

	menu_function: detachable FUNCTION [ANY, TUPLE, like menu]
			-- Function to compute the menu to popup after end user pressed.
			-- Note: `menu' has priority over menu_function,
			--		which has priority over `popup_widget'.
			-- It means, if `menu' or `menu_function.item (Void)' and `popup_widget' both not void,
			-- `menu' or `menu_function.item (Void)' will be used.

	popup_widget_function: detachable FUNCTION [ANY, TUPLE, like popup_widget]
			-- Function to compute the popup_widget to popup after end user pressed.
			-- Note: `popup_widget' has priority over `popup_widget_function',
			--		which has priority over `popup_widget'.
			-- It means, if `menu' or `menu_function.item (Void)' and `popup_widget' both not void,
			-- `menu' or `menu_function.item (Void)' will be used.	

	popup_widget: detachable EV_WIDGET
			-- Widget to popup after end user pressed

	gap: INTEGER = 2
			-- Gap size between front icon and dropdown icon

	dropdrown_width: INTEGER
			-- With of the dropdown area
		do
			Result := dropdown_pixel_buffer.width
		end

	dropdown_pixel_buffer: EV_PIXEL_BUFFER
			-- Dropdown pixel buffer
		local
			l_pixel_buffer: like dropdown_pixel_buffer_imp
		do
			l_pixel_buffer := dropdown_pixel_buffer_imp
			if l_pixel_buffer /= Void then
				Result := l_pixel_buffer
			else
				Result := internal_shared.icons.tool_bar_dropdown_buffer
			end
		ensure
			not_void: Result /= Void
		end

	dropdown_left: INTEGER
			--	X position where dropdown button should be drawn
		local
			l_tool_bar: like tool_bar
		do
			l_tool_bar := tool_bar
			if l_tool_bar /= Void then
				Result := l_tool_bar.item_x (Current) + width - dropdrown_width - 2
			end
		end

feature -- Basic operations

	perform_select
			-- Performs a selection
		require
			not_is_destroyed: not is_destroyed
			is_displayed: is_displayed
			has_function: menu /= Void or menu_function /= Void or popup_widget /= Void or popup_widget_function /= Void
		do
			on_select
		end

feature {NONE} -- Implementation

	popup: EV_POPUP_WINDOW
			-- Lazy creator of `popup_imp'
		local
			l_popup_imp: like popup_imp
		do
			l_popup_imp := popup_imp
			if l_popup_imp = Void then
				create l_popup_imp
				popup_imp := l_popup_imp
				l_popup_imp.focus_out_actions.extend (agent l_popup_imp.hide)
			end
			Result := l_popup_imp
		ensure
			not_void: Result /= Void
		end

	popup_imp: detachable EV_POPUP_WINDOW
			-- Popup window which appears after end user pressed

	on_select
			-- Handle select actions
		require
			set: menu /= Void or menu_function /= Void or popup_widget /= Void or popup_widget_function /= Void
		local
			l_helper: SD_POSITION_HELPER
			l_x, l_y, l_height: INTEGER
			l_menu: detachable EV_MENU
			l_tool_bar: like tool_bar
			l_popup_widget: like popup_widget
			l_popup: like popup
		do
			l_tool_bar := tool_bar
			if l_tool_bar /= Void then
				l_menu := menu
				if l_menu = Void and attached menu_function as l_menu_function then
					l_menu := l_menu_function.item (Void)
				end
				l_popup_widget := popup_widget
				if l_menu = Void and l_popup_widget = Void and attached popup_widget_function as l_popup_widget_function then
					l_popup_widget := l_popup_widget_function.item (Void)
				end
				if l_menu /= Void or l_popup_widget /= Void then
					create l_helper.make
					l_x := l_tool_bar.item_x (Current)
					l_y := l_tool_bar.item_y (Current)
					l_height := l_tool_bar.height
					if l_menu /= Void then
						if attached {EV_WIDGET} l_tool_bar as lt_widget then
							l_menu.show_at (lt_widget, l_x, l_y + l_tool_bar.standard_height)
						else
							check not_possible: False end
						end
					elseif l_popup_widget /= Void then
						l_popup := popup
						if not l_popup.has (l_popup_widget) then
							l_popup.wipe_out
							l_popup.extend (l_popup_widget)
						end
						l_helper.set_dialog_position (l_popup, l_tool_bar.screen_x + l_x, l_tool_bar.screen_y + l_y, l_height)
						l_popup.show
					end
				end
			end
		ensure
			popuped: (menu = Void and (menu_function = Void
						or else (attached menu_function as le_menu_function implies le_menu_function.item (Void) = Void)))
						 implies popup.is_displayed
		end

	dropdown_pixel_buffer_imp: detachable EV_PIXEL_BUFFER;
			-- Pixel buffer for dropdown button

note
	library:	"SmartDocking: Library of reusable components for Eiffel."
	copyright:	"Copyright (c) 1984-2010, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"


end

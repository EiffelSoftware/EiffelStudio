indexing
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

	make is
			-- Creation method
		do
			Precursor
			select_actions.extend (agent on_select)
		end

feature -- Command

	set_popup_widget (a_widget: like popup_widget) is
			-- Set `popup_widget' with `a_widget'
		do
			popup_widget := a_widget
			popup.wipe_out
			popup.extend (popup_widget)
		ensure
			set: popup_widget = a_widget and popup.has (popup_widget)
		end

	set_dropdown_pixel_buffer (a_pixel_buffer: EV_PIXEL_BUFFER) is
			-- Set `pixel_buffer_imp' with `a_pixel_buffer'.
		do
			dropdown_pixel_buffer_imp := a_pixel_buffer
		ensure
			set: dropdown_pixel_buffer_imp = a_pixel_buffer
		end

feature -- Query

	width: INTEGER is
			-- Redefine
		do
			Result := Precursor + gap + dropdrown_width
		end

	popup_widget: EV_WIDGET
			-- Widget to popup after end user pressed.

	gap: INTEGER is 2
			-- Gap size between front icon and dropdown icon.

	dropdrown_width: INTEGER is
			-- With of the dropdown area.
		do
			-- We plus one pixel for the middle separator in the button
			Result := dropdown_pixel_buffer.width
		end

	dropdown_pixel_buffer: EV_PIXEL_BUFFER is
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

	dropdown_left: INTEGER is
			--	X position where dropdown button should be drawn.
		do
			if tool_bar /= Void then
				Result := tool_bar.item_x (Current) + width - dropdrown_width
			end
		end

feature {NONE} -- Implementation

	popup: EV_POPUP_WINDOW is
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

	on_select is
			-- Handle select actions.
		require
			set: popup_widget /= Void
		local
			l_helper: SD_POSITION_HELPER
		do
			if popup_widget /= Void and tool_bar /= Void then
				create l_helper.make
				l_helper.set_dialog_position (popup, tool_bar.screen_x + tool_bar.item_x (Current), tool_bar.screen_y + tool_bar.item_y (Current), tool_bar.height)
				popup.show
			end
		ensure
			popuped: popup.is_displayed
		end

	dropdown_pixel_buffer_imp: EV_PIXEL_BUFFER;
			-- Pixel buffer for dropdown button.

indexing
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

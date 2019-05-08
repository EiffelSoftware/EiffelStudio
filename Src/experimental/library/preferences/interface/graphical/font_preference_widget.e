note
	description: "Default widget for viewing and editing font preferences."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	FONT_PREFERENCE_WIDGET

inherit
	PREFERENCE_WIDGET
		redefine
			preference,
			change_item_widget,
			update_changes,
			refresh
		end

create
	make_with_preference

feature -- Access

	graphical_type: STRING
			-- Graphical type identifier.
		do
			Result := "FONT"
		end

	preference: FONT_PREFERENCE
			-- Actual preference.

	last_selected_value: detachable EV_FONT
			-- value last selected by user.

	change_item_widget: EV_GRID_LABEL_ITEM
			-- font change label.

feature {preference_view} -- commands

	change
			-- change the value.
		require
			preference_exists: preference /= Void
			in_view: caller /= Void
		local
			l_font_tool: like font_tool
		do
				-- create font tool.
			create l_font_tool
			font_tool := l_font_tool
			l_font_tool.set_font (preference.value)
			l_font_tool.ok_actions.extend (agent update_changes)
			l_font_tool.cancel_actions.extend (agent cancel_changes)
			if attached caller as l_caller then
				l_caller.show_dialog_modal (l_font_tool)
			end
		end

feature {NONE} -- Commands

	update_changes
			-- Commit the result of Font Tool.
		do
			if font_tool /= Void then
				last_selected_value := font_tool.font
				if attached last_selected_value as v then
					preference.set_value (v)
					refresh
				end
			end
			Precursor {PREFERENCE_WIDGET}
		end

	cancel_changes
			-- Commit the result of Font Tool.
		do
			last_selected_value := Void
		end

	show
			-- Show the widget in its editable state
		do
			show_change_item_widget
		end

	refresh
		local
			l_font: EV_FONT
		do
			Precursor {PREFERENCE_WIDGET}
			l_font := preference.value.twin
			l_font.set_height_in_points (default_font_height)
			if change_item_widget /= Void then
				change_item_widget.set_font (l_font)
				change_item_widget.set_text (preference.text_value)
			end
		end

feature {NONE} -- Implementation

	build_change_item_widget
			-- Create and setup `change_item_widget'.
		do
			create change_item_widget
			refresh
			change_item_widget.pointer_double_press_actions.extend
				(agent (x, y, b: INTEGER_32; x_tilt, y_tilt, pressure: REAL_64; screen_x, screen_y: INTEGER_32) do show_change_item_widget end)
		end

	show_change_item_widget
			-- Show the font change dialog.
		do
			change
		end

	font_tool: detachable EV_FONT_DIALOG note option: stable attribute end
			-- Dialog from which we can select a font.

	default_font_height: INTEGER = 9;
			-- Default font height in points (for display only)

note

	copyright:	"Copyright (c) 1984-2018, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end

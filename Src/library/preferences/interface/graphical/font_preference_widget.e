note
	description	: "Default widget for viewing and editing font preferences."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date		: "$Date$"
	revision	: "$Revision$"

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
	make,
	make_with_preference

feature -- Access

	graphical_type: STRING
			-- Graphical type identifier.
		do
			Result := "FONT"
		end

	preference: FONT_PREFERENCE
			-- Actual preference.

	last_selected_value: EV_FONT
			-- value last selected by user.

	change_item_widget: ev_grid_label_item
			-- font change label.

feature {preference_view} -- commands

	change
			-- change the value.
		require
			preference_exists: preference /= Void
			in_view: caller /= Void
		do
				-- create font tool.
			create font_tool
			font_tool.set_font (preference.value)

			font_tool.ok_actions.extend (agent update_changes)
			font_tool.cancel_actions.extend (agent cancel_changes)
			caller.show_dialog_modal (font_tool)
		end

feature {NONE} -- Commands

	update_changes
			-- Commit the result of Font Tool.
		do
			last_selected_value := font_tool.font
			if last_selected_value /= Void then
				preference.set_value (last_selected_value)
				refresh
			end
			Precursor {PREFERENCE_WIDGET}
		end

	cancel_changes
			-- Commit the result of Font Tool.
		do
			last_selected_value := Void
		end

	update_preference
			-- Update preference to reflect recently chosen value
		do
			if last_selected_value /= Void then
				preference.set_value (last_selected_value)
			end
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
			change_item_widget.set_font (l_font)
			change_item_widget.set_text (preference.string_value)
		end

feature {NONE} -- Implementation

	build_change_item_widget
			-- Create and setup `change_item_widget'.
		do
			create change_item_widget
			refresh
			change_item_widget.pointer_double_press_actions.force_extend (agent show_change_item_widget)
		end

	show_change_item_widget
			-- Show the font change dialog.
		do
			change
		end

	font_tool: EV_FONT_DIALOG
			-- Dialog from which we can select a font.

	default_font_height: INTEGER = 9;
			-- Default font height in points (for display only)

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

end -- class FONT_PREFERENCE_WIDGET

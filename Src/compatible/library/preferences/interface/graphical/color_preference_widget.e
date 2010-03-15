note
	description	: "Default widget for viewing and editing color preferences."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date		: "$Date$"
	revision	: "$Revision$"

class
	COLOR_PREFERENCE_WIDGET

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
			Result := "COLOR"
		end

	preference: COLOR_PREFERENCE
			-- Actual preference.

	last_selected_value: detachable EV_COLOR
			-- The last selected value in the choice dialog.

	change_item_widget: EV_GRID_DRAWABLE_ITEM
			-- Color change item widget.

feature {PREFERENCE_VIEW} -- Commands

	change
			-- Change the value.
		require
			preference_exists: preference /= Void
			in_view: caller /= Void
		local
			l_color_tool: like color_tool
		do
			create l_color_tool
			color_tool := l_color_tool
			if attached preference.value as v then
				l_color_tool.set_color (v)
			end
			l_color_tool.ok_actions.extend (agent update_changes)
			if attached caller as l_caller then
				l_caller.show_dialog_modal (l_color_tool)
			else
				check in_view: False end
			end
		end

feature {NONE} -- Commands

	update_changes
			-- Update the changes made in `change_item_widget' to `preference'.
		require else
			color_tool_exists: attached color_tool as rl_color_tool
			color_selected : rl_color_tool.color /= Void
		local
			l_color_tool: like color_tool
			color: EV_COLOR
		do
			l_color_tool := color_tool
			check l_color_tool /= Void end -- implied by `color_tool_exists'
			color := l_color_tool.color
			last_selected_value := color
			if color /= Void then
				preference.set_value (color)
			end
			Precursor {PREFERENCE_WIDGET}
		end

	update_preference
			-- Updates preference.
		do
			if attached last_selected_value as v then
				preference.set_value (v)
			end
		end

	show
			-- Show the widget in its editable state.
		do
			show_change_item_widget
		end

	refresh
		do
			Precursor {PREFERENCE_WIDGET}
			if attached change_item_widget as w and then w.parent /= Void then
				w.redraw
			end
		end

feature {NONE} -- Implementation

	build_change_item_widget
			-- Create and setup `change_item_widget'.
		local
			l_change_item_widget: like change_item_widget
		do
			create l_change_item_widget
			change_item_widget := l_change_item_widget
			l_change_item_widget.expose_actions.extend (agent on_color_item_exposed (?))
			refresh
			l_change_item_widget.pointer_double_press_actions.force_extend (agent show_change_item_widget)
		end

	show_change_item_widget
			-- Show the change color dialog.
		do
			change
			if attached last_selected_value as v then
				preference.set_value (v)
			end
		end

	on_color_item_exposed (area: EV_DRAWABLE)
			-- Expose part of color preference value item.
		local
			l_y: INTEGER
			g: detachable EV_GRID
			l_change_item_widget: like change_item_widget
		do
			l_change_item_widget := change_item_widget
			check l_change_item_widget /= Void end
				-- Write the text
			g := l_change_item_widget.parent
			check g /= Void end -- Implied by `on_color_item_exposed' being called			

			if l_change_item_widget.row.is_selected then
				area.set_foreground_color (g.focused_selection_color)
				area.fill_rectangle (0, 0, l_change_item_widget.width, l_change_item_widget.height)
				area.set_foreground_color ((create {EV_STOCK_COLORS}).white)
				area.draw_text_top_left (20, 1, preference.string_value)
			else
				area.set_foreground_color ((create {EV_STOCK_COLORS}).white)
				area.fill_rectangle (0, 0, l_change_item_widget.width, l_change_item_widget.height)
				area.set_foreground_color ((create {EV_STOCK_COLORS}).black)
				area.draw_text_top_left (20, 1, preference.string_value)
			end

				-- Draw the little color box border
			if g.is_row_height_fixed then
				l_y := (g.row_height // 2 - 6)
			else
				l_y := (l_change_item_widget.row.height // 2 - 6)
			end
			area.set_foreground_color ((create {EV_STOCK_COLORS}).black)
			area.draw_rectangle (2, l_y, 12, 12)

				-- Draw the little color box internal color
			if attached preference.value as v then
				area.set_foreground_color (v)
			else
				area.set_default_colors --| Should not occur
			end
			area.fill_rectangle (3, l_y + 1, 10, 10)
		end

	color_tool: detachable EV_COLOR_DIALOG;
			-- Color Palette from which we can select a color.

note
	copyright:	"Copyright (c) 1984-2009, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"




end -- class COLOR_PREFERENCE_WIDGET

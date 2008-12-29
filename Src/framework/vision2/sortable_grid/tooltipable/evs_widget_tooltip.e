note
	description: "General tooltip that displays a widget as its content"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EVS_WIDGET_TOOLTIP

inherit
	EVS_GENERAL_TOOLTIP
		rename
			make as old_make
		end

	EVS_BORDERED

create
	make

feature{NONE} -- Initialization

	make (a_enter_actions: like pointer_enter_actions;
	      a_leave_actions: like pointer_leave_actions;
	      a_select_actions: like select_actions;
	      a_destroy_function: like owner_destroy_function; a_widget: like widget)
			-- Initialize agents used for current tooltip.
			-- See `pointer_enter_actions', `pointer_leave_actions',
			-- `owner_destroy_function', for more information.
		require
			a_enter_actions_attached: a_enter_actions /= Void
			a_leave_actions_attached: a_leave_actions /= Void
			a_destroy_function_attached: a_destroy_function /= Void
			a_widget_attached: a_widget /= Void
		do
			create widget_container
			create left_border_cell
			create right_border_cell
			create top_border_cell
			create bottom_border_cell
			create horizontal_container
			create vertical_container
			set_widget (a_widget)
			setting_change_actions.extend (agent on_setting_change)

			horizontal_container.extend (left_border_cell)
			horizontal_container.disable_item_expand (left_border_cell)
			horizontal_container.extend (widget)
			horizontal_container.extend (right_border_cell)
			horizontal_container.disable_item_expand (right_border_cell)

			vertical_container.extend (top_border_cell)
			vertical_container.disable_item_expand (top_border_cell)
			vertical_container.extend (horizontal_container)
			vertical_container.extend (bottom_border_cell)
			vertical_container.disable_item_expand (bottom_border_cell)

			widget_container.extend (vertical_container)

			set_left_border (2)
			set_right_border (2)
			set_top_border (2)
			set_bottom_border (2)
			set_border_line_width (1)

			old_make (
				a_enter_actions, a_leave_actions, a_select_actions,
				agent actual_widget,
				a_destroy_function,
				agent tooltip_width,
				agent tooltip_height)
		end

feature -- Access

	has_tooltip_text_function: FUNCTION [ANY, TUPLE, BOOLEAN]
			-- Function to indicate if there is text in Current tooltip
			-- Used by `has_tooltip_text'.

	widget: EV_WIDGET
			-- Widget to be displayed in Current tooltip

	tooltip_width: INTEGER
			-- Required width for tooltip
		do
			Result := left_border + widget.width + right_border + border_line_width * 2
		end

	tooltip_height: INTEGER
			-- Required height for tooltip
		do
			Result := top_border + widget.height + bottom_border + border_line_width * 2
		end

	actual_widget: like widget
			-- Actual widget
		do
			Result := widget_container
		ensure
			result_attached: Result /= Void
		end

	widget_container: EV_VERTICAL_BOX
			-- Container for `widget'

feature -- Status report

	has_tooltip_text: BOOLEAN
			-- Does current tooltip has any text?
		do
			if has_tooltip_text_function /= Void then
				Result := has_tooltip_text_function.item (Void)
			else
				Result := True
			end
		end

feature -- Setting

	set_has_tooltip_text_function (a_function: like has_tooltip_text_function)
			-- Set `has_tooltip_text_function' with `a_function'.
		do
			has_tooltip_text_function := a_function
		ensure
			has_tooltip_text_function_set: has_tooltip_text_function = a_function
		end

	set_widget (a_widget: like widget)
			-- Set `widget' with `a_widget'.
		do
			widget := a_widget
		ensure
			widget_set: widget = a_widget
		end

	unify_background_color
			-- Unify background color for `widget'.
			-- i.e., set background color of `widget' to `actual_tooltip_background_color'.
		do
			widget.set_background_color (actual_tooltip_background_color)
		end

feature{NONE} -- Implementation

	on_setting_change
			-- Action to be performed when setting chanages
		local
			l_background_color: like actual_tooltip_background_color
		do
			l_background_color := actual_tooltip_background_color
			widget_container.set_border_width (border_line_width)
			widget_container.set_background_color (actual_border_line_color)
			widget_container.set_foreground_color (l_background_color)

			left_border_cell.set_background_color (l_background_color)
			left_border_cell.set_minimum_size (left_border, widget.height)

			right_border_cell.set_background_color (l_background_color)
			right_border_cell.set_minimum_size (right_border, widget.height)

			top_border_cell.set_background_color (l_background_color)
			top_border_cell.set_minimum_size (widget.width + left_border + right_border, top_border)

			bottom_border_cell.set_background_color (l_background_color)
			bottom_border_cell.set_minimum_size (widget.width + left_border + right_border, bottom_border)
		end

	left_border_cell: EV_CELL
	right_border_cell: EV_CELL
	top_border_cell: EV_CELL
	bottom_border_cell: EV_CELL

	horizontal_container: EV_HORIZONTAL_BOX
	vertical_container: EV_VERTICAL_BOX

invariant
	widget_attached: widget /= Void
	widget_container_attached: widget_container /= Void
end


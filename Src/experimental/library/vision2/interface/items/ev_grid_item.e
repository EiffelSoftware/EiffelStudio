note
	description: "Item that can be inserted in a cell of an EV_GRID."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_GRID_ITEM

inherit
	EV_CONTAINABLE
		redefine
			implementation,
			is_in_default_state
		end

	REFACTORING_HELPER
		undefine
			copy, default_create
		end

	EV_DESELECTABLE
		redefine
			implementation,
			is_in_default_state
		end

	EV_GRID_ITEM_ACTION_SEQUENCES
		redefine
			implementation
		end

create
	default_create

feature -- Access

	column: EV_GRID_COLUMN
			-- Column to which current item belongs.
		require
			not_destroyed: not is_destroyed
			is_parented: is_parented
		do
			Result := implementation.column
		ensure
			column_not_void: Result /= Void
		end

	parent: detachable EV_GRID
			-- Grid in which `Current' is contained if any.
		do
			Result := implementation.parent
		end

	attached_parent: EV_GRID
			-- Attached grid in which `Current' is contained.
		require
			parent /= Void
		do
			Result := implementation.attached_parent
		end

	row: EV_GRID_ROW
			-- Row to which current item belongs.
		require
			not_destroyed: not is_destroyed
			parented: is_parented
		do
			Result := implementation.row
		ensure
			row_not_void: Result /= Void
		end

	virtual_x_position: INTEGER
			-- Horizontal offset of `Current' in relation to the
			-- the virtual area of `parent' grid in pixels.
		require
			not_destroyed: not is_destroyed
			parented: is_parented
		do
			Result := implementation.virtual_x_position
		ensure
			valid_result: attached parent as l_parent implies Result >= 0 and Result <= l_parent.virtual_width - column.width + horizontal_indent
		end

	virtual_y_position: INTEGER
			-- Vertical offset of `Current' in relation to the
			-- the virtual area of `parent' grid in pixels.
		require
			not_destroyed: not is_destroyed
			parented: is_parented
		do
			Result := implementation.virtual_y_position
		ensure
			valid_result_when_parent_row_height_fixed: attached parent as l_parent and then l_parent.is_row_height_fixed implies Result >= 0 and Result <= l_parent.virtual_height - l_parent.row_height
			valid_result_when_parent_row_height_not_fixed: attached parent as l_parent and then not l_parent.is_row_height_fixed implies Result >= 0 and Result <= l_parent.virtual_height - row.height
		end

	horizontal_indent: INTEGER
			-- Horizontal distance in pixels from left edge of `Current' to left edge of `column'.
			-- This may not be set, but the value is determined by the current tree structure
			-- of `parent' and `row'.
		require
			not_destroyed: not is_destroyed
			parented: is_parented
		do
			Result := implementation.horizontal_indent
		ensure
			not_parent_tree_enabled_implies_result_zero: attached parent and then ((attached parent as l_parent and then not l_parent.is_tree_enabled) implies Result = 0)
			parent_tree_enabled_implies_result_greater_or_equal_to_zero: attached parent and then ((attached parent as l_parent and then l_parent.is_tree_enabled) implies Result >= 0)
		end

	width: INTEGER
			-- Width of `Current' in pixels.
		require
			not_destroyed: not is_destroyed
			parented: is_parented
		do
			Result := implementation.width
		ensure
			Result_non_negative: Result >= 0
		end

	height: INTEGER
			-- Height of `Current' in pixels.
		require
			not_destroyed: not is_destroyed
			parented: is_parented
		do
			Result := implementation.height
		ensure
			Result_non_negative: Result >= 0
		end

	foreground_color: detachable EV_COLOR
			-- Color of foreground features like text.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.foreground_color
		end

	background_color: detachable EV_COLOR
			-- Color displayed behind foreground features.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.background_color
		end

	tooltip: detachable STRING_32
			-- Tooltip displayed on `Current'.
			-- If `Result' is `Void' or `is_empty' then no tooltip is displayed.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.tooltip
		end

	required_width: INTEGER
			-- Width in pixels required to fully display contents, based
			-- on current settings.
			-- Note that in some descendents such as EV_GRID_DRAWABLE_ITEM, this
			-- returns 0. For such items, `set_required_width' is available.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.required_width
		ensure
			result_non_negative: Result >= 0
		end

	is_displayed: BOOLEAN
			-- Is `Current' visible on the screen?
			-- An item that is_displayed does not necessarily have to be visible on screen at that particular time.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.is_displayed
		ensure
			bridge_ok: Result = implementation.is_displayed
		end

feature -- Status setting

	ensure_visible
			-- Ensure `Current' is visible in viewable area of `parent'.
		require
			not_destroyed: not is_destroyed
			parented: parent /= Void
			is_displayed: is_displayed
		do
			implementation.ensure_visible
		ensure
			virtual_x_position_not_changed_if_indent_greater_or_equal_to_column_width: old (horizontal_indent > column.width) implies old virtual_x_position = virtual_x_position
			virtual_x_position_not_changed_if_item_already_visible: old (virtual_x_position >= attached_parent.virtual_x_position) and old (virtual_x_position + width <= attached_parent.virtual_x_position + attached_parent.viewable_width) implies old (virtual_x_position = virtual_x_position)
			virtual_y_position_not_changed_if_item_already_visible: old (virtual_y_position >= attached_parent.virtual_y_position) and old (virtual_y_position + height <= attached_parent.virtual_y_position + attached_parent.viewable_height) implies old (virtual_y_position = virtual_y_position)
			row_visible_when_heights_fixed_in_parent: attached_parent.is_row_height_fixed implies row.virtual_y_position >= attached_parent.virtual_y_position and virtual_y_position + attached_parent.row_height <= attached_parent.virtual_y_position + (attached_parent.viewable_height).max (attached_parent.row_height)
			row_visible_when_heights_not_fixed_in_parent: not attached_parent.is_row_height_fixed implies row.virtual_y_position >= attached_parent.virtual_y_position and virtual_y_position + row.height <= attached_parent.virtual_y_position + (attached_parent.viewable_height).max (row.height)
			virtual_x_position_visible_if_indent_less_than_column_width: horizontal_indent < column.width implies virtual_x_position >= attached_parent.virtual_x_position and virtual_x_position + width <= attached_parent.virtual_x_position + (attached_parent.viewable_width).max (width)
		end

	set_foreground_color (a_color: like foreground_color)
			-- Assign `a_color' to `foreground_color'.
		require
			not_destroyed: not is_destroyed
		do
			implementation.set_foreground_color (a_color)
		ensure
			foreground_color_assigned: foreground_color = a_color
		end

	set_background_color (a_color: like background_color)
			-- Assign `a_color' to `background_color'.
		require
			not_destroyed: not is_destroyed
		do
			implementation.set_background_color (a_color)
		ensure
			background_color_assigned: background_color = a_color
		end

	set_tooltip (a_tooltip: detachable STRING_GENERAL)
			-- Assign `a_tooltip' to `tooltip'.
			-- pass `Void' to remove the tooltip.
		require
			not_destroyed: not is_destroyed
		do
			implementation.set_tooltip (a_tooltip)
		ensure
			tooltip_reset: a_tooltip = Void implies tooltip = Void
			tooltip_set: a_tooltip /= Void implies (attached tooltip as l_tooltip and then a_tooltip.as_string_32 ~ l_tooltip)
		end

feature -- Actions

	activate
			-- Setup `Current' for interactive in-place editing of `Current'.
			-- Activation is usually achieved by connecting an agent  to
			-- {EV_GRID}.pointer_double_press_actions' that calls `activate'.
			-- Will call `activate_action' of `Current' to setup the in-place editing.
			-- The default behavior of the activation can be overriden in {EV_GRID}.item_activate_actions,
			-- this is useful for repositioning the popup window used editing `Current'.
			-- See {EV_GRID_EDITABLE_ITEM}.activate_action for an example of what happens on activation.
		require
			not_destroyed: not is_destroyed
			parented: is_parented
		do
			implementation.activate
		end

	deactivate
			-- Cleanup from previous call to `activate'.
		require
			not_destroyed: not is_destroyed
			parented: is_parented
		do
			implementation.deactivate
		end

	redraw
			-- Force `Current' to be re-drawn when next idle.
		require
			not_destroyed: not is_destroyed
			parented: is_parented
		do
			implementation.redraw
		end

feature -- Status report

	is_parented: BOOLEAN
			-- Does current item belong to an EV_GRID?
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.is_parented
		end

feature {NONE} -- Contract Support

	is_in_default_state: BOOLEAN
			-- Is `Current' in its default state?
			-- (from EV_ANY)
			-- (export status {NONE})
		do
			Result := Precursor {EV_CONTAINABLE} and Precursor {EV_DESELECTABLE} and
				foreground_color = Void and background_color = Void and tooltip = Void
		end

feature {EV_ANY, EV_ANY_I, EV_GRID_DRAWER_I} -- Implementation

	implementation: EV_GRID_ITEM_I
			-- Responsible for interaction with native graphics toolkit.

feature {EV_GRID_I} -- Implementation

	activate_action (popup_window: EV_POPUP_WINDOW)
			-- `Current' has been requested to be updated via `popup_window'.
			-- Used for initializing `popup_window' for in-place editing.
			-- `popup_window' will be shown after `activate_action' has executed.
		require
			parented: is_parented
			popup_window_not_void: popup_window /= Void
			popup_window_not_destroyed: not popup_window.is_destroyed
		do
			-- By default do nothing, redefined by descendants.
		ensure
			popup_window_not_destroyed: not popup_window.is_destroyed
			popup_window_not_shown: not popup_window.is_show_requested
		end

feature {NONE} -- Implementation

	create_interface_objects
			-- <Precursor>
		do

		end

	create_implementation
			-- See `{EV_ANY}.create_implementation'.
		do
			create {EV_GRID_ITEM_I} implementation.make
		end

invariant
	parented_implies_height_equals_row_height_or_parent_row_height:
		(attached parent as l_parent and then not l_parent.is_row_height_fixed implies height = row.height) or
		(attached parent as l_parent and then l_parent.is_row_height_fixed implies height = l_parent.row_height)
	parented_and_parent_has_no_tree_implies_width_equals_column_width:
		attached parent as l_parent and then not l_parent.is_tree_enabled implies width = column.width
	parented_and_row_is_subrow_implies_width_equals_column_width_less_indent:
		attached parent as l_parent and row.parent_row /= Void implies width = (column.width - horizontal_indent).max (0)

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




end












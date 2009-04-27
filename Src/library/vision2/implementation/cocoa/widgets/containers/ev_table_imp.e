indexing

	description:
		"EiffelVision table, Cocoa implementation"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	EV_TABLE_IMP

inherit
	EV_TABLE_I
		undefine
			propagate_foreground_color,
			propagate_background_color
		redefine
			interface,
			set_item_position,
			set_item_span,
			remove,
			put,
			resize
		end

	EV_CONTAINER_IMP
		redefine
			interface,
			set_top_level_window_imp
		end

create
	make

feature {NONE} -- Implementation

	make (an_interface: like interface)
			-- Create a table widget with `par' as parent.
		do
			base_make (an_interface)
			create {NS_BOX}cocoa_item.new

			-- Initialize internal values
			rows := 1
			columns := 1
			create internal_array.make (1, 1)
			rebuild_internal_item_list
		end

feature -- Status report

	is_homogeneous: BOOLEAN
			-- Does Table have homogeneous spacing, no by default.

	row_spacing: INTEGER
		do

		end

	column_spacing: INTEGER
		do

		end

	border_width: INTEGER
			-- Width of border around container in pixels.
		do

		end

	replace (a_widget: EV_WIDGET)
		local
			w_imp: EV_WIDGET_IMP
		do
			w_imp ?= a_widget.implementation
			on_new_item (w_imp)
		end

feature -- Widget relationships

	top_level_window_imp: EV_WINDOW_IMP
			-- Top level window that contains `Current'.
		do
			check
				not_implemented: false
			end
		end

	set_top_level_window_imp (a_window: EV_WINDOW_IMP)
			-- Make `a_window' the new `top_level_window_imp'
			-- of `Current'.
		do
			check
				not_implemented: false
			end
		end

feature -- Status settings

	enable_homogeneous
			-- Homogenous controls whether each object in
			-- the box has the same size.
		do


		end

	disable_homogeneous
			-- Homogenous controls whether each object in
			-- the box has the same size.
		do

			is_homogeneous := False
		end

	set_border_width (a_value: INTEGER)
			-- Set the tables border width to `a_value' pixels.
		do

		end

	set_row_spacing (a_value: INTEGER)
			-- Spacing between two rows of the table.
		do

		end

	set_column_spacing (a_value: INTEGER)
			-- Spacing between two columns of the table.
		do

		end

	put (v: EV_WIDGET; a_column, a_row, column_span, row_span: INTEGER)
			-- Set the position of the `v' in the table.
		do
		end

	remove (v: EV_WIDGET)
			-- Remove `v' from the table if present.
		do

		end

	set_item_position (v: EV_WIDGET; a_column, a_row: INTEGER)
			-- Move `v' to position `a_column', `a_row'.
		do

		end

	item_column_span (widget: EV_WIDGET): INTEGER
			-- `Result' is number of columns taken by `widget'.
		do

		end

	item_row_span (widget: EV_WIDGET): INTEGER
			--  `Result' is number of rows taken by `widget'.
		do
		end

	item_row_position (widget: EV_WIDGET): INTEGER
			-- Result is row coordinate of 'widget'
		do

		end

	item_column_position (widget: EV_WIDGET): INTEGER
			-- Result is column coordinate of 'widget'
		do

		end

feature {EV_ANY_I, EV_ANY} -- Status Settings

	resize (a_column, a_row: INTEGER)
		do
		end

	set_item_span (v: EV_WIDGET; column_span, row_span: INTEGER)
			-- Resize 'v' to occupy column span and row span
		do
		end

feature {NONE} -- Layout

	compute_minimum_width
			-- Recompute minimum_width of `Curren'.
		do
			-- FIXME: not yet implemented
		end

	compute_minimum_height
			-- Recompute minimum_width of `Current'.
		do
			-- FIXME: not yet implemented
		end

	compute_minimum_size
			-- Recompute minimum size of `Current'.
		do
			-- FIXME: not yet implemented
		end

	ev_apply_new_size (a_x_position, a_y_position, a_width, a_height: INTEGER_32; repaint: BOOLEAN)
		do
			
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_TABLE;

indexing
	copyright:	"Copyright (c) 2009, Daniel Furrer"
end -- class EV_TABLE_IMP


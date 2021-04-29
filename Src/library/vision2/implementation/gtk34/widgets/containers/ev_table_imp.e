note

	description:
		"EiffelVision table, gtk implementation"
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
			needs_event_box,
			make
		end

create
	make

feature {NONE} -- Implementation

	needs_event_box: BOOLEAN = True

	old_make (an_interface: attached like interface)
		do
			assign_interface (an_interface)
		end

	make
			-- Create and initialize `Current'.
		do
			set_c_object ({GTK3}.gtk_grid_new)

			-- Initialize internal values
			rows := 1
			columns := 1
			create internal_array.make_filled (Void, rows, columns)
			rebuild_internal_item_list
			Precursor
		end

feature -- Status report

	is_homogeneous: BOOLEAN
			-- Does Table have homogeneous spacing, no by default.

	row_spacing: INTEGER
		do
			Result := {GTK3}.gtk_grid_get_row_spacing (container_widget)
		end

	column_spacing: INTEGER
		do
			Result := {GTK3}.gtk_grid_get_column_spacing (container_widget)
		end

	border_width: INTEGER
			-- Width of border around container in pixels.
		do
			Result := {GTK}.gtk_container_get_border_width (container_widget)
		end

feature -- Status settings

	enable_homogeneous
			-- Homogenous controls whether each object in
			-- the box has the same size.
		do
			{GTK3}.gtk_grid_set_row_homogeneous (container_widget, True)
			{GTK3}.gtk_grid_set_column_homogeneous (container_widget, True)
			is_homogeneous := True
		end

	disable_homogeneous
			-- Homogenous controls whether each object in
			-- the box has the same size.
		do
			{GTK3}.gtk_grid_set_row_homogeneous (container_widget, False)
			{GTK3}.gtk_grid_set_column_homogeneous (container_widget, False)
			is_homogeneous := False
		end

	set_border_width (a_value: INTEGER)
			-- Set the tables border width to `a_value' pixels.
		do
			{GTK}.gtk_container_set_border_width (container_widget, a_value)
		end

	set_row_spacing (a_value: INTEGER)
			-- Spacing between two rows of the table.
		do
			{GTK3}.gtk_grid_set_row_spacing (container_widget, a_value)
		end

	set_column_spacing (a_value: INTEGER)
			-- Spacing between two columns of the table.
		do
			{GTK3}.gtk_grid_set_column_spacing (container_widget, a_value)
		end

	put (v: EV_WIDGET; a_column, a_row, column_span, row_span: INTEGER)
			-- Set the position of the `v' in the table.
		local
			item_imp: detachable EV_WIDGET_IMP
		do
			Precursor {EV_TABLE_I} (v, a_column, a_row, column_span, row_span)
			item_imp ?= v.implementation
			check item_imp /= Void end
			if item_imp /= Void then
				on_new_item (item_imp)
				{GTK3}.gtk_grid_attach (
						container_widget,
						item_imp.c_object,
						a_column - 1,
						a_row - 1,
						column_span,
						row_span
				)
			end
		end

	remove (v: EV_WIDGET)
			-- Remove `v' from the table if present.
		local
			item_imp: detachable EV_WIDGET_IMP
		do
			Precursor {EV_TABLE_I} (v)
			item_imp ?= v.implementation
			check item_imp /= Void end
			if item_imp /= Void then
				on_removed_item (item_imp)
				{GTK}.gtk_container_remove (container_widget, item_imp.c_object)
			end
		end

	set_item_position (v: EV_WIDGET; a_column, a_row: INTEGER)
			-- Move `v' to position `a_column', `a_row'.
		local
			column_span, row_span: INTEGER
		do
			Precursor {EV_TABLE_I} (v, a_column, a_row)
			column_span := item_column_span (v)
			row_span := item_row_span (v)
			remove (v)
			put (v, a_column, a_row, column_span, row_span)
		end

	item_column_span (widget: EV_WIDGET): INTEGER
			-- `Result' is number of columns taken by `widget'.
		local
			row_index, column_index: INTEGER
			end_span: BOOLEAN
		do
			from
				row_index := item_row_position (widget)
				column_index := item_column_position (widget)
			until
				end_span or (column_index - 1) = columns
			loop
				if item_at_position (column_index, row_index) = widget then
					Result := Result + 1
				else
					end_span := True
				end
				column_index := column_index + 1
			end
		end

	item_row_span (widget: EV_WIDGET): INTEGER
			--  `Result' is number of rows taken by `widget'.
		local
			row_index, column_index: INTEGER
			end_span: BOOLEAN
		do
			from
				row_index := item_row_position (widget)
				column_index := item_column_position (widget)
			until
				end_span or else (row_index - 1) = rows
			loop
				if item_at_position (column_index, row_index) = widget then
					Result := Result + 1
				else
					end_span := True
				end
				row_index := row_index + 1
			end
		end

	item_row_position (widget: EV_WIDGET): INTEGER
			-- Result is row coordinate of 'widget'
		local
			row_cnt, column_cnt: INTEGER
			found: BOOLEAN
		do
			from
				row_cnt := 1
			until
				row_cnt > rows or found
			loop
				from
					column_cnt := 1
				until
					column_cnt > columns or found
				loop
					if item_at_position (column_cnt, row_cnt) = widget then
						Result := row_cnt
						found := True
					end
					column_cnt := column_cnt + 1
				end
				row_cnt := row_cnt + 1
			end
		end

	item_column_position (widget: EV_WIDGET): INTEGER
			-- Result is column coordinate of 'widget'
		local
			row_cnt, column_cnt: INTEGER
			found: BOOLEAN
		do
			from
				row_cnt := 1
			until
				row_cnt > rows or found
			loop
				from
					column_cnt := 1
				until
					column_cnt > columns or found
				loop
					if item_at_position (column_cnt, row_cnt) = widget then
						Result := column_cnt
						found := True
					end
					column_cnt := column_cnt + 1
				end
				row_cnt := row_cnt + 1
			end
		end

feature {EV_ANY_I, EV_ANY} -- Status Settings

	resize (a_column, a_row: INTEGER)
		do
			-- Now using GtkGrid, resizes automatically

			Precursor {EV_TABLE_I} (a_column, a_row)
			--{GTK}.gtk_table_resize (container_widget, a_row, a_column)
		end

	set_item_span (v: EV_WIDGET; column_span, row_span: INTEGER)
			-- Resize 'v' to occupy column span and row span
		local
			a_column, a_row: INTEGER
		do
			Precursor {EV_TABLE_I} (v, column_span, row_span)
			a_column := item_column_position (v)
			a_row := item_row_position (v)
			remove (v)
			put (v, a_column, a_row, column_span, row_span)
		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	interface: detachable EV_TABLE note option: stable attribute end;

note
	copyright:	"Copyright (c) 1984-2021, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end -- class EV_TABLE_IMP

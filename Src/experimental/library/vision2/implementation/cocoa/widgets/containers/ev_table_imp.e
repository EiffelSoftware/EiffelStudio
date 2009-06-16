note
	description: "EiffelVision table, Cocoa implementation"
	author: "Daniel Furrer"
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
			make,
			set_top_level_window_imp
		end

create
	make

feature {NONE} -- Implementation

	old_make (an_interface: like interface)
			-- Create a table widget with `par' as parent.
		do
			assign_interface (an_interface)
		end

	make
		do
			create {NS_BOX}cocoa_item.make

			-- Initialize internal values
			rows := 1
			columns := 1
			create ev_children.make (2)
			create internal_array.make (1, 1)
			rebuild_internal_item_list
			Precursor
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

	replace (v: like item)
			-- Replace `item' with `v'.	
		do
			check
				to_be_implemented: False
			end
		end

feature -- Widget relationships

	top_level_window_imp: EV_WINDOW_IMP
			-- Top level window that contains `Current'.

	set_top_level_window_imp (a_window: EV_WINDOW_IMP)
			-- Make `a_window' the new `top_level_window_imp'
			-- of `Current'.
		local
			list: ARRAYED_LIST [EV_TABLE_CHILD_IMP]
			cur: CURSOR
		do
			top_level_window_imp := a_window
			if not ev_children.is_empty then
				list := ev_children
				from
					cur := list.cursor
					list.start
				until
					list.after
				loop
					list.item.widget.set_top_level_window_imp (a_window)
					list.forth
				end
				list.go_to (cur)
			end
		end


feature -- Status settings

	enable_homogeneous
			-- Homogenous controls whether each object in
			-- the box has the same size.
		do
			is_homogeneous := True
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

	put (child: EV_WIDGET; a_x, a_y, a_width, a_height: INTEGER)
			--	Add `child' to `Current' at cell position `a_x', `a_y',
			-- with size `a_width', `a_height' in cells.
		local
			table_child: EV_TABLE_CHILD_IMP
			child_imp: EV_WIDGET_IMP
		do
			Precursor {EV_TABLE_I} (child, a_x, a_y, a_width, a_height)
			child.implementation.on_parented
			child_imp ?= child.implementation
			check
				valid_child: child_imp /= Void
			end
			-- Set the parent of `child_imp'.
			child_imp.set_parent_imp (current)

			-- Create `table_child' to hold `child_imp'.
			create table_child.make (child_imp, Current)
			-- Add the table child to `ev_children'.
			ev_children.extend (table_child)
			-- Set the attachment of the table child.
			table_child.set_attachment (a_y - 1, a_x - 1, a_y + a_height - 1, a_x + a_width - 1)
			-- We show the child and resize the container
			child_imp.show
			notify_change (Nc_minsize, Current)
			new_item_actions.call ([child])
		end

	remove (v: EV_WIDGET)
			-- Remove `v' from the table if present.
		do

		end

	set_item_position (v: EV_WIDGET; a_column, a_row: INTEGER)
			-- Move `v' to position `a_column', `a_row'.
		do

		end

	item_column_position (widget: EV_WIDGET): INTEGER
			-- `Result' is column coordinate of `widget'.
		local
			widget_imp: EV_WIDGET_IMP
		do
			-- Retrieve implementation of `widget'.
			widget_imp ?= widget.implementation
			check
				implementation_not_void: widget_imp /= Void
			end
			Result := find_widget_child (widget_imp).left_attachment + 1
		end

	item_row_position (widget: EV_WIDGET): INTEGER
			-- `Result' is row coordinate of `widget'.
		local
			widget_imp: EV_WIDGET_IMP
		do
			-- Retrieve implementation of `widget'.
			widget_imp ?= widget.implementation
			check
				implementation_not_void: widget_imp /= Void
			end
			Result := find_widget_child (widget_imp).top_attachment + 1
		end

	item_column_span (widget: EV_WIDGET): INTEGER
			-- `Result' is number of columns taken by `widget'.
		local
			widget_child: EV_TABLE_CHILD_IMP
			widget_imp: EV_WIDGET_IMP
		do
			-- Retrieve implementation of `widget'.
			widget_imp ?= widget.implementation
			check
				implementation_not_void: widget_imp /= Void
			end
			widget_child := find_widget_child (widget_imp)
			Result := widget_child.right_attachment - widget_child.left_attachment
		end

	item_row_span (widget: EV_WIDGET): INTEGER
			-- `Result' is number of rows taken by `widget'.
		local
			widget_child: EV_TABLE_CHILD_IMP
			widget_imp: EV_WIDGET_IMP
		do
			-- Retrieve implementation of `widget'.	
			widget_imp ?= widget.implementation
			check
				implementation_not_void: widget_imp /= Void
			end
			widget_child := find_widget_child (widget_imp)
			Result := widget_child.bottom_attachment - widget_child.top_attachment
		end

feature {EV_ANY_I, EV_ANY} -- Status Settings

	resize (a_column, a_row: INTEGER)
		do
			Precursor {EV_TABLE_I} (a_column, a_row)
--			initialize_columns (a_column)
--			initialize_rows (a_row)
			notify_change (Nc_minsize, Current)
		end

	set_item_span (v: EV_WIDGET; column_span, row_span: INTEGER)
			-- Resize 'v' to occupy column span and row span
		do
		end

feature {NONE} -- Access features for implementation

	ev_children: ARRAYED_LIST [EV_TABLE_CHILD_IMP]
		-- List of the children of the tab.
		-- The children are in the order left -> right and top -> bottom of
		-- the table. An item that takes several cells are several times in
		-- the list. Be carefull to remove everything when needed.


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

feature {NONE} -- Implementation

	find_widget_child (a_child: EV_WIDGET_IMP): EV_TABLE_CHILD_IMP
		-- `Result' is the table child containing `a_child'.
		require
			valid_child: a_child /= Void
			current_child: a_child.parent_imp = Current
			valie_children: ev_children /= Void
		local
			list: ARRAYED_LIST [EV_TABLE_CHILD_IMP]
			cur: CURSOR
		do
			list := ev_children
			if not list.is_empty then
				from
					cur := list.cursor
					list.start
				until
					list.after or Result /= Void
				loop
					if list.item.widget = a_child then
						Result := list.item
					end
					list.forth
				end
				list.go_to (cur)
			else
				Result := Void
			end
		end

feature {EV_ANY_I} -- Implementation

	interface: detachable EV_TABLE note option: stable attribute end;

end -- class EV_TABLE_IMP

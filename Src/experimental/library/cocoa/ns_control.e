note
	description: "Wrapper for NSControl."
	author: "Daniel Furrer"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_CONTROL

inherit
	NS_VIEW
		redefine
			make
		end

create
	make

feature {NONE} -- Creation

	make
		do
			make_shared ({NS_CONTROL_API}.new)
		end

feature -- Access

	set_action (an_action: PROCEDURE [ANY, TUPLE])
			-- Sets the receiver's action method to call the given eiffel agent.
		do
			action := an_action
			{NS_CONTROL_API}.set_target (item, target_new ($current, $target))
			{NS_CONTROL_API}.set_action (item)
		end

	set_double_value (a_double: DOUBLE)
			-- Sets the value of the receiver's cell using a double-precision floating-point number.
    		-- The value of the cell interpreted as a double-precision floating-point number.
			-- If the cell is being edited, this method aborts all editing before setting the value.
			-- If the cell does not inherit from NSActionCell, the method marks the cell's interior as needing to be redisplayed;
			-- NSActionCell performs its own updating of cells.
		do
			{NS_CONTROL_API}.set_double_value (item, a_double)
		ensure
			value_set: a_double = double_value
		end

	double_value: DOUBLE
			-- Returns the value of the receiver's cell as a double-precision floating-point number.
			-- The value of the cell interpreted as a double-precision floating-point number.
			-- If the control contains many cells (for example, NSMatrix), then the value of the currently
			-- selected cell is returned. If the control is in the process of editing the affected cell, then
			-- it invokes the validateEditing method before extracting and returning the value.
		do
			Result := {NS_CONTROL_API}.double_value (item)
		end

	set_enabled (a_flag: BOOLEAN)
			-- Sets whether the receiver (and its cell) reacts to mouse events.
			-- True if you want the receiver to react to mouse events; otherwise, False.
			-- If flag is False, any editing is aborted. This method redraws the entire control if it is marked
			-- as needing redisplay. Subclasses may want to override this method to redraw only a portion of
			-- the control when the enabled state changes; NS_BUTTON and NS_SLIDER do this.
		do
			{NS_CONTROL_API}.set_enabled (item, a_flag)
		ensure
			enabled_set: a_flag = is_enabled
		end

	is_enabled: BOOLEAN
			-- Returns whether the receiver reacts to mouse events.
			-- True if the receiver responds to mouse events; otherwise False.
		do
			Result := {NS_CONTROL_API}.is_enabled (item)
		end

	set_string_value (a_string: STRING_GENERAL)
			-- Sets the value of the receiver's cell
			-- If the cell is being edited, this method aborts all editing before setting the value.
			-- If the cell does not inherit from NSActionCell, the method marks the cell's interior as needing to be redisplayed; NSActionCell performs its own updating of cells.
		do
			{NS_CONTROL_API}.set_string_value (item, (create {NS_STRING}.make_with_string (a_string)).item)
		end

	font: NS_FONT
			-- Returns the font used to draw text in the receiver's cell.
		do
			create Result.make_shared ({NS_CONTROL_API}.font (item))
		ensure
			result_not_void: Result /= void
		end

	set_cell (a_cell: NS_CELL)
			-- Sets the receiver's cell
			-- Use this method with great care as it can irrevocably damage the affected control;
			-- specifically, you should only use this method in initializers for subclasses of NS_CONTROL.
		require
			cell_not_void: a_cell /= void
		do
			{NS_CONTROL_API}.set_cell (item, a_cell.item)
		ensure
			cell_set: a_cell = cell
		end

	cell: NS_CELL
			-- Returns the receiver's cell object.
		do
			create Result.make_shared ({NS_CONTROL_API}.cell (item))
		ensure
			result_not_void: Result /= void
		end

feature {NONE} -- Callback Handling

	target
		do
			action.call([])
		end

	action: PROCEDURE [ANY, TUPLE]
end

indexing
	description:
		"Graphically representable objects."
	status: "See notice at end of class"
	keywords: "figure, graphic"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_FIGURE

inherit
	EV_FIGURE_MATH
		export
			{NONE} all
		redefine
			default_create
		end

	EV_ABSTRACT_PICK_AND_DROPABLE
		undefine
			default_create,
			is_equal,
			copy
		end

feature {NONE} -- Initialization

	default_create is
			-- Create without origins.
		local
			n: INTEGER
			p: EV_RELATIVE_POINT
		do
			assign_draw_id
			is_show_requested := True
			internal_is_sensitive := True
			create points.make_filled (point_count)
			from
				n := 1
			until
				n > point_count
			loop
				create p
				points.put_i_th (p, n)
				p.notify_list_ids.extend (object_id)
				n := n + 1
			end
			create internal_invalid_rectangle
		end

feature -- Access

	pebble: ANY
			-- Data to be transported by pick and drop mechanism.

	pebble_function: FUNCTION [ANY, TUPLE [], ANY]
			-- Returns data to be transported by pick and drop mechanism.
			-- When not `Void', `pebble' is ignored.

	group: EV_FIGURE_GROUP
			-- Parent of `Current'.

	world: EV_FIGURE_WORLD is
			-- Top-level parent of `Current'.
		do
			if group /= Void then
				Result ?= group
				if Result = Void then
					Result := group.world
				end
			end
		end

	pointer_style: EV_CURSOR is
			-- Cursor displayed when pointer is over this figure.
		do
			if internal_pointer_style /= Void then
				Result := internal_pointer_style
			elseif group /= Void then
				Result := group.pointer_style
			end
		end

	point_count: INTEGER is
			-- Number of points needed to describe `Current'.
		deferred
		end

	orientation: DOUBLE is
			-- Angle of first point of `Current'.
		do
			if not points.is_empty then
				Result := points.i_th (1).angle_abs
			end
		end

	point_array: ARRAY [EV_COORDINATE] is
			-- `points' as absolute coordinates.
		local
			n: INTEGER
		do
			from
				create Result.make (1, points.count)
				n := 1
			until
				n > points.count
			loop
				Result.force (points.i_th (n).absolute_coordinates, n)
				n := n + 1
			end
		ensure
			same_length: Result.count = points.count
		end

feature -- Action sequences

	pointer_motion_actions: EV_POINTER_MOTION_ACTION_SEQUENCE is
			-- Actions to be performed when screen pointer moves.
		do
			if internal_pointer_motion_actions = Void then
				create internal_pointer_motion_actions
			end
			Result := internal_pointer_motion_actions
		end

	pointer_button_press_actions: EV_POINTER_BUTTON_ACTION_SEQUENCE is
			-- Actions to be performed when screen pointer button is pressed.
		do
			if internal_pointer_button_press_actions = Void then
				create internal_pointer_button_press_actions
			end
			Result := internal_pointer_button_press_actions
		end

	pointer_double_press_actions: EV_POINTER_BUTTON_ACTION_SEQUENCE is
			-- Actions to be performed when screen pointer is double clicked.
		do
			if internal_pointer_double_press_actions = Void then
				create internal_pointer_double_press_actions
			end
			Result := internal_pointer_double_press_actions
		end

	pointer_button_release_actions: EV_POINTER_BUTTON_ACTION_SEQUENCE is
			-- Actions to be performed when screen pointer button is released.
		do
			if internal_pointer_button_release_actions = Void then
				create internal_pointer_button_release_actions
			end
			Result := internal_pointer_button_release_actions
		end

	pointer_enter_actions: EV_NOTIFY_ACTION_SEQUENCE is
			-- Actions to be performed when screen pointer enters widget.
		do
			if internal_pointer_enter_actions = Void then
				create internal_pointer_enter_actions
			end
			Result := internal_pointer_enter_actions
		end

	pointer_leave_actions: EV_NOTIFY_ACTION_SEQUENCE is
			-- Actions to be performed when screen pointer leaves widget.
		do
			if internal_pointer_leave_actions = Void then
				create internal_pointer_leave_actions
			end
			Result := internal_pointer_leave_actions
		end

	proximity_in_actions: EV_PROXIMITY_ACTION_SEQUENCE is
			-- Actions to be performed when pointing device comes into range.
		do
			if internal_proximity_in_actions = Void then
				create internal_proximity_in_actions
			end
			Result := internal_proximity_in_actions
		end

	proximity_out_actions: EV_PROXIMITY_ACTION_SEQUENCE is
			-- Actions to be performed when pointing device goes out of range.
		do
			if internal_proximity_out_actions = Void then
				create internal_proximity_out_actions
			end
			Result := internal_proximity_out_actions
		end

	pick_actions: EV_PND_START_ACTION_SEQUENCE is
			-- Actions to be performed when `pebble' is picked up.
		do
			if internal_pick_actions = Void then
				create internal_pick_actions
			end
			Result := internal_pick_actions
		end

	conforming_pick_actions: EV_NOTIFY_ACTION_SEQUENCE is
			-- Actions to be performed when a pebble that fits this hole is
			-- picked up from another source.
			-- (when drop_actions.accepts_pebble (pebble))
		do
			if internal_conforming_pick_actions = Void then
				create internal_conforming_pick_actions
			end
			Result := internal_conforming_pick_actions
		end

	drop_actions: EV_PND_ACTION_SEQUENCE is
			-- Actions to take when pick and drop transport drops on `Current'.
		do
			if internal_drop_actions = Void then
				create internal_drop_actions
				init_drop_actions (internal_drop_actions)
			end
			Result := internal_drop_actions
		end

feature -- Status report

	has_capture: BOOLEAN is
			-- Are all events sent to `Current'?
		do
			if world /= Void then
				Result := world.capture_figure = Current
			end
		end

	is_show_requested: BOOLEAN
			-- Will `Current' be displayed when its parent is?

	is_sensitive: BOOLEAN is
			-- Is object sensitive to user input?
		do
			if group = Void or else group.is_sensitive then
				Result := internal_is_sensitive
			end
		end

feature -- Element change

	set_pebble (a_pebble: like pebble) is
			-- Assign `a_pebble' to `pebble'.
		do
			pebble := a_pebble
		end

	remove_pebble is
			-- Make `pebble' `Void' and `pebble_function' `Void,
			-- Removing transport.
		do
			pebble := Void
			pebble_function := Void
		end

	set_pebble_function (a_function: FUNCTION [ANY, TUPLE [], ANY]) is
			-- Set `a_function' to compute `pebble'.
		do
			pebble_function := a_function
		end
	
	set_pointer_style (a_cursor: like pointer_style) is
			-- Assign `a_cursor' to `pointer_style'.
		require
			a_cursor_not_void: a_cursor /= Void
		do
			internal_pointer_style := a_cursor
		ensure
			pointer_style_assigned: pointer_style = a_cursor
		end

	set_accept_cursor (a_cursor: EV_CURSOR) is
			-- Set `a_cursor' to be displayed when the screen pointer is over a
			-- target that accepts `pebble' during pick and drop.
		do
			accept_cursor := a_cursor
		end

	set_deny_cursor (a_cursor: EV_CURSOR) is
			-- Set `a_cursor' to be displayed when the screen pointer is not
			-- over a valid target.
		do
			deny_cursor := a_cursor
		end

	set_origin (an_origin: EV_RELATIVE_POINT) is
			-- Change origin of all points to `o' without moving.
		do
			from
				points.start
			until
				points.after
			loop
				points.item.change_origin (an_origin)
				points.forth
			end
		end

feature -- Status setting

	enable_capture is
			-- Grab all mouse events for `world'.
		require
			in_world: world /= Void
		do
			world.set_capture_figure (Current)
		ensure
			capture_set: has_capture
		end

	disable_capture is
			-- Disable grab of all events on `world'.
		require
			in_world: world /= Void
		do
			world.remove_capture_figure
		ensure
			capture_released: not has_capture
		end

	show is
			-- Request that `Current' be displayed when its `group' is.
			-- `True' by default.
		do
			is_show_requested := True
			invalidate
		ensure
			is_show_requested: is_show_requested
		end

	hide is
			-- Request that `Current' not be displayed even when its `group' is.
		do
			is_show_requested := False
			invalidate
		ensure
			not_is_show_requested: not is_show_requested
		end

	enable_sensitive is
			-- Make object sensitive to user input.
		do
			internal_is_sensitive := True
		ensure
			sensitive_requested: internal_is_sensitive
		end

	disable_sensitive is
			-- Make object non-sensitive to user input.
		do
			internal_is_sensitive := False
		ensure
			insensitive_requested: not internal_is_sensitive
		end

	intersects (r: EV_RECTANGLE): BOOLEAN is
			-- Does `r' intersect `Current's `bounding_box'?
		do
			Result := bounding_box.intersects (r)
		end

feature {EV_FIGURE, EV_PROJECTOR, EV_RELATIVE_POINT} -- Implementation

	calculate_absolute_position is
			-- Recalculate absolute coordinates of any position
			-- this figure may have.
		local
			n: INTEGER
		do
			from
				n := 1
			until
				n > point_count
			loop
				points.i_th (n).calculate_absolute_position
				n := n + 1
			end
		end

	invalidate is
			-- Some property of `Current' has changed.
		do
			valid := False
		end

	validate is
			-- `Current' has been updated by a projector.
		do
			if not valid then
				valid := True
				internal_invalid_rectangle := bounding_box
			end
		end

	valid: BOOLEAN
			-- Is there no change to `Current'?

	invalid_rectangle: EV_RECTANGLE is
			-- Area that needs erasing.
		do
			if not valid then
				Result := internal_invalid_rectangle
			end
		end

	update_rectangle: EV_RECTANGLE is
			-- Area that needs redrawing.
		do
			if not valid then
				Result := bounding_box
			end
		end

	internal_invalid_rectangle: EV_RECTANGLE
			-- Area that needs updating.

feature -- Events

	position_on_figure (x, y: INTEGER): BOOLEAN is
			-- Is the point on (`x', `y') on this figure?
			--| Used to generate events.
		deferred
		end

	bounding_box: EV_RECTANGLE is
			-- Smallest orthogonal rectangular area `Current' fits in.
		do
			if points.is_empty then
				create Result
			else
				create Result.make (
					points.first.x_abs, points.first.y_abs, 1, 1
				)
				from
					points.start
					points.forth
				until
					points.after
				loop
					Result.include (points.item.x_abs, points.item.y_abs)
					points.forth
				end
			end
		ensure
			not_void: Result /= Void
		end

feature {NONE} -- Contract support

	all_points_exist (list: like points): BOOLEAN is
			-- Are all items in `list' non-`Void'?
		require
			list_exists: list /= Void
		local
			cur: CURSOR
		do
			cur := list.cursor
			Result := True
			from list.start until not Result or else list.after loop
				Result := list.item /= Void
				list.forth
			end
			list.go_to (cur)
		end

feature {EV_FIGURE, EV_RELATIVE_POINT, EV_FIGURE_DRAWING_ROUTINES} -- Implementation

	points: ARRAYED_LIST [EV_RELATIVE_POINT]
			-- Points needed to describe `Current'.
			-- Index: [1..point_count].

feature {EV_FIGURE_GROUP} -- Implementation

	set_group (new_group: EV_FIGURE_GROUP) is
			-- Set the figure-group of this figure to `new_group'.
		require
			new_group_exists: new_group /= Void
		do
			if group /= Void and then group /= new_group then
				group.prune_all (Current)
			end
			group := new_group
			from
				points.start
			until
				points.after
			loop
				if points.item.origin = Void then
					points.item.set_origin (new_group.point)
				end
				points.forth
			end
		ensure
			group_assigned: group = new_group
		end

	unreference_group is
			-- Set group to Void after removal from it.
		require
			group_exists: group /= Void
		do
			group := Void
		ensure
			not_group_exists: group = Void
		end

feature {EV_FIGURE, EV_PROJECTOR, EV_PROJECTION_ROUTINES} -- Access

	draw_id: INTEGER
			-- Used to look up drawing routine.

	real_pebble: ANY is
			-- Calculated `pebble'.
		do
			if pebble_function /= Void then
				Result := pebble_function.item ([])
			else
				Result := pebble
			end
		end

feature {NONE} -- Implementation

	internal_pointer_style: EV_CURSOR
			-- `pointer_style'.

	internal_is_sensitive: BOOLEAN
			-- `is_sensitive'.

	Default_colors: EV_STOCK_COLORS is
			-- Eiffel Vision colors.
		once
			create Result
		end

	Default_pixmaps: EV_STOCK_PIXMAPS is
			-- Eiffel Vision bitmaps.
		once
			create Result
		end

	Id_counter: INTEGER_REF is
			-- Last assigned `draw_id'.
		once
			create Result
			Result.set_item (1)
		end

	Known_ids: HASH_TABLE [INTEGER, STRING] is
			-- Table of assigned `draw_id's, hashed by the
			-- generated types of EV_FIGURE descendants.
		once
			create Result.make (20)
		end

	assign_draw_id is
		do
			known_ids.search (generator)
			draw_id := known_ids.found_item
			if draw_id = 0 then
				draw_id := id_counter.item
				id_counter.set_item (draw_id + 1)
				known_ids.put (draw_id, generator)
			end
		end

feature {EV_WIDGET_PROJECTOR} -- Implementation

	accept_cursor: EV_CURSOR
			-- Accept cursor set by user.
			-- To be displayed when the screen pointer is over a target that accepts
			-- `pebble' during pick and drop.

	deny_cursor: EV_CURSOR
		-- Deny cursor set by user.
		-- To be displayed when the screen pointer is not over a valid target.

	Default_accept_cursor: EV_CURSOR is
			-- Used in lieu of a user defined `accept_cursor'.
		once
			Result := Default_pixmaps.Standard_cursor
		end

	Default_deny_cursor: EV_CURSOR is
			-- Used in lieu of a user defined `deny_cursor'.
		once
			Result := Default_pixmaps.No_cursor
		end

feature {EV_WIDGET_PROJECTOR, EV_FIGURE} -- Implementation

	internal_pointer_motion_actions: EV_POINTER_MOTION_ACTION_SEQUENCE
			-- Implementation of once per object `pointer_motion_actions'.

	internal_pointer_button_press_actions: EV_POINTER_BUTTON_ACTION_SEQUENCE
			-- Implementation of once per object `pointer_button_press_actions'.

	internal_pointer_double_press_actions: EV_POINTER_BUTTON_ACTION_SEQUENCE
			-- Implementation of once per object `pointer_double_press_actions'.

	internal_pointer_button_release_actions: EV_POINTER_BUTTON_ACTION_SEQUENCE
			-- Implementation of once per object
			-- `pointer_button_release_actions'.

	internal_pointer_enter_actions: EV_NOTIFY_ACTION_SEQUENCE
			-- Implementation of once per object `pointer_enter_actions'.

	internal_pointer_leave_actions: EV_NOTIFY_ACTION_SEQUENCE
			-- Implementation of once per object `pointer_leave_actions'.

	internal_proximity_in_actions: EV_PROXIMITY_ACTION_SEQUENCE
			-- Implementation of once per object `proximity_in_actions'.

	internal_proximity_out_actions: EV_PROXIMITY_ACTION_SEQUENCE
			-- Implementation of once per object `proximity_out_actions'.

	internal_pick_actions: EV_PND_START_ACTION_SEQUENCE
			-- Implementation of once per object `pick_actions'.

	internal_conforming_pick_actions: EV_NOTIFY_ACTION_SEQUENCE
			-- Implementation of once per object `conforming_pick_actions'.

	internal_drop_actions: EV_PND_ACTION_SEQUENCE
			-- Implementation of once per object `drop_actions'.

invariant
	points_not_void: points /= Void
	points_correct_size: points.count = point_count
	points_items_not_void: all_points_exist (points)

end -- class EV_FIGURE

--!-----------------------------------------------------------------------------
--! EiffelVision2: library of reusable components for ISE Eiffel.
--! Copyright (C) 1986-2000 Interactive Software Engineering Inc.
--! All rights reserved. Duplication and distribution prohibited.
--! May be used only with ISE Eiffel, under terms of user license. 
--! Contact ISE for any other use.
--!
--! Interactive Software Engineering Inc.
--! ISE Building, 2nd floor
--! 270 Storke Road, Goleta, CA 93117 USA
--! Telephone 805-685-1006, Fax 805-685-6869
--! Electronic mail <info@eiffel.com>
--! Customer support e-mail <support@eiffel.com>
--! For latest info see award-winning pages: http://www.eiffel.com
--!-----------------------------------------------------------------------------

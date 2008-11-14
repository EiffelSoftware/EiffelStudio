indexing
	description: "[
						Every figure has a center. The position of the
						center are the values x and y. It is the position
						on the screen. The center of the figure can be moved arround
						and the figure can be rotated around its center and
						scaled in x and y direction. 2*pi is a full rotation. The
						direction of a rotation is clockwise.
					]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_MODEL

inherit
	EV_MODEL_DOUBLE_MATH
		export
			{NONE} all
			{ANY} generating_type
		redefine
			default_create
		end

	HASHABLE
		rename
			hash_code as id
		undefine
			default_create
		end

	EV_ABSTRACT_PICK_AND_DROPABLE
		undefine
			default_create,
			is_equal,
			copy
		end

feature {NONE} -- initialization

	default_create is
			-- Initialize a figure.
		do
			assign_draw_id
			is_show_requested := True
			internal_is_sensitive := True
			create internal_invalid_rectangle
			set_deny_cursor (default_deny_cursor)
			set_accept_cursor (default_accept_cursor)
			create center
			is_center_valid := False
			are_events_sent_to_group := True
		end

feature -- Access

	x: INTEGER is
			-- `X' position of the center on the screen.
		do
			if not is_center_valid then
				set_center
			end
			Result := center.x
		end

	y: INTEGER is
			-- `Y' position of the center on the screen .
		do
			if not is_center_valid then
				set_center
			end
			Result := center.y
		end

	angle: DOUBLE is
			-- `Current' has to be rotated around (`x',`y') for -`angle'
			-- to be in upright position. Upright position has to
			-- be defined for every figure. If a figure is in upright position
			-- and you scale it to `x' direction, the figure should be
			-- scaled in the direction of the `x' direction of the screen.
		deferred
		end

	point_count: INTEGER is
			-- Number of points needed to describe `Current'.
			-- Without center.
		do
			Result := point_array.count
		ensure
			correct: Result = point_array.count
		end

	id: INTEGER is
			-- Unique id.
		do
			if internal_hash_id = 0  then
				counter.put (counter.item + 1)
				internal_hash_id := counter.item
			end
			Result := internal_hash_id
		end

	pebble: ANY
			-- Data to be transported by pick and drop mechanism.

	pebble_function: FUNCTION [ANY, TUPLE, ANY]
			-- Returns data to be transported by pick and drop mechanism.
			-- When not `Void', `pebble' is ignored.

	pointer_style: EV_POINTER_STYLE is
			-- Cursor displayed when pointer is over this figure.
		do
			if internal_pointer_style /= Void then
				Result := internal_pointer_style
			elseif group /= Void then
				Result := group.pointer_style
			end
		end

	group: EV_MODEL_GROUP
			-- The group `Current' is part of. Void if `Current' is
			-- not part of a group.

	world: EV_MODEL_WORLD is
			-- The world `Current' is part of. Void if `Current' is
			-- not part of a world
		do
			if group /= Void then
				Result ?= group
				if Result = Void then
					Result := group.world
				end
			end
		end

feature -- Element change

	set_x (a_x: INTEGER) is
			-- Set `x' to `an_x'.
		local
			a_delta_x: INTEGER
			l_point_array: SPECIAL [EV_COORDINATE]
			l_coordinate: EV_COORDINATE
			i, nb: INTEGER
		do
			a_delta_x := a_x - x
			if a_delta_x /= 0 then
				l_point_array := point_array
				from
					i := 0
					nb := l_point_array.count - 1
				until
					i > nb
				loop
					l_coordinate := l_point_array.item (i)
					l_coordinate.set_x_precise (l_coordinate.x_precise + a_delta_x)
					i := i + 1
				end
				if is_in_group and then group.is_center_valid then
					group.center_invalidate
				end
				invalidate
				center.set_x (a_x)
			end
		ensure
			x_set: a_x = x
			center_valid: is_center_valid
		end

	set_y (a_y: INTEGER) is
			-- Set `y' to `an_y'.
		local
			a_delta_y: INTEGER
			l_point_array: SPECIAL [EV_COORDINATE]
			l_coordinate: EV_COORDINATE
			i, nb: INTEGER
		do
			a_delta_y := a_y - y
			if a_delta_y /= 0 then
				l_point_array := point_array
				from
					i := 0
					nb := point_array.count - 1
				until
					i > nb
				loop
					l_coordinate := l_point_array.item (i)
					l_coordinate.set_y_precise (l_coordinate.y_precise + a_delta_y)
					i := i + 1
				end
				if is_in_group and then group.is_center_valid then
					group.center_invalidate
				end
				invalidate
				center.set_y (a_y)
			end
		ensure
			y_set: a_y = y
			center_valid: is_center_valid
		end

	set_x_y (a_x, a_y: INTEGER) is
			-- Set `x' to `a_x' and `y' to `a_y'.
		local
			a_delta_y, a_delta_x: INTEGER
			l_point_array: SPECIAL [EV_COORDINATE]
			l_coordinate: EV_COORDINATE
			i, nb: INTEGER
		do
			a_delta_y := a_y - y
			a_delta_x := a_x - x
			if a_delta_y /= 0 or a_delta_x /= 0 then
				l_point_array := point_array
				from
					i := 0
					nb := l_point_array.count - 1
				until
					i > nb
				loop
					l_coordinate := l_point_array.item (i)
					l_coordinate.set_precise (l_coordinate.x_precise + a_delta_x, l_coordinate.y_precise + a_delta_y)
					i := i + 1
				end
				if is_in_group and then group.is_center_valid then
					group.center_invalidate
				end
				center.set (a_x, a_y)
				invalidate
			end
		ensure
			set: a_x = x and a_y = y
			center_valid: is_center_valid
		end

	rotate (an_angle: DOUBLE) is
			-- Rotate around the center for `an_angle'.
		require
			is_rotatable: is_rotatable
		do
			if not is_center_valid then
				set_center
			end
			projection_matrix.rotate (an_angle, center.x_precise, center.y_precise)
			recursive_transform (projection_matrix)
			is_center_valid := True
		ensure
			center_valid: is_center_valid
		end

	rotate_around (an_angle: DOUBLE; ax, ay: INTEGER) is
			-- Rotate around (`ax', `ay') for `an_angle'.
		require
			is_rotatable: is_rotatable
		do
			if not is_center_valid then
				set_center
			end
			projection_matrix.rotate (an_angle, ax, ay)
			recursive_transform (projection_matrix)
			is_center_valid := True
		ensure
			center_valid: is_center_valid
		end

	scale_x (a_scale_x: DOUBLE) is
			-- Scale to x direction for `a_scale_x'.
		require
			is_scalable: is_scalable
			a_scale_x_bigger_zero: a_scale_x > 0.0
		do
			if not is_center_valid then
				set_center
			end
			projection_matrix.scale (a_scale_x, 1, center.x_precise, center.y_precise, angle)
			recursive_transform (projection_matrix)
			if is_in_group and then group.is_center_valid then
				group.center_invalidate
			end
		end

	scale_y (a_scale_y: DOUBLE) is
			-- Scale to y direction for `a_scale_y'.
		require
			is_scalable: is_scalable
			a_scale_y_bigger_zero: a_scale_y > 0.0
		do
			if not is_center_valid then
				set_center
			end
			projection_matrix.scale (1, a_scale_y, center.x_precise, center.y_precise, angle)
			recursive_transform (projection_matrix)
			if is_in_group and then group.is_center_valid then
				group.center_invalidate
			end
		end

	scale (a_scale: DOUBLE) is
			-- Scale to x and y direction for `a_scale'.
		require
			is_scalable: is_scalable
			a_scale_bigger_zero: a_scale > 0.0
		do
			if not is_center_valid then
				set_center
			end

			projection_matrix.scale (a_scale, a_scale, center.x_precise, center.y_precise, angle)
			recursive_transform (projection_matrix)
			if is_in_group and then group.is_center_valid then
				group.center_invalidate
			end
		end

	scale_x_abs (a_scale_x: DOUBLE) is
			-- Scale absolute to x direction for `a_scale_x'.
			-- Do not rotate around `angle' first.
		require
			is_scalable: is_scalable
			a_scale_x_bigger_zero: a_scale_x > 0.0
		do
			if not is_center_valid then
				set_center
			end
			projection_matrix.scale_abs (a_scale_x, 1, center.x_precise, center.y_precise)
			recursive_transform (projection_matrix)
			if is_in_group and then group.is_center_valid then
				group.center_invalidate
			end
		end

	scale_y_abs (a_scale_y: DOUBLE) is
			-- Scale to y direction for `a_scale_y'.
			-- Do not rotate around `angle' first.
		require
			is_scalable: is_scalable
			a_scale_y_bigger_zero: a_scale_y > 0.0
		do
			if not is_center_valid then
				set_center
			end
			projection_matrix.scale_abs (1, a_scale_y, center.x_precise, center.y_precise)
			recursive_transform (projection_matrix)
			if is_in_group and then group.is_center_valid then
				group.center_invalidate
			end
		end

	scale_abs (a_scale: DOUBLE) is
			-- Scale to x and y direction for `a_scale'.
			-- Do not rotate around `angle' first.
		require
			is_scalable: is_scalable
			a_scale_bigger_zero: a_scale > 0.0
		do
			if not is_center_valid then
				set_center
			end

			projection_matrix.scale_abs (a_scale, a_scale, center.x_precise, center.y_precise)
			recursive_transform (projection_matrix)
			if is_in_group and then group.is_center_valid then
				group.center_invalidate
			end
		end

	transform (a_transformation: EV_MODEL_TRANSFORMATION) is
			-- Transform all points in `point_array' using `a_transformation'.
			-- You can do any transformation you want. You can
			-- for example rotate `Current' around an other point
			-- than the center.
		require
			a_transformation_not_void: a_transformation /= Void
			is_transformable: is_transformable
		do
			recursive_transform (a_transformation)
			if is_in_group and then group.is_center_valid then
				group.center_invalidate
			end
		end

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

	set_pebble_function (a_function: FUNCTION [ANY, TUPLE, ANY]) is
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

	set_accept_cursor (a_cursor: EV_POINTER_STYLE) is
			-- Set `a_cursor' to be displayed when the screen pointer is over a
			-- target that accepts `pebble' during pick and drop.
		do
			accept_cursor := a_cursor
		end

	set_deny_cursor (a_cursor: EV_POINTER_STYLE) is
			-- Set `a_cursor' to be displayed when the screen pointer is not
			-- over a valid target.
		do
			deny_cursor := a_cursor
		end

feature -- Status Report

	is_rotatable: BOOLEAN is
			-- Is this figure rotatable?
		deferred
		end

	is_scalable: BOOLEAN is
			-- Is this figure scalable?
		deferred
		end

	is_transformable: BOOLEAN is
			-- Is this figure transformable no matter what kind of transformation?
		deferred
		end

	is_in_group: BOOLEAN is
			-- Is `Current' part of a group?
		do
			Result := group /= Void
		ensure
			group_defines_is_in_group: Result = (group /= Void)
		end

	is_in_world: BOOLEAN is
			-- Is `Current' part of a world?
		do
			Result := world /= Void
		ensure
			world_defines_is_in_world: Result = (world /= Void)
		end

	accept_cursor: EV_POINTER_STYLE
			-- Accept cursor set by user.
			-- To be displayed when the screen pointer is over a target that accepts
			-- `pebble' during pick and drop.

	deny_cursor: EV_POINTER_STYLE
		-- Deny cursor set by user.
		-- To be displayed when the screen pointer is not over a valid target.

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

	is_center_valid: BOOLEAN
			-- Is the position of the center valid?

	are_events_sent_to_group: BOOLEAN
			-- Are events for `pointer_motion_actions', `pointer_button_press_actions',
			-- `pointer_double_press_actions',  `pointer_button_release_actions'
			-- `pointer_enter_actions' and `pointer_leave_actions' send to `Current's
			-- group (if any) even if `Current' catch the event. (Default True).

feature -- Status settings

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
			has_capture: has_capture
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

	disable_events_sended_to_group is
			-- Set `are_events_sent_to_group' to False.
		do
			are_events_sent_to_group := False
		ensure
			events_blocked: not are_events_sent_to_group
		end

	enable_events_sended_to_group is
			-- Set `are_events_sent_to_group' to True.
		do
			are_events_sent_to_group := True
		ensure
			events_sended_to_group: are_events_sent_to_group
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

	pick_actions: EV_PND_START_ACTION_SEQUENCE is
			-- Actions to be performed when `pebble' is picked up.
		do
			if internal_pick_actions = Void then
				create internal_pick_actions
			end
			Result := internal_pick_actions
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

feature -- Events

	position_on_figure (a_x, a_y: INTEGER): BOOLEAN is
			-- Is the point on (`a_x', `a_y') on this figure?
			--| Used to generate events.
		deferred
		end

	bounding_box: EV_RECTANGLE is
			-- Smallest orthogonal rectangular area `Current' fits in.
			-- Every call returns a new instance.
		local
			l_point_array: SPECIAL [EV_COORDINATE]
			i, nb: INTEGER
			min_x, min_y, max_x, max_y, val: DOUBLE
			ax, ay, w, h: INTEGER
			l_item: EV_COORDINATE
		do
			if internal_bounding_box /= Void then
				Result := internal_bounding_box.twin
			else
				if point_count = 0 then
					create Result
				else
					l_point_array := point_array
					l_item := l_point_array.item (0)
					min_x := l_item.x_precise
					max_x := min_x
					min_y := l_item.y_precise
					max_y := min_y
					from
						i := 1
						nb := l_point_array.count - 1
					until
						i > nb
					loop
						l_item := l_point_array.item (i)
						val := l_item.x_precise
						max_x := max_x.max (val)
						min_x := min_x.min (val)
						val := l_item.y_precise
						max_y := max_y.max (val)
						min_y := min_y.min (val)
						i := i + 1
					end

					ax := as_integer (min_x)
					ay := as_integer (min_y)
					w := as_integer (max_x) - ax + 1
					h := as_integer (max_y) - ay + 1
					create Result.make (ax, ay, w, h)
				end
				internal_bounding_box := Result.twin
			end
		ensure
			Result_not_void: Result /= Void
			internal_is_twin: internal_bounding_box /= Result
		end

feature --{EV_FIGURE} -- Status settings

	center_invalidate is
			-- The position of the center may have changed.
		do
			if is_center_valid then
				is_center_valid := False
				if is_in_group and then group.is_center_valid then
					group.center_invalidate
				end
			end
		end

feature {EV_MODEL, EV_MODEL_DRAWER} -- Access

	point_array: SPECIAL [EV_COORDINATE]
			-- All points of the Figure.

	invalidate is
			-- Some property of `Current' has changed.
		do
			valid := False
			internal_bounding_box := Void
			if is_in_group then
				group.invalidate
			end
		end

	validate is
			-- `Current' has been updated by a projector.
		do
			if not valid then
				valid := True
				internal_invalid_rectangle := bounding_box
			end
		end

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
				last_update_rectangle := Result
			end
		end

	internal_invalid_rectangle: EV_RECTANGLE
			-- Area that needs updating.


	real_pebble (a_x, a_y: INTEGER): ANY is
			-- Calculated `pebble'.
		do
			if pebble_function /= Void then
				Result := pebble_function.item ([a_x, a_y])
			else
				Result := pebble
			end
		end

feature {EV_MODEL, EV_MODEL_PROJECTOR, EV_MODEL_PROJECTION_ROUTINES} -- Access

	draw_id: INTEGER
			-- Used to look up drawing routine.

	last_update_rectangle: EV_RECTANGLE
			-- Last calculated bounding box when validate was called.


feature {EV_MODEL, EV_MODEL_PROJECTION_ROUTINES}

	valid: BOOLEAN
			-- Is there no change to `Current'?

feature {EV_MODEL_GROUP} -- Figure group

	set_group (a_group: EV_MODEL_GROUP) is
			-- Set `group' to `a_group'
		do
			if group /= Void and group /= a_group then
				group.prune_all (Current)
			end
			group := a_group
		ensure
			group_set: group = a_group
			is_in_group_proper_defined: is_in_group = (a_group /= Void)
		end

	unreference_group is
			-- Set group to Void after removal from it.
			-- Remove `Current' from `group'.
		require
			group_exists: group /= Void
		do
			group := Void
		ensure
			not_in_group: not is_in_group
		end

	recursive_transform (a_transformation: EV_MODEL_TRANSFORMATION) is
			-- Same as transform but without precondition
			-- is_transformable and without invalidating
			-- groups center
		require
			a_transformation_exists: a_transformation /= Void
		local
			l_point_array: like point_array
			i, nb: INTEGER
		do
			from
				l_point_array := point_array
				i := 0
				nb := l_point_array.count - 1
			until
				i > nb
			loop
				a_transformation.project (l_point_array.item (i))
				i := i + 1
			end
			invalidate
			is_center_valid := False
		end

feature {EV_MODEL_WIDGET_PROJECTOR} -- Implementation

	default_accept_cursor: EV_POINTER_STYLE is
			-- Used in lieu of a user defined `accept_cursor'.
		once
			Result := Default_pixmaps.Standard_cursor
		end

	default_deny_cursor: EV_POINTER_STYLE is
			-- Used in lieu of a user defined `deny_cursor'.
		once
			Result := Default_pixmaps.No_cursor
		end

feature {NONE} -- Contract support

	all_points_exist (list: like point_array): BOOLEAN is
			-- Are all items in `list' non-`Void'?
		require
			list_exists: list /= Void
		local
			i: INTEGER
		do
			Result := True
			from
				i := point_array.lower
			until
				i > point_array.upper or not Result
			loop
				Result := point_array.item (i) /= Void
				i := i + 1
			end
		end

feature {EV_MODEL_WIDGET_PROJECTOR} -- Internal action Sequence

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

	internal_pick_actions: EV_PND_START_ACTION_SEQUENCE
			-- Implementation of once per object `pick_actions'.

	internal_conforming_pick_actions: EV_NOTIFY_ACTION_SEQUENCE
			-- Implementation of once per object `conforming_pick_actions'.

	internal_drop_actions: EV_PND_ACTION_SEQUENCE
			-- Implementation of once per object `drop_actions'.

feature {NONE} -- Implementation

	internal_hash_id: INTEGER
			-- Unique id if not 0

	counter: CELL [INTEGER] is
			-- Id counter.
		once
			create Result.put (0)
		ensure
			counter_not_void: Result /= Void
		end

	projection_matrix: EV_MODEL_TRANSFORMATION is
			-- The transformation used to rotate and scale.
		do
			if internal_projection_matrix = Void then
				create internal_projection_matrix.make_id
			end
			Result := internal_projection_matrix
		end

	internal_projection_matrix: like projection_matrix
			-- Internal projection matrix.

	internal_pointer_style: EV_POINTER_STYLE
			-- `pointer_style'.

	internal_is_sensitive: BOOLEAN
			-- `is_sensitive'.

	default_colors: EV_STOCK_COLORS is
			-- Eiffel Vision colors.
		once
			create Result
		end

	draw_id_counter: CELL [INTEGER] is
			-- Last assigned `draw_id'.
		once
			create Result.put (1)
		ensure
			draw_id_count_not_void: Result /= Void
		end

	known_draw_ids: HASH_TABLE [INTEGER, STRING] is
			-- Table of assigned `draw_id's, hashed by the
			-- generated types of EV_FIGURE descendants.
		once
			create Result.make (20)
		end

	assign_draw_id is
		do
			known_draw_ids.search (generator)
			draw_id := known_draw_ids.found_item
			if draw_id = 0 then
				draw_id := draw_id_counter.item
				draw_id_counter.put (draw_id + 1)
				known_draw_ids.put (draw_id, generator)
			end
		end

	center: EV_COORDINATE
			-- Position of the center.

	set_center is
			-- Set the position of the center
		deferred
		ensure
			center_valid: is_center_valid
		end

	internal_bounding_box: EV_RECTANGLE
			-- Used to speed up bounding box calculation.

invariant

	point_array_exists: point_array /= Void
	center_exists: center /= Void
	x_is_center_x: x = center.x
	y_is_center_y: y = center.y
	all_points_exist: all_points_exist (point_array)
	projection_matrix_not_void: projection_matrix /= Void
	is_transfomable_implies_rotatable_and_scalable: is_transformable implies (is_rotatable and is_scalable)

indexing
	copyright:	"Copyright (c) 1984-2008, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end -- class EV_MODEL

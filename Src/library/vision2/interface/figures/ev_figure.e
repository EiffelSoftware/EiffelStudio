indexing
	description: "Ancestor of all figures. Each decendant has to specify%
		%the number of points that are needed to represent it.%
		%If this figure is in a group, all points have to be relative%
		%to the group('s point)."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_FIGURE

inherit
	EV_FIGURE_MATH
		rename
			out as default_out
		redefine
			default_create
		end

feature {NONE} -- Initialization

	default_create is
			-- Create with all points Void origin.
		local
			n: INTEGER
		do
			create pointer_motion_actions
			create pointer_button_press_actions
			create pointer_button_release_actions
			create pointer_enter_actions
			create pointer_leave_actions
			create proximity_in_actions
			create proximity_out_actions

			create points.make_filled (point_count)
			from
				n := 1
			until
				n > point_count
			loop
				points.put_i_th (create {EV_RELATIVE_POINT}, n)
				n := n + 1
			end
		end

	make_with_point_list (list: like points) is
			-- Create with `list''s items.
		require
			list_correct_size: list_has_correct_size (list)
			all_points_exist_in_list: all_points_exist (list)
		do
			default_create
			set_points (list)
		end

	make_in_group (grp: EV_FIGURE_GROUP) is
			-- Create in `grp'.
			-- Create all points relative to the group's point.
		require
			grp_exists: grp /= Void
		local
			n: INTEGER
		do
			default_create
			from
				n := 1
			until
				n > point_count
			loop
				set_point_by_index (n, grp.get_relative_point (0, 0))
				n := n + 1
			end
			grp.extend (Current)
		end

feature -- Access

	group: EV_FIGURE_GROUP
			-- The group this figure belongs to. Can be Void.

feature -- Status report

	point_count: INTEGER is
			-- Number of points needed to describe this figure.
			-- Preferably a constant, but we also have polyline.
		deferred
		end

feature {EV_FIGURE, EV_RELATIVE_POINT} -- Implementation

	points: ARRAYED_LIST [EV_RELATIVE_POINT]
			-- Array of points needed to describe this figure.
			-- Index: [1..point_count].

feature -- Status report

	get_point_by_index (index: INTEGER): EV_RELATIVE_POINT is
			-- Returns the point with `index'.
		require
			index_within_bounds: index > 0 and then index <= point_count
		do
			Result := points.i_th (index)
		ensure
			Result_assigned: Result /= Void
		end

	point_array: ARRAY [EV_COORDINATES] is
			-- Return point-array in the form of an array with absolute coordinates.
		local
			n: INTEGER
		do
			from
				create Result.make (1, points.count)
				n := 1
			until
				n > points.count
			loop
				Result.force (
					create {EV_COORDINATES}.set (points.i_th (n).x_abs, points.i_th (n).y_abs),
					n)
				n := n + 1
			end
		ensure
			Result_same_length: Result.count = points.count
		end

feature -- Status setting

	set_point_by_index (index: INTEGER; point: EV_RELATIVE_POINT) is
			-- Sets point on `index' to `point'.
		require
			index_within_bounds: index > 0 and then index <= point_count
			point_exists: point /= Void
			point_relative_to_group_point:
				group /= Void implies point.valid_group_point (group.point)
			point_not_in_other_figure: point.figure = Void
		do
			get_point_by_index (index).set_figure (Void)
			points.put_i_th (point, index)
			point.set_figure (Current)
		ensure
			point_inserted_on_index: point = get_point_by_index (index)
		end

	set_points (list: like points) is
			-- Set all points to the items in `list'.
		require
			list_correct_size: list_has_correct_size (list)
			all_points_exist_in_list: all_points_exist (list)
			points_relative_to_group_point:
				group /= Void implies list_relative_to_point (list, group.point)
		local
			n: INTEGER
		do
			from
				n := 1
			until
				n > point_count
			loop
				set_point_by_index (n, list.i_th (n))
				n := n + 1
			end
		ensure
			points_assigned: points.count = list.count
		end

feature -- Convenience

	get_relative_point (new_x, new_y: INTEGER): EV_RELATIVE_POINT is
			-- get a point relative to point 1 of this figure.
		do
			Result := get_point_by_index (1).get_relative_point (new_x, new_y)
		end

feature -- Recomputation

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
				get_point_by_index (n).calculate_absolute_position
				n := n + 1
			end
		end

	invalidate_absolute_position is
			-- Invalidates the absolute positions of figures.
			-- This is the way to let positioners be called again and
			-- changes to coordinates to be "committed".
		local
			n: INTEGER
		do
			from
				n := 1
			until
				n > point_count
			loop
				get_point_by_index (n).invalidate_absolute_position
				n := n + 1
			end
		end

feature -- Action sequences

	pointer_motion_actions: EV_POINTER_MOTION_ACTION_SEQUENCE
			-- The handlers to be called when the pointer moved over this figure.

	pointer_button_press_actions: EV_POINTER_BUTTON_ACTION_SEQUENCE
			-- The handlers to be called when the pointer-button was clicked on this figure.

	pointer_button_release_actions: EV_POINTER_BUTTON_ACTION_SEQUENCE
			-- The handlers to be called when the pointer-button was clicked on this figure.

	pointer_enter_actions: EV_NOTIFY_ACTION_SEQUENCE
			-- The handlers to be called when the pointer entered this figure.

	pointer_leave_actions: EV_NOTIFY_ACTION_SEQUENCE
			-- The handlers to be called when the pointer left this figure.

	proximity_in_actions: EV_PROXIMITY_ACTION_SEQUENCE
			-- The handlers to be called when the pointer is put down on this figure.

	proximity_out_actions: EV_PROXIMITY_ACTION_SEQUENCE
			-- The handlers to be called when the pointer is lifted up from this figure.

feature {EV_PROJECTION} -- Events

	position_on_figure (x, y: INTEGER): BOOLEAN is
			-- Is the point on (`x', `y') on this figure?
			--| Used to generate events.
		deferred
		end

feature -- Standard output

	out: STRING is
			-- Return a string with a representation of this figure.
		local
			n: INTEGER
		do
			from
				Result := "Figure: "
				n := 1
			until
				n > point_count
			loop
				Result.append (get_point_by_index (n).out + "; ")
				n := n + 1
			end
		end

feature {EV_FIGURE_GROUP} -- Implementation

	set_group (new_group: EV_FIGURE_GROUP) is
			-- Set the figure-group of this figure to `new_group'.
		require
			new_group_exists: new_group /= Void
			points_relative_to_group_point:
				relative_to (new_group.point)
			points_in_group:
				all_points_in_group (new_group)
		do
			group := new_group
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

feature -- Status report

	orientation: EV_ANGLE is
			-- Get the orientation of this figure.
			-- We always take the orientation of the first point for it.
		do
			create Result.make_radians (- get_point_by_index (1).angle_abs)
		end

feature -- Contract support

	list_has_correct_size (list: like points): BOOLEAN is
			-- Does `list' have the correct number of items?
			--| In polyline and polygon, etc. this will hold as well, but
			--| We redefine it there to return true, because any list has the
			--| correct amount of points.
		require
			list_exists: list /= Void
		do
			Result := list.count = point_count
		end

	relative_to (pos: EV_RELATIVE_POINT): BOOLEAN is
			-- Do all points of this figure move relative to `pos'?
		do
			Result := list_relative_to_point (points, pos)
		end

	list_relative_to_point (list: like points; pnt: EV_RELATIVE_POINT): BOOLEAN is
			-- Are all items in `list' relative to `pnt'?
		require
			list_exists: list /= Void
		local
			n: INTEGER
		do
			from
				Result := True
				n := 1
			until
				not Result or else n > list.count
			loop
				if not list.i_th (n).valid_group_point (pnt) then
					Result := False
				end
				n := n + 1
			end
		end

	all_points_exist (list: like points): BOOLEAN is
			-- Are all the points in `list' initialized?
		require
			list_exists: list /= Void
		local
			n: INTEGER
		do
			from
				Result := True
				n := 1
			until
				not Result or else n > point_count
			loop
				if list.i_th (n) = Void then
					Result := False
				end
				n := n + 1
			end
		end

	all_points_in_group (grp: EV_FIGURE_GROUP): BOOLEAN is
			-- Are all `points' `in_group' `grp'.
		require
			grp_exists: grp /= Void
		local
			n: INTEGER
		do
			from
				Result := True
				n := 1
			until
				not Result or else n > point_count
			loop
				if not points.i_th (n).in_group (grp) then
					Result := False
				end
				n := n + 1
			end
		end

invariant
	pointer_motion_actions_exists: pointer_motion_actions /= Void
	pointer_button_press_actions_exists: pointer_button_press_actions /= Void
	pointer_button_release_actions_exists: pointer_button_release_actions /= Void
	pointer_enter_actions_exists: pointer_enter_actions /= Void
	pointer_leave_actions_exists: pointer_leave_actions /= Void
	proximity_in_actions_exists: proximity_in_actions /= Void
	proximity_out_actions_exists: proximity_out_actions /= Void

	points_exists: points /= Void
	points_correct_size: list_has_correct_size (points)
	all_points_exist: all_points_exist (points)
	relative_to_group: group /= Void implies relative_to (group.point)
	all_points_in_group: group /= Void implies all_points_in_group (group)

	--in_group_implies_group_has_current: group /= Void implies group.has (Current)
	--| invariant does not hold because it is called at a stange time or something.

end -- class EV_FIGURE

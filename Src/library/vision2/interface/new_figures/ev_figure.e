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
	ANY
		redefine
			default_create
		end

feature {NONE} -- Initialization

	default_create is
			-- Create with all points Void.
		local
			n: INTEGER
		do
			create points.make_filled (point_count)
			from
				n := 1
			until
				n > point_count
			loop
				set_point_by_index (n, create {EV_RELATIVE_POINT})
				n := n + 1
			end
		end

	make_with_points (list: like points) is
			-- Create with `list''s items.
		require
			list_correct_size: list_has_correct_size (list)
		do
			default_create
			set_points (list)
		end

	make_in_group (grp: EV_FIGURE_GROUP) is
			-- Create in `grp'.
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
			-- The group this figure belongs to.
			-- Void means this figure is not in a group.

	point_count: INTEGER is
			-- Number of points needed to describe this figure.
			-- Preferably a constant, but we also have polyline.
		deferred
		end

feature {NONE} -- Implementation

	points: ARRAYED_LIST [EV_RELATIVE_POINT]
			-- Array of points needed to describe this figure.
			-- Index: [1..point_count].

feature -- Status report

	get_point, get_point_by_index (index: INTEGER): EV_RELATIVE_POINT is
			-- Returns the point with `index'.
		require
			index_within_bounds: index > 0 and then index <= point_count
		do
			Result := points.i_th (index)
		end

feature -- Status setting

	set_point, set_point_by_index (index: INTEGER; point: EV_RELATIVE_POINT) is
			-- Sets point on `index' to `point'.
		require
			index_within_bounds: index > 0 and then index <= point_count
			point_exists: point /= Void
			point_relative_to_group_point:
				group /= Void implies point.relative_to (group.point)
		do
			points.put_i_th (point, index)
		ensure
			point_inserted_on_index: point = get_point (index)
		end

	set_points (list: like points) is
			-- Set all points to the items in `list'.
		require
			list_correct_size: list_has_correct_size (list)
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
				get_point (n).calculate_absolute_position
				n := n + 1
			end
		end

	invalidate_absolute_position is
			-- Invalidates the absolute positions of figures.
			-- Not if no positioner installed and position not changed.
			-- This is the way to let positioners be called again and
			-- changes to coordinates to be committed.
		local
			n: INTEGER
		do
			from
				n := 1
			until
				n > point_count
			loop
				get_point (n).invalidate_absolute_position
				n := n + 1
			end
		end

feature -- Standard output

	print_status is
			-- Write a textual representation to standard output.
		local
			n: INTEGER
		do
			from
				io.put_string ("Figure: ")
				n := 1
			until
				n > point_count
			loop
				get_point (n).print_status
				io.put_string ("; ")
				n := n + 1
			end
		end

	print_prefixed (pref: STRING) is
			-- Write a textual representation to standard output.
			-- Prepend `pref' to every line.
		do
			io.put_string (pref)
			print_status
			io.new_line
		end

feature {EV_FIGURE_GROUP} -- Implementation

	set_group (new_group: EV_FIGURE_GROUP) is
			-- Set the figure-group of this figure to `new_group'.
		require
			new_group_exists: new_group /= Void
			points_relative_to_group_point:
				relative_to (new_group.point)
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

feature {EV_PROJECTION} -- Implementation

	orientation: EV_ANGLE is
			-- Get the orientation of this figure.
		do
			create Result.make_radians (get_point_by_index (1).angle_abs)
		end

feature -- Assertion

	list_has_correct_size (list: like points): BOOLEAN is
			-- Does `list' have the correct number of items?
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

	relative_to_group (grp: EV_FIGURE_GROUP): BOOLEAN is
			-- Do all points of this figure move relative to the group's point?
		obsolete
			"Use: group /= Void implies relative to (group.point)"
		do
			if grp /= Void then
				Result := relative_to (grp.point)
			else
				Result := True
			end
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
				if not list.i_th (n).relative_to (pnt) then
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

invariant
	points_exists: points /= Void
	points_correct_size: list_has_correct_size (points)
	all_points_exist: all_points_exist (points)
	relative_to_group: group /= Void implies relative_to (group.point)

end -- class EV_FIGURE

indexing
	description: "Objects that represent a position.%
		% Takes another relative point as origin and then defines a%
		% hor. & vert. scaling factor, x, y and angle.%
		% You can then access absolute scale_x, scale_y, x, y and angle%
		% which are recomputed only if invalidate_absolute_position has been called.%
		% You may also choose to specify a positioner. This is an agent%
		% that gets called everytime a recomputation is requested.%
		% When a positioner is installed, the other attributes are ignored.%
		% The x and y are transformed by the angle and scaling of the origin.%
		% This implies that the scale_x, scale_y and angle features of this%
		% object are only for propagation to referring points."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_RELATIVE_POINT

inherit
	SINGLE_MATH
		rename
			out as default_out
		redefine
			default_create
		end

create
	default_create,
	make_with_origin,
	make_with_origin_and_position,
	make_with_positioner

feature {NONE}  -- Initialization

	default_create is
			-- Base origin.
		do
			Precursor
			create notify_list.make
			position_changed := True
			scale_x := 1
			scale_y := 1
		end

	make_with_origin (an_origin: EV_RELATIVE_POINT) is
			-- Create with `an_origin' on position (0, 0).
		do
			default_create
			set_origin (an_origin)
		end	

	make_with_origin_and_position (an_origin: EV_RELATIVE_POINT; new_x, new_y: INTEGER) is
			-- Create with `an_origin' on position (`new_x', `new_y').
		do
			default_create
			set_origin (an_origin)
			set_x (new_x)
			set_y (new_y)
		end	


	make_with_positioner (pos_agent: like positioner) is
			-- Create with `pos_agent'.
		do
			default_create
			set_positioner (pos_agent)
		end	

feature -- Access

	origin: EV_RELATIVE_POINT
			-- The origin the position is relative to.
			-- If this is Void, the x and y are relative to (0, 0).

	x: INTEGER
			-- The x-coordinate relative to origin.
			--| This is in fact not the actual x coordinate relative to the origin.
			--| The actual place is a calculation including scale_x and angle.

	y: INTEGER
			-- The y-coordinate relative to origin.
			--| This is in fact not the actual x coordinate relative to the origin.
			--| The actual place is a calculation including scale_y and angle.

	angle: REAL
			-- The angle in radians relative to origin.
			--| This angle has few to do with this point. It's main purpose is to
			--| propagate it to the points who have this point as origin.

	scale_x: REAL
			-- The relative horizontal scaling factor.
			--| Only propagation purpose.

	scale_y: REAL
			-- The relative vertical scaling factor.
			--| Only propagation purpose.

	positioner: PROCEDURE [ANY, TUPLE [like Current]]
			-- Take special absolute positioning action.
			-- A positioner is expected to use the routines: set_x_abs, set_y_abs.
			-- set_angle_abs, set_scale_x_abs, set_scale_y_abs can be used too
			-- to propagate angle and scaling factor to referring points.
			--| When a positioner is used, origin is ignored.

	figure: EV_FIGURE
			-- The figure to which this position is attached.
			-- Void means this point floats in space.

feature -- Status report

	x_abs: INTEGER is
			-- The x relative to (0, 0). Updates if necessary.
		do
			calculate_absolute_position
			Result := last_x_abs
		ensure
			Result_assigned: Result = last_x_abs
		end

	y_abs: INTEGER is
			-- The y relative to (0, 0). Updates if necessary.
		do
			calculate_absolute_position
			Result := last_y_abs
		ensure
			Result_assigned: Result = last_y_abs
		end

	angle_abs: REAL is
			-- The angle relative to 0. Updates if necessary.
		do
			calculate_absolute_position
			Result := last_angle_abs
		ensure
			Result_assigned: Result = last_angle_abs
		end		

	scale_x_abs: REAL is
			-- The final horizontal scaling factor. Updates if necessary.
		do
			calculate_absolute_position
			Result := last_scale_x_abs
		ensure
			Result_assigned: Result = last_scale_x_abs
		end		

	scale_y_abs: REAL is
			-- The final vertical scaling factor. Updates if necessary.
		do
			calculate_absolute_position
			Result := last_scale_y_abs
		ensure
			Result_assigned: Result = last_scale_y_abs
		end		

	has_positioner: BOOLEAN is
			-- Is this point controlled by an agent?
		do
			Result := positioner /= Void
		ensure
			Result_assigned: Result = (positioner /= Void)
		end

	group: EV_FIGURE_GROUP is
			-- Return the group this position is considered to be in.
			-- Is resolved by going up in the origins until a group is found.
		do
			if figure /= Void then
				Result := figure.group
			else
				if origin /= Void then
					Result := origin.group
				end
			end
		end

	in_group (g: EV_FIGURE_GROUP): BOOLEAN is
			-- Is this point transitively in `g'?
		require
			g_exists: g /= Void
		do
			Result := Current /= g.point and then valid_group_point (g.point)
		end

	relative_to (org: EV_RELATIVE_POINT): BOOLEAN is
			-- Does this point have `org' as origin somehow?
			-- This is not the case when it is being positioned.
			--| Used in preconditions of x_rel_to and y_rel_to.
			--| A point is not relative to itself.
		do 
			if origin = org then
				Result := True
			elseif origin = Void or else has_positioner then
				Result := False
			else
				Result := origin.relative_to (org)
			end
		end

feature -- Status setting

	set_positioner (pos_agent: like positioner) is
			-- Set a customized positioning routine.
		do
			positioner := pos_agent
			notify_of_position_change
		ensure
			positioner_assigned: positioner = pos_agent
		end

	set_origin (new_origin: EV_RELATIVE_POINT) is
			-- Set the point this point is relative to.
			--| FIXME This is tricky, because we have the invariant in EV_FIGURE
			--| This could mess it up completely!!!!
			--| However, we have nothing do to with it in this scope.
			--| Maybe export it to {EV_FIGURE}

			--|EV_FIGURE_relative_to_group: group /= Void implies relative_to (group.point)
			--|EV_FIGURE_all_points_in_group: group /= Void implies all_points_in_group (group)

			-- Can `org' be assigned to `origin'?
			-- This is the case when the invariant in EV_FIGURE will not break.
			-- This means that this point will still have to be relative to (valid group point)
			-- the figure's group's point. What is this point's figure???? or group????
			-- Use the feature `group' for this.
		require
			new_origin_relative_to_group_point_or_positioned:
				group /= Void implies origin.valid_group_point (group.point)
		do
			if origin /= Void then
				origin.notify_list.prune (Current)
			end
			origin := new_origin
			if origin /= Void then
				origin.notify_list.extend (Current)
			end
		end

	set_x (new_x: INTEGER) is
			-- Change the relative horizontal position.
		do
			x := new_x
			notify_of_position_change
		end

	set_y (new_y: INTEGER) is
			-- Change the relative vertical position.
		do
			y := new_y
			notify_of_position_change
		end

	set_angle (new_angle: REAL) is
			-- Set the angle of this point (in radians).
		do
			angle := new_angle
			notify_of_position_change
		end

	set_scale_x (new_scale_x: REAL) is
			-- Set the the relative horizontal scaling factor.
		do
			scale_x := new_scale_x
			notify_of_position_change
		end

	set_scale_y (new_scale_y: REAL) is
			-- Set the the relative vertical scaling factor.
		do
			scale_y := new_scale_y
			notify_of_position_change
		end

	set_scale (new_scale: REAL) is
			-- Set the relative scaling factor.
		do
			scale_y := new_scale
			scale_x := new_scale
			notify_of_position_change
		end

feature {EV_FIGURE} -- Status setting

	set_figure (new_figure: EV_FIGURE) is
			-- Set the figure where this point is referenced.
			--|EV_FIGURE_relative_to_group: group /= Void implies relative_to (group.point)
			--|EV_FIGURE_all_points_in_group: group /= Void implies all_points_in_group (group)
		do
			figure := new_figure
		ensure
			figure_assigned: figure = new_figure
		end

feature -- Status setting (by positioner)

	set_x_abs (new_x_abs: INTEGER) is
			-- Change the absolute position.
			-- Can only be used by a positioner.
		require
			being_positioned: being_positioned
		do
			last_x_abs := new_x_abs
		ensure
			last_x_abs_assigned: last_x_abs = new_x_abs
		end

	set_y_abs (new_y_abs: INTEGER) is
			-- Change the absolute position.
			-- Can only be used by a positioner.
		require
			being_positioned: being_positioned
		do
			last_y_abs := new_y_abs
		ensure
			last_y_abs_assigned: last_y_abs = new_y_abs
		end

	set_angle_abs (new_angle_abs: REAL) is
			-- Change the absolute angle.
			-- Can only be used by a positioner.
		require
			being_positioned: being_positioned
		do
			last_angle_abs := new_angle_abs
		ensure
			last_angle_abs_assigned: last_angle_abs = new_angle_abs
		end

	set_scale_x_abs (new_scale_x_abs: REAL) is
			-- Change the absolute horizontal scaling factor.
			-- Can only be used by a positioner.
		require
			being_positioned: being_positioned
		do
			last_scale_x_abs := new_scale_x_abs
		ensure
			last_scale_x_abs_assigned: last_scale_x_abs = new_scale_x_abs
		end

	set_scale_y_abs (new_scale_y_abs: REAL) is
			-- Change the absolute vertical scaling factor.
			-- Can only be used by a positioner.
		require
			being_positioned: being_positioned
		do
			last_scale_y_abs := new_scale_y_abs
		ensure
			last_scale_y_abs_assigned: last_scale_y_abs = new_scale_y_abs
		end

feature -- Convencience

	get_relative_point (new_x, new_y: INTEGER): EV_RELATIVE_POINT is
			-- Create a new point relative to this one
			-- and with relative coordinates (`x', `y').
		do
			create Result
			Result.set_origin (Current)
			Result.set_x (new_x)
			Result.set_y (new_y)
		end

feature -- Recomputation

	last_x_abs: INTEGER
			-- The last calculated x relative to (0, 0).

	last_y_abs: INTEGER
			-- The last calculated y relative to (0, 0).

	last_angle_abs: REAL
			-- The last calculated cumulative angle (relative to 0).

	last_scale_x_abs: REAL
			-- The last calculated final horizontal scaling factor.

	last_scale_y_abs: REAL
			-- The last calculated final vertical scaling factor.

	being_positioned: BOOLEAN
			-- Used for cycle detection of positioning agents.
			--| Is a precondition of set_x_abs, set_y_abs, set_angle_abs,
			--| set_scale_x_abs, set_scale_y_abs.

	x_transformed (ang, scale: REAL): INTEGER is
			-- The x if the point it was rotated by `abs'.
			-- Used to add to the absolute coordinate of origin.
			-- Formula: rx = (x cos ang - y sin ang) * scale
			--| This is used to add to the absolute coordinates of the origin
			--| to get this point's absolute coordinates. Same for y_transformed.
		do
			Result := (((cosine (ang) * x) - (sine (ang) * y)) * scale).rounded
		end

	y_transformed (ang, scale: REAL): INTEGER is
			-- The y if the point it was rotated by `angle'.
			-- Used to add to the absolute coordinate of origin.
			-- Formula: ry = (x sin ang + y cos ang) * scale
		do
			Result := (((sine (ang) * x) + (cosine (ang) * y)) * scale).rounded
		end

	calculate_absolute_position is
			-- Do the absolute calculation if needed.
			-- Do nothing if absolute_position is already valid.
			--| It is not really necessary to call this directly.
			--| Only when you want every calculation to be done at the same time.
		do
			if not absolute_position_valid then
				-- Not always! Only when:
				if position_changed or else controlled_by_positioner then
					if positioner /= Void then
						if being_positioned then
							io.put_string ("EV_RELATIVE_POINT: loop detected in positioning agents.")
							--| FIXME Raise exception???
						else
							being_positioned := True
							positioner.call ([Current])
							being_positioned := False
						end
					else
						if origin = Void then
							last_x_abs := 0
							last_y_abs := 0
							last_scale_x_abs := 1
							last_scale_y_abs := 1
							last_angle_abs := 0
						else
							last_x_abs := origin.x_abs
							last_y_abs := origin.y_abs
							last_scale_x_abs := origin.scale_x_abs
							last_scale_y_abs := origin.scale_y_abs
							last_angle_abs := origin.angle_abs
						end
						last_x_abs := last_x_abs + x_transformed (last_angle_abs, last_scale_x_abs)
						last_y_abs := last_y_abs + y_transformed (last_angle_abs, last_scale_y_abs)
						last_angle_abs := last_angle_abs + angle
						last_scale_x_abs := last_scale_x_abs * scale_x
						last_scale_y_abs := last_scale_y_abs * scale_y
						position_changed := False
					end
				end
				absolute_position_valid := True
			end
		end

	absolute_position_valid: BOOLEAN
			-- Are the absolute coordinates of this figure valid?
			--| If they are not, calculate_absolute_position is called first.

	invalidate_absolute_position is
			-- Force recalculation of absolute coordinates next time they
			-- are accessed.
			--| Calls the function for its origin, because it might not be
			--| set as a point of a figure and connot be reached otherwise.
		do
			if absolute_position_valid then
				absolute_position_valid := False
				if origin /= Void then
					origin.invalidate_absolute_position
				end
			end
		end

feature {EV_FIGURE, EV_RELATIVE_POINT} -- Implementation

	--| These features are to determine the x, y and angle relative
	--| to a given point. That point can be positioned, but no positioner can
	--| be in between this point and that point.
	--| enforced by precondition: (this point).originated_from (that point)
	--| Use these functions for projection purposes.
	--| If for a rectangle, point_a is originated from point_b,
	--| Use point_b.x_rel_to (point_a) as a width for it,
	--| and use the angle on point_a as orientation.

	angle_rel_to (pnt: EV_RELATIVE_POINT): REAL is
			-- Get the angle relative to `pnt'.
			-- This point must originate from `pnt'.
			--| FIXME This function is not correct.
			--| It adds its own angle to the result. (=wrong)
			--| VB: Tried to fix it, but not yet sure if it works.
		require
			pnt_exists: pnt /= Void
			relative_to_pnt: relative_to (pnt)
		do
			if origin /= pnt then
				Result := origin.angle_rel_to (pnt)
			end
			if origin /= Void then
				Result := Result + origin.angle
			end
		end

	x_rel_to (pnt: EV_RELATIVE_POINT): INTEGER is
			-- Get the x relative to `pnt'.
			-- This point must originate from `pnt'.
		require
			pnt_exists: pnt /= Void
			relative_to_pnt: relative_to (pnt)
		do
			if origin /= pnt then
				Result := origin.x_rel_to (pnt)
			end
			Result := Result + x_transformed (angle_rel_to (pnt), scale_x_abs)
		end

	y_rel_to (pnt: EV_RELATIVE_POINT): INTEGER is
			-- Get the y relative to `pnt'.
			-- This point must originate from `pnt'.
		require
			pnt_exists: pnt /= Void
			relative_to_pnt: relative_to (pnt)
		do
			if origin /= pnt then
				Result := origin.y_rel_to (pnt)
			end
			Result := Result + y_transformed (angle_rel_to (pnt), scale_y_abs)
		end

feature -- Representation

	out: STRING is
			-- Write a textual representation to standard output.
		do
			Result := out_rel + "=" + out_abs
		end

	out_abs: STRING is
			-- A string with absolute coordinates.
		do
			Result := "(" + x_abs.out + ", " + y_abs.out + ")"
		end

	out_rel: STRING is
			-- A string with all relative coordinates of origins.
		do
			if origin /= Void then
				Result := origin.out_rel + "+"
			end
			Result := Result + "(" + x.out + ", " + y.out + ")"
		end

feature {EV_RELATIVE_POINT, EV_PROJECTION} -- Implementation

	position_changed: BOOLEAN
			-- Is the position updated since last calculation?
			-- (this position is notified of change by it's origin)

	controlled_by_positioner: BOOLEAN is
			-- Checks whether this position is somehow controlled by a positioner.
		do
			if positioner /= Void then
				Result := True
			elseif origin /= Void then
				Result := origin.controlled_by_positioner
			else
				Result := False
			end
		end

	--| FIXME The whole notify_list thing is meant to improve performance.
	--| However, we cannot make sure there is actually a gain on this, so
	--| testing will be required.

	notify_list: LINKED_LIST [EV_RELATIVE_POINT]
			-- The list of points which have to be notified
			-- when the absolute coordinates of this point change.

	notify_of_position_change is
			-- Set the flag `position_changed' and in all referring positions.
		do
			if not position_changed then
				position_changed := True
				from
					notify_list.start
				until
					notify_list.after
				loop
					notify_list.item.notify_of_position_change
					notify_list.forth
				end
			end
		end

feature -- Contract support

	--| Naming problem. is_group_point?
	valid_group_point (pos: EV_RELATIVE_POINT): BOOLEAN is
			-- Can `pos' be this point's group-point?
			-- This is always assumed to be the case when it is being positioned.
			-- Reason: A point can only be put in a group if it is relative to that
			-- group's origin, and with a positioner, you're always allowed to
			-- add it to any group. Function is used in many assertion clauses.
			--| Current.valid_group_point (Current) =====> FALSE!
		require
			pos_exists: pos /= Void
		do
			if has_positioner then
				Result := True --| Assumption
			elseif origin = Void then
				Result := False
			elseif origin = pos then
				Result := True
			else
				Result := origin.valid_group_point (pos)
			end
		end

	valid_origin (org: EV_RELATIVE_POINT): BOOLEAN is
			-- Can `org' be assigned to `origin'?
			-- This is the case when the invariant in EV_FIGURE will not break.
			-- This means that this point will still have to be relative to (valid group point)
			-- the figure's group's point. What is this point's figure???? or group????
			-- Use the feature `group' for this.
		do
			Result := org.group /= Void implies valid_group_point (org.group.point)
		end

	valid_figure (fig: EV_FIGURE): BOOLEAN is
			-- Is `fig' a valid figure for this point?
			-- This means the origin of this point (if exists) should be
			-- relative to the figure's group's point (if group exists)
		require
			fig_exists: fig /= Void
		do
			Result := origin /= Void implies (fig.group /= Void implies
				origin.valid_group_point (fig.group.point))
		end

invariant
	notify_list_exists: notify_list /= Void
	has_origin_implies_origin_notifies: origin /= Void implies origin.notify_list.has (Current)
	--figure_exists_implies_valid: figure /= Void implies valid_figure (figure)
	in_figure_implies_figure_has_point: figure /= Void implies figure.points.has (Current)
	is_in_own_group: group /= Void implies in_group (group)

	--origin_exists_implies_origin_in_same_group: origin /= Void implies (origin.figure = group or else origin.group = group)
	--in_group_implies_relative_to_group_point: group /= Void implies valid_group_point (group.point)

end -- class EV_RELATIVE_POINT

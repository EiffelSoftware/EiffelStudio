indexing
	description:
		"Positions relative to other positions.%N%
		%Takes another relative point as origin and then defines a%N%
		%hor. & vert. scaling factor, x, y and angle.%N%
		%You can then access absolute scale_x, scale_y, x, y and angle%N%
		%which are recomputed only if invalidate_absolute_position has%N%
		%been called.%N%
		%You may also choose to specify a positioner. This is an agent%N%
		%that gets called everytime a recomputation is requested.%N%
		%When a positioner is installed, the other attributes are ignored.%N%
		%The x and y are transformed by the angle and scaling of the origin.%N%
		%This implies that the scale_x, scale_y and angle features of this%N%
		%object are only for propagation to referring points."
	status: "See notice at end of class"
	keywords: "point, position, location, origin"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_RELATIVE_POINT

inherit
	EV_FIGURE_MATH
		undefine
			default_create
		end

	IDENTIFIED
		undefine
			default_create,
			is_equal,
			copy
		end

create
	default_create,
	make_with_origin,
	make_with_origin_and_position,
	make_with_position,
	make_with_positioner

feature {NONE}  -- Initialization

	default_create is
			-- Base origin.
		do
			create notify_list_ids.make (2)
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

	make_with_origin_and_position (
		an_origin: EV_RELATIVE_POINT; new_x, new_y: INTEGER) is
			-- Create with `an_origin' on position (`new_x', `new_y').
		do
			default_create
			set_origin (an_origin)
			set_x (new_x)
			set_y (new_y)
		end	

	make_with_position (new_x, new_y: INTEGER) is
			-- Create on position (`new_x', `new_y').
		do
			default_create
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
			--| This is in fact not the actual x coordinate relative to
			--| the origin.
			--| The actual place is a calculation including scale_x and angle.

	y: INTEGER
			-- The y-coordinate relative to origin.
			--| This is in fact not the actual x coordinate relative to
			--| the origin.
			--| The actual place is a calculation including scale_y and angle.

	angle: DOUBLE
			-- The angle in radians relative to origin.
			--| This angle has few to do with this point.
			--| It's main purpose is to
			--| propagate it to the points who have this point as origin.

	scale_x: DOUBLE
			-- The relative horizontal scaling factor.
			--| Only propagation purpose.

	scale_y: DOUBLE
			-- The relative vertical scaling factor.
			--| Only propagation purpose.

	positioner: PROCEDURE [ANY, TUPLE [like Current]]
			-- Take special absolute positioning action.
			-- A positioner is expected to use the routines:
			-- set_x_abs, set_y_abs.
			-- set_angle_abs, set_scale_x_abs, set_scale_y_abs can be used too
			-- to propagate angle and scaling factor to referring points.
			--| When a positioner is used, origin is ignored.

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

	absolute_coordinates: EV_COORDINATES is
			-- Coordinates relative to (0, 0). Updates if necessary.
		do
			calculate_absolute_position
			create Result.set (last_x_abs, last_y_abs)
		end

	angle_abs: DOUBLE is
			-- The angle relative to 0. Updates if necessary.
		do
			calculate_absolute_position
			Result := last_angle_abs
		ensure
			Result_assigned: Result = last_angle_abs
		end		

	scale_x_abs: DOUBLE is
			-- The final horizontal scaling factor. Updates if necessary.
		do
			calculate_absolute_position
			Result := last_scale_x_abs
		ensure
			Result_assigned: Result = last_scale_x_abs
		end		

	scale_y_abs: DOUBLE is
			-- The final vertical scaling factor. Updates if necessary.
		do
			calculate_absolute_position
			Result := last_scale_y_abs
		ensure
			Result_assigned: Result = last_scale_y_abs
		end		

feature -- Status report

	has_positioner: BOOLEAN is
			-- Is this point controlled by an agent?
		do
			Result := positioner /= Void
		ensure
			Result_assigned: Result = (positioner /= Void)
		end

	being_positioned: BOOLEAN
			-- Used for cycle detection of positioning agents.
			--| Is a precondition of set_x_abs, set_y_abs, set_angle_abs,
			--| set_scale_x_abs, set_scale_y_abs.

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

feature -- Element change

	set_positioner (pos_agent: like positioner) is
			-- Set a customized positioning routine.
		do
			positioner := pos_agent
			set_controlled_by_positioner (pos_agent /= Void)
			notify_of_position_change
		ensure
			positioner_assigned: positioner = pos_agent
		end

	set_origin (new_origin: EV_RELATIVE_POINT) is
			-- Set the point this point is relative to.
		require
			new_origin_not_void: new_origin /= Void
			no_dependance_circle: not new_origin.relative_to (Current)
		do
			if origin /= Void then
				origin.notify_list_ids.prune (object_id)
			end
			origin := new_origin
			origin.notify_list_ids.extend (object_id)
			notify_of_position_change
		end

	change_origin (new_origin: EV_RELATIVE_POINT) is
			-- Set the point this point is relative to.
			-- Do not change absolute coordinates if
			-- scaling factors and angle do not change.
		require
			new_origin_not_void: new_origin /= Void
			no_dependance_circle: not new_origin.relative_to (Current)
		do
			x := x_abs - new_origin.x_abs
			y := y_abs - new_origin.y_abs
			set_origin (new_origin)
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

	set_angle (new_angle: DOUBLE) is
			-- Set the angle of this point (in radians).
		do
			angle := new_angle
			notify_of_position_change
		end

	set_scale_x (new_scale_x: DOUBLE) is
			-- Set the the relative horizontal scaling factor.
		do
			scale_x := new_scale_x
			notify_of_position_change
		end

	set_scale_y (new_scale_y: DOUBLE) is
			-- Set the the relative vertical scaling factor.
		do
			scale_y := new_scale_y
			notify_of_position_change
		end

	set_scale (new_scale: DOUBLE) is
			-- Set the relative scaling factor.
		do
			scale_y := new_scale
			scale_x := new_scale
			notify_of_position_change
		end

	set_position (new_x, new_y: INTEGER) is
			-- Set both `x' and `y'.
		do
			x := new_x
			y := new_y
			notify_of_position_change
		end

	set_x_abs (new_x_abs: INTEGER) is
			-- Change the absolute position.
		do
			last_x_abs := new_x_abs
		ensure
			last_x_abs_assigned: last_x_abs = new_x_abs
		end

	set_y_abs (new_y_abs: INTEGER) is
			-- Change the absolute position.
		do
			last_y_abs := new_y_abs
		ensure
			last_y_abs_assigned: last_y_abs = new_y_abs
		end

	set_angle_abs (new_angle_abs: DOUBLE) is
			-- Change the absolute angle.
		do
			last_angle_abs := new_angle_abs
		ensure
			last_angle_abs_assigned: last_angle_abs = new_angle_abs
		end

	set_scale_x_abs (new_scale_x_abs: DOUBLE) is
			-- Change the absolute horizontal scaling factor.
		do
			last_scale_x_abs := new_scale_x_abs
		ensure
			last_scale_x_abs_assigned: last_scale_x_abs = new_scale_x_abs
		end

	set_scale_y_abs (new_scale_y_abs: DOUBLE) is
			-- Change the absolute vertical scaling factor.
		do
			last_scale_y_abs := new_scale_y_abs
		ensure
			last_scale_y_abs_assigned: last_scale_y_abs = new_scale_y_abs
		end

feature {EV_FIGURE, EV_RELATIVE_POINT} -- Implementation

	last_x_abs: INTEGER
			-- The last calculated x relative to (0, 0).

	last_y_abs: INTEGER
			-- The last calculated y relative to (0, 0).

	last_angle_abs: DOUBLE
			-- The last calculated cumulative angle (relative to 0).

	last_scale_x_abs: DOUBLE
			-- The last calculated final horizontal scaling factor.

	last_scale_y_abs: DOUBLE
			-- The last calculated final vertical scaling factor.

	x_transformed (ang, scale: DOUBLE): INTEGER is
			-- The x if the point it was rotated by `abs'.
			-- Used to add to the absolute coordinate of origin.
			-- Formula: rx = (x cos ang - y sin ang) * scale
			--| This is used to add to the absolute coordinates of the origin
			--| to get this point's absolute coordinates.
			--| Same for y_transformed.
		do
			if ang = 0.0 and scale = 1.0 then
				Result := x
			elseif ang = 0.0 then
				Result := (x * scale).truncated_to_integer
			else
				Result := (((cosine (ang) * x) -
					(sine (ang) * y)) * scale).truncated_to_integer
			end
		end

	y_transformed (ang, scale: DOUBLE): INTEGER is
			-- The y if the point it was rotated by `angle'.
			-- Used to add to the absolute coordinate of origin.
			-- Formula: ry = (x sin ang + y cos ang) * scale
		do
			if ang = 0.0 and scale = 1.0 then
				Result := y
			elseif ang = 0.0 then
				Result := (y * scale).truncated_to_integer
			else
				Result := (((sine (ang) * x) +
					(cosine (ang) * y)) * scale).truncated_to_integer
			end
		end

	calculate_absolute_position is
			-- Do the absolute calculation if needed.
			-- Do nothing if absolute_position is already valid.
			--| It is not really necessary to call this directly.
			--| Only when you want every calculation to be done at the
			--| same time.
		local
			l_x_abs, l_y_abs: INTEGER
			l_scale_x_abs, l_scale_y_abs, l_angle_abs: DOUBLE
		do
			if position_changed or else controlled_by_positioner then
				if positioner /= Void then
					check
						positioning_agent_loop: not being_positioned
					end
					being_positioned := True
					positioner.call ([Current])
					being_positioned := False
				else
					if origin = Void then
						l_scale_x_abs := 1
						l_scale_y_abs := 1
					else
						origin.calculate_absolute_position
						l_x_abs := origin.last_x_abs
						l_y_abs := origin.last_y_abs
						l_scale_x_abs := origin.last_scale_x_abs
						l_scale_y_abs := origin.last_scale_y_abs
						l_angle_abs := origin.last_angle_abs
					end
					l_x_abs := l_x_abs + x_transformed (
						l_angle_abs, l_scale_x_abs
					)
					l_y_abs := l_y_abs + y_transformed (
						l_angle_abs, l_scale_y_abs
					)
					l_angle_abs := l_angle_abs + angle
					l_scale_x_abs := l_scale_x_abs * scale_x
					l_scale_y_abs := l_scale_y_abs * scale_y
					last_x_abs := l_x_abs
					last_y_abs := l_y_abs
					last_scale_x_abs := l_scale_x_abs
					last_scale_y_abs := l_scale_y_abs
					last_angle_abs := l_angle_abs
					position_changed := False
				end
			end
		end

	absolute_position_valid: BOOLEAN is
			-- Are the absolute coordinates of this figure valid?
			--| If they are not, calculate_absolute_position is called first.
		do
			Result := not position_changed
		end

	invalidate_absolute_position is
			-- Force recalculation of absolute coordinates next time they
			-- are accessed.
		do
			position_changed := True
		end

feature {EV_RELATIVE_POINT} -- Implementation

	all_abs: TUPLE [INTEGER, INTEGER, DOUBLE, DOUBLE, DOUBLE] is
		do
			calculate_absolute_position
			Result := [last_x_abs, last_y_abs, last_scale_x_abs,
				last_scale_y_abs, last_angle_abs]
		end

	set_all (ax, ay: INTEGER; sx, sy, an: DOUBLE) is
		do
			last_x_abs := ax
			last_y_abs := ay
			last_scale_x_abs := sx
			last_scale_y_abs := sy
			last_angle_abs := an
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

	angle_rel_to (pnt: EV_RELATIVE_POINT): DOUBLE is
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

feature {EV_FIGURE, EV_RELATIVE_POINT, EV_PROJECTOR} -- Implementation

	position_changed: BOOLEAN
			-- Is the position updated since last calculation?

	controlled_by_positioner: BOOLEAN
			-- Checks whether this position is somehow controlled by a
			-- positioner.

	set_controlled_by_positioner (f: BOOLEAN) is
		local
			nl: like notify_list
		do
			controlled_by_positioner := f
			if f /= (positioner /= Void) then
				nl := notify_list
				from
					nl.start
				until
					nl.after
				loop
					nl.item.set_controlled_by_positioner (f)
					nl.forth
				end
			end
		end

	notify_list: LINKED_LIST [EV_RELATIVE_POINT] is
			-- Immediate dependant points.
		local
			i: EV_RELATIVE_POINT
		do
			create Result.make
			from
				notify_list_ids.start
			until
				notify_list_ids.after
			loop
				i ?= id_object (notify_list_ids.item)
				if i /= Void then
					Result.extend (i)
				end
				notify_list_ids.forth
			end
		end

	notify_list_ids: ARRAYED_LIST [INTEGER]
			-- Immediate dependant points and figures using weak referencing.

	notify_of_position_change is
			-- Set the flag `position_changed' and in all referring positions.
		local
			i: EV_RELATIVE_POINT
			f: EV_FIGURE
			ids: like notify_list_ids
		do
			if not position_changed then
				position_changed := True

				ids := notify_list_ids
				from
					ids.start
				until
					ids.after
				loop
					i ?= id_object (ids.item)
					if i /= Void then
						i.notify_of_position_change
						ids.forth
					else
						f ?= id_object (ids.item)
						if f /= Void then
							f.invalidate
							ids.forth
						else
							-- Remove object id from list.
							ids.remove
						end
					end
				end
			end
		end
		
feature -- Obsolete

	trace is
		Obsolete
			"Please do not use this feature as it will shortly be removed."
		do
			io.error.put_string (out_rel + "=" + out_abs)
		end

invariant
	notify_list_exists: notify_list_ids /= Void
	has_origin_implies_origin_notifies:
		origin /= Void implies origin.notify_list_ids.has (object_id)

end -- class EV_RELATIVE_POINT

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

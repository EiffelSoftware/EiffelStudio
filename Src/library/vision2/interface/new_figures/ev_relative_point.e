indexing
	description: "A figure that represents a position."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_RELATIVE_POINT

inherit
	ANY
		redefine
			default_create
		end

create
	default_create,
	make_with_origin,
	make

feature -- Initialization

	default_create is
			-- Base origin.
		do
			Precursor
			create notify_list.make
			position_changed := True
		end

	make_with_origin (an_origin: EV_RELATIVE_POINT) is
			-- Create with `an_origin' on position (0, 0).
		do
			default_create
			set_origin (an_origin)
		end	

	--| FIXME Naming problem.
	make (an_origin: EV_RELATIVE_POINT; new_x, new_y: INTEGER) is
			-- Create with `an_origin' on position (`new_x', `new_y')
		do
			default_create
			set_origin (an_origin)
			set_x (new_x)
			set_y (new_y)
		end	

feature -- Access

	origin: EV_RELATIVE_POINT
			-- The origin the position is relative to.
			-- If this is Void, the x and y are relativ to (0, 0).

	x: INTEGER
			-- The x-coordinate relative to origin.

	y: INTEGER
			-- The y-coordinate relative to origin.

	angle: REAL
			-- The angle in radians relative to origin.

	positioner: PROCEDURE [ANY, TUPLE [like Current]]
			-- Take special absolute positioning action.
			-- Be careful not to shoot yourself in the foot.
			-- If there is a positioner installed, the origin, x and y are ignored.

feature -- Status report

	x_abs: INTEGER is
			-- The x relative to (0, 0). Updates if necessary.
		do
			calculate_absolute_position
			Result := last_x_abs
		end		

	y_abs: INTEGER is
			-- The y relative to (0, 0). Updates if necessary.
		do
			calculate_absolute_position
			Result := last_y_abs
		end

	angle_abs: REAL is
			-- The angle relative to 0.
		do
			calculate_absolute_position
			Result := last_angle_abs
		end		

--	position: EV_POINT is
--			-- The relative position to origin.
--		do
--			create Result.set (x, y)
--		end

--	absolute_position: EV_POINT is
--			-- The position relative to (0, 0).
--		do
--			calculate_absolute_position
--			create Result.set (last_x_abs, last_y_abs)
--		end

	has_positioner: BOOLEAN is
			-- Is this point controlled by an agent?
		do
			Result := positioner /= Void
		end

	relative_to (pos: EV_RELATIVE_POINT): BOOLEAN is
			-- Is this position moved relative to `pos'.
		require
			pos_exists: pos /= Void
		do
			if has_positioner then
				Result := True
			elseif origin = Void then
				Result := False
			elseif origin = pos then
				Result := True
			else
				Result := origin.relative_to (pos)
			end
		end

feature -- Status setting

	set_positioner (pos_agent: like positioner) is
			-- Set a customized positioning routine.
		do
			positioner := pos_agent
		end

	set_origin (new_origin: EV_RELATIVE_POINT) is
			-- Set the point this point is relative to.
			--| FIXME This is tricky, because we have the invariant in EV_FIGURE
			--| This could mess it up completely!!!!
			--| However, we have nothing do to with it in this scope.
			--| Maybe export it to {EV_FIGURE}.
		do
			if origin /= Void then
				origin.remove_reference (Current)
			end
			origin := new_origin
			if origin /= Void then
				origin.add_reference (Current)
			end
		end

--	set_position (new_pos: EV_POINT) is
--			-- Change the relative position.
--		do
--			set_x (new_pos.x)
--			set_y (new_pos.y)
--		end

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

--	set_x_y (new_x, new_y: INTEGER) is
--			-- Change the relative position.
--		do
--			set_x (new_x)
--			set_y (new_y)
--		end

	set_x_abs (new_x_abs: INTEGER) is
			-- Change the absolute position.
			-- Can only be used by a positioner.
		require
			being_positioned: being_positioned
		do
			last_x_abs := new_x_abs
		end

	set_y_abs (new_y_abs: INTEGER) is
			-- Change the absolute position.
			-- Can only be used by a positioner.
		require
			being_positioned: being_positioned
		do
			last_y_abs := new_y_abs
		end

	set_angle_abs (new_angle_abs: REAL) is
			-- Change the absolute angle.
			-- Can only be used by a positioner.
		require
			being_positioned: being_positioned
		do
			last_angle_abs := new_angle_abs
		end

feature -- Convencience

	get_relative_point (new_x, new_y: INTEGER): EV_RELATIVE_POINT is
			-- Create a new point relative to this one
			-- and with relative coordinates (`x', `y').
		do
			create Result.make (Current, new_x, new_y)
		end

feature -- Recomputation

	last_x_abs: INTEGER
			-- The last calculated x relative to (0, 0).

	last_y_abs: INTEGER
			-- The last calculated y relative to (0, 0).

	last_angle_abs: REAL
			-- The last calculated angle relative to 0.

	being_positioned: BOOLEAN
			-- Used for cycle detection of positioning agents.

	calculate_absolute_position is
			-- Do the absolute calculation if needed.
			-- Do nothing if absolute_position is already valid.
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
							last_x_abs := x
							last_y_abs := y
							last_angle_abs := angle
						else
							-- The origin is updated if necessary:
							last_x_abs := origin.x_abs + x
							last_y_abs := origin.y_abs + y
							last_angle_abs := origin.angle + angle
						end
						position_changed := False
					end
				end
				absolute_position_valid := True
			end
		end

	absolute_position_valid: BOOLEAN
			-- Are the absolute coordinates of this figure valid?
			-- If they are, there is no need to recalculate.

	invalidate_absolute_position is
			-- Force recalculation of absolute coordinates next time they
			-- are accessed.
		do
			if absolute_position_valid then
				absolute_position_valid := False
				if origin /= Void then
					origin.invalidate_absolute_position
				end
			end
		end

feature -- Standard output

	print_status is
			-- Write a textual representation to standard output.
		do
			print_rel
			io.put_string ("=")
			print_abs
		end

	print_abs is
			-- Write a the absolute coordinates to standard output.
		do
			io.put_string ("(" + x_abs.out + ", " + y_abs.out + ")")
		end

	print_rel is
			-- Write all relative coordinates to standard output.
		do
			if origin /= Void then
				origin.print_rel
				io.put_string ("+")
			end
			io.put_string ("(" + x.out + ", " + y.out + ")")
		end

feature {EV_RELATIVE_POINT} -- Implementation

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

	add_reference (point: EV_RELATIVE_POINT) is
			-- Add point `other' depending on this origin and notify when
			-- the absolute coordinates of this point change.
		require
			point_exists: point /= Void
			notify_list_not_has_point: not notify_list.has (point)
		do
			notify_list.extend (point)
		ensure
			notify_list_has_point: notify_list.has (point)
		end

	remove_reference (point: EV_RELATIVE_POINT) is
			-- Remove `other' from the notify-list.
		require
			point_exists: point /= Void
			notify_list_has_point: notify_list.has (point)
		do
			notify_list.search (point)
			notify_list.remove
		ensure
			notify_list_not_has_point: not notify_list.has (point)
		end

	notify_of_position_change is
			-- Set the flag 'position_changed' and in all referring positions.
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

invariant
	notify_list_exists: notify_list /= Void

end -- class EV_RELATIVE_POINT

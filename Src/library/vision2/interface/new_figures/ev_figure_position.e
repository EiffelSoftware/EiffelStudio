indexing
	description: "A figure that represents a position."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_FIGURE_POSITION

inherit
	EV_FIGURE
		redefine
			default_create,
			out
		end

create
	default_create,
	make

feature -- Initialization

	default_create is
			-- Base origin.
		do
			Precursor
			create notify_list.make
			position_changed := True
		end

	make (an_origin: EV_FIGURE_POSITION; new_x, new_y: INTEGER) is
			-- Create with `an_origin' on position (`new_x', `new_y')
		do
			default_create
			set_origin (an_origin)
			set_x (new_x)
			set_y (new_y)
		end	

feature -- Access

	origin: EV_FIGURE_POSITION
			-- The origin the position is relative to.
			-- If this is Void, the x and y are relativ to (0, 0).

	x: INTEGER
			-- The relative x-coordinate.

	y: INTEGER
			-- The relative y-coordinate.

	positioner: PROCEDURE [ANY, TUPLE [like Current]]
			-- Take special absolute positioning action.
			-- Be careful not to shoot yourself in the foot.

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

	position: EV_POINT is
			-- The relative position to origin.
		do
			create Result.set (x, y)
		end

	absolute_position: EV_POINT is
			-- The position relative to (0, 0).
		do
			calculate_absolute_position
			create Result.set (last_x_abs, last_y_abs)
		end

	has_positioner: BOOLEAN is
			-- Is this point controlled by an agent?
		do
			Result := positioner /= Void
		end

	out: STRING is
		do
			Result := "(" + x_abs.out + ", " + y_abs.out +")"
		end

feature -- Status setting

	set_positioner (pos_agent: like positioner) is
			-- Set a customized positioning routine.
		do
			positioner := pos_agent
		end

	set_origin (new_origin: EV_FIGURE_POSITION) is
			-- Set the point this point is relative to.
		do
			if origin /= Void then
				origin.remove_reference (Current)
			end
			origin := new_origin
			if origin /= Void then
				origin.add_reference (Current)
			end
		end

	set_position (new_pos: EV_POINT) is
			-- Change the relative position.
		do
			set_x (new_pos.x)
			set_y (new_pos.y)
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

	set_x_y (new_x, new_y: INTEGER) is
			-- Change the relative position.
		do
			set_x (new_x)
			set_y (new_y)
		end

feature {EV_FIGURE} -- Recomputation

	last_x_abs: INTEGER
			-- The last calculated x relative to (0, 0).

	last_y_abs: INTEGER
			-- The last calculated y relative to (0, 0).

	being_positioned: BOOLEAN
			-- Used for cycle detection in positioning agents.

	calculate_absolute_position is
			-- Recalculate abs. coords. of any position this figure may have.
			-- Do nothing if absolute_position_valid is already True.
		do
			if not absolute_position_valid then
				if positioner /= Void then
					if being_positioned then
						io.put_string ("EV_FIGURE_POSITION: loop detected in positioning agents.")
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
					else
						-- The origin is updated if necessary:
						last_x_abs := origin.x_abs + x
						last_y_abs := origin.y_abs + y
					end
					position_changed := False
				end
				absolute_position_valid := True
			end
		end

	absolute_position_valid: BOOLEAN
			-- Are the absolute coordinates of this figure valid?
			-- If they are, there is no need to recalculate.

	invalidate_absolute_position is
			-- Set `absolute_position_valid' to False if a parent's
			-- Position has been updated or has a positioner.
		do
			absolute_position_valid := not (position_changed or else
				controlled_by_positioner)
		end

feature {EV_FIGURE_POSITION} -- Implementation

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

	--| FIXME The whole notify_list thing is meant to improve performce.
	--| We cannot make sure there is actually a gain on this, so
	--| testing will be required.

	notify_list: LINKED_LIST [EV_FIGURE_POSITION]
			-- The list of points which have to be notified
			-- when the absolute coordinates of this point change.

	add_reference (point: EV_FIGURE_POSITION) is
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

	remove_reference (point: EV_FIGURE_POSITION) is
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

end -- class EV_FIGURE_POSITION

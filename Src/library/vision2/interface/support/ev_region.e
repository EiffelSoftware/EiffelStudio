note
	description: "Used for defining a clip region in EV_DRAWABLE"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EV_REGION

inherit
	EV_ANY
		redefine
			implementation,
			copy,
			is_equal
		end
create
	default_create,
	make_with_rectangle

convert
	make_with_rectangle ({EV_RECTANGLE})

feature {NONE} -- Initialize

	make_with_rectangle (a_rectangle: EV_RECTANGLE)
			-- Create region with area set to `a_rectangle'.
		require
			a_rect_not_void: a_rectangle /= Void
		do
			default_create
			set_rectangle (a_rectangle)
		end

feature -- Element Change

	set_rectangle (a_rectangle: EV_RECTANGLE)
			-- Set region to area `a_rectangle'.
		require
			a_rect_not_void: a_rectangle /= Void
			not_is_destroyed: not is_destroyed
		do
			implementation.set_rectangle (a_rectangle)
		end

	offset (a_horizontal_offset, a_vertical_offset: INTEGER)
			-- Move `Current' a `a_horizontal_offset' horizontally and `a_vertical_offset' vertically.
		require
			not_is_destroyed: not is_destroyed
		do
			implementation.offset (a_horizontal_offset, a_vertical_offset)
		end

feature -- Access

	intersect, infix "and", infix "&" (a_region: EV_REGION): EV_REGION
			-- Intersection of `a_region' with `Current' .
		require
			a_region_valid: a_region /= Void and then not a_region.is_destroyed
			not_is_destroyed: not is_destroyed
		do
			Result := implementation.intersect (a_region)
		ensure
			result_not_void: Result /= Void
		end

	union, infix "or", infix "|" (a_region: EV_REGION): EV_REGION
			-- Union of `a_region' with `Current'.
		require
			a_region_valid: a_region /= Void and then not a_region.is_destroyed
			not_is_destroyed: not is_destroyed
		do
			Result := implementation.union (a_region)
		ensure
			result_not_void: Result /= Void
		end

	subtract, infix "-" (a_region: EV_REGION): EV_REGION
			-- `a_region' subtracted from `Current'.
		require
			a_region_valid: a_region /= Void and then not a_region.is_destroyed
			not_is_destroyed: not is_destroyed
		do
			Result := implementation.subtract (a_region)
		ensure
			result_not_void: Result /= Void
		end

	exclusive_or, infix "xor" (a_region: EV_REGION): EV_REGION
			-- Exclusive or `a_region' with `Current'.
		require
			a_region_valid: a_region /= Void and then not a_region.is_destroyed
			not_is_destroyed: not is_destroyed
		do
			Result := implementation.exclusive_or (a_region)
		ensure
			result_not_void: Result /= Void
		end

feature -- Duplication

	copy (other: like Current)
			-- Update `Current' to have same appearance as `other'.
			-- (So as to satisfy `is_equal'.)
		do
			if implementation = Void then
				default_create
			end
			if not other.is_destroyed then
				implementation.copy_region (other)
			else
				implementation.destroy
			end
		end

feature -- Comparison

	is_equal (other: like Current): BOOLEAN
			-- Does `other' have the same appearance as `Current'.
		do
			if other /= Void then
				if other.is_destroyed and then is_destroyed then
					Result := True
				else
					Result := implementation.is_region_equal (other)
				end
			end
		end

feature {NONE} -- Implementation

	create_implementation
			-- Create implementation.
		do
			create {EV_REGION_IMP} implementation.make (Current)
		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	implementation: EV_REGION_I;
			-- Implementation interface.

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end

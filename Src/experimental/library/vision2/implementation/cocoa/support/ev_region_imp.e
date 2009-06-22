note
	description: "Cocoa Implementation for EV_REGION"
	author: "Daniel Furrer"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_REGION_IMP

inherit
	EV_REGION_I

create
	make

feature {NONE} -- Initialization

	old_make (an_interface: EV_REGION)
			-- Creation method.	
		do
			assign_interface (an_interface)
		end

	make
			-- Initialize `Current'.
		do
			set_is_initialized (True)
		end

feature -- Element Change

	set_rectangle (a_rectangle: EV_RECTANGLE)
			-- Set region to area a_rectangle.
		do
		end

	offset (a_horizontal_offset, a_vertical_offset: INTEGER)
			-- Move `Current' a `a_horizontal_offset' horizontally and `a_vertical_offset' vertically.
		do
		end

feature -- Access

	intersect (a_region: EV_REGION): EV_REGION
			-- Intersect `a_region' with `Current'.
		do
			-- NSRect NSIntersectionRect(NSRect aRect, NSRect bRect)
			create Result
		end

	union (a_region: EV_REGION): EV_REGION
			-- Create a union `a_region' with `Current'.
		do
			-- NSRect NSUnionRect(NSRect aRect, NSRect bRect)
			create Result
		end

	subtract (a_region: EV_REGION): EV_REGION
			-- Subtract `a_region' from `Current'.
		do
			create Result
		end

	exclusive_or (a_region: EV_REGION): EV_REGION
			-- Exclusive or `a_region' with `Current'
		do
			create Result
		end

feature -- Duplication

	copy_region (other: EV_REGION)
			-- Update `Current' to be the same as `other'.
		do
		end

feature {EV_DRAWABLE_IMP, EV_REGION_IMP} -- Access

feature {NONE} -- Implementation

	is_region_equal (other: EV_REGION): BOOLEAN
			-- Does `other' have the same appearance as `Current'.
		do
			-- BOOL NSEqualRects(NSRect aRect, NSRect bRect)
			if attached other and then attached {EV_REGION_IMP} other.implementation as region_imp then
				Result := is_equal (region_imp)
			end
		end

	destroy
			-- Destroy `Current'.
		do
			set_is_in_destroy (True)
			set_is_destroyed (True)
		end

end

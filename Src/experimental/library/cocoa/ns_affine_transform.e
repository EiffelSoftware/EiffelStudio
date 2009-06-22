note
	description: "Summary description for {NS_AFFINE_TRANSFORM}."
	author: "Daniel Furrer"
	date: "$Date$"
	revision: "$Revision$"

-- TODO move to foundation (partially)

class
	NS_AFFINE_TRANSFORM

inherit
	NS_OBJECT

create
	make

feature {NONE} -- Creation

	make
			-- Creates and returns a new NSAffineTransform object initialized to the identity matrix.
		do
			make_from_pointer ({NS_AFFINE_TRANSFORM_API}.transform)
		end

feature -- Access

	translate_by_xy (x, y: REAL)
			-- Applies the specified translation factors to the receiver's transformation matrix.
		do
			{NS_AFFINE_TRANSFORM_API}.translate_by_xy (item, x, y)
		end

	scale_by_xy (x, y: REAL)
			-- Applies scaling factors to each axis of the receiver's transformation matrix.
		do
			{NS_AFFINE_TRANSFORM_API}.scale_by_xy (item, x, y)
		end

	concat
			-- Appends the receiver's matrix to the current transformation matrix stored in the current graphics context, replacing the current transformation matrix with the result.
		do
			{NS_AFFINE_TRANSFORM_API}.concat (item)
		end

end

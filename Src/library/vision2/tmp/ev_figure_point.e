<<<<<<< ev_figure_point.e
indexing
	description: "Point which has an origin and a validity criterion."
	author: "pascalf"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_FIGURE_POINT

inherit

	EV_POINT
		rename
			make as point_make
		end

	EV_NEW_FIGURE
		rename
			origin as local_origin
		redefine
			reference
		end

creation
	make,make_empty,make_default

feature -- Initialization

	make_empty,make_default is
			-- Create an 'empty' point.
		do
			set(0,0)
			valid := TRUE
		ensure
			valid: valid
		end

	make(x1,y1: INTEGER;new_parent: EV_FIGURE_GROUP) is
			-- Create Current.
			-- if 'pt' is Void, then we assume the coordinates
			-- are absolute.
		require
			figure_exists: new_parent /= Void
			figure_valid: new_parent.valid
		do
			set(x1,y1)
			parent_figure := new_parent
			valid := TRUE
		ensure
			valid: valid
			set: x=x1 and y=y1 and parent_figure = new_parent
		end

feature {EV_NEW_FIGURE} -- Settings

	compute_absolute_position(x1,y1: INTEGER) is
		-- Set the absolute coordinates of Current 
		-- with the origin of Current beeing establi 
		require
			possible: x1 >=0 and y1>=0
		do
			absolute_x := x1 + x
			absolute_y := y1 + y
		ensure
			set: absolute_x = x1 + x and absolute_y = y1 + y
		end

	compute_absolute_position_from_point(pt: EV_FIGURE_POINT) is
		-- Set the absolute coordinates of Current 
		-- with the origin of Current beeing establi 
		require
			possible: pt /= Void 
		do
			absolute_x := pt.absolute_x + x
			absolute_y := pt.absolute_y + y
		ensure
			set: absolute_x = pt.absolute_x + x and 
							  absolute_y = pt.absolute_y + y
		end

	remove is
			-- Remove Point.
		do
		end

feature -- Access

	absolute_position: EV_POINT is
			-- Absolute position of Current.
		do
			Create Result.set(absolute_x,absolute_y)
		ensure
			not_void: Result /= Void
		end

	center: EV_FIGURE_POINT is
			-- Center of Current
		do
			Result := Current
		end

	surround_box: EV_CLOSURE is
			-- Rectangle which encompasses the point defined
			-- by Current.
		do
			Create Result.make
			Result.enlarge(Current)
		end

feature {EV_NEW_FIGURE,EV_PROJECTION} -- Implementation

	reference: EV_FIGURE_POINT
		-- reference from which the origin is computed.

	absolute_x: INTEGER
		-- Absolute x of Current.

	absolute_y: INTEGER
		-- Absolute x of Current.

feature -- not used

	set_center(cent: like center) is 
		-- not used
		do 
		end

invariant
	origin_exists: origin /= Void
	figure_exists: parent_figure /= Void
end -- class EV_FIGURE_POINT
=======
>>>>>>> 1.1

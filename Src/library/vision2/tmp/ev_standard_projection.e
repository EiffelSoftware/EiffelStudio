<<<<<<< ev_standard_projection.e
indexing
	description: "Ancestor of standard Projections"
	author: "pascalf"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_STANDARD_PROJECTION

inherit
	EV_PROJECTION

	SINGLE_MATH

	MATH_CONST

feature -- Routines for drawing.

	draw_ellipse(an_ellipse: EV_ELLIPSE) is
			-- Draw ellipse 'an_ellipse'
		require
			not_void: an_ellipse /= Void
		local
			lint: EV_INTERIOR
			lpath: EV_PATH
			angle1,angle2: EV_ANGLE
			pt: EV_POINT
		do
				create angle1.make (0.0)
				create angle2.make (Pi * 2)
				Create pt.set(an_ellipse.center.x+an_ellipse.origin.x,
						an_ellipse.center.y+an_ellipse.origin.y)
				if an_ellipse.interior /= Void then
					create lint.make
					lint.get_drawing_attributes (device)
					an_ellipse.interior.set_drawing_attributes (device)
					device.fill_arc (pt,
						an_ellipse.radius1,
						an_ellipse.radius2,
						angle1, angle2,
						an_ellipse.orientation, 0)
					lint.set_drawing_attributes (device)
				end
				if an_ellipse.path /= Void then
					create lpath.make
					lpath.get_drawing_attributes (device)
					an_ellipse.path.set_drawing_attributes (device)
					device.draw_arc (pt, 
						an_ellipse.radius1,
						an_ellipse.radius2,
						angle1,angle2, 
						an_ellipse.orientation,-1)
					lpath.set_drawing_attributes (device)
				end
		end


	draw_polyline(a_polyline: EV_POLYLINE) is
			-- Draw the figure in `drawing'.
		require 
			not_void: a_polyline /= Void
		local
			p1, p2: EV_POINT
			keep_cursor: CURSOR
			lpath: EV_PATH
		do
				create lpath.make
				lpath.get_drawing_attributes (device)
				a_polyline.set_drawing_attributes (device)
				keep_cursor := a_polyline.cursor
				from
					a_polyline.start
					p1 := a_polyline.item
					a_polyline.forth
					p2 := a_polyline.item
				until
					a_polyline.off
				loop
					device.draw_segment (p1,p2)
					p1 := p2
					a_polyline.forth
					if not a_polyline.off then
						p2 := a_polyline.item
					end
				end
				a_polyline.go_to (keep_cursor)
				lpath.set_drawing_attributes (device)
		end

	draw_rectangle(a_rectangle: EV_RECTANGLE) is
			-- Draw the rectangle.
		require
			not_void: a_rectangle /= Void
		local
			lint: EV_INTERIOR
			lpath: EV_PATH
			red, blue: EV_COLOR
		do
			if a_rectangle.interior /= Void then
				create lint.make
				lint.get_drawing_attributes (device)
				a_rectangle.interior.set_drawing_attributes (device)
				device.fill_rectangle (a_rectangle.center,
					 a_rectangle.width,
					 a_rectangle.height,
					 a_rectangle.orientation)
				lint.set_drawing_attributes (device)
			end
			if a_rectangle.path /= Void then
				create lpath.make
				lpath.get_drawing_attributes (device)
				a_rectangle.path.set_drawing_attributes (device)
				!! red.make_rgb (255, 0, 0) 
				!! blue.make_rgb (0,0,255)
				device.set_foreground_color (red)
				device.set_background_color (blue)
				device.draw_rectangle (a_rectangle.center, 
					a_rectangle.width,
					a_rectangle.height,
					a_rectangle.orientation)
				lpath.set_drawing_attributes (device)
				end
		end

end -- class EV_STANDARD_PROJECTION
=======
>>>>>>> 1.1

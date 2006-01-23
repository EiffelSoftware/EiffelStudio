indexing
	description: "First example of utilisation"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "pascalf"
	date: "$Date$" 
	revision: "$Revision$"

class
	EXAMPLE1
 
inherit
	EXAMPLE_FRAME

feature -- drawing

	build is
			-- Build figures on the images.
		local
			pt1,pt2,pt3,pt4: EV_COORDINATES
			ang,ang2,ang3: EV_ANGLE
		do
			drawable.set_foreground_color(color(0,0,255))
			
			-- Draw a rectangle.
			Create pt1.set(100,100)
			Create ang.make_radians(0)
			drawable.draw_rectangle(pt1,40,50,ang)
			
			-- Draw an ellipse and fill it.
			Create pt1.set(300,300)
			drawable.fill_ellipse(pt1,30,20,ang)

			drawable.set_foreground_color(color(255,0,0))
	
			-- Draw a polyline
			Create pt1.set(300,10)
			Create pt2.set(280,5)
			Create pt3.set(300,40)
			Create pt4.set(300,10)
			drawable.draw_polyline(<<pt1,pt2,pt3,pt4>>,TRUE)

			-- Draw a point
			Create pt1.set(200,250)
			drawable.draw_point(pt1)

			--Fill a slice
			Create pt1.set(100,350)
			Create ang.make_radians(0)
			Create ang2.make_degrees(90)
			create ang3.make_radians(0)
			drawable.fill_arc(pt1,60,70,ang,ang2,ang3,1)

			
		end

feature -- Access
	
	suffix: STRING is "_1";

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"






end -- class EXAMPLE1

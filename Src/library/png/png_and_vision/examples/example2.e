indexing
	description: "Example2, which builds a spirale."
	author: "pascalf"
	date: "$Date$"
	revision: "$Revision$"

class
	EXAMPLE2

inherit
	EXAMPLE_FRAME

feature -- drawing

	build is
			-- Build figures on the images.
		local
			pt: EV_COORDINATES
			ang: EV_ANGLE
			i: INTEGER
			b: BOOLEAN
		do
			Create pt.set(200,200)
			Create ang.make_radians(0)
			from
				i := 1
			until
				i*20>200
			loop			
				-- Draw an ellipse and fill it.
				if b then
					drawable.set_foreground_color(color(255,0,0))
				else
					drawable.set_foreground_color(color(0,0,255))
				end
				drawable.fill_ellipse(pt,(200-i*20),(220-i*20),ang)
				b:= not b
				i := i + 1
			end
		end

feature -- Access
	
	suffix: STRING is "_2"

end -- class EXAMPLE2

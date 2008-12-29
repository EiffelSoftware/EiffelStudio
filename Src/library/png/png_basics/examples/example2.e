note
	description: "Example2, which builds a spirale."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "pascalf"
	date: "$Date$"
	revision: "$Revision$"

class
	EXAMPLE2

inherit
	EXAMPLE_FRAME

feature -- drawing

	build
			-- Build figures on the images.
		local
			pt: EV_COORDINATES
			ang: EV_ANGLE
			i: INTEGER
			b: BOOLEAN
		do
			from
				i := 1
			until
				i*20>200
			loop			
				-- Draw an ellipse and fill it.
				if b then
					drawable.set_foreground_color(255,0,0)
				else
					drawable.set_foreground_color(0,0,255)
				end
				drawable.fill_ellipse(200,200,(200-i*20),(220-i*20))
				b:= not b
				i := i + 1
			end
		end

feature -- Access
	
	suffix: STRING = "_2";

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






end -- class EXAMPLE2

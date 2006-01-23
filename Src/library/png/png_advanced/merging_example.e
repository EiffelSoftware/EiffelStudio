indexing
	description: "Example which shows some application of the merging facilities."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "pascalf"
	date: "$Date$"
	revision: "$Revision$"

class
	MERGING_EXAMPLE
 
	create
	make

feature -- Init
	make is 
		local
			fn: FILE_NAME	
		do 
			Create im1.make(400,400)
			im1.set_background_color(200,30,100)
			Create ellipse1.make(im1,200,200,150,100)
			ellipse1.set_color(0,255,0)
			ellipse1.draw_plain_ellipse (255,0,0)

			Create im2.make(400,400)
			im2.set_background_color(40,0,130)
			Create ellipse2.make(im2,150,200,150,100)
			ellipse2.set_color(0,255,255)
			ellipse2.draw_plain_ellipse (255,255,0)

			Create merger
			merger.merge(im1,im2,50)

			Create fn.make_from_string("d:\PNG\merge.png")
			im2.save_to_file(fn)
			
		end

feature -- Implementation

	im1,im2: GD_IMAGE

	ellipse1,ellipse2: GD_ELLIPSE

	merger: GD_COPIER;

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






end -- class MERGING_EXAMPLE

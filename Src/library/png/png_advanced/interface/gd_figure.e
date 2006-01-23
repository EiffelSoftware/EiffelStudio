indexing
	description: "figure"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "pascalf"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	GD_FIGURE

feature -- Initialization

	initialize_figure(im: like image) is
		-- Initializatize figure
		require
			not_void: im /= Void
		do
			image := im
			image.extend(Current)
		ensure
			set: image = im
			incremented: image.count = old image.count + 1
		end
			
			
feature -- Drawings

	draw_border is
		deferred
		end

feature -- Settings

	set_x_y(new_x,new_y: INTEGER) is
			-- Set position of Current to
			-- (new_x,new_y).
		require
			within_image:coordinates_within_the_image(new_x,new_y)
		do
			x := new_x
			y := new_y
		end

feature -- Access

	x,y: INTEGER
		-- Position of Current figure.

feature -- Validity of use for Current Image.

	coordinates_within_the_image(new_x,new_y: INTEGER): BOOLEAN is
			-- Does a point (x,y ) within the boundaries ?
		do
			Result := (gdImageBoundsSafe(image.image,new_x,new_y)=1)
		end

feature {NONE} -- Implementation

	image: GD_IMAGE
		-- Image Current is relative to.

feature {NONE} -- Externals

	gdImageBoundsSafe(p: POINTER; new_x,new_y: INTEGER):INTEGER is
		external
			"c"
		alias
			"gdImageBoundsSafe"
		end

invariant
	image_exists: image /=Void	
	center_within_image:coordinates_within_the_image(x,y)
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






end -- class GD_FIGURE

note
	description: "Frame for building example."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "pascalf"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EXAMPLE_FRAME

feature -- drawing

	process
			-- Create, build and save an image
			-- under the PNG fromat.
		do
			create_image
			build
			save
		end

	create_image
			-- Create the image.
		do
			Create drawable.make(400,400)
			drawable.set_background_color(color(0,255,0))
		end

	save
			-- Save the image.
		local
			fi: FILE_NAME
		do
			Create fi.make_from_string("d:\PNG\example"+suffix+".png")
			drawable.save_to_file(fi)
		end

	build deferred end
		-- Build the image.

feature -- Access

	drawable: EV_PNG_AREA
		-- Drawable area.

	suffix: STRING deferred end
		-- Suffix corresponding to current example

	color(r,g,b: INTEGER): EV_COLOR
			-- Color corresponding to the rgb 3-uplet 'r', 'g', and 'b'
		do
			Create Result.make_rgb(r,g,b)
		end

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






end -- class EXAMPLE_FRAME

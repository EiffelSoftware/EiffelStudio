indexing
	description: "Frame for building example."
	author: "pascalf"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EXAMPLE_FRAME

feature -- drawing

	process is
			-- Create, build and save an image
			-- under the PNG fromat.
		do
			create_image
			build
			save
		end

	create_image is
			-- Create the image.
		do
			Create drawable.make(400,400)
			drawable.set_background_color(color(0,255,0))
		end

	save is
			-- Save the image.
		local
			fi: FILE_NAME
		do
			Create fi.make_from_string("d:\PNG\example"+suffix+".png")
			drawable.save_to_file(fi)
		end

	build is deferred end
		-- Build the image.

feature -- Access

	drawable: EV_PNG_AREA
		-- Drawable area.

	suffix: STRING is deferred end
		-- Suffix corresponding to current example

	color(r,g,b: INTEGER): EV_COLOR is
			-- Color corresponding to the rgb 3-uplet 'r', 'g', and 'b'
		do
			Create Result.make_rgb(r,g,b)
		end

end -- class EXAMPLE_FRAME

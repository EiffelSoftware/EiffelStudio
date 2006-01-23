indexing
	description: "GD Image"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "pascalf"
	date: "$Date$"
	revision: "$Revision$"

class
	GD_IMAGE

inherit
	DISPOSABLE

	LINKED_LIST[GD_FIGURE]
		rename
			make as list_make
		end

	GD_COLOR_PROPERTIES

create
	make,make_from_file

feature -- Initialization

	make(w,h: INTEGER) is
			-- Initialize the image with
			-- 'w' as width and 'h' as height.
		require
			width_possible: w > 0
			height_possible: h > 0
		do
			image := GdImageCreate (w,h)
			list_make
		end

	make_from_file (file_name: FILE_NAME) is
			-- Load a PNG file, and store it into 'image'
		require
			file_name_possible: file_name /= Void and then file_name.is_valid
		local
			file: RAW_FILE
			fd_file: POINTER
		do
			Create file.make_open_read(file_name)
			fd_file := file.file_pointer
			image := gdImageCreateFromPng(fd_file)
			file.close
			background_color_allocated := TRUE
			list_make
		end

feature -- Settings

	set_interlaced(b: BOOLEAN) is
		-- If 'b', then set Current as interlaced image,
		-- else make it linear ( default ).
	local
		i: INTEGER
	do
		if b then
			i := 1
		end
		gdImageInterlace(image, i)
	end

feature -- Basic Operations

	save_to_file (file_name: FILE_NAME) is
			-- Save Current to file.
		require
			file_name_possible: file_name /= Void and then file_name.is_valid
		local
			file: RAW_FILE
			fd_file: POINTER
		do
			create file.make_create_read_write(file_name)
			file.open_write
			fd_file := file.file_pointer
			GdImagePng(image, fd_file)
			file.close
		end

feature -- Access

	width: INTEGER is
			-- Width of Current.
		do
			Result := c_get_width ( image )
		end		

	height: INTEGER is
			-- Width of Current
		do
			Result := c_get_height ( image )
		end

feature -- Validity status.

	coordinates_within_the_image(x,y: INTEGER): BOOLEAN is
			-- Does a point (x,y ) within the boundaries ?
		do
			Result := (gdImageBoundsSafe(image,x,y)=1)
		end
	
	points_within_the_image(array: ARRAY [TUPLE[INTEGER,INTEGER]]): BOOLEAN is
			-- Are all the points of 'array' within the image ?
		require
			array_not_empty: array /= Void and then array.count>0
		local
			i: INTEGER
			gp: TUPLE[INTEGER,INTEGER]
		do
			from
				i := 1
				Result := TRUE
			until
				i >= array.count or not Result
			loop
				gp := array.item (i)
				Result := coordinates_within_the_image(gp.integer_item(1), gp.integer_item(2) ) 
				i := i+1	
			end
		end

feature -- Implementation

	image: POINTER
		-- Pointer on the image structure.

feature {NONE} -- Memory 

	dispose is
			-- Remove C_struture associated with Current Image.
		do
			c_destroy_image(image)
		end

feature {NONE} -- Externals

	GdImageCreate (i,j: INTEGER):POINTER is
		external
			"C"
		alias
			"gdImageCreate"
		end

	c_destroy_image (p: POINTER)is
		external
			"C"
		alias
			"gdImageDestroy"
		end

	gdImageCreateFromPng (p: POINTER): POINTER is
		external
			"C"
		alias
			"gdImageCreateFromPng"
		end

	gdImagePng(p: POINTER; f: POINTER) is
		external
			"c"
		alias
			"gdImagePng"
		end

	gdImageInterlace(p: POINTER; i: INTEGER) is
		external
			"c"
		alias
			"gdImageInterlace"
		end

	gdImageBoundsSafe(p: POINTER; x,y: INTEGER):INTEGER is
		external
			"c"
		alias
			"gdImageBoundsSafe"
		end

	c_get_height (p: POINTER ): INTEGER is
		external
			"c[macro <eiffel_png.h>]"
		end

	c_get_width (p: POINTER ): INTEGER is
		external
			"c[macro <eiffel_png.h>]"
		end

invariant
	image_exists: image /= DEFAULT_POINTER
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






end -- class GD_IMAGE

indexing
	description:	"[
		Objects that provide access to information regarding pixmap location.
		This is only required for compilation purposes for the files copied from
		EiffelBuild. Nothing that has access to `png_location' uses it for anything.
					]"
	date: "$Date$"
	revision: "$Revision$"

class
	GB_SHARED_PIXMAPS

feature -- Access

	png_location: STRING is
			-- PNG location of images. Not used in the tour, but required
			-- for compilation of the CONSTANTS file.
		do
		end

end -- class GB_SHARED_PIXMAPS

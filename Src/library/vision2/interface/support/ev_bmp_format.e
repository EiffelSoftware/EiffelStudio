indexing
	description:
		""
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_BMP_FORMAT

inherit
	EV_GRAPHICAL_FORMAT

feature {EV_PIXMAP_I} -- Access

	file_extension: STRING is
			-- Three character file extension associated with format.
		do
			Result := "bmp"
		end

	save (raw_image_data: EV_RAW_IMAGE_DATA; a_filename: FILE_NAME) is

		do
			-- Implemented in pixmap implementation
		end

end -- class EV_BMP_FORMAT

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
--| Copyright (C) 1985-2004 Eiffel Software. All rights reserved.
--| Duplication and distribution prohibited.  May be used only with
--| ISE Eiffel, under terms of user license.
--| Contact Eiffel Software for any other use.
--|
--| Interactive Software Engineering Inc.
--| dba Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Contact us at: http://www.eiffel.com/general/email.html
--| Customer support: http://support.eiffel.com
--| For latest info on our award winning products, visit:
--|	http://www.eiffel.com
--|----------------------------------------------------------------


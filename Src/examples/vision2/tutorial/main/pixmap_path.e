indexing
	description: "A class for the tutorial example that%
			%gives a path for the bitmaps."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	PIXMAP_PATH

inherit
	EXECUTION_ENVIRONMENT

feature -- Access

	pixmap_path (name: STRING): STRING is
			-- A pixmap
		do
			Result := "d:\Eiffel45\examples\vision2\tutorial"
--			Result := current_working_directory
			Result.append ("\bmp\")
			Result.append (name)
		end

end -- class PIXMAP_PATH

--|----------------------------------------------------------------
--| EiffelVision Tutorial: Example for the ISE EiffelVision library.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

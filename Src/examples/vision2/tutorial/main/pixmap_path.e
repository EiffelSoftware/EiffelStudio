indexing
	description: "A class for the tutorial example that%
			%gives a path for the bitmaps."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	PIXMAP_PATH

feature -- Access

	pixmap_path (name: STRING): STRING is
			-- Return the full name of the given pixmap of EiffelBench.
		local
			env: EXECUTION_ENVIRONMENT
		do
			create env
			Result := env.get ("$EIFFEL4")
--			Result := "d:\Eiffel45"
			Result.append_character (Operating_environment.directory_separator)
			Result.append ("bench")
			Result.append_character (Operating_environment.directory_separator)
			Result.append ("bitmaps")
			Result.append_character (Operating_environment.directory_separator)
			Result.append (pixmap_extension)
			Result.append_character (Operating_environment.directory_separator)
			Result.append (name)
			Result.append (".")
			Result.append (pixmap_extension)
		end

feature {NONE} -- Implementation

	pixmap_extension: STRING is
		once
			if Operating_environment.directory_separator = '\' then
				Result := "bmp"
			else
				Result := "xpm"
			end
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

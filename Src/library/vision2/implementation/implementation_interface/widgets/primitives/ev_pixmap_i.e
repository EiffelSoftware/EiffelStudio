indexing

	description: "EiffelVision pixmap, implementation interface"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_PIXMAP_I 

inherit
	EV_DRAWABLE_I

feature {NONE} -- Initialization

	make (par: EV_PIXMAP_CONTAINER) is
			-- Create a pixmap implementation.
		deferred
		end	

feature -- Meassurement

	width: INTEGER is
			-- width of the pixmap
		deferred
		end

	height: INTEGER is
			-- height of the pixmap
		deferred
		end

feature -- Element change
	
	read_from_file (file_name: STRING) is
			-- Load the pixmap described in 'file_name'. 
			-- If the file does not exist or it is in a 
			-- wrong format, an exception is raised.
		require
			file_name_exists: file_name /= Void
		deferred
		end	
	
end -- class EV_PIXMAP_I

--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
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


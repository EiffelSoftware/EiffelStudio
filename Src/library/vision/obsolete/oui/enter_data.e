indexing

	description:
		"Information given by EiffelVision when the pointer enters a window. %
		%X event associated: `EnterNotify'";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class ENTER_DATA 

obsolete
	"Use class CONTEXT_DATA instead."

inherit

	CONTEXT_DATA
		undefine
			make
		end

create

	make

feature {NONE}

	absolute_x: INTEGER;
            -- Absolute horizontal position of the point of entry of the
			-- pointer

    absolute_y: INTEGER;
            -- Absolute vertical position of the point of entry of the
			-- pointer

    relative_x: INTEGER;
            -- Horizontal position of the point of entry of the pointer
			-- relative to the receiving window

    relative_y: INTEGER;
            -- Vertical position of the point of entry of the pointer relative
			-- to the receiving window

feature 

	make (a_widget: WIDGET) is
			-- Create a context_data for `EnterNotify' event.
		do
			widget := a_widget
		end 

end -- class ENTER_DATA

--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
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


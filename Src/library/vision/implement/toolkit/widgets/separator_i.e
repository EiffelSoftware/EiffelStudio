indexing

	description: "General separator implementation";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

deferred class

	SEPARATOR_I 

inherit

	PRIMITIVE_I
	
feature -- Status report

	is_horizontal: BOOLEAN is
			-- Is separator oriented horizontal?
		deferred
		end;

feature -- Status setting

	set_double_dashed_line is
			-- Set separator display to be double dashed line.
		deferred
		end;

	set_double_line is
			-- Set separator display to be double line.
		deferred
		end;

	set_horizontal (flag: BOOLEAN) is
			-- Set orientation of the scale to horizontal if `flag',
			-- to vertical otherwise.
		deferred
		ensure
			value_correctly_set: is_horizontal = flag
		end;

	set_no_line is
			-- Make current separator invisible.
		deferred
		end;

	set_single_dashed_line is
			-- Set separator display to be single dashed line.
		deferred
		end;

	set_single_line is
			-- Set separator display to be single line.
		deferred
		end

end -- class SEPARATOR_I



--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------


indexing
	description: "A debuggable NAG_ERROR"

class FAKE_NAG_ERROR inherit
	NAG_ERROR
		redefine
			failed, last_error_message, last_error_aux,
			last_error_code
		end;

feature
	failed: BOOLEAN is True;

	set (m: STRING; j, k: INTEGER) is
			-- set the error fields.
		do
			last_error_message := deep_clone(m);
			last_error_code := j;
			last_error_aux := k;
		end;

	last_error_message: STRING;
	last_error_code: INTEGER;
	last_error_aux: INTEGER;

end -- class FAKE_NAG_ERROR
--|----------------------------------------------------------------
--| EiffelMath: library of reusable components for ISE Eiffel.
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


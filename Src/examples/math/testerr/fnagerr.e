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
--| EiffelMath: library of reusable components for numerical
--| computation ISE Eiffel 3.
--| Copyright (C) 1995, Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|----------------------------------------------------------------

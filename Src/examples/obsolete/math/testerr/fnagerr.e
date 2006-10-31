indexing
	description: "A debuggable NAG_ERROR"
	legal: "See notice at end of class."
	status: "See notice at end of class."

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
	last_error_aux: INTEGER;;

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


end -- class FAKE_NAG_ERROR

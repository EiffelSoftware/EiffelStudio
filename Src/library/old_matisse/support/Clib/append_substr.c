/*
--|----------------------------------------------------------------
--| EiffelStore: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1995, Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <eiffel@eiffel.com>
--|----------------------------------------------------------------

	date: "$Date$";
	revision: "$Revision$";
	product: "EiffelStore";
	database: "All"
*/

extern void * memcpy ();

void c_append_substring (a1, a2, c, n1, n2)
	char * a1, * a2;
	int c, n1, n2;
{
	memcpy (a1 + c, a2 + n1 - 1, n2 - n1 + 1);
}

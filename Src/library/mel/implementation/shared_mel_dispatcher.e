indexing

	description: 
		"Shared instance of dispatcher for MEL";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	SHARED_MEL_DISPATCHER

feature {NONE} -- Access

	Mel_dispatcher: MEL_DISPATCHER is
			-- MEL dispatcher manager
		once
			!! Result.make
		ensure
			valid_result: Result /= void
		end;

end -- class SHARED_MEL_DISPATCHER

--|-----------------------------------------------------------------------
--| Motif Eiffel Library: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1996, Interactive Software Engineering, Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Information e-mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|-----------------------------------------------------------------------

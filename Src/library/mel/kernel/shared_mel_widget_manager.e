indexing

	description: 
		"Shared instance of widget manager for MEL. %
		%It is a widget manager which is able to retrieve an Eiffel %
        %object (MEL_OBJECT) from a `screen_object' or a `window' object.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	SHARED_MEL_WIDGET_MANAGER

feature -- Access

	Mel_widgets: MEL_WIDGET_MANAGER is
			-- MEL widget manager
		once
			!! Result.make
		ensure
			valid_result: Result /= void
		end;

end -- class SHARED_MEL_WIDGET_MANAGER

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

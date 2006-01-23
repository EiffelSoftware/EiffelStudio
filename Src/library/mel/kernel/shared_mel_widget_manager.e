indexing

	description: 
		"Shared instance of widget manager for MEL. %
		%It is a widget manager which is able to retrieve an Eiffel %
        %object (MEL_OBJECT) from a `screen_object' or a `window' object."
	legal: "See notice at end of class.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	SHARED_MEL_WIDGET_MANAGER

feature -- Access

	Mel_widgets: MEL_WIDGET_MANAGER is
			-- MEL widget manager
		once
			create Result.make
		ensure
			valid_result: Result /= void
		end;

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




end -- class SHARED_MEL_WIDGET_MANAGER



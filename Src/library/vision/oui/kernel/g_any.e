indexing

	description: "Parent of any oui graphic class"
	legal: "See notice at end of class.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class

	G_ANY

feature {NONE} -- Initialization

	init_toolkit: like toolkit is
			-- Init toolkit to desired implementation.
		do
		end;

feature -- Access

	toolkit: TOOLKIT is
			-- Toolkit of implementation in the environment desired
		once
			Result := init_toolkit
		ensure
			toolkit_exists: Result /= Void
		end 

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




end -- G_ANY


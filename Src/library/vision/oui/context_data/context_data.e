indexing

	description: "Information given by EiffelVision when a callback is triggered"
	legal: "See notice at end of class.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class

	CONTEXT_DATA 

create

	make

feature -- Initialization

	make (a_widget: WIDGET) is
			-- Create a general context_data.
		do
			widget := a_widget
		end
feature -- Access

	widget: WIDGET;;
			-- The widget who triggered the callback

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




end -- CONTEXT_DATA


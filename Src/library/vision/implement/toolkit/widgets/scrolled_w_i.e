indexing

	description: "General scrolled window implementation"
	legal: "See notice at end of class.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

deferred class

	SCROLLED_W_I 

inherit

	MANAGER_I
	
feature 

	working_area: WIDGET is
			-- Working area of window which will
			-- be moved using scrollbars
		deferred
		end;

	set_working_area (a_widget: WIDGET) is
			-- Set work area of windon to `a_widget'.
		require
			not_a_widget_void: a_widget /= Void
		deferred
		ensure
			working_area = a_widget
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




end -- class SCROLLED_W_I


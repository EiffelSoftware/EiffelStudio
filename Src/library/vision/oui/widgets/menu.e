indexing

	description: "General notion of menu"
	legal: "See notice at end of class.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

deferred class

	MENU  

inherit

	MANAGER
		redefine
			implementation
		end
	
feature -- Access

	title: STRING is
			-- Title of menu
		require
			exists: not destroyed;
		do
			Result:= implementation.title
		end; 

feature -- Element change

	set_title (a_title: STRING) is
			-- Set menu title to `a_title'.
		require
			exists: not destroyed;
			valid_title: a_title /= Void
		do
			implementation.set_title (a_title)
		end;

	remove_title is
			-- Remove current menu title if any.
		require
			exists: not destroyed;
		do
			implementation.remove_title
		end

feature {G_ANY, G_ANY_I, WIDGET_I, TOOLKIT} -- Implementation

	implementation: MENU_I;;
			-- Implementation of menu

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




end -- class MENU


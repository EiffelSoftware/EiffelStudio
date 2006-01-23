indexing

	description: "General menu implementation"
	legal: "See notice at end of class.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

deferred class

	MENU_I 

inherit

	MANAGER_I
	
feature -- Access

	title: STRING is
			-- Title of menu
		deferred
		end;

feature -- Element change

	set_title (a_title: STRING) is
			-- Set menu title to `a_title'.
		require
			not_title_void: a_title /= Void
		deferred
		end;

feature -- Removal

	remove_title is
			-- Remove current menu title if any.
		deferred
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




end -- class MENU_I


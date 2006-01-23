indexing

	description:
		"Menu which is part of a menu system. % 
		%It has to be attached to a menu button which will make appear %
		%it when armed"
	legal: "See notice at end of class.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

deferred class

	PULLDOWN 

inherit

	MENU
		redefine
			implementation
		end
	
feature 

	button: BUTTON is
			-- button 
		deferred
		end;
	
feature -- Access

	text: STRING is
			-- Label of menu button
		require
			exists: not destroyed
		do
			Result := implementation.text
		end;

feature -- Status setting

	allow_recompute_size is
		require
			exists: not destroyed
		do
			implementation.allow_recompute_size;
		end;

	forbid_recompute_size is
		require
			exists: not destroyed
		do
			implementation.forbid_recompute_size;
		end;

feature -- Element change

	set_text (a_text: STRING) is
			-- Set button label to `a_text'.
		require
			exists: not destroyed
		do
			implementation.set_text(a_text)
		end;

feature {G_ANY, G_ANY_I, WIDGET_I, TOOLKIT} -- Implementation

	implementation: PULLDOWN_I;;
			-- Implementation of pulldown menu
	
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




end -- class PULLDOWN


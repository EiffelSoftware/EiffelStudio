indexing

	description: "Shell is the base class for all shell widgets"
	legal: "See notice at end of class.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

deferred class

	SHELL 

inherit

	COMPOSITE
		export
			{NONE} set_managed, manage, unmanage, managed
		redefine 
			implementation
		end
	
feature -- Status report

	is_popup_shell: BOOLEAN is
		do
		end;

feature -- Status setting

	set_override (flag: BOOLEAN) is
		require
			exists: not destroyed
		do
			implementation.set_override (flag);
		end;

	allow_resize is
			-- Allow geometry resize to all geometry requests
			-- from its children.
		require
			exists: not destroyed
		do
			implementation.allow_resize
		end;

	forbid_resize is
			-- Forbid geometry resize to all geometry requests
			-- from its children.
		require
			exists: not destroyed
		do
			implementation.forbid_resize
		end;

feature {G_ANY, G_ANY_I, WIDGET_I, TOOLKIT} -- Implementation

	implementation: SHELL_I;;
			-- Implementation of shell

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




end -- class SHELL


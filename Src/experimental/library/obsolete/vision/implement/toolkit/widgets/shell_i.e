note

	description: "General shell implementation"
	legal: "See notice at end of class.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

deferred class

	SHELL_I 

inherit

	COMPOSITE_I
	
feature -- Status setting

	set_override (flag: BOOLEAN)
		deferred
		end;

	allow_resize
			-- Allow geometry resize to all geometry requests
			-- from its children.
		deferred
		end;

	forbid_resize
			-- Forbid geometry resize to all geometry requests
			-- from its children.
		deferred
		end;

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class SHELL_I


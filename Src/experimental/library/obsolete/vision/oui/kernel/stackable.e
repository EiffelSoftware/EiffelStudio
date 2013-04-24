note
	
	description: "Item that can be stacked on the screen"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

deferred class

	STACKABLE

feature -- Access

	screen_object: POINTER
			-- implementation of current widget
		require
			exists: not destroyed;
		do
			Result := implementation.screen_object;
		end;

	parent: COMPOSITE
		require
			exists: not destroyed;
		deferred
		end;

feature -- Status report

	is_stackable: BOOLEAN
		require
			exists: not destroyed;
		do
			Result := implementation.is_stackable;
		end

	destroyed: BOOLEAN
		deferred
		end;

	realized: BOOLEAN
		require
			exists: not destroyed;
		deferred
		end;

feature {NONE}

	implementation: STACKABLE_I;;

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




end -- STACKABLE


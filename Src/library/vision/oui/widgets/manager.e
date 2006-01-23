indexing

	description: "General parent widget"
	legal: "See notice at end of class.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

deferred class

	MANAGER 

inherit 

	COMPOSITE
		redefine
			implementation, parent
		end

	STACKABLE
		redefine
			implementation
		end;

feature -- Access

	parent: COMPOSITE is
			-- Parent of manager widget
		do
			Result ?= widget_manager.parent (Current)
		end;

	foreground_color: COLOR is
			-- Foreground color of manager widget
		require
			exists: not destroyed
		do
			Result:= implementation.foreground_color
		ensure
			valid_result: Result /= Void
		end;

feature -- Element change

	set_foreground_color (new_color: COLOR) is
			-- Set foreground color to `new_color'.
		require
			exists: not destroyed;
			color_not_void: new_color /= Void
		do
			implementation.set_foreground_color (new_color)
		ensure
			foreground_color = new_color
		end;

	set_foreground (new_color: COLOR) is
			-- Set foreground color to `new_color'.
		require
			exists: not destroyed;
			color_not_void: new_color /= Void
		do
			set_foreground_color (new_color)
		ensure
			foreground_color = new_color
		end 
	
	set_initial_input_focus (a_child: WIDGET) is
			-- Set child which will initially have input focus
		require
			exists: not destroyed;
			a_child_not_void: not (a_child = Void)
			is_a_child: children.has (a_child)
		do
			implementation.set_initial_input_focus (a_child)
		end

feature {G_ANY, G_ANY_I, WIDGET_I, TOOLKIT} -- Implementation

	implementation: MANAGER_I;
			-- Implementation of manager widget

invariant

	valid_parent: (not destroyed and then parent /= Void) implies depth > 0

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




end -- class MANAGER


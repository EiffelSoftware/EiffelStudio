indexing

	description: "General primitive implementation"
	legal: "See notice at end of class.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

deferred class

	PRIMITIVE_I 

inherit

	WIDGET_I;

	STACKABLE_I;

feature -- Access

	foreground_color: COLOR is
			-- Foreground color of primitive widget
		deferred
		ensure
			valid_result: Result /= Void
		end;

feature -- Status setting

	update_foreground_color is
		deferred
		end;

feature -- Element change

	set_foreground_color (new_color: COLOR) is
			-- Set foreground color to `new_color'.
		require
			valid_color: new_color /= Void
		deferred
		ensure
			foreground_set: foreground_color = new_color
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




end -- class PRIMITIVE_I


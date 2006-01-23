indexing

	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

deferred class

	SCREEN_I 

inherit

	DRAWING_I
	
feature 

	buttons: BUTTONS is
			-- Current state of the mouse buttons
		deferred
		ensure
			result_not_void: Result /= Void
		end;

	screen_object: POINTER is
			-- Screen object associated
		deferred
		end;

	widget_pointed: WIDGET is
			-- Widget currently pointed by the pointer
		deferred
		end;

	width: INTEGER is
			-- Width of screen (in pixel)
		deferred
		ensure
			width_large_enough: Result >= 0
		end;

	height: INTEGER is
			-- Height of screen (in pixel)
		deferred
		ensure
			height_large_enough: Result >= 0
		end;

	visible_width: INTEGER is
			-- Width of the visible part of the screen (in pixel)
		deferred
		ensure
			visible_width_large_enough: Result >= 0
		end;

	visible_height: INTEGER is
			-- Height of the visible part of the screen (in pixel)
		deferred
		ensure
			visible_height_large_enough: Result >= 0
		end;

	x: INTEGER is
			-- Current absolute horizontal coordinate of the mouse
		deferred
		ensure
			position_positive: Result >= 0;
			position_small_enough: Result < width
		end;

	y: INTEGER is
			-- Current absolute vertical coordinate of the mouse
		deferred
		ensure
			position_positive: Result >= 0;
			position_small_enough: Result < height
		end;

	is_valid: BOOLEAN is
			-- Is Current screen created?
		deferred
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




end -- class SCREEN_I


indexing

	description:
		"Screen. An object of this class must be created before any other %
		%operation of this screen. It will be parent of TOP_SHELL or BASE. %
		%The screen is also a drawing and thus can be used for a world. %
		%Warning: used screen as a drawing can be non-portable. It will work %
		%fin one X window version but the other platforms may not accept it";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class

	SCREEN 

inherit

	G_ANY
		export
			{NONE} all
		end;

	DRAWING

creation

	make

feature -- Initialization

	make (a_screen_name: STRING) is
			-- Create a screen specified by `a_screen_name'.
		do
			screen_name := clone (a_screen_name);
			!SCREEN_IMP! implementation.make (Current)
		end;

feature -- Access

	buttons: BUTTONS is
			-- Current state of the mouse buttons
		require
			exists: not destroyed
		do
			Result := implementation.buttons
		ensure
			result_exists: Result /= Void
		end;

	screen_name: STRING;
			-- Screen name

	widget_pointed: WIDGET is
			-- Widget currently pointed by the pointer
		require
			exists: not destroyed
		do
			Result := implementation.widget_pointed
		end;

feature -- Status report

	destroyed: BOOLEAN is
		do
			Result := implementation = Void
		end;

	is_valid: BOOLEAN is
			-- Is Current screen created?
		require
			exists: not destroyed
		do
			Result := implementation.is_valid
		end;

feature -- Measurement

	height: INTEGER is
			-- Height of screen (in pixel)
		require
			exists: not destroyed
		do
			Result := implementation.height
		ensure
			height_large_enough: Result >= 0
		end;

	width: INTEGER is
			-- Width of screen (in pixel)
		require
			exists: not destroyed
		do
			Result := implementation.width
		ensure
			width_large_enough: Result >= 0
		end;

	visible_height: INTEGER is
			-- Height of screen (in pixel)
		require
			exists: not destroyed
		do
			Result := implementation.visible_height
		ensure
			visible_height_large_enough: Result >= 0
		end;

	visible_width: INTEGER is
			-- Width of screen (in pixel)
		require
			exists: not destroyed
		do
			Result := implementation.visible_width
		ensure
			visible_width_large_enough: Result >= 0
		end;

	x: INTEGER is
			-- Current absolute horizontal coordinate of the mouse
		require
			exists: not destroyed
		do
			Result := implementation.x
		ensure
			position_positive: Result >= 0;
			position_small_enough: Result < width
		end;

	y: INTEGER is
			-- Current absolute vertical coordinate of the mouse
		require
			exists: not destroyed
		do
			Result := implementation.y
		ensure
			position_positive: Result >= 0;
			position_small_enough: Result < height
		end

feature -- Comparison

	same (other: like Current): BOOLEAN is
			-- Does the current screen and `other' representing the
			-- same screen ?
		require else
			exists: not destroyed;
			other_exists: other /= Void
		do
			Result := other.implementation = implementation
		end;

feature -- Implementation

	implementation: SCREEN_I;
			-- Implementation of current screen

end -- class SCREEN


--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------


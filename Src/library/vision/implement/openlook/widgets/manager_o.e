
-- MANAGER_O: implementation of manager

indexing

	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class MANAGER_O 

inherit

	MANAGER_R_O
		export
			{NONE} all
		end;

	COMPOSITE_O;
	
feature {COLOR_X}

	fg_color: COLOR;
			-- Color used for the foreground.
			-- Void after creation.

	foreground: COLOR is
			-- Color used for the foreground.
		local
			x_fg_color: COLOR_X
		do
			if fg_color = Void then
				!!fg_color.make;
				x_fg_color ?= fg_color.implementation;
				x_fg_color.set_pixel (xt_pixel (screen_object, "foreground"));
			end;
			Result := fg_color;
		ensure
			not (Result = Void)
		end;

	set_foreground (a_color: COLOR) is
			-- Set `foreground' to `a_color'.
		require
			a_color_exists: not (a_color = Void)
		
		local
			forg_name: ANY;
			color_implementation: COLOR_X
		do
			if not (fg_color = Void) then
				color_implementation ?= fg_color.implementation;
				color_implementation.remove_object (Current)
			end;
			fg_color := a_color;
			color_implementation ?= a_color.implementation;
			color_implementation.put_object (Current);
			forg_name := Oforeground.to_c;
			c_set_color (screen_object, color_implementation.pixel (screen), $forg_name)
		ensure
			foreground = a_color
		end; 

	update_foreground is
			-- Update the X color after a change inside the Eiffel color.
		
		local
			forg_name: ANY;
			color_implementation: COLOR_X
		do
			forg_name := Oforeground.to_c;
			color_implementation ?= foreground.implementation;
			c_set_color (screen_object, 
						color_implementation.pixel (screen), 
						$forg_name)
		end;

feature

    is_stackable: BOOLEAN is
        do
            Result := True;
        end;


end 


--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1989, 1991, 1993, 1994, Interactive Software
--|   Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <eiffel@eiffel.com>
--|----------------------------------------------------------------

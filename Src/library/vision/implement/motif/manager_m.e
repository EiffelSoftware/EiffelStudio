
-- MANAGER_M:

indexing

	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class MANAGER_M 

inherit

	COMPOSITE_M;

	MANAGER_R_M
		export
			{NONE} all
		end

feature 

	foreground_color: COLOR;
			-- Color used for the foreground_color

	set_foreground_color (a_color: COLOR) is
			-- Set `foreground_color' to `a_color'.
		require
			a_color_exists: not (a_color = Void)
		local
			color_implementation: COLOR_X;	
			ext_name: ANY
		do
			if not (foreground_color = Void) then
				color_implementation ?= foreground_color.implementation;
				color_implementation.remove_object (Current)
			end;
			foreground_color := a_color;
			color_implementation ?= a_color.implementation;
			color_implementation.put_object (Current);
			ext_name := Mforeground_color.to_c;
			c_set_color (screen_object, color_implementation.pixel (screen), $ext_name)
		ensure
			foreground_color = a_color
		end;

feature {COLOR_X}

	update_foreground_color is
			-- Update the X color after a change inside the Eiffel color.
		local
			ext_name: ANY;
			color_implementation: COLOR_X;	
		do
			ext_name := Mforeground_color.to_c;
			color_implementation ?= foreground_color.implementation;
			c_set_color (screen_object, color_implementation.pixel (screen), $ext_name)
		end


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

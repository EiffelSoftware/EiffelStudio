indexing

	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class TOP_O 

inherit

	TOP_R_O
		export
			{NONE} all
		end;

	SHELL_O
		redefine
			set_x, set_y, set_x_y
		end

feature {NONE}

	to_c_if_not_void (a_string: STRING): ANY is
            		-- `a_string.to_c' if not void, Void otherwise
        	do
            		if not (a_string = Void) then
                		Result := a_string.to_c
            		end
        	end;
	
feature 

	set_x (new_x: INTEGER) is
			-- Put at horizontal position `new_x'
		
		local
			ext_name: ANY;
		do
			if  not realized then
				xt_set_geometry (screen_object, new_x, y)
			else
				if shown then
					ext_name := Ox.to_c;		
					set_posit (screen_object, new_x, $ext_name)
				else
					xt_move_widget (screen_object, new_x, y)
				end
			end
		end;

	set_y (new_y: INTEGER) is
			-- Put at vertical position `new_y'
		
		local
			ext_name: ANY;
		do
			if  not realized then
				xt_set_geometry (screen_object, x, new_y)
			else
				if shown then
					ext_name := Oy.to_c;		
					set_posit (screen_object, new_y, $ext_name);
				else
					xt_move_widget (screen_object, x, new_y)
				end
			end
		end;

	set_x_y (new_x: INTEGER; new_y: INTEGER) is
			-- Put at horizontal position `new_x' and at
			-- vertical position `new_y'
		local
			ext_x, ext_y: ANY
		do
			if  not realized then
				xt_set_geometry (screen_object, new_x, new_y)
			else
				if shown then
					ext_x := Ox.to_c;
					ext_y := Oy.to_c;
					set_posit (screen_object, new_x, $ext_x);
					set_posit (screen_object, new_y, $ext_y);
					xt_move_widget (screen_object, new_x, new_y)
				else
					xt_move_widget (screen_object, new_x, new_y)
				end
			end;
		end;

	set_icon_name (a_name: STRING) is
			-- Set `icon_name' to `a_name'.
		require
			not_a_name_void: not (a_name = Void)
		do
			set_xt_string (screen_object, a_name, OiconName)
		end;

	icon_name: STRING is
			-- Short form of application name to be displayed
			-- by the window manager when application is iconified
		do
			Result := xt_string (screen_object, OiconName)
		end;

	set_iconic_state is
			-- Set start state of the application to be iconic.
		do
			set_xt_int (screen_object, OICONIC_STATE, OinitialState)
		end;

	set_normal_state is
			-- Set start state of the application to be normal.
		do
			set_xt_int (screen_object, ONORMAL_STATE, OinitialState)
		end;

	is_iconic_state: BOOLEAN is
			-- Does application start in iconic state?
		do
			Result := xt_boolean (screen_object, Oiconic)
		end

feature {NONE} -- External features

	xt_set_geometry (scr_obj: POINTER; new_x, new_y: INTEGER) is
		external
			"C"
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

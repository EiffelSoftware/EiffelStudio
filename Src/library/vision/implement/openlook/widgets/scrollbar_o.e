
indexing

	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class SCROLLBAR_O 

inherit

	SCROLLBAR_I;

	SCROLLBAR_R_O
		export
			{NONE} all
		end;

	SLIDER_O
		rename
			value as position,
			set_value as set_position
		export
			{NONE} all
		end

creation

	make

feature 

	make (a_scrollbar: SCROLLBAR) is
			-- Create a openlook scrollbar.
		
		local
			ext_name: ANY;
		do
			ext_name := a_scrollbar.identifier.to_c;		
			screen_object := create_vertical_scrollbar ($ext_name,
						a_scrollbar.parent.implementation.screen_object)
		end;

	initial_delay: INTEGER is
			-- Amount of time to wait (milliseconds) before starting
			-- continuous slider movement
		do
			Result := xt_int (screen_object, OinitialDelay)
		ensure then
			positive_value: Result > 0
		end;

	repeat_delay: INTEGER is
			-- Amount of time to wait (milliseconds) between subsequent
			-- slider movements after the initial delay
		do
			Result := xt_int (screen_object, OrepeatDelay)
		ensure then
			positive_delay: Result > 0
		end;

	set_initial_delay (new_delay: INTEGER) is
			-- Set the amount of time to wait (milliseconds) before
			-- starting continuous slider movement to `new_delay'.
		require else
			positive_delay: new_delay > 0
		do
			set_xt_int (screen_object, new_delay, OinitialDelay)
		ensure then
			initial_delay = new_delay
		end;

	set_repeat_delay (new_delay: INTEGER) is
			-- Set the amount of time to wait (milliseconds) between
			-- subsequent movements after the initial delay to 'new_delay'.
		require else
			positive_delay: new_delay > 0
		do
			set_xt_int (screen_object, new_delay, OrepeatDelay)
		ensure then
			repeat_delay = new_delay
		end; 

	set_slider_size (new_size: INTEGER) is
			-- Set size of slider to 'new_size'.
		do
			io.putstring ("*** set_slider_size not implemented for OpenLook \n");
		end; 

	slider_size: INTEGER is
			-- Size of slider.
		do
			io.putstring ("*** slider_size not implemented for OpenLook \n");
		end;

	set_horizontal (flag: BOOLEAN) is
            		-- Set orientation of the scrollbar to horizontal if `flag',
            		-- to vertical otherwise.
        	do
			if flag xor is_horizontal then
				screen_object := set_scrollbar_horizontal (screen_object, flag);
				is_horizontal := flag;
				update_event_handlers
			end
        	ensure then
            		value_correctly_set: is_horizontal = flag
        	end; -- set_horizontal
	
feature {NONE} -- External features

	create_vertical_scrollbar (name: POINTER; scr_obj: POINTER): POINTER is
		external
			"C"
		end; 

	create_horizontal_scrollbar (name: ANY; scr_obj: POINTER): POINTER is
		external
			"C"
		end; 

	set_scrollbar_horizontal (scr_obj: POINTER; flag: BOOLEAN): POINTER is
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

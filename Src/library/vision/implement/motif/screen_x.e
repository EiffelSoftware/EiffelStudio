indexing

	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class SCREEN_X

inherit

	W_MAN_GEN
		export
			{NONE} all
		end;

	G_ANY_I
		export
			{NONE} all
		end;

	DRAWING_X
		redefine
			height, 
			width, 
			screen_object 
		end;

	SCREEN_I
		export
			{NONE} all
		redefine
			height, width, screen_object
		end

creation

	make

feature {NONE}

	add_expose_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to execute when
			-- current area is exposed.
		require else
			not_a_command_void: not (a_command = Void)
		do
		end; 
	
feature 

	buttons: BUTTONS is
			-- Current state of the mouse buttons
		local
			i: INTEGER
		do
			!! Result.make (5);
			from
				i := 1
			until
				i > 5
			loop
				Result.put (x_query_button_pointer (display_pointer, i), i);
				i := i+1
			end
		ensure then
			not (Result = Void)
		end; 

	make (a_screen: SCREEN; application_class: STRING) is
			-- Create a screen
		local
			ext_name, ext_name_app: ANY;
			scr_name: STRING
			null_pointer: POINTER;
		do
			scr_name := a_screen.screen_name;
			if not scr_name.empty then
				ext_name := scr_name.to_c;
			end;
			if (application_class = Void) then
				display_pointer := xt_open_display ($ext_name, null_pointer)
			else
				ext_name_app := application_class.to_c;
				display_pointer := xt_open_display ($ext_name, $ext_name_app)
			end;
			if is_valid then
				create_gc
			end
		end;

	is_valid: BOOLEAN is
			-- Is Current screen created?
		local
			null_pointer: POINTER
		do
			Result := display_pointer /= null_pointer
		end

feature {NONE}

	height: INTEGER is
			-- Height of screen
		do
			Result := c_screen_height (display_pointer)
		end;

	remove_expose_action (a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' from the list of action to execute when
			-- current area is exposed.
		require else
			not_a_command_void: not (a_command = Void)
		do
		end;

	screen: SCREEN_I is
			-- Screen of widget
		do
			Result := Current
		ensure then
			not (Result = Void)
		end;

	screen_object: POINTER is
			-- Screen object associated
		do
			Result := display_pointer
		end;

	
feature 

	widget_pointed: WIDGET is
			-- Widget currently pointed by the pointer
		local
			last_widget_c: POINTER;
			widget_c: POINTER;
			void_pointer: POINTER;
			found: BOOLEAN;
			widget_list: LINKED_LIST [POINTER]
		do
			!! widget_list.make;
			from
				widget_c := x_query_window_pointer 
					(display_pointer, root_window_object)
			until
				widget_c = void_pointer
			loop
				last_widget_c := widget_c;
				widget_list.put_right (last_widget_c);
				widget_list.forth;
				widget_c := x_query_window_pointer (display_pointer, widget_c)
			end;
				-- Remove last item;
			if not widget_list.empty and then
				last_widget_c /= default_pointer 
			then
				widget_list.remove;
				last_widget_c := xt_window_to_widget (display_pointer, last_widget_c);
				from
					widget_manager.start;
				until	
					Result /= Void or widget_manager.after
				loop
					if last_widget_c 
						= widget_manager.item.implementation.screen_object
					then
						Result := widget_manager.item;
					end;
					widget_manager.forth
				end
				if Result = Void then
					--| Cannot find widget in widget_manager.
					--| This means that this widget was created on the
					--| C side and hasn't been recorded in the widget_manager.
					--| The best we can do is to get the parent that has
					--| been recorded in the w_manager.
					from
						widget_list.start
					until
						widget_list.after
					loop
						widget_c := xt_window_to_widget (display_pointer, 
							widget_list.item);
						if widget_c /= void_pointer then
							from
								found := false;
								widget_manager.start
							until
								found or widget_manager.after
							loop
								if widget_c = 
									widget_manager.item.implementation.screen_object
								then
									Result := widget_manager.item;
									found := true
								end;
								widget_manager.forth
							end;
						end;
						widget_list.forth
					end
				end
			end
		end;

feature {NONE}

	width: INTEGER is
			-- Width of screen
		do
			Result := c_screen_width (display_pointer)
		end;

	window_object: POINTER is
			-- X identifier of the drawable.
		do
			Result := root_window_object
		end;

feature 

	x: INTEGER is
			-- Current absolute horizontal coordinate of the mouse
		do
			Result := x_query_x_pointer (display_pointer)
		ensure then
			position_positive: Result >= 0;
			position_small_enough: Result < width
		end;

	y: INTEGER is
			-- Current absolute vertical coordinate of the mouse
		do
			Result := x_query_y_pointer (display_pointer)
		ensure then
			position_positive: Result >= 0;
			position_small_enough: Result < height
		end

feature {NONE} -- External features

	xt_window_to_widget (dspl_pointer, window: POINTER): POINTER is
		external
			"C"
		end;

	x_query_button_pointer (dspl_pointer: POINTER; pos: INTEGER): BOOLEAN is
		external
			"C"
		end;

	x_query_y_pointer (dspl_pointer: POINTER): INTEGER is
		external
			"C"
		end;

	x_query_x_pointer (dspl_pointer: POINTER): INTEGER is
		external
			"C"
		end;

	c_screen_width (dspl_pointer: POINTER): INTEGER is
		external
			"C"
		end;

	x_query_window_pointer (dspl_pointer, wndw: POINTER): POINTER is
		external
			"C"
		end;

	c_screen_height (dspl_pointer: POINTER): INTEGER is
		external
			"C"
		end;

	xt_open_display (name1, name2: POINTER): POINTER is
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

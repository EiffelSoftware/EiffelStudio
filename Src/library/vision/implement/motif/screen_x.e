indexing

	description: 
		"EiffelVision implementation of the X Display.";
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
			display_pointer
		end;

	SCREEN_I

	MEL_DISPLAY
		rename
			make as make_display,
			handle as display_pointer
		redefine
			display_pointer
		end	

creation

	make

feature {NONE} -- Initialization

	make (app_context: MEL_APPLICATION_CONTEXT; 
			a_screen: SCREEN; 
			application_class: STRING) is
			-- Create a screen
		do
			make_display (app_context, a_screen.screen_name, 
					application_class, application_class);
			if is_valid then
				create_gc
			end
		end;

feature -- Access

	display_pointer: POINTER;
			-- C pointer to X display

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
				Result.put (default_screen.query_button_pointer (i), i);
				i := i+1
			end
		ensure then
			not (Result = Void)
		end; 

	height: INTEGER is
			-- Height of screen
		do
			Result := default_screen.height
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
	
	widget_pointed: WIDGET is
			-- Widget currently pointed by the pointer
		local
			last_widget_c: POINTER;
			widget_c: POINTER;
			void_pointer: POINTER;
			found: BOOLEAN;
			widget_list: LINKED_LIST [POINTER]
		do
			widget_list := default_screen.widgets_pointed;
				-- Remove last item;
			if not widget_list.empty then
				widget_list.finish;
				last_widget_c := widget_list.item
			end;
			if last_widget_c /= default_pointer then
					-- Remove last one
				widget_list.remove;
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
						widget_c := widget_list.item;
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

	width: INTEGER is
			-- Width of screen
		do
			Result := default_screen.width
		end;

	window_object: POINTER is
			-- X identifier of the drawable.
		do
			--Result := default_screen.root
			Result := root_window_object
		end;

	x: INTEGER is
			-- Current absolute horizontal coordinate of the mouse
		do
			Result := default_screen.x
		end;

	y: INTEGER is
			-- Current absolute vertical coordinate of the mouse
		do
			Result := default_screen.y
		end

feature {NONE} -- Useless routines

	add_expose_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to execute when
			-- current area is exposed.
		do
		end; 

	remove_expose_action (a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' from the list of action to execute when
			-- current area is exposed.
		do
		end;

end -- class SCREEN_X

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
--| Customer support e-mail <support@eiffel.com>
--|----------------------------------------------------------------

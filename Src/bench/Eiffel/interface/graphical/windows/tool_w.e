indexing

	description:	
		"Ancestor of all tools in the workbench, providing %
					%dragging capabilities (transport)";
	date: "$Date$";
	revision: "$Revision$"

deferred class TOOL_W 

inherit

	NAMER;
	PAINTER;
	COMMAND_W
		redefine
			execute
		end;
	SHARED_TABS

feature -- Window Properties

	text_window: TEXT_WINDOW;
			-- Text window attached to Current

	tool_name: STRING is do end;
			-- Name of the tool

	realized: BOOLEAN is
			-- Is Current realized?
		deferred
		end;

	shown: BOOLEAN is
			-- Is Current shown on the screen?
		deferred
		end;

	title: STRING is
			-- The title of the window.
		deferred
		end;

	hole: HOLE is
			-- Hole associated with Current.
		do
		end;

	save_command: ICONED_COMMAND is
			-- The command to save the contents of Current.
		do
		end;

feature -- Window Implementation

	realize is
			-- Realize Current.
		deferred
		end;

	show is
			-- Show Current on the screen.
		deferred
		end;

	raise is
			-- Raise Current to the top.
		deferred
		end;

	destroy is
			-- Destroy the window.
		deferred
		end;

	hide is
			-- Hide Current from the screen.
		deferred
		end

	close_windows is
			-- Close the related windows.
			-- Used for popping down.
		deferred
		end;

feature -- Window settings

	set_default_position is
			-- Set the position to its default.
		deferred
		end;

	set_default_size is
			-- Set the size to its default.
		deferred
		end;

	set_icon_name (s: STRING) is
			-- Set `s' to the name shown just below the icon.
		deferred
		end;

	set_default_format is
			-- Default format of windows.
		do
			-- Do nothing
		end;

	set_title (s: STRING) is
			-- Set `title' to `s'.
		deferred
		end;

feature -- Update

	synchronize is
			-- Synchronize the contents of `text_window'.
		do
			text_window.synchronize
		end;

feature -- Pick and Throw Implementation

	receive (dropped: STONE) is
			-- Deal with element `dropped'.
		do
			text_window.receive (dropped)
		end;

	reset is
			-- Reset the window contents.
		do
			set_title (tool_name);
			set_default_format;
			set_default_size;
			text_window.clear_window;
			close_windows;
			if hole /= Void then
				hole.set_empty_symbol
			end;
		end;

	transport (element: like last_transported; a_text: TEXT_WINDOW;
				start_x, start_y: INTEGER) is
			-- Grab cursor and leave a track when the pointer
			-- moves on the screen.
		require
			tranported_not_void: element /= Void
		do
			if not transporting then
				transporting := True;
				origin_text := a_text;
				last_transported := element;
				x0 := start_x; y0 := start_y;
				x1 := start_x; y1 := start_y;
				draw_point (start_x, start_y);
				tell_type (element.stone_name);
				grab (cursor_table.item (element.stone_type))
			end;
		ensure
			origin_text = a_text;
			last_transported = element
		end;
	
feature {NONE} -- Implementation

	transporter_init is
			-- Initialize tranport stuff.
		local
			void_reference: ANY
		do
			!! abort;
			set_drawing (screen);
			set_logical_mode (10);
			set_subwindow_mode (1);
			add_pointer_motion_action (Current, Current);
--			add_button_click_action (3, Current, text_window);
			add_button_press_action (3, Current, text_window);
			add_button_release_action (1, Current, abort);
			add_button_release_action (2, Current, abort);
		end;
	
	raise_grabbed_popup is
			-- Raise popup windows with exclusive grab set.
		do
			if 
				last_warner /= Void and then 
				last_warner.is_popped_up and then
				last_warner.is_exclusive_grab 
			then
				last_warner.raise
			elseif 
				last_confirmer /= Void and then 
				last_confirmer.is_popped_up 
			then
				last_confirmer.raise
			elseif
				name_chooser.is_popped_up
			then
				name_chooser.raise
			else
				window_manager.class_win_mgr.raise_shell_popup
			end
		end;

feature {NONE} -- Execution Implementation

	execute (argument: ANY) is
			-- Leave a track when the pointer moves on the screen,
			-- ungrab when button is released
		local
			pointed_widget: WIDGET;
			pointed_text: TEXT_WINDOW;
			pointed_hole: HOLE;
			transported_hole: HOLE;
			transported_node: like last_transported;
		do
			if (argument = Current) then
				-- Motion action (when grabbed)
				if transporting then
					draw_segment (x0, y0, x1, y1);
					x1 := screen.x; y1 := screen.y;
					draw_segment (x0, y0, x1, y1)
				end;
			elseif (argument = abort) then
				-- The Pick and Throw is aborted.
				draw_segment (x0, y0, x1, y1);
				if origin_text /= Void then
					origin_text.deselect_all
				end;
				ungrab;
				clean_type;
				transporting := False;
			elseif argument /= Void then
				-- Finally, the user really threw the pebble
				-- in a hole.
				draw_segment (x0, y0, x1, y1);
				if origin_text /= Void then
					origin_text.deselect_all
				end;
				clean_type;
				transporting := False;
				ungrab;
				pointed_widget := screen.widget_pointed;
				pointed_hole ?= pointed_widget;
				pointed_text ?= pointed_widget;
				transported_node ?= last_transported;
				transported_hole ?= last_transported;
				if pointed_text /= Void then
					if
						transported_hole /= Void
							and then
						pointed_text.clickable
					then
						pointed_text.change_focus;
						transported_hole.receive
							(pointed_text.focus);
						pointed_text.deselect_all;
					elseif
						transported_node /= Void
					then
						pointed_text.receive
							(transported_node);
					end
				elseif pointed_hole /= Void then
					if transported_node /= Void then
						pointed_hole.receive
							(transported_node);
					end
				end;
			else
				-- Must be something, we cannot deal with.
				work (argument)
			end
		end;

	work (arg: ANY) is
			-- Not used.
		do
			-- Do Nothing
		end;

feature {NONE} -- Cursor grabbing

	grab (cursor: SCREEN_CURSOR) is
			-- Grab all events in the system.
		deferred
		end;

	ungrab is
			-- Stop grabbing all events in the system.
		deferred
		end;

feature {NONE} -- Properties

	abort: ANY;
			-- Argument passed when Pick and Throw is aborted.

	transporting: BOOLEAN;
			-- Is a stone currently being transported?

	origin_text: TEXT_WINDOW;
			-- Text window where the last transported element came
			-- from, Void if last transported was a hole
 
	last_transported: STONE;
			-- Last transported element, Void between grabs

	screen: SCREEN is
			-- The screen where Current is shown.
		deferred
		end;
 
	x0, y0, x1, y1: INTEGER;
			-- Initial and current pointer coordinates

feature -- Focus Label

	tell_type (a_type_name: STRING) is
			-- Display `a_type_name' in type teller.
		deferred
		end;
 
	clean_type is
			-- Clean what's said in the type teller window.
		deferred
		end;

feature {NONE} -- Action Adding

	add_pointer_motion_action (a_command: COMMAND; argument: ANY) is
			-- Add action for motion of the mouse pointer.
			-- Pass `argument' down to `a_command' when action
			-- occurs.
		deferred
		end;

	--add_button_click_action (number: INTEGER; a_command: COMMAND; argument: ANY) is
		--deferred
		--end;

	add_button_press_action (number: INTEGER; a_command: COMMAND;
				argument: ANY) is
			-- Add action for pressing a mouse button.
			-- Pass `argument' down to `a_command' when button
			-- `number' is pressed.
		deferred
		end;

	add_button_release_action (number: INTEGER; a_command: COMMAND;
				argument: ANY) is
			-- Add action for releasing a mouse button.
			-- Pass `argument' down to `a_command' when button
			-- `number' is released.
		deferred
		end;

end -- class TOOL_W

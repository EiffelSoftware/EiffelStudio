
-- Ancestor of all tools in the workbench, providing dragging capabilities (transport)

deferred class TOOL_W 

inherit

	NAMER;
	PAINTER;
	COMMAND_W
		redefine
			execute
		end

feature 

	text_window: TEXT_WINDOW;
			-- Text window attached to Current

feature {NONE}

	tool_name: STRING is do end;
			-- Name of the tool

feature -- Window features

	realized: BOOLEAN is deferred end;
	realize is deferred end;
	shown: BOOLEAN is deferred end;
	show is deferred end;
	raise is deferred end;
	title: STRING is deferred end;
	set_title (s: STRING) is deferred end;
	destroy is deferred end;
	hide is deferred end

feature

	synchronize is
		do
			text_window.synchronize
		end;

	receive (dropped: STONE) is
			-- Deal with element `dropped'.
		do
			text_window.receive (dropped)
		end;

	reset is
			-- Reset the window contents
		do
			set_title (tool_name);
			text_window.clean
		end;

	
feature {NONE}

	transporter_init is
			-- Initialize tranport stuff.
		local
			void_reference: ANY
		do
			set_drawing (screen);
			set_logical_mode (10);
			set_subwindow_mode (1);
			add_button_motion_action (3, Current, Current);
			add_button_release_action (3, Current, text_window)
		end;

	execute (argument: ANY) is
			-- Leave a track when the pointer moves on the screen, ungrab when button is released
		local
			pointed_widget: WIDGET;
			pointed_text: TEXT_WINDOW;
			pointed_hole: HOLE;
			transported_hole: HOLE;
			transported_node: like last_transported
		do
			if argument = Current then
				-- Motion action (when grabbed)
				draw_segment (x0, y0, x1, y1);
				x1 := screen.x; y1 := screen.y;
				draw_segment (x0, y0, x1, y1)
			elseif argument /= Void then
				draw_segment (x0, y0, x1, y1);
				if origin_text /= Void then
					origin_text.deselect_all
				end;
				pointed_widget := screen.widget_pointed;
				pointed_hole ?= pointed_widget;
				pointed_text ?= pointed_widget;
				transported_node ?= last_transported;
				transported_hole ?= last_transported;
				if pointed_text /= Void then
					if transported_hole /= Void and then pointed_text.clickable then
						pointed_text.change_focus;
						transported_hole.receive (pointed_text.focus);
						pointed_text.deselect_all
					elseif transported_node /= Void then
						pointed_text.receive (transported_node)
					end
				elseif pointed_hole /= Void then
					if transported_node /= Void then
						pointed_hole.receive (transported_node)
					end
				end;
				ungrab;
				clean_type
			else
				work (argument)
			end
		end;

	work (arg: ANY) is do end;
			-- Useless here

feature 

	transport (element: like last_transported; a_text: TEXT_WINDOW; start_x, start_y: INTEGER) is
			-- Grab cursor and leave a track when the pointer moves on the screen.
		require
			tranported_not_void: element /= Void
		do
			origin_text := a_text;
			last_transported := element;
			x0 := start_x; y0 := start_y;
			x1 := start_x; y1 := start_y;
			draw_point (start_x, start_y);
			tell_type (element.stone_name);
			grab (cursor_table.item (element.stone_type))
		ensure
			origin_text = a_text;
			last_transported = element
		end;

	
feature {NONE}

	origin_text: TEXT_WINDOW;
			-- Text window where the last transported element came from, Void
			-- if last transported was a hole
 
	last_transported: STONE;
			-- Last transported element, Void between grabs
 
	x0, y0, x1, y1: INTEGER;
			-- Initial and current pointer coordinates

feature

	tell_type (a_type_name: STRING) is
			-- Display `a_type_name' in type teller.
		deferred
		end;
 
	clean_type is
			-- Clean what's said in the type teller window.
		deferred
		end;

	
feature 

	save_command: ICONED_COMMAND is do end;
	
feature {NONE}

	screen: SCREEN is deferred end;
	add_button_motion_action (number: INTEGER; a_command: COMMAND; argument: ANY) is deferred end;
	add_button_release_action (number: INTEGER; a_command: COMMAND; argument: ANY) is deferred end;
	grab (cursor: SCREEN_CURSOR) is deferred end;
	ungrab is deferred end;
	

end

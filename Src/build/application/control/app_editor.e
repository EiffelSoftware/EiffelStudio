
class APP_EDITOR 

inherit
	
	APP_SHARED;
	APP_FIND_FIGURE;
	COMMAND
		redefine
			context_data_useful
		end;
	COMMAND_ARGS
		rename
			First as expose_action,
			Second as ctrl_select_action,
			Third as popdown_labels_action,
			Fourth as popup_labels_action,
			Fifth as set_state_action,
			Sixth as set_label_action
		end;
	TOP_SHELL
		rename
			make as top_create
		export
			{NONE} all;
			{ANY} realize, realized, set_cursor, cursor, hide, show, shown
		undefine
			init_toolkit
		end;
	WIDGET_NAMES;
	WINDOWS;

creation

	make

feature -- Drawing area 

	initial_state_circle: STATE_CIRCLE;
			-- Circle/State that triggers the application

	lines: APP_LINES;
			-- Contains all lines

	selected_figure: STATE_CIRCLE;
			-- Selected figure in list

	transitions: TRANSITION;
			-- State transitions

	figures: APP_FIGURES;
			-- Contains all circles and sub_app 

	clear is
		do
			--initial_state_circle.original_stone.reset_namer;
			figures.wipe_out;
			lines.wipe_out;
			graph.clear_all;
			drawing_area.clear
			--create_initial_state;
		end;

	disable_drawing is
			-- Disable the drawing of the figures and lines. 
		do
			figures.disable_drawing;
			lines.disable_drawing;
			drawing_area.clear;
		end;
	
	enable_drawing is
			-- ENable the drawing of the figures and lines. 
		do
			figures.enable_drawing;
			lines.enable_drawing
		end;

	draw_figures is
			-- Draw the figures. 
		do	
			drawing_area.clear;
			lines.draw;
			figures.draw;
		end;

	create_initial_state is
			-- Create an initial state of the application
		local
			circle: STATE_CIRCLE;
			point: COORD_XY_FIG;
			state: STATE
		do
			!!state.make;
			state.set_internal_name ("");
			!!circle.make;
			circle.init;
			circle.set_stone (state);
			transitions.init_element (state);	
			figures.append (circle);
				!!point;
				point.set (50, 50);
			circle.set_center (point);
			circle.set_double_thickness;
			set_initial_state_circle (circle);
			display_states;
		end; -- Create

	set_default_selected is
		do
			figures.start;
			if not figures.after then
				set_selected (figures.figure);
				display_states;
				display_transitions;
			end;
		end;

	set_selected (a_circle: STATE_CIRCLE) is
			-- Deselect selected_figure and then set `a_figure' 
			-- to selected_figure. Also update the selected_figure
			-- in figures and state_list.
		do
			if
				not (a_circle = selected_figure)
			then
				if
					not (selected_figure = Void)
				then
					selected_figure.deselect
				end;
				state_list.set_selected (a_circle);
				figures.set_selected (a_circle);
				selected_figure := a_circle;
				if
					not (selected_figure = Void)
				then
					selected_figure.select_figure
				end;
			end
		end; 

	valid_drawing_size (w, h: INTEGER): BOOLEAN is
		do
			Result := (w >= drawing_sw.width 
					and h >= drawing_sw.height)
		end;

	set_drawing_area_size (w, h: INTEGER) is
		do
			drawing_area.set_size (w, h)
		end;

	set_initial_state (s: STATE) is
			-- Set `a_circle' to init_state_circle and update
			-- initial_state of the transition graph.
		require
			valid_state: s /= Void
		local
			transition_graph: APP_GRAPH;
		do
			if (initial_state_circle.original_stone /= s) then
				find_figure (s);
				if not figures.after then
					set_initial_state_circle (figures.figure);
				end
			end
		end; 

	set_initial_state_circle (a_circle: STATE_CIRCLE) is
			-- Set `a_circle' to init_state_circle and update
			-- initial_state of the transition graph.
		require
			valid_arg: a_circle /= Void
		local
			transition_graph: APP_GRAPH;
		do
			if initial_state_circle /= Void then
				initial_state_circle.set_standard_thickness;
			end;
			initial_state_circle := a_circle;
			initial_state_circle.set_double_thickness;
			transition_graph := transitions.graph;
			transition_graph.set_initial_state (initial_state_circle.original_stone)
		end; 
	
	update_circle_text (s: STATE) is
		local
			eds: LINKED_LIST [STATE_EDITOR];
		do
			find_figure (s);
			if not figures.after then
				figures.figure.update_text;
				draw_figures;
				display_states;
				eds := window_mgr.state_editors;
				from 
					eds.start
				until
					eds.after or else 
					eds.item.edited_function.original_stone.equivalent (s)
				--! There is only one editor per function
				loop
					eds.forth
				end;	
				if not eds.after then
					eds.item.update_name
				end
			end	
		end;

	update_selected (s: STATE) is
			-- Update the selected_cirlce using `s'.
			-- Then display the state list.
		local
			old_selected: like selected_figure;
		do
			find_figure (s);
			if not figures.after then
				old_selected := state_list.selected_circle;
				set_selected (figures.figure);
				if selected_figure /= old_selected then
					display_states;
					display_transitions;
				end
			end
		end;

feature -- State editor

	add_sub_application is
			-- Add a sub application (future use)
		do
		end;

feature {NONE}

	current_label: STRING;
			-- Current selected label
	
	curr_trans: SORTED_TWO_WAY_LIST [TRAN_NAME] is
			-- All the  transitions of a selected state in alphabetical order
		local
			state: STATE
		do
			if
				not (selected_figure = Void) 
			then
				state := selected_figure.original_stone;	
				if
					not (state = Void)
				then
					Result := transitions.all_transitions (state)
				else
					!!Result.make
				end;
			else
				!!Result.make
			end;
		end; 

feature -- State and transition list

	display_transitions is
			-- Display transitions in the transition_list for the 
			-- selected_state in alphabetical order.
		do
			if not transition_list.empty then
				transition_list.wipe_out;
			end;
			current_label := Void;
			transition_list.merge_right (curr_trans);
		end;

	display_states is
			-- Display all the states in the state_list alphabetical order.
		local
			position: INTEGER
		do
			if not state_list.empty then
				state_list.wipe_out;
			end;
			state_list.merge_right (states);
			highlight_state;
		end;
	
feature {NONE} -- State and transition list

	highlight_state is
			-- Highlight selected_figure (i.e. state) in state_list.
			-- Don't highlight if selected_figure is void.
		do
			if
				not (selected_figure = Void)
			then
				state_list.start;
				state_list.search_equal (selected_figure.text);
				state_list.select_item;
			else
				state_list.deselect_item
			end;
		end; -- highlight_state

	popup_labels_window (l: STATE_LINE) is
			-- Popup a window with a list of labels for `line'.
		local
			source, dest: STATE;
		do
			source ?= l.source.original_stone;
			dest ?= l.destination.original_stone;
			if
				not (source = Void) and (not (dest = Void)) and not labels_wnd.is_poped_up
			then
				labels_wnd.popup (transitions.selected_labels (source, dest));
			end
		end; -- popup_labels_window

feature {NONE}

	select_state (state_name: STRING) is
			-- Set selected_figure using `state_name' and select 
			-- the figure in the drawing area. 
		require
			not (state_name = Void)
		do
			from
				figures.start
			until
				figures.after or 
				equal (figures.figure.label, state_name)
			loop
				figures.forth
			end;
			if 
				(not figures.after and 
				not (selected_figure = figures.figure))
			then
				set_selected (figures.figure);
				display_transitions
			end;
		end; 

	states: SORTED_TWO_WAY_LIST [STRING] is
			-- All the state names of the application in alphabetical order
		local
			text: STRING;
			circle: STATE_CIRCLE
		do
			from
				figures.start;
				!!Result.make
			until
				figures.after
			loop
				circle ?= figures.figure;
				if
					not (circle = Void) and then 
					not Result.has (circle.text)
				then	
					Result.extend (circle.text)
				end;
				figures.forth
			end
		end; -- states

feature -- EiffelVision Section

	drawing_area: APP_DR_AREA;

	state_list: STATE_SCR_L;
	
feature {NONE} -- EiffelVision Section

	form,form1: FORM;

	drawing_sw: SCROLLED_W;

	menu_bar: APP_BAR;

	labels_wnd: CHOICE_WND;
			-- Popup window that displays labels between states

	state_label: LABEL_G;

	transition_label: LABEL_G;

	transition_list: LABEL_SCR_L;
	
feature 

	make (a_screen: SCREEN) is
			-- Create app_editor interface 
		local
			contin_command: ITER_COMMAND;
		do
				-- **************
				-- Create widgets
				-- **************
			top_create ("Application Editor", a_screen);
			!!form.make (F_orm, Current);
			!!form1.make (F_orm1, form);
			!!drawing_sw.make (S_croll, form);
			!!drawing_area.make (D_rawingarea, drawing_sw, Current);
			!!menu_bar.make (B_ar, form, Current);
			!!state_label.make (L_abel, form1);
			!!transition_label.make (L_abel2, form1);
			!!state_list.make (L_ist1, form1, Current);
			!!transition_list.make (L_ist2, form1);
				-- *******************
				-- Perform attachments
				-- *******************
			form.set_fraction_base (4);
			form.attach_right_position (drawing_sw, 3);
			form.attach_left_position (form1, 3);
			form.attach_top (menu_bar, 5);
			form.attach_left (menu_bar, 5);
			form.attach_right (menu_bar, 5);

			form.attach_left (drawing_sw, 2);
			form.attach_bottom (drawing_sw, 2);
			form.attach_top_widget (menu_bar, drawing_sw, 5);

			form.attach_right (form1, 2);
			form.attach_bottom (form1, 2);
			form.attach_top_widget (menu_bar, form1, 5);

			form1.set_fraction_base (2);
			form1.attach_bottom_position (state_list, 1);
			form1.attach_top_position (transition_label, 1);
			form1.attach_top (state_label, 5);
			form1.attach_top_widget (state_label, state_list, 5);
			form1.attach_top_widget (transition_label, transition_list, 5);
			form1.attach_bottom (transition_list, 2);
			form1.attach_left (state_label, 2);
			form1.attach_left (transition_label, 2);
			form1.attach_left (state_list, 2);
			form1.attach_left (transition_list, 2);
			form1.attach_right (state_label, 2);
			form1.attach_right (transition_label, 2);
			form1.attach_right (state_list, 2);
			form1.attach_right (transition_list, 2);
				-- **********
				-- Set values
				-- **********
			transition_list.set_single_selection;
			state_list.set_single_selection;
			!!transitions;
			!!lines.make (drawing_area);
			!!figures.make (drawing_area, Current);
			figures.set_showable_area (drawing_sw);
			state_label.set_text ("State");
			transition_label.set_text ("Transition");
			drawing_sw.set_working_area (drawing_area);
			--add_sub_application_command.Create (Current);
			!!labels_wnd.make (form);
				-- *************
				-- Set callbacks
				-- *************
				-- These are set here so these callbacks are
				-- made after the 'figures' callbacks are
				-- executed.
			drawing_area.add_expose_action (Current, expose_action);
			drawing_area.add_button_press_action (2, Current, popup_labels_action);
			drawing_area.set_action ("Ctrl<Btn1Down>", Current, ctrl_select_action);
			state_list.add_selection_action (Current, set_state_action);
			transition_list.add_selection_action (Current, set_label_action);
			
			!!contin_command;
			set_delete_command (contin_command);
		end; 

	context_data_useful: BOOLEAN is
		do
			Result := True;
		end;

	execute (argument: ANY) is
				-- Execute the command.
		local
			state_name: STRING;
			circle: STATE_CIRCLE;
			expose_data: EXPOSE_DATA;
		do
			if
				argument = expose_action
			then
				expose_data ?= context_data;
				if expose_data.exposes_to_come = 0 then
					lines.draw;
					figures.draw	
				end;
			elseif
				argument = ctrl_select_action
			then
				figures.find;
				if not figures.after then	
					set_selected (figures.figure);
					display_states;
					draw_figures;
					display_transitions;
				end;
			elseif
				argument = set_state_action
			then
				if
					(state_list.selected_item = Void)	
				then
					state_list.start;
					state_list.search_equal (selected_figure.text);
					state_list.select_item;
					display_transitions;
				else
					select_state (state_list.selected_item)
				end;
			elseif
				argument = set_label_action
			then
				if
					(transition_list.selected_item = Void)	
				then
					transition_list.start;
					transition_list.search_equal (current_label);
					transition_list.select_item;
				else
					current_label := transition_list.selected_item;
				end;
			elseif
				argument = popup_labels_action
			then
				lines.find;
				if
					lines.found
				then	
					popup_labels_window (lines.line)
				end
			end;
		end; 

	invariant

		valid_fig: drawing_area /= Void implies figures /= Void;
		valid_lines: drawing_area /= Void implies lines /= Void;

end 

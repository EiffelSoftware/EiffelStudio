
class APP_EDITOR 

inherit
	
	SHARED_APPLICATION;
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
			Sixth as set_label_action,
			Seventh as namer_action
		end;
	EB_TOP_SHELL
		rename
			make as top_create,
			realize as shell_realize
		export
			{NONE} all;
			{ANY}realized, set_cursor, 
			cursor, hide, show, shown, ungrab
		redefine
			set_geometry
		end;
	WINDOWS
		select 
			init_toolkit
		end
	CLOSEABLE

creation

	make

feature -- Window attributes

	set_geometry is
		do
			set_x_y (Resources.app_ed_x,
					Resources.app_ed_y);
			set_size (Resources.app_ed_width,
					Resources.app_ed_height);
		end;
	
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
			if initial_state_circle /= Void then
				initial_state_circle.data.reset_namer;
				initial_state_circle := Void
			end;
			figures.wipe_out;
			lines.wipe_out;
			Shared_app_graph.clear_all;
			set_selected (Void);
			if implementation /= Void then
				drawing_area.clear
			end;
			--create_initial_state;
		end;

	close is
		do
			main_panel.application_editor_entry.set_toggle_off
			hide
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

	find_selected_figure is
		do
			-- Search classes first
			figures.find;
			if not figures.found then
				lines.find;
			end;
		end;

	selected_figure_stone: STONE is
		do
			if figures.found then
				Result := figures.element
			elseif lines.found then
				Result := lines.line
			end	
		end;

	remove_selected_figure is
		local
			cut_figure_command: APP_CUT_FIGURE;
			cut_line_command: APP_CUT_LINE;
		do
			if figures.found then
				!! cut_figure_command.make (figures.element)
				cut_figure_command.execute (Void)
			elseif lines.found then
				!!cut_line_command;
				cut_line_command.execute (lines.line)
			end	
		end;

	create_initial_state is
			-- Create an initial state of the application
		local
			circle: STATE_CIRCLE;
			point: COORD_XY_FIG;
			state: BUILD_STATE
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
		end; -- Create

	set_default_selected is
		do
			if implementation /= Void and then realized then
				figures.start;
				if not figures.after then
					set_selected (figures.figure);
					display_states;
					display_transitions;
				end
			end;
		end;

	set_selected (a_circle: STATE_CIRCLE) is
			-- Deselect selected_figure and then set `a_figure' 
			-- to selected_figure. Also update the selected_figure
			-- in figures and state_list.
		do
			if a_circle /= selected_figure then
				if selected_figure /= Void then
					selected_figure.deselect
				end;
				if implementation /= Void then
					state_list.set_selected (a_circle);
				end;
				figures.set_selected (a_circle);
				selected_figure := a_circle;
				if selected_figure /= Void then
					selected_figure.select_figure
					main_panel.set_current_state (a_circle.data)
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

	set_initial_state (s: BUILD_STATE) is
			-- Set `a_circle' to init_state_circle and update
			-- initial_state of the transition graph.
		require
			valid_state: s /= Void
		do
			if (initial_state_circle.data /= s) then
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
		do
			if initial_state_circle /= Void then
				initial_state_circle.set_standard_thickness;
			end;
			initial_state_circle := a_circle;
			initial_state_circle.set_double_thickness;
			Shared_app_graph.set_initial_state (initial_state_circle.data)
		end; 
	
	update_circle_text (s: BUILD_STATE) is
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
					eds.item.edited_function.data = s
				--! There is only one editor per function
				loop
					eds.forth
				end;	
				if not eds.after then
					eds.item.update_title
				end
			end	
		end;

	update_context_name_in_editors (c: CONTEXT) is
			-- Update context name in state_editors for 
			-- context `c'.
		local
			eds: LINKED_LIST [STATE_EDITOR];
		do
			eds := window_mgr.state_editors;
			from 
				eds.start
			until
				eds.after 
			loop
				eds.item.update_context_name (c);
				eds.forth
			end;	
		end;

	update_selected (s: BUILD_STATE) is
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
	
	curr_trans: ARRAYED_LIST [TRAN_NAME] is
			-- All the  transitions of a selected state in alphabetical order
		local
			state: BUILD_STATE
			a_sorted_list: SORTED_TWO_WAY_LIST [TRAN_NAME]
		do
			!! Result.make (0)
			if selected_figure /= Void then
				state := selected_figure.data;	
				if state /= Void then
					a_sorted_list := transitions.all_transitions (state)
					from
						a_sorted_list.start
					until
						a_sorted_list.after
					loop
						Result.extend (a_sorted_list.item)
						a_sorted_list.forth
					end
				end;
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
			transition_list.append (curr_trans)
		end;

	display_states is
			-- Display all the states in the state_list alphabetical order.
		local
			position: INTEGER
		do
			if not state_list.empty then
				state_list.wipe_out;
			end;
			state_list.append (states)
			highlight_state;
		end;
	
feature {NONE} -- State and transition list

	highlight_state is
			-- Highlight selected_figure (i.e. state) in state_list.
			-- Don't highlight if selected_figure is void.
		local
			a_string_scrollable_element: STRING_SCROLLABLE_ELEMENT
		do
			if
				not (selected_figure = Void)
			then
				state_list.start;
				!! a_string_scrollable_element.make (0)
				a_string_scrollable_element.append (selected_figure.text)
				state_list.go_i_th (state_list.index_of (a_string_scrollable_element, 1))
				state_list.select_item;
			else
--				state_list.deselect_item
			end;
		end; -- highlight_state

feature {STATE_LINE}

	popup_labels_window (l: STATE_LINE) is
			-- Popup a window with a list of labels for `line'.
		local
			source, dest: BUILD_STATE;
		do
			source ?= l.source.data;
			dest ?= l.destination.data;
			if source /= Void and then 
				dest /= Void and then
				not labels_wnd.is_popped_up
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

	states: ARRAYED_LIST [STRING_SCROLLABLE_ELEMENT] is
			-- All the state names of the application in alphabetical order
		local
			text: STRING;
			circle: STATE_CIRCLE
			a_str_scr_elt: STRING_SCROLLABLE_ELEMENT
		do
			from
				figures.start;
				!!Result.make (0)
			until
				figures.after
			loop
				circle ?= figures.figure;
				!! a_str_scr_elt.make (0)
				if circle /= Void then
					a_str_scr_elt.append (circle.text)
					if
						not Result.has (a_str_scr_elt)
					then	
						from
							Result.finish
						until
							Result.before or else Result.item.value < circle.text
						loop
							Result.back
						end
						Result.put_right (a_str_scr_elt)
--						Result.forth
					end;
				end
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

	state_label: LABEL;

	transition_label: LABEL;

	transition_list: LABEL_SCR_L;
	
feature

	realize is
		local
			mp: MOUSE_PTR
		do
			!! mp;
			mp.set_watch_shape;
			figures.attach_to_drawing_area;
			lines.attach_to_drawing_area;
			set_default_selected;
			shell_realize;
			mp.restore
		end;

	update_display is
		do
			if implementation /= Void and then realized then
				app_editor.display_states;
				app_editor.display_transitions;
				app_editor.draw_figures;
			end
		end;

	update_transitions_list (cmd: CMD) is
			-- Update the transition list for
			-- modified command `cmd'.
		do
			if implementation /= Void and then realized then
				if cmd = Void or else 
					selected_figure.data.has_command (cmd) 
				then
					app_editor.display_transitions;
				end
			end
		end;

	is_initialized: BOOLEAN is
		do
			Result := realized
		end;

feature {NONE}

	make is
			-- Create app_editor interface 
		local
			del_com: DELETE_WINDOW;
		do
				-- **************
				-- Create widgets
				-- **************
			top_create (Widget_names.application_editor, Eb_screen);
			set_title (Widget_names.application_editor)
			!!form.make (Widget_names.form, Current);
			!!form1.make (Widget_names.form1, form);
			!!drawing_sw.make (Widget_names.scroll, form);
			!!drawing_area.make_visible (Widget_names.drawingarea, drawing_sw);
			!! transitions    
              
			!!lines.make (drawing_area);
			!!figures.make (drawing_area);

			!!menu_bar.make (Widget_names.bar, form, Current);
			!!state_label.make (Widget_names.state_name, form1);
			!!transition_label.make (Widget_names.transition_name, form1);
			!!state_list.make (Widget_names.list1, form1, Current);
			!!transition_list.make (Widget_names.list2, form1);
			initialize_window_attributes;
				-- *******************
				-- Perform attachments
				-- *******************
			figures.add_callbacks;
			form.set_fraction_base (4);
			form.attach_right_position (drawing_sw, 3);
			form.attach_left_position (form1, 3);

			form.attach_top (form1, 5)
			form.attach_left_position (form1, 3);
			form.attach_right (form1, 2);
			form.attach_bottom (form1, 2);

			form.attach_top (menu_bar, 5);
			form.attach_left (menu_bar, 5);
			form.attach_right_position (menu_bar, 3);

			form.attach_left (drawing_sw, 2);
			form.attach_bottom (drawing_sw, 2);
			form.attach_top_widget (menu_bar, drawing_sw, 5);

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
			drawing_sw.set_working_area (drawing_area);
			drawing_area.set_background_color (Resources.app_dr_area_color);
			drawing_area.set_size (Resources.app_dr_area_width,
							Resources.app_dr_area_height);
			!!labels_wnd.make (form);
				-- *************
				-- Set callbacks
				-- *************
				-- These are set here so these callbacks are
				-- made after the 'figures' callbacks are
				-- executed.
			drawing_area.add_expose_action (Current, expose_action);
			drawing_area.set_action ("Ctrl<Btn1Down>", Current, ctrl_select_action);
			drawing_area.set_action ("Shift<Btn3Down>", Current, namer_action);
			state_list.add_selection_action (Current, set_state_action);
			transition_list.add_selection_action (Current, set_label_action);
			
			!! del_com.make (Current);
			set_delete_command (del_com);
	
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
			rename_com: RENAME_COMMAND
			a_string_scrollable_element: STRING_SCROLLABLE_ELEMENT
		do
			if argument = expose_action then
				expose_data ?= context_data;
				if expose_data.exposes_to_come = 0 then
					lines.draw;
					figures.draw	
				end;
			elseif argument = ctrl_select_action then
				figures.find;
				if figures.found then	
					set_selected (figures.figure);
					display_states;
					draw_figures;
					display_transitions;
				end;
			elseif argument = namer_action then
				figures.find;
				if figures.found then	
					!! rename_com;
					rename_com.execute (figures.figure);
				end;
			elseif argument = set_state_action then
				if (state_list.selected_item = Void) then
					state_list.start;
					!! a_string_scrollable_element.make (0)
					a_string_scrollable_element.append (selected_figure.text)
					state_list.go_i_th (state_list.index_of (a_string_scrollable_element, 1))					state_list.select_item;
					display_transitions;
				else
					select_state (state_list.selected_item.value)
				end;
			elseif argument = set_label_action then
				if (transition_list.selected_item = Void) then
					transition_list.start;
					!! a_string_scrollable_element.make (0)
					a_string_scrollable_element.append (current_label)
					transition_list.go_i_th (state_list.index_of (a_string_scrollable_element, 1))
					transition_list.select_item;
				else
					current_label := transition_list.selected_item.value;
				end;
			end;
		end; 

invariant

		valid_fig: drawing_area /= Void implies figures /= Void;
		valid_lines: drawing_area /= Void implies lines /= Void;

end 

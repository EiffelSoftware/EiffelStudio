indexing
	description: "Application editor window."
	Id: "$Id $"
	date: "$Date$"
	revision: "$Revision$"

class APP_EDITOR 

inherit
	EB_TOP_WINDOW
		redefine
			make
		end

	EV_COMMAND

	SHARED_APPLICATION

	APP_FIND_FIGURE

	WINDOWS

	CLOSEABLE

	CONSTANTS

creation
	make

feature {NONE} -- Initialization

	make is
			-- Create app_editor interface 
		local
			vbox: EV_VERTICAL_BOX
			hbox: EV_HORIZONTAL_BOX
			state_label: EV_LABEL
			transition_label: EV_LABEL
			split_area: EV_HORIZONTAL_SPLIT_AREA
		do
			{EB_TOP_WINDOW} Precursor
			set_title (Widget_names.application_editor)

			create vbox.make (Current)
			create toolbar.make (vbox)
			create split_area.make (vbox)

			create vbox.make (split_area)
			create state_label.make_with_text (vbox, Widget_names.state_name)
			state_label.set_expand (False)
			create state_list.make (vbox, Current)
			create transition_label.make_with_text (vbox, Widget_names.transition_name)
			transition_label.set_expand (False)
			create transition_list.make (vbox)

			create drawing_sw.make (split_area)
			create drawing_area.make (drawing_sw)

			set_values
			set_callbacks
		end

	set_values is
		do
			create transitions
			create lines.make (drawing_area)
			create figures.make (drawing_area)

--			initialize_window_attributes
			transition_list.set_single_selection
			state_list.set_single_selection
			drawing_area.set_background_color (Resources.app_dr_area_color)
			drawing_area.set_size (Resources.app_dr_area_width, Resources.app_dr_area_height)
			set_default_selected
		end

	set_callbacks is
			-- These are set here so these callbacks are
			-- made after the 'figures' callbacks are
			-- executed.
		do
			state_list.add_selection_command (Current, Void)
			set_close_callback (Void)
		end 

feature -- Window attributes

	set_geometry is
		do
			set_x_y (Resources.app_ed_x, Resources.app_ed_y)
			set_size (Resources.app_ed_width, Resources.app_ed_height)
		end

feature {NONE} -- Command

	execute (arg: EV_ARGUMENT; ev_data: EV_BUTTON_EVENT_DATA) is
			-- Set selected_figure using `state_name' and select 
			-- the figure in the drawing area. 
		require else
			selected_item: state_list.selected_item /= Void
		do
			from
				figures.start
			until
				figures.after or 
				equal (figures.figure.label, state_list.selected_item.text)
			loop
				figures.forth
			end
			if not figures.after and selected_figure /= figures.figure then
				set_selected (figures.figure)
				display_transitions
			end
		end 

feature -- EiffelVision Section

	drawing_area: APP_DR_AREA

	state_list: STATE_SCR_L

feature {NONE} -- EiffelVision Section

	drawing_sw: EV_SCROLLABLE_AREA

	toolbar: APP_TOOLBAR

	transition_list: LABEL_SCR_L

feature -- Drawing area 

	initial_state_circle: STATE_CIRCLE
			-- Circle/State that triggers the application

	lines: APP_LINES
			-- Contains all lines

	selected_figure: STATE_CIRCLE
			-- Selected figure in list

	transitions: TRANSITION
			-- State transitions

	figures: APP_FIGURES
			-- Contains all circles and sub_app 

	clear is
		do
			if initial_state_circle /= Void then
				initial_state_circle.data.reset_namer
				initial_state_circle := Void
			end
			figures.wipe_out
			lines.wipe_out
			Shared_app_graph.clear_all
			set_selected (Void)
			if not destroyed then
				drawing_area.clear
			end
		end

	close (arg: EV_ARGUMENT; ev_data: EV_EVENT_DATA) is
		do
--			main_window.application_editor_entry.set_state (False)
			hide
		end

	draw_figures is
			-- Draw the figures. 
		do	
			drawing_area.clear
			lines.draw
			figures.draw
		end

	find_pointed_figure (lx, ly: INTEGER) is
		do
			-- Search classes first
			figures.find (lx, ly)
			if not figures.found then
				lines.find (lx, ly)
			end
		end

	pointed_figure: EB_FIGURE is
		do
			if figures.found then
				Result := figures.figure
			elseif lines.found then
				Result := lines.line
			end	
		end

	remove_pointed_figure is
		local
			cut_figure_cmd: APP_CUT_FIGURE
			arg1: EV_ARGUMENT1 [STATE_CIRCLE]
			cut_line_cmd: APP_CUT_LINE
			arg2: EV_ARGUMENT1 [STATE_LINE]
		do
			if figures.found then
				create cut_figure_cmd
				create arg1.make (figures.figure)
				cut_figure_cmd.execute (arg1, Void)
			elseif lines.found then
				create cut_line_cmd
				create arg2.make (lines.line)
				cut_line_cmd.execute (arg2, Void)
			end	
		end

	create_initial_state is
			-- Create an initial state of the application
		local
			circle: STATE_CIRCLE
			pt: EV_POINT
			state: BUILD_STATE
		do
			create state.make
			state.set_internal_name ("")
			create circle.make
			circle.init
			circle.set_data (state)
			transitions.init_element (state)

			figures.append (circle)
			create pt.set (50, 50)
			circle.set_center (pt)
			circle.set_double_thickness
			set_initial_state_circle (circle)
		end

	set_default_selected is
		do
			if not destroyed then
				figures.start
				if not figures.after then
					set_selected (figures.figure)
					display_states
					display_transitions
				end
			end
		end

	set_selected (a_circle: STATE_CIRCLE) is
			-- Deselect selected_figure and then set `a_figure' 
			-- to selected_figure. Also update the selected_figure
			-- in figures and state_list.
		do
			if a_circle /= selected_figure then
				if selected_figure /= Void then
					selected_figure.deselect
				end
				if not destroyed then
					state_list.set_selected (a_circle)
				end
				figures.set_selected (a_circle)
				selected_figure := a_circle
				if selected_figure /= Void then
					selected_figure.select_figure
					main_window.set_current_state (a_circle.data)
				end
			end
		end

	valid_drawing_size (w, h: INTEGER): BOOLEAN is
		do
			Result := w >= drawing_sw.width and then h >= drawing_sw.height
		end

	set_drawing_area_size (w, h: INTEGER) is
		do
			drawing_area.set_size (w, h)
		end

	set_initial_state (s: BUILD_STATE) is
			-- Set `a_circle' to init_state_circle and update
			-- initial_state of the transition graph.
		require
			valid_state: s /= Void
		do
			if initial_state_circle.data /= s then
				find_figure (s)
				if not figures.after then
					set_initial_state_circle (figures.figure)
				end
			end
		end

	set_initial_state_circle (a_circle: STATE_CIRCLE) is
			-- Set `a_circle' to init_state_circle and update
			-- initial_state of the transition graph.
		require
			valid_arg: a_circle /= Void
		do
			if initial_state_circle /= Void then
				initial_state_circle.set_standard_thickness
			end
			initial_state_circle := a_circle
			initial_state_circle.set_double_thickness
			Shared_app_graph.set_initial_state (initial_state_circle.data)
		end 
	
	update_circle_text (s: BUILD_STATE) is
		local
			eds: LINKED_LIST [STATE_EDITOR]
		do
			find_figure (s)
			if not figures.after then
				figures.figure.update_text
				draw_figures
				display_states
				eds := window_mgr.state_editors
				from 
					eds.start
				until
					eds.after or else 
					eds.item.edited_function.data = s
				--! There is only one editor per function
				loop
					eds.forth
				end	
				if not eds.after then
					eds.item.update_title
				end
			end	
		end

	update_context_name_in_editors (c: CONTEXT) is
			-- Update context name in state_editors for 
			-- context `c'.
		local
			eds: LINKED_LIST [STATE_EDITOR]
		do
			eds := window_mgr.state_editors
			from 
				eds.start
			until
				eds.after 
			loop
				eds.item.update_context_name (c)
				eds.forth
			end	
		end

	update_selected (s: BUILD_STATE) is
			-- Update the selected_cirlce using `s'.
			-- Then display the state list.
		local
			old_selected: like selected_figure
		do
			find_figure (s)
			if not figures.after then
				old_selected := state_list.selected_circle
				set_selected (figures.figure)
				if selected_figure /= old_selected then
					display_states
					display_transitions
				end
			end
		end

feature -- State and transition list

	display_transitions is
			-- Display transitions in the transition_list for the 
			-- selected_state in alphabetical order.
		local
			state: BUILD_STATE
		do
			if transition_list.count /= 0 then
				transition_list.clear_items
			end
			if selected_figure /= Void then
				state := selected_figure.data	
				if state /= Void then
					transition_list.append (transitions.all_transitions (state))
				end
			end
		end

	display_states is
			-- Display all the states in the state_list alphabetical order.
		local
			elt: EV_LIST_ITEM
			circle: STATE_CIRCLE
			i: INTEGER
		do
			if state_list.count /= 0 then
				state_list.clear_items
			end
			from
				figures.start
			until
				figures.after
			loop
				circle ?= figures.figure
				if circle /= Void then
--					if not state_list.has (a_str_scr_elt) then	
--						from
--							i := 1
--						until
--							i <= state_list.count
--							or else state_list.get_item (i).text > circle.text
--						loop
--							i := i + 1
--						end
--						create elt.make_with_index (state_list, i)
						create elt.make (state_list)  --XX Temporary
						elt.set_text (circle.text)
						if selected_figure = circle then
							elt.set_selected (True)
						end
--					end
				end
				figures.forth
			end
		end

feature {STATE_LINE} -- List of labels for a transition

	popup_labels_window (l: STATE_LINE) is
			-- Popup a window with a list of labels for `line'.
		local
			source, dest: BUILD_STATE
			tran_list: SORTED_TWO_WAY_LIST [STRING]
			elmt: EV_MENU_ITEM
			popup_m: EV_POPUP_MENU
		do
			source ?= l.source.data
			dest ?= l.destination.data
			if source /= Void and then dest /= Void then
				tran_list := transitions.selected_labels (source, dest)
				create popup_m.make (Current)
				from
					tran_list.start
				until
					tran_list.after
				loop
					create elmt.make_with_text (popup_m, tran_list.item)
					tran_list.forth
				end
					--XX Use the position of the mouse (EV_SCREEN).
				popup_m.show_at_position (100, 100)
			end
		end

feature -- Access

	update_display is
		do
			if not destroyed and then shown then
				app_editor.display_states
				app_editor.display_transitions
				app_editor.draw_figures
			end
		end

	update_transitions_list (cmd: CMD) is
			-- Update the transition list for
			-- modified command `cmd'.
		do
			if not destroyed and then shown then
				if cmd = Void or else 
					selected_figure.data.has_command (cmd) 
				then
					app_editor.display_transitions
				end
			end
		end

invariant
		valid_fig: drawing_area /= Void implies figures /= Void
		valid_lines: drawing_area /= Void implies lines /= Void

end -- class APP_EDITOR


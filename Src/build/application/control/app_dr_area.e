
class APP_DR_AREA 

inherit

	DRAWING_AREA
		rename
			init_toolkit as drawing_area_init_toolkit
		end;
	HOLE
		redefine
			process_any	
		select
			init_toolkit
		end;
	DRAG_SOURCE;
	COMMAND;

creation

	make_visible
	

feature

	make_visible (a_name: STRING; a_parent: COMPOSITE) is
			-- Create the drawing area.
		do
			make (a_name, a_parent);
			add_button_press_action (3, Current, Void);
			register;
			initialize_transport
		end; -- Create

feature 

	source, target: WIDGET is
		do
			Result := Current
		end;

feature -- Stone transportion

	stone: STONE;

	execute (arg: ANY) is
		do
			app_editor.find_selected_figure;
			stone := app_editor.selected_figure_stone
		end;

feature {NONE} -- Removable

	remove_yourself is
			-- Remove source_figure.
		do
			app_editor.remove_selected_figure
		end;

feature {NONE}

	new_state: BUILD_STATE;

	stone_type: INTEGER is 
		do 		
			Result := Stone_types.any_type
		end;

	process_any (dropped: STONE) is
			-- Update the drawing area appropriately 
			-- using the dropped stone. 
			-- Either 
			-- 		. update the transition label between figure
			--		. add a transition between figures 
			--		. update the state
			--		. copy a state
			--		. add a line between two circles
		local
			drawing_area: APP_DR_AREA;
			label_list: LABEL_SCR_L;
			state_list: STATE_SCR_L;
			circle: STATE_CIRCLE;
			new_state_stone: NEW_STATE_STONE;
			update_trans_command: APP_UPDATE_TRANS;
			state_stone: STATE_STONE
		do
			label_list ?= dropped;
			if label_list /= Void then
					-- A label has been dragged from the scrolled
					-- list of the application editor.
				!!update_trans_command;
				update_trans_command.execute (label_list.selected_label)
			else
			 	circle ?= dropped;
				if circle /= Void then
						-- A figure was dragged and dropped from
						-- within the drawing area.
					update_figures (circle)
				else
					new_state_stone ?= dropped;
					if new_state_stone /= Void then
						add_new_state;
						-- A state stone has been brought in
						-- from the outside.
					else
						state_list ?= dropped;
						if state_list /= Void then
							circle ?= state_list.selected_circle;
							if circle /= Void then
								update_figures (circle)
							end
						else
							state_stone ?= dropped.data;
							if state_stone /= Void then
								copy_state (state_stone.data)
							end
						end	
					end
				end
			end
		end; -- process_stone

	update_figures (circle: STATE_CIRCLE) is
			-- Find the destination circle and if found, add
			-- a line between them.
			-- If circle not found then add state circle.
			
		local
			figures: APP_FIGURES;
			add_line_command: APP_ADD_LINE;
		do
			figures := app_editor.figures;
			figures.find;
			if
				figures.found
			then
				!!add_line_command;
				add_line_command.set_source_circle (circle);
				add_line_command.execute (figures.figure);
			else
				copy_state (circle.data);
			end
		end; -- add_line

	copy_state (s: BUILD_STATE) is
			-- Copy lists from `s' to new_state.
		do
			add_new_state;
			new_state.copy_contents (s);
			new_state := Void
		end;

	add_new_state is
			-- Search for a figure in Current according 
			-- to the mouse position. If found, then 
			-- override found figure with stone dropped. 
			-- Otherwise, add a new figure to the 
			-- drawing area. 
		local
			figures: APP_FIGURES;
			circle: STATE_CIRCLE;
			add_state_command: APP_ADD_STATE;
		do
			!!new_state.make;
			new_state.set_internal_name ("");
			figures := app_editor.figures;
			figures.find;	
			!!add_state_command;
			add_state_command.execute (new_state)
		end;

end 
	

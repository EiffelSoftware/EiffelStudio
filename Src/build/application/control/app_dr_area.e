
class APP_DR_AREA 

inherit

	DRAWING_AREA
		rename
			make as make_drawing_area
		undefine
			init_toolkit
		end;
	HOLE;

creation

	make
	
feature -- Creation

	make (a_name: STRING; a_parent: COMPOSITE; appl: APP_EDITOR) is
			-- Create the drawing area.
		do
			make_drawing_area (a_name, a_parent);
			application_editor := appl;
			register
		end; -- Create

feature 

	target: WIDGET is
		do
			Result := Current
		end;
	
feature {NONE}

	new_state: STATE;
		-- New state added

	application_editor: APP_EDITOR;

	add_line_command: APP_ADD_LINE;
	add_state_command: APP_ADD_STATE;
	update_trans_command: APP_UPDATE_TRANS;
			-- Application commands 

	process_stone is
			-- Update the drawing area appropriately 
			-- using the dropped stone. 
			-- Either 
			-- 		. update the transition label between figure
			--		. add a transition between figures 
			--		. update the state
			--		. copy a state
			--		. add a line between two circles
		local
			figures: APP_FIGURES;
			label_list: LABEL_SCR_L;
			state_list: STATE_SCR_L;
			circle: STATE_CIRCLE;
			new_state_stone: NEW_STATE_STONE;
			state_stone: STATE_STONE
		do
			label_list ?= stone;
			if 
				not (label_list = Void) 
			then
					-- A label has been dragged from the scrolled
					-- list of the application editor.
				!!update_trans_command;
				update_trans_command.execute (label_list.label)
			else
			 	figures ?= stone;
				if 
					not (figures = Void) 
				then
						-- A figure was dragged and dropped from
						-- within the drawing area.
					circle ?= figures.source_figure;
					if
						not (circle = Void)
					then
						update_figures (circle)
					end
				else
					new_state_stone ?= stone;
					if 
						not (new_state_stone = Void) 
					then
						add_new_state;
						-- A state stone has been brought in
						-- from the outside.
					else
						state_list ?= stone;
						if
							not (state_list = Void)
						then
							circle ?= state_list.selected_circle;
							if
								not (circle = Void)
							then
								update_figures (circle)
							end
						else
							state_stone ?= stone;
							if
								state_stone /= Void
							then
								copy_state (state_stone.original_stone)
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
			figures: APP_FIGURES
		do
			figures := application_editor.figures;
			figures.find;
			if
				figures.found
			then
				!!add_line_command;
				add_line_command.set_source_circle (circle);
				add_line_command.execute (figures.figure);
			else
				copy_state (circle.original_stone);
			end
		end; -- add_line

	copy_state (s: STATE) is
			-- Copy lists from `s' to new_state.
		do
			add_new_state;
			new_state.copy_lists (s);
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
		do
			!!new_state.make;
			new_state.set_internal_name ("");
			figures := application_editor.figures;
			figures.find;	
			!!add_state_command;
			add_state_command.execute (new_state)
		end;

end 
	

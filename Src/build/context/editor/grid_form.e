class GRID_FORM 

inherit

	EDITOR_FORM;
	COMMAND;
	COMMAND_ARGS;
	PIXMAPS

creation
	make
	
feature {NONE}

	form_number: INTEGER is
		do
			Result := Context_const.grid_form_nbr
		end;

	no_grid: TOGGLE_B
	grid5: TOGGLE_B
	grid10: TOGGLE_B
	grid15: TOGGLE_B
	grid20: TOGGLE_B

feature -- Interface

	make_visible (a_parent: COMPOSITE) is
		local
			grid_title: LABEL_G
			grids: RADIO_BOX
		do	
			initialize (Context_const.grid_form_name, a_parent)
			!!grid_title.make (Context_const.grid_options_name, Current)
			!!grids.make (Widget_names.radio_box, Current)
			!!no_grid.make (Context_const.no_grid_name, grids)
			!!grid5.make (Context_const.grid5_name, grids)
			!!grid10.make (Context_const.grid10_name, grids)
			!!grid15.make (Context_const.grid15_name, grids)
			!!grid20.make (Context_const.grid20_name, grids)

			attach_top (grid_title, 10)
			attach_left (grid_title, 10)
			attach_left (grids, 50)
			attach_top_widget (grid_title, grids, 10)
			detach_bottom (grids)
			no_grid.arm
			no_grid.add_arm_action (Current, First)
			grid5.add_arm_action (Current, Second)
			grid10.add_arm_action (Current, Third)
			grid15.add_arm_action (Current, Fourth)
			grid20.add_arm_action (Current, Fifth)
			grids.set_always_one (True)
			show_current
		end

	apply is
		do
		end

feature {NONE}

	reset is
		local
			bg_pixmap: PIXMAP
		do
			bg_pixmap := context.widget.background_pixmap;
			if (bg_pixmap = grid5_pixmap) then
				grid5.set_toggle_on
			elseif (bg_pixmap = grid10_pixmap) then
				grid10.set_toggle_on
			elseif (bg_pixmap = grid15_pixmap) then
				grid15.set_toggle_on
			elseif (bg_pixmap = grid20_pixmap) then
				grid20.set_toggle_on
			end
		end
	
	execute (argument: ANY) is
		do
			if (argument = First) then
				context.set_grid (Void)
			elseif (argument = Second) then
				context.set_grid (grid5_pixmap)
			elseif (argument = Third) then
				context.set_grid (grid10_pixmap)
			elseif (argument = Fourth) then
				context.set_grid (grid15_pixmap)
			elseif (argument = Fifth) then
				context.set_grid (grid20_pixmap)
			end
		end

end

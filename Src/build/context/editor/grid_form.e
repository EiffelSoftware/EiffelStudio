class GRID_FORM 

inherit

	CONTEXT_CMDS
		export
			{NONE} all
		end

	EDITOR_FORM
		redefine
			context, form_name
		end

	COMMAND
	COMMAND_ARGS
	PIXMAPS

creation
	make
	
feature 

	form_name: STRING is
		do
			Result := grid_form_name
		end

	make (a_parent: CONTEXT_EDITOR) is
		do
			a_parent.form_list.put (Current, grid_form_number)
		end

	make_visible (a_parent: CONTEXT_EDITOR) is
		local
			grid_title: LABEL_G
			grids: RADIO_BOX
			no_grid: TOGGLE_B
			grid5: TOGGLE_B
			grid10: TOGGLE_B
			grid15: TOGGLE_B
			grid20: TOGGLE_B
		do	
			initialize (grid_form_name, a_parent)
			!!grid_title.make (T_itle, Current)
			!!grids.make (R_adio_box, Current)
			!!no_grid.make (T_oggle, grids)
			!!grid5.make (T_oggle1, grids)
			!!grid10.make (T_oggle2, grids)
			!!grid15.make (T_oggle3, grids)
			!!grid20.make (T_oggle4, grids)

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
			grid_title.set_text ("Grid Options")
			no_grid.set_text ("off")
			grid5.set_text ("5 pixels")
			grid10.set_text ("10 pixels")
			grid15.set_text ("15 pixels")
			grid20.set_text ("20 pixels")
			grids.set_always_one (True)
		end

	apply is
		do
			reset
		end

feature {NONE}

	context: WINDOW_C

	reset is
		do
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

indexing
	description: "Abstract function editor."
	Id: "$Id $"
	date: "$Date$"
	revision: "$Revision$"

deferred class FUNC_EDITOR 

inherit
	CONSTANTS

feature {NONE} -- Initialization

	initialize (par: EV_CONTAINER) is
		local
			vbox: EV_VERTICAL_BOX
			hbox, input_box, output_box: EV_HORIZONTAL_BOX
			tbar: EV_TOOL_BAR
		do
			create vbox.make (par)
			create_menu (vbox)
			create hbox.make (vbox)

			create vbox.make (hbox)
			create input_box.make (vbox)
			vbox.set_child_expandable (input_box, False)
			create tbar.make (input_box)
			input_box.set_child_expandable (tbar, False)
			create input_hole.make_with_editor (tbar, Current)
			create input_stone.make (input_box)
			input_stone.hide_title_row
			create input_list.make (vbox)

			create vbox.make (hbox)
			create output_box.make (vbox)
			vbox.set_child_expandable (output_box, False)
			create tbar.make (output_box)
			output_box.set_child_expandable (tbar, False)
			create output_hole.make_with_editor (tbar, Current)
			create output_stone.make (output_box)
			output_stone.hide_title_row
			create output_list.make (vbox)
		end

	edit_hole: FUNC_EDIT_HOLE

	create_menu (par: EV_CONTAINER) is
			-- Create the menu.
		deferred
		end

	clear_menu is
			-- Clear the menu
		deferred
		end

feature {NONE} -- Anchors

	input_stone, output_stone: EB_ICON_LIST
			-- Input and output stones
			-- associated with the function
			-- editor (list with only one element)

	input_hole, output_hole: ELMT_HOLE
			-- Input and output holes
			-- associated with the function
			-- editor
	
feature -- Anchors

	input_list: EB_ICON_LIST
	output_list: EB_ICON_LIST
			-- Data representing the edited
			-- function visually

feature -- Edited function

	edited_function: BUILD_FUNCTION
			-- Currently edited function

	save_previous_function is
			-- Save values of currently 
			-- edited function.
		do
			if (edited_function /= Void) then
				reset_stones
				edited_function.save_lists
				edited_function.reset
			end
		end

	set_edited_function (f: like edited_function) is
			-- Set `f' to be the currently edited
			-- function.
		require
			valid_f: f /= Void	
		do
			save_previous_function
			edited_function := f
			input_list.set (f.input_list)
			output_list.set (f.output_list)
			edited_function.set_lists (f.input_list, f.output_list)
			edited_function.set_editor (Current)
			if input_list.count /= 0 then
				edited_function.go_i_th (1)
			end
			edit_hole.set_full_symbol
		end

	hide_stones is
			-- Hides input and output stones if they
			-- are not set
		do
--			if (input_stone.data = Void) then
				input_stone.hide
--			end
--			if (output_stone.data = Void) then
				output_stone.hide
--			end

	end

--	reset_stone (s: ICON_STONE) is
--			-- Reset eith input and output stones 
--			-- according to `s'.
--		do
--			if (s = input_stone) then
--				edited_function.reset_input_data
--			elseif (s = output_stone) then
--				edited_function.reset_output_data
--			end		
--		end

	clear is
			-- Clear Current function editor.
		do
			save_previous_function
			clear_menu
			input_list.clear_items
			output_list.clear_items
			edited_function := Void
		end 

	reset_stones is
			-- Reset the input and output lists
		do
			input_list.clear_items
			output_list.clear_items
		end

feature {ELMT_HOLE}

	update_input_hole (arg: EV_ARGUMENT; ev_data: EV_PND_EVENT_DATA) is
			-- Update the function with the information contained in the
			-- entry `ev_data'.
		local
			dt: PND_DATA
		do
			if edited_function /= Void then
				dt ?= ev_data.data
				check
					invalid_data: dt /= Void
				end
				set_input_data (ev_data.data_type, dt)
				edited_function.set_input_data (dt)
				edited_function.drop_pair
			end
		end

	update_output_hole (arg: EV_ARGUMENT; ev_data: EV_PND_EVENT_DATA) is
			-- Update the function with the
			-- information contained in the
			-- entry hole `hole'.
		local
			dt: PND_DATA
		do
			if edited_function /= Void then
				dt ?= ev_data.data
				check
					invalid_data: dt /= Void
				end
				set_output_data (ev_data.data_type, dt)
				edited_function.set_output_data (dt)
				edited_function.drop_pair
			end
		end

feature {NONE}

	set_input_data (dt_type: EV_PND_TYPE; dt: PND_DATA) is
			-- Set data of input_stone to `st'.
		local
			elmt: EB_ICON_LIST_ITEM [PND_DATA]
		do
			create elmt.make_with_text (input_stone, <<dt.label>>)
--XX		elmt.set_pixmap (dt.symbol)
			elmt.activate_pick_and_drop (Void, Void)
			elmt.set_data_type (dt_type)
			elmt.set_transported_data (dt)
		end

	set_output_data (dt_type: EV_PND_TYPE; dt: PND_DATA) is
			-- Set data of output_stone to `st'.
		local
			elmt: EB_ICON_LIST_ITEM [PND_DATA]
		do
			create elmt.make_with_text (input_stone, <<dt.label>>)
--XX		elmt.set_pixmap (dt.symbol)
			elmt.activate_pick_and_drop (Void, Void)
			elmt.set_data_type (dt_type)
			elmt.set_transported_data (dt)
		end

end -- class FUNC_EDITOR


indexing
	description: "Class importer used to choose for which application %
				% class the user wants to generate an object tool %
				% editor."
	date: "$Date$"
	id: "$Id$"
	revision: "$Revision$"

class
	CLASS_IMPORTER

inherit

	EV_WINDOW
		redefine
			make_top_level
		end

	SHARED_CLASS_IMPORTER

	EV_COMMAND

	CLOSEABLE

	WINDOWS

	CONSTANTS

creation
	make_top_level

feature -- Creation

	make_top_level is
			-- Create class selector.
		local
			vertical_box: EV_VERTICAL_BOX
			horizontal_box: EV_HORIZONTAL_BOX
			frame: EV_FRAME
			fixed: EV_FIXED
		do
			{EV_WINDOW} Precursor
			create horizontal_box.make (Current)
			horizontal_box.set_homogeneous (False)
			horizontal_box.set_spacing (10)

			create frame.make_with_text (horizontal_box, "Select a class")
			create available_classes_list.make (frame)
			
			create vertical_box.make (horizontal_box)
			vertical_box.set_expand (False)
			vertical_box.set_homogeneous (False)
			vertical_box.set_spacing (10)
			create refresh_button.make (vertical_box)
			create generate_command_button.make (vertical_box)
			create generate_object_editor_button.make (vertical_box)
			create fixed.make (vertical_box)

			set_values
			set_callbacks
		end

	set_values is
			-- Set values for the GUI elements
--		local
--			set_colors: SET_WINDOW_ATTRIBUTES_COM
		do
			set_minimum_width (resources.class_importer_width)
			set_minimum_height (resources.class_importer_height)
			set_x_y (resources.class_importer_x, resources.class_importer_y)
--			!! set_colors
--			set_colors.execute (Current)
			set_title ("Class importer")
			available_classes_list.set_minimum_width (2 * resources.class_importer_width // 3)
			refresh_button.set_text ("Refresh")
			refresh_button.set_expand (False)
			generate_command_button.set_text ("Generate command")
			generate_command_button.set_expand (False)
			generate_object_editor_button.set_text ("Object Editor")
			generate_object_editor_button.set_expand (False)
		end

	set_callbacks is
			-- Sets the callbacks on the GUI elements.
		local
			close_cmd: CLOSE_WINDOW
			arg: EV_ARGUMENT1 [EV_BUTTON]
 		do
			create arg.make (refresh_button)
 			refresh_button.add_click_command (Current, arg)
			create arg.make (generate_command_button)
 			generate_command_button.add_click_command (Current, arg)
			create arg.make (generate_object_editor_button)
 			generate_object_editor_button.add_click_command (Current, arg)

 			create close_cmd.make (Current)
			add_close_command (close_cmd, Void)
		end

feature -- Generation tools

	object_command_generator: OBJECT_COMMAND_GENERATOR is
			-- Command generation from a feature
		once
			create Result.make (Current)
		end

	object_tool_generator: OBJECT_TOOL_GENERATOR is
			-- Object editor generation from a class
		once
			create Result.make (Current)
		end

feature {NONE} -- GUI attributes

	available_classes_list: EV_LIST
			-- List of available classes

	refresh_button,
			-- Refresh button

	generate_command_button,
			-- Button that open the object command generator

	generate_object_editor_button: EV_BUTTON
			-- Button that open the object editor generator

feature -- Command execution

	execute (args: EV_ARGUMENT1 [EV_BUTTON]; data: EV_EVENT_DATA) is
		do
 			if args.first = refresh_button then
 				close_object_windows
 				generate_lists
 			elseif args.first = generate_command_button then
 				if available_classes_list.selected then
 					object_command_generator.display (available_classes_list.selected_item)
 				end
 			elseif args.first = generate_object_editor_button then
 				if available_classes_list.selected then
 					object_tool_generator.display (available_classes_list.selected_item)
 				end
 			end
		end

feature 

	display is
			-- Display class selector.
		do
			show
 			generate_lists
		end

	close is
			-- Close class selector, object tool generator
			-- and object command generator.
		do
			hide
 			close_object_windows
 			main_panel.class_importer_entry.set_toggle_off
		end

feature {NONE}

	close_object_windows is
			-- Close object tool generator and object command generator.
		do
-- 			if object_command_generator.realized then
-- 				object_command_generator.close
-- 			end
-- 			if object_tool_generator.realized then
-- 				object_tool_generator.close
-- 			end
		end

feature -- Lists generation

	generate_lists is
			-- Generate `available_list' and `selected_list'
		local
			import_cmd: IMPORT_APPLICATION_CLASS_CMD	
			selected_classes: ARRAYED_LIST [APPLICATION_CLASS]
			arg: EV_ARGUMENT1 [EV_LIST]
			event_data: EV_EVENT_DATA
		do
 			class_list.wipe_out
			available_classes_list.clear_items
			create import_cmd
			create arg.make (available_classes_list)
			create event_data.make
 			import_cmd.execute (arg, event_data)
		end

end -- class CLASS_IMPORTER
 


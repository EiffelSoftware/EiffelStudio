indexing
	description: "Class representing the command generator %
				% which allows the user to build a (EBUILD) %
				% command from a feature."
	date: "$Date$"
	id: "$Id$"
	revision: "$Revision$"

class
	OBJECT_COMMAND_GENERATOR

inherit

	EV_WINDOW
		redefine
			make
		end

	SHARED_CLASS_IMPORTER

	CLOSEABLE

	CONSTANTS

creation

	make

feature -- Initialization

	make (par: EV_WINDOW) is
			-- Create the object tool generator.
		local
			vertical_box: EV_VERTICAL_BOX
			horizontal_box: EV_HORIZONTAL_BOX
			frame: EV_FRAME
		do
			{EV_WINDOW} Precursor (par)

			create vertical_box.make (Current)
			vertical_box.set_homogeneous (False)
			vertical_box.set_spacing (5)
			create frame.make_with_text (vertical_box, "Available features")
			create routine_list.make (frame)

			create horizontal_box.make (vertical_box)
			horizontal_box.set_expand (False)
			create precondition_toggle_b.make_with_text (horizontal_box,
														"Precondition test")
			create generate_button.make (horizontal_box)

			create frame.make_with_text (vertical_box, "Generated commands")
			create generated_routines.make (frame)

			set_values
			set_callbacks
		end

	set_values is
			-- Set velues for GUI elements.
--		local
--			set_colors: SET_WINDOW_ATTRIBUTES_COM
		do
			set_title ("Object command generator:")
--			!! set_colors
--			set_colors.execute (Current)
			set_minimum_width (resources.Object_command_generator_width)
			set_minimum_height (resources.Object_command_generator_height)
			generate_button.set_text ("Generate")
			generate_button.set_horizontal_resize (False)
			generate_button.set_vertical_resize (False)

 			precondition_toggle_b.set_state (True)
		end

	set_callbacks is
			-- Set callbacks.
		local
			close_cmd: CLOSE_WINDOW
			generate_cmd: GENERATE_OBJECT_COMMAND_CMD
		do
-- 			!! generate_cmd
-- 			generate_button.add_activate_action (generate_cmd, precondition_toggle_b)
-- 			routine_list.add_default_action (generate_cmd, precondition_toggle_b)
 			create close_cmd.make (Current)
 			add_close_command (close_cmd, Void)
		end

feature {NONE} -- GUI attributes

	generate_button: EV_BUTTON
			-- `Generate' button

	separator: EV_HORIZONTAL_SEPARATOR
			-- Separator between the list and the button

feature -- GUI attributes

	routine_list,
			-- List of available routines

	generated_routines: EV_LIST
			-- List of generated routines

	precondition_toggle_b: EV_CHECK_BUTTON
			-- Precondition tes toggle button

feature -- Command execution

	generate_command is
		-- Move the command to `generated_routines' list.
		local
			routine: APPLICATION_ROUTINE
		do
-- 			routine_list.go_i_th (routine_list.selected_position)
-- 			generated_routines.extend (routine_list.item)
-- 			generated_routines.set_insensitive
-- 			routine ?= routine_list.item
-- 			edited_class.add_generated_routine (routine)
-- 			routine_list.remove
-- 			routine_list.go_i_th (routine_list.count)			
		end
			

feature -- Closeable

	close is
			-- Close object tool generator.
		do
			hide
		end

	display (application_class: EV_LIST_ITEM) is
			-- Display object tool generator.
		require
			class_not_void: application_class /= Void
		do
			show
-- 			raise
 			edited_class ?= application_class
 			check
 				edited_class_not_void: edited_class /= Void
 			end
 			update_interface
		end

feature {NONE} -- Implementation

	update_interface is
			-- Update the interface according to the new application
			-- class that is edited.
		require
			edited_class_not_void: edited_class /= Void
		local
			rout_list: LINKED_LIST [APPLICATION_ROUTINE]
			generated_routines_list: LINKED_LIST [APPLICATION_ROUTINE]
			temp_title: STRING
			list_item: EV_LIST_ITEM
		do
 			create temp_title.make (0)
 			temp_title.append ("Object command generator: ")
 			temp_title.append (edited_class.class_name)
 			set_title (temp_title)
 			routine_list.clear_items
 			generated_routines.clear_items
 			generated_routines_list := edited_class.generated_routines
 			rout_list := edited_class.routine_list
 			from
 				generated_routines_list.start
 			until
 				generated_routines_list.after
 			loop
				create list_item.make_with_text (generated_routines,
											generated_routines_list.item.value)
 				generated_routines_list.forth
 			end
 				
 			from
 				rout_list.start
 			until
 				rout_list.after
 			loop
-- 				if not generated_routines.has (rout_list.item) then
					create list_item.make_with_text (routine_list,
													rout_list.item.value)
-- 				end
 				rout_list.forth
 			end
		end

feature -- Attribute

	edited_class: APPLICATION_CLASS
			-- Currently edited application class


end -- class OBJECT_COMMAND_GENERATOR

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

	EB_TOP_SHELL
		redefine
			make
		end

	SHARED_CLASS_IMPORTER

	CLOSEABLE

creation

	make

feature -- Initialization

	make (a_name: STRING; a_screen: SCREEN) is
			-- Create the object tool generator.
		do
			{EB_TOP_SHELL} Precursor (a_name, a_screen)
			!! top_form.make ("", Current)
			!! available_label.make ("Available commands:", top_form)
			!! generated_label.make ("Generated commands:", top_form)
			!! routine_list.make ("", top_form)
			!! generated_routines.make ("", top_form)
			!! generate_button.make ("Generate", top_form)
			!! separator.make ("", top_form)
			!! precondition_toggle_b.make ("Precondition test", top_form)
			set_values
			attach_all
			set_callbacks
		end

	set_values is
			-- Set velues for GUI elements.
		local
			set_colors: SET_WINDOW_ATTRIBUTES_COM
		do
			!! set_colors
			set_colors.execute (Current)
			set_size (Resources.Object_command_generator_width, Resources.Object_command_generator_height)
		end

	attach_all is
			-- Perform attachments.
		do
			top_form.set_fraction_base (2)
			top_form.attach_bottom (generate_button, 0)
			top_form.attach_bottom (precondition_toggle_b, 0)
			top_form.attach_left (precondition_toggle_b, 5)
			top_form.attach_right (generate_button, 0)
			top_form.attach_bottom_widget (generate_button, separator, 0)
			top_form.attach_left (separator, 0)
			top_form.attach_right (separator, 0)
			top_form.attach_bottom_widget (separator, routine_list, 0)
			top_form.attach_bottom_widget (separator, generated_routines, 0)
			top_form.attach_left (routine_list, 0)
			top_form.attach_right_position (routine_list, 1)
			top_form.attach_right (generated_routines, 0)
			top_form.attach_left_position (generated_routines, 1)
			top_form.attach_top_widget (available_label, routine_list, 3)
			top_form.attach_top_widget (generated_label, generated_routines, 3)
			top_form.attach_top (available_label, 0)
			top_form.attach_left (available_label, 0)
			top_form.attach_right_position (available_label, 1)
			top_form.attach_top (generated_label, 0)
			top_form.attach_right (generated_label, 0)
			top_form.attach_left_position (generated_label, 1)
		end

	set_callbacks is
			-- Set callbacks.
		local
			del_com: DELETE_WINDOW
			generate_cmd: GENERATE_OBJECT_COMMAND_CMD
		do
			!! generate_cmd
			generate_button.add_activate_action (generate_cmd, precondition_toggle_b)
			routine_list.add_default_action (generate_cmd, precondition_toggle_b)
			!! del_com.make (Current)
			set_delete_command (del_com)
			precondition_toggle_b.arm
		end

feature {NONE} -- GUI attributes

	available_label,
			-- Available routines label

	generated_label: LABEL
			-- Generated routines label

	top_form: FORM
			-- Form of the top shell

	generate_button: PUSH_B
			-- `Generate' button

	separator: THREE_D_SEPARATOR
			-- Separator between the list and the button

feature -- GUI attributes

	routine_list,
			-- List of available routines

	generated_routines: SCROLLABLE_LIST
			-- List of generated routines

	precondition_toggle_b: TOGGLE_B
			-- Precondition tes toggle button

feature -- Command execution

	generate_command is
		-- Move the command to `generated_routines' list.
		local
			routine: APPLICATION_ROUTINE
		do
			routine_list.go_i_th (routine_list.selected_position)
			generated_routines.extend (routine_list.item)
			generated_routines.set_insensitive
			routine ?= routine_list.item
			edited_class.add_generated_routine (routine)
			routine_list.remove
			routine_list.go_i_th (routine_list.count)			
		end
			

feature -- Closeable

	close is
			-- Close object tool generator.
		do
			hide
		end

	display (application_class: SCROLLABLE_LIST_ELEMENT) is
			-- Display object tool generator.
		require
			class_not_void: application_class /= Void
		do
			if not realized then
				realize
			else
				show
				raise
			end
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
		do
			!! temp_title.make (0)
			temp_title.append ("Object command generator: ")
			temp_title.append (edited_class.class_name)
			set_title (temp_title)
			routine_list.wipe_out
			generated_routines.wipe_out
			generated_routines_list := edited_class.generated_routines
			rout_list := edited_class.routine_list
			from
				generated_routines_list.start
			until
				generated_routines_list.after
			loop
				generated_routines.extend (generated_routines_list.item)
				generated_routines_list.forth
			end
				
			from
				rout_list.start
			until
				rout_list.after
			loop
				if not generated_routines.has (rout_list.item) then
					routine_list.extend (rout_list.item)
				end
				rout_list.forth
			end
		end

feature -- Attribute

	edited_class: APPLICATION_CLASS
			-- Currently edited application class


end -- class OBJECT_COMMAND_GENERATOR

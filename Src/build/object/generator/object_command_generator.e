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
			!! routine_list.make ("", top_form)
			!! generate_button.make ("Generate", top_form)
			!! separator.make ("", top_form)
			!! precondition_toggle_b.make ("Precondition test")
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
--			set_size (410, 160)
			set_size (Resources.Object_command_generator_width, Resources.Object_command_generator_height)
		end

	attach_all is
			-- Perform attachments.
		do
			top_form.attach_bottom (generate_button, 0)
			top_form.attach_bottom (precondition_toggle_b, 0)
			top_form.attach_left (precondition_toggle_b, 5)
			top_form.attach_right (generate_button, 0)
			top_form.attach_bottom_widget (generate_button, separator, 0)
			top_form.attach_left (separator, 0)
			top_form.attach_right (separator, 0)
			top_form.attach_bottom_widget (separator, routine_list, 0)
			top_form.attach_left (routine_list, 0)
			top_form.attach_right (routine_list, 0)
			top_form.attach_top (routine_list, 0)
		end

	set_callbacks is
			-- Set callbacks.
		local
			del_com: DELETE_WINDOW
			generate_cmd: GENERATE_OBJECT_COMMAND_CMD
		do
			!! generate_cmd
			generate_button.add_activate_action (generate_cmd, precondition_toggle_b)
			!! del_com.make (Current)
			set_delete_command (del_com)
		end

feature {NONE} -- GUI attributes

	top_form: FORM
			-- Form of the top shell

	generate_button: PUSH_B
			-- `Generate' button

	separator: THREE_D_SEPARATOR
			-- Separator between the list and the button

feature -- GUI attributes

	routine_list: SCROLLABLE_LIST
			-- List of avaible routines

	precondition_toggle_b: TOGGLE_B
			-- Precondition tes toggle button

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
			temp_title: STRING
		do
			!! temp_title.make (0)
			temp_title.append ("Object command generator: ")
			temp_title.append (edited_class.class_name)
			set_title (temp_title)
			routine_list.wipe_out
			rout_list := edited_class.routine_list
			from
				rout_list.start
			until
				rout_list.after
			loop
				routine_list.extend (rout_list.item)
				rout_list.forth
			end
		end

feature -- Attribute

	edited_class: APPLICATION_CLASS
			-- Currently edited application class


end -- class OBJECT_COMMAND_GENERATOR

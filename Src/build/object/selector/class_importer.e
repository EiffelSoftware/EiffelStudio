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

	EB_TOP_SHELL
		redefine
			make
		end

	SHARED_CLASS_IMPORTER

	COMMAND

	COMMAND_ARGS

	CLOSEABLE

	WINDOWS
		select
			init_toolkit
		end
	
creation
	make

feature -- Creation

	make (a_name:STRING; a_screen: SCREEN) is
			-- Create class selector.
		do
			{EB_TOP_SHELL} Precursor (a_name, a_screen)
			!! top_form.make ("", Current)
			!! available_label.make ("", top_form)
			!! available_list.make ("", top_form)
			!! selected_label.make ("", top_form)
			!! selected_list.make ("", top_form)
			!! arrow_form.make ("", top_form)
			!! refresh_button.make ("Refresh", arrow_form)
			!! blank_label.make ("", arrow_form)
			!! select_button.make ("", arrow_form)
			!! unselect_button.make ("", arrow_form)
			!! separator1.make ("", top_form)
			!! button_form.make ("", top_form)
			!! generate_label.make ("Generate", top_form)
			!! generate_tool_button.make ("Object Editor", button_form)
			!! generate_command_button.make ("Command", button_form)
			set_values
			attach_all
			set_callbacks
		end

	set_values is
			-- Set values for the GUI elements
		local
			set_colors: SET_WINDOW_ATTRIBUTES_COM
		do
			set_size (resources.class_importer_width, resources.class_importer_height)
			set_x_y (resources.class_importer_x, resources.class_importer_y)
			!! set_colors
			set_colors.execute (Current)
			set_title ("Class importer")
			available_label.set_text ("Available classes")
			available_list.set_multiple_selection
			available_list.compare_objects
			selected_label.set_text ("Selected classes")
			selected_list.set_single_selection
			selected_list.compare_objects
			select_button.set_down
			unselect_button.set_up
		end

	attach_all is
			-- Perform attachments.
		do
			arrow_form.attach_top (refresh_button, 0)
			arrow_form.attach_top (blank_label, 0)
			arrow_form.attach_top (select_button, 0)
			arrow_form.attach_top (unselect_button, 0)
			arrow_form.attach_bottom (refresh_button, 0)
			arrow_form.attach_bottom (blank_label, 0)
			arrow_form.attach_bottom (select_button, 0)
			arrow_form.attach_bottom (unselect_button, 0)
			arrow_form.attach_left (refresh_button, 0)
			arrow_form.attach_left_widget (refresh_button, blank_label, 0)
			arrow_form.attach_right (unselect_button, 0)
			arrow_form.attach_right_widget (unselect_button, select_button, 0)
			arrow_form.attach_right_widget (select_button, blank_label, 0)

			button_form.set_fraction_base (2)
			button_form.attach_top (generate_tool_button, 0)
			button_form.attach_top (generate_command_button, 0)
			button_form.attach_bottom (generate_tool_button, 0)
			button_form.attach_bottom (generate_command_button, 0)
			button_form.attach_left (generate_tool_button, 0)
			button_form.attach_right_position (generate_tool_button, 1)
			button_form.attach_left_position (generate_command_button, 1)
			button_form.attach_right (generate_command_button, 0)

			top_form.set_fraction_base (100)
			top_form.attach_top (available_label, 0)
			top_form.attach_left (available_label, 0)
			top_form.attach_right (available_label, 0)
			top_form.attach_top_widget (available_label, available_list, 5)
			top_form.attach_left (available_list, 0)
			top_form.attach_right (available_list, 0)
			top_form.attach_bottom_widget (arrow_form, available_list, 5)
			top_form.attach_left (arrow_form, 0)
			top_form.attach_right (arrow_form, 0)
			top_form.attach_bottom_widget (selected_label, arrow_form, 5)
			top_form.attach_left (selected_label, 0)
			top_form.attach_right (selected_label, 0)
			top_form.attach_bottom_position (selected_label, 60)
			top_form.attach_top_position (selected_list, 60)
			top_form.attach_left (selected_list, 0)
			top_form.attach_right (selected_list, 0)
			top_form.attach_bottom_widget (separator1, selected_list, 5)
			top_form.attach_left (separator1, 0)
			top_form.attach_right (separator1, 0)
			top_form.attach_bottom_widget (generate_label, separator1, 2)
			top_form.attach_left (generate_label, 0)
			top_form.attach_right (generate_label, 0)
			top_form.attach_bottom_widget (button_form, generate_label, 2)
			top_form.attach_left (button_form, 0)
			top_form.attach_right (button_form, 0)
			top_form.attach_bottom (button_form, 0)
		end

	set_callbacks is
			-- Sets the callbacks on the GUI elements.
		local
			import_cmd: IMPORT_APPLICATION_CLASS_CMD
			del_com: DELETE_WINDOW
		do
			available_list.add_default_action (Current, First)
			selected_list.add_default_action (Current, Second)
			select_button.add_activate_action (Current, First)
			unselect_button.add_activate_action (Current, Second)
			refresh_button.add_activate_action (Current, Third)
			generate_tool_button.add_activate_action (Current, Fourth)
			generate_command_button.add_activate_action (Current, Fifth)
			!! del_com.make (Current)
			set_delete_command (del_com)
		end

feature {NONE} -- GUI attributes

	top_form,
			-- Form of the top shell

	arrow_form,
			-- Form containing the arrow buttons

	button_form: FORM
			-- Form containing the two buttons

	available_label,
			-- Available classes label

	selected_label,
			-- Selected classes label

	blank_label,
			-- Blank label

	generate_label: LABEL
			-- Generate label	

	available_list,
			-- List of available classes

	selected_list: SCROLLABLE_LIST
			-- List of selected classes

	select_button,
			-- Button used to select classes

	unselect_button: ARROW_B
			-- Button used to deselect classes

	generate_tool_button: PUSH_B
			-- `Generate Tool' button

	generate_command_button: PUSH_B
			-- `Generate Command' button

	refresh_button: PUSH_B
			-- `Refresh' button

	separator1: THREE_D_SEPARATOR
			-- Separator between `selected_list' and `button_form'

feature -- Command execution

	execute (arg: ANY) is
		do
			if arg = First then
				select_classes
			elseif arg = Second then
				unselect_classes
			elseif arg = Third then
				generate_lists
			elseif arg = Fourth then
				if selected_list.selected_count > 0 then
					object_tool_generator.display (selected_list.selected_item)
				end
			elseif arg = Fifth then
				if selected_list.selected_count > 0 then
					object_command_generator.display (selected_list.selected_item)
				end
			end
		end

	select_classes is
			-- Move all selected classes of `available_list' into
			-- `selected_list'.
		local
			selected_items: LINKED_LIST [SCROLLABLE_LIST_ELEMENT]
			finished: BOOLEAN
		do
			if available_list.selected_count > 0 then
				!! selected_items.make
				selected_items := available_list.selected_items
				from
					selected_items.start
				until
					selected_items.after
				loop
					from
						available_list.start
						finished := False
					until
						available_list.after or finished
					loop
						if available_list.item.value.is_equal (selected_items.item.value) then
							finished := True
							available_list.remove
						else
							available_list.forth
						end
					end
					from
						selected_list.start
						finished := False
					until
						selected_list.after or finished
					loop
						if selected_list.item.value > selected_items.item.value then
							finished := True
							selected_list.put_left (selected_items.item)
						end
						selected_list.forth
					end
					if not finished then
						selected_list.extend (selected_items.item)
					end
					selected_items.forth
				end
				if not finished then
					selected_list.select_item	
				else
					selected_list.select_i_th (selected_list.index - 2)	
				end
			end
		end

	unselect_classes is
			-- Move all selected classes of `selected_list' into
			-- `available_list'.
		local
			selected_items: LINKED_LIST [SCROLLABLE_LIST_ELEMENT]
			finished: BOOLEAN
		do
			if selected_list.selected_count > 0 then
				!! selected_items.make
				selected_items := selected_list.selected_items
				from
					selected_items.start
				until
					selected_items.after
				loop
					from
						selected_list.start
						finished := False
					until
						selected_list.after or finished
					loop
						if selected_list.item.value.is_equal (selected_items.item.value) then
							finished := True
							selected_list.remove
						else
							selected_list.forth
						end
					end
					from
						available_list.start
						finished := False
					until
						available_list.after or finished
					loop
						if available_list.item.value > selected_items.item.value then
							finished := True
							available_list.put_left (selected_items.item)
						end
						available_list.forth
					end
					if not finished then
						available_list.extend (selected_items.item)
					end
					selected_items.forth
				end
				selected_list.select_i_th (selected_list.count)
			end
		end

feature 

	display is
			-- Display class selector.
		do
			if not realized then
				realize
			else
				show
			end
			generate_lists
		end

	close is
			-- Close class selector.
		do
			hide
			if object_command_generator.realized then
				object_command_generator.close
			end
			if object_tool_generator.realized then
				object_tool_generator.close
			end
			main_panel.class_importer_entry.set_toggle_off
		end

feature -- Lists generation

	generate_lists is
			-- Generate `available_list' and `selected_list'
		local
			import_cmd: IMPORT_APPLICATION_CLASS_CMD	
			inserted: BOOLEAN
		do
			!! import_cmd
			class_list.wipe_out
			import_cmd.execute (Void)
			available_list.wipe_out
			from 
				class_list.start
			until
				class_list.after
			loop
				if not selected_list.has (class_list.item) then
					available_list.extend (class_list.item)
				end
				class_list.forth
			end
		end

end -- class CLASS_IMPORTER
 


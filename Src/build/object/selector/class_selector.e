indexing
	description: "Class selector used to choose for which application %
				% class the user wants to generate an object tool %
				% editor."
	date: "$Date$"
	id: "$Id$"
	revision: "$Revision$"

class
	CLASS_SELECTOR

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
			!! select_button.make ("", arrow_form)
			!! unselect_button.make ("", arrow_form)
			!! separator1.make ("", top_form)
			!! button_form.make ("", top_form)
			!! generate_button.make ("Generate", button_form)
			!! refresh_button.make ("Refresh", button_form)
			set_values
			attach_all
			set_callbacks
		end

	set_values is
			-- Set values for the GUI elements
		local
			set_colors: SET_WINDOW_ATTRIBUTES_COM
		do
			set_size (300, 300)
			!! set_colors
			set_colors.execute (Current)
			set_title ("Class selector")
			available_label.set_text ("Available classes")
			available_label.set_left_alignment
			available_list.set_multiple_selection
			available_list.compare_objects
			selected_label.set_text ("Selected classes")
			selected_label.set_left_alignment
			selected_list.set_single_selection
			selected_list.compare_objects
			select_button.set_down
			unselect_button.set_up
		end

	attach_all is
			-- Perform attachments.
		do
			arrow_form.attach_top (select_button, 0)
			arrow_form.attach_top (unselect_button, 0)
			arrow_form.attach_bottom (select_button, 0)
			arrow_form.attach_bottom (unselect_button, 0)
			arrow_form.attach_left (select_button, 70)
			arrow_form.attach_right (unselect_button, 70)

			button_form.set_fraction_base (100)
			button_form.attach_top (generate_button, 0)
			button_form.attach_top (refresh_button, 0)
			button_form.attach_bottom (generate_button, 0)
			button_form.attach_bottom (refresh_button, 0)
			button_form.attach_left (generate_button, 20)
			button_form.attach_right_position (generate_button, 45)
			button_form.attach_left_position (refresh_button, 55)
			button_form.attach_right (refresh_button, 20)

			top_form.attach_top (available_label, 0)
			top_form.attach_left (available_label, 0)
			top_form.attach_right (available_label, 0)
			top_form.attach_top_widget (available_label, available_list, 5)
			top_form.attach_left (available_list, 5)
			top_form.attach_right (available_list, 5)
			top_form.attach_top_widget (available_list, arrow_form, 15)
			top_form.attach_left (arrow_form, 0)
			top_form.attach_right (arrow_form, 0)
			top_form.attach_top_widget (arrow_form, selected_label, 0)
			top_form.attach_left (selected_label, 0)
			top_form.attach_right (selected_label, 0)
			top_form.attach_top_widget (selected_label, selected_list, 5)
			top_form.attach_left (selected_list, 5)
			top_form.attach_right (selected_list, 5)
			top_form.attach_top_widget (selected_list, separator1, 5)
			top_form.attach_left (separator1, 0)
			top_form.attach_right (separator1, 0)
			top_form.attach_top_widget (separator1, button_form, 2)
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
			select_button.add_activate_action (Current, First)
			unselect_button.add_activate_action (Current, Second)
			refresh_button.add_activate_action (Current, Third)
			generate_button.add_activate_action (Current, Fourth)
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

	selected_label: LABEL
			-- Selected classes

	available_list,
			-- List of available classes

	selected_list: SCROLLABLE_LIST
			-- List of selected classes

	select_button,
			-- Button used to select classes

	unselect_button: ARROW_B
			-- Button used to deselect classes

	generate_button: PUSH_B
			-- `Generate' button

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
			main_panel.class_selector_entry.set_toggle_off
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
			if not available_list.empty then
				available_list.start
				available_list.merge_right (class_list)
			else
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
		end

end -- class CLASS_SELECTOR

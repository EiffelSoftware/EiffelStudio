indexing
	description: "Form containing a set of query properties used to generate %
			% the corresponding object editor. Used when the returned %
			% is BOOLEAN."
	date: "$Date$"
	id: "$Id$"
	revision: "$Revision$"

class
	BOOLEAN_QUERY_EDITOR_FORM

inherit

	QUERY_EDITOR_FORM

	COMMAND

creation
	make

feature {NONE} --GUI

	create_interface is
			-- Create interface.
		do
			!! bottom_form.make ("", Current)
			!! separator.make ("", Current)
			!! query_label.make ("", Current)

			!! test_toggle_b.make ("Precondition test", Current)
			!! test_label.make("Error message:", Current)
			!! test_text_field.make ("", Current)

			!! select_procedure_box.make ("", Current)
			!! one_procedure_toggle_b.make ("One procedure,", select_procedure_box)
			!! two_procedure_toggle_b.make ("Two procedures", select_procedure_box)
			!! argument_label.make ("with boolean argument:", Current)
			!! procedure_opt_pull.make ("", Current)
			!! set_true_label.make ("set True:", Current)
			!! true_opt_pull.make ("", Current)
			!! set_false_label.make ("set False:", Current)
			!! false_opt_pull.make ("", Current)

			!! select_label.make ("Select through:", bottom_form)
			!! select_radio_box.make ("", bottom_form)
			!! check_toggle_b.make ("Check box", select_radio_box)
			!! radio_toggle_b.make ("Radio buttons", select_radio_box)
			!! menu_toggle_b.make ("Menu", select_radio_box)

			!! check_label.make ("Label:", bottom_form)
			!! check_field.make ("", bottom_form)
			!! radio_true_label.make ("True label:", bottom_form)
			!! radio_true_field.make ("", bottom_form)
			!! radio_false_label.make ("False label:", bottom_form)
			!! radio_false_field.make ("", bottom_form)

			!! menu_true_label.make ("True entry:", bottom_form)
			!! menu_true_field.make ("", bottom_form)
			!! menu_false_label.make ("False entry:", bottom_form)
			!! menu_false_field.make ("", bottom_form)
			set_values
			attach_all
			set_callbacks
		end

	set_values is
			-- Set values for GUI elements.
		local
			set_colors: SET_WINDOW_ATTRIBUTES_COM
		do
			set_size (475, 210)
			!! set_colors
			set_colors.execute (Current)
			select_radio_box.set_always_one (True)
			check_toggle_b.set_toggle_on
			select_procedure_box.set_always_one (True)
			one_procedure_toggle_b.set_toggle_on
			true_opt_pull.set_insensitive
			false_opt_pull.set_insensitive	
			desactivate_all_fields
			radio_true_field.set_text ("True")
			radio_true_field.set_width (115)
			radio_false_field.set_text ("False")
			radio_false_field.set_width (115)
			menu_true_field.set_text ("Yes")
			menu_true_field.set_width (115)
			menu_false_field.set_text ("No")
			menu_false_field.set_width (115)
			query_label.set_left_alignment
			if object_tool_generator.precondition_test.state then
				test_toggle_b.arm
			else	
				test_text_field.set_insensitive
			end
		end

	attach_all is
			-- Perform attachments.
		do
 			attach_top (query_label, 5)
 			attach_left (query_label, 0)
			attach_right (query_label, 0)

			attach_left (test_toggle_b, 5)
	   		attach_top_widget (query_label, test_toggle_b, 5)
			attach_top_widget (query_label, test_label, 11) 
			attach_top_widget (query_label, test_text_field, 5) 
			attach_left_widget (test_toggle_b, test_label, 0)
			attach_left_widget (test_label, test_text_field, 10)
			attach_right (test_text_field, 0)

 			attach_top_widget (test_toggle_b, select_procedure_box, 5)
			attach_top_widget (test_label, argument_label, 18)
 			attach_top_widget (test_text_field, procedure_opt_pull, 12)
			attach_left (select_procedure_box, 5)
  			attach_left_widget (select_procedure_box, argument_label, 0)
			attach_left_widget (argument_label, procedure_opt_pull, 5)
			attach_top_widget (argument_label, set_true_label, 13)
			attach_top_widget (argument_label, true_opt_pull, 5)
			attach_top_widget (argument_label, set_false_label, 13)
			attach_top_widget (procedure_opt_pull, false_opt_pull, 5)
			attach_left_widget (select_procedure_box, set_true_label, 0)
			attach_left_widget (set_true_label, true_opt_pull, 7)
			attach_left_widget (true_opt_pull, set_false_label, 5)
			attach_left_widget (set_false_label, false_opt_pull, 5)
			

			attach_top_widget (select_procedure_box, bottom_form, 10)
			attach_top_widget (set_true_label, bottom_form, 10)
			attach_top_widget (true_opt_pull, bottom_form, 10)
			attach_top_widget (set_false_label, bottom_form, 10)
			attach_top_widget (false_opt_pull, bottom_form, 10)						
			attach_left (bottom_form, 0)
			attach_right (bottom_form, 0)

 			attach_top_widget (bottom_form, separator, 0)
 			attach_left (separator, 0)
 			attach_right (separator, 0)
 			attach_bottom (separator, 0)
			
			bottom_form.attach_left (select_label, 10)
			bottom_form.attach_top (select_label, 5)
			bottom_form.attach_top_widget (select_label, select_radio_box, 0)		
			bottom_form.attach_left (select_radio_box, 20)
			
			bottom_form.attach_top (check_label, 25)
			bottom_form.attach_top (check_field, 20)
			bottom_form.attach_left_widget (select_radio_box, check_label, 0)
			bottom_form.attach_left_widget (check_label, check_field, 5)

			bottom_form.attach_top_widget (check_label, radio_true_label, 13)
			bottom_form.attach_top_widget (check_field, radio_true_field, 10)
			bottom_form.attach_top_widget (check_field, radio_false_label, 15)
			bottom_form.attach_top_widget (check_field, radio_false_field, 10)
			bottom_form.attach_left_widget (select_radio_box, radio_true_label, 0)
			bottom_form.attach_left_widget (radio_true_label, radio_true_field, 6)
			bottom_form.attach_left_widget (radio_true_field, radio_false_label, 8)
			bottom_form.attach_left_widget	(radio_false_label, radio_false_field, 6)

			bottom_form.attach_top_widget (radio_true_label, menu_true_label, 13)
			bottom_form.attach_top_widget (radio_true_field, menu_true_field, 10)
			bottom_form.attach_top_widget (radio_false_label, menu_false_label, 13)
			bottom_form.attach_top_widget (radio_false_field, menu_false_field, 10)
			bottom_form.attach_left_widget (select_radio_box, menu_true_label, 0)
			bottom_form.attach_left_widget (menu_true_label, menu_true_field, 5)
			bottom_form.attach_left_widget (menu_true_field, menu_false_label, 8)		
			bottom_form.attach_left_widget	(menu_false_label, menu_false_field, 5)

			bottom_form.attach_bottom (select_radio_box, 0)
		end	

	update_interface is
			-- Update the interface after setting `query'.
		local
			error_message, label: STRING
		do
			query_label.set_text (query.value)
			!! label.make (0)
			label.append (query.query_name)
			label.append (" ?")
			check_field.set_text (label)
			!! error_message.make (0)
			error_message.append ("Incorrect `")
			error_message.append (query.query_name)
			error_message.append ("' field.")
			test_text_field.set_text (error_message)
			update_procedures_list
		end

	set_callbacks is
			-- Add callbacks on GUI elements
		do
			test_toggle_b.add_activate_action (Current, Void)
			menu_toggle_b.add_activate_action (Current, Void)
			check_toggle_b.add_activate_action (Current, Void)
			radio_toggle_b.add_activate_action (Current, Void)
			one_procedure_toggle_b.add_activate_action (Current, Void)
			two_procedure_toggle_b.add_activate_action (Current, Void)
		end

feature {NONE} -- GUI attributes

	bottom_form: FORM
			-- Form at the bottom including radio_box and text_fields

	query_label,
			-- Query label

	argument_label,
			-- "with boolean argument" 

	set_true_label,
			-- Set true label

	set_false_label,
			-- Set false label

	test_label,
			-- Precondition test label
	
	check_label,
			--Label when selecting `menu_toggle_b' and `check_toggle_b'

	radio_true_label,
			-- True value

	radio_false_label,
			-- False value

	menu_true_label,
			-- True value

	menu_false_label,
			-- False value

	select_label: LABEL
			-- "Select through" label

	test_text_field,
			-- Text field used to add the precondition test

	check_field,
			-- Text field used to set the label

	menu_true_field,
			-- Text field used to set the true value

	menu_false_field,
			-- Text field used to set the false value

	radio_true_field,
			-- Text field used to set the true value

	radio_false_field: TEXT_FIELD
			-- Text field used to set the false value
	
	select_procedure_box,
			-- Radio box used to select the procedure used
			-- to set `query'

	select_radio_box: RADIO_BOX
			-- Radio box used to select the kind of widget used
			-- to edit the query

	one_procedure_toggle_b,
			-- One procedure with attribute

	two_procedure_toggle_b,
			-- Two procedures without argument

	test_toggle_b,
			-- Precondition test field

	check_toggle_b,
			-- 'Check_box' field

	menu_toggle_b,
			-- 'Menu' field

	radio_toggle_b: TOGGLE_B
			-- 'Radio_box' field

	separator: THREE_D_SEPARATOR
			-- Separator used between different query editor forms

feature -- Option pull used to select the procedure used to set `query'

	procedure_opt_pull,

	true_opt_pull,

	false_opt_pull: OPT_PULL

feature {NONE} -- Heuristic

	update_procedures_list is
			-- Display a list of compatible procedures
		require
			current_application_class_not_void: current_application_class /= Void
		local
			menu_entry, menu_entry_bis: APPLICATION_METHOD_PUSH_B
			procedure_empty: BOOLEAN
		do
			if not query.possible_commands.empty then
				from 
					query.possible_commands.finish
				until
					query.possible_commands.before
				loop
					!! menu_entry.make (query.possible_commands.item, procedure_opt_pull)
					query.possible_commands.back
				end
				procedure_opt_pull.set_selected_button (menu_entry)
			else
				procedure_opt_pull.set_insensitive
				two_procedure_toggle_b.set_toggle_on
				one_procedure_toggle_b.set_insensitive
				procedure_empty := True
			end

			if not query.possible_routines.empty then
				from 
					query.possible_routines.finish
				until
					query.possible_routines.before
				loop
					!! menu_entry.make (query.possible_routines.item, true_opt_pull)
					!! menu_entry_bis.make (query.possible_routines.item, false_opt_pull)
					query.possible_routines.back
				end
				true_opt_pull.set_selected_button (menu_entry)
				false_opt_pull.set_selected_button (menu_entry_bis)
			else
				true_opt_pull.set_insensitive
				false_opt_pull.set_insensitive
				if procedure_empty then
					one_procedure_toggle_b.set_toggle_off
					two_procedure_toggle_b.set_toggle_off
				else
					one_procedure_toggle_b.set_toggle_on
				end
				two_procedure_toggle_b.set_insensitive
			end	
		end

feature -- Execution

	execute (arg: ANY) is
			-- Activate or desactivate the menu fields.
		local
			a_menu_choice: STRING_SCROLLABLE_ELEMENT
			selected_items: LINKED_LIST [SCROLLABLE_LIST_ELEMENT]
			removed: BOOLEAN
			temp_string: STRING
		do
			if radio_toggle_b.state then 
				check_field.set_insensitive
				radio_true_field.set_sensitive
				radio_false_field.set_sensitive
				menu_true_field.set_insensitive
				menu_false_field.set_insensitive
			else
				check_field.set_sensitive
				desactivate_all_fields
				if menu_toggle_b.state then
					menu_true_field.set_sensitive
					menu_false_field.set_sensitive
				end
			end
		
			if one_procedure_toggle_b.state then
				procedure_opt_pull.set_sensitive
				true_opt_pull.set_insensitive
				false_opt_pull.set_insensitive
			elseif two_procedure_toggle_b.state then
				procedure_opt_pull.set_insensitive
				true_opt_pull.set_sensitive
				false_opt_pull.set_sensitive
			end

			if test_toggle_b.state then
				test_text_field.set_sensitive
			else
				test_text_field.set_insensitive
			end
		end

	desactivate_all_fields is
			-- Desactivate all the fields
		do
			radio_true_field.set_insensitive
			radio_false_field.set_insensitive
			menu_true_field.set_insensitive
			menu_false_field.set_insensitive
		end

feature {NONE} -- Attribute

	default_choice: STRING_SCROLLABLE_ELEMENT
			-- Default choice in the menu entries

feature {NONE} -- Generated interface attributes

	new_toggle_b_c, true_toggle_b_c, false_toggle_b_c: TOGGLE_B_C
			-- Toggle buttons holding the value used to set `query'

	new_opt_pull_c: OPT_PULL_C
			-- Option pull menu holding the value used to set `query'	

feature -- Interface generation

	generate_interface_elements (base_x, base_y: INTEGER; a_perm_wind_c: PERM_WIND_C) is
			-- Generate the interface elements in `a_perm_wind_c'
			-- starting at position (`base_x', `base_y').
		local
			new_label_c: LABEL_C
			new_radio_box_c: RADIO_BOX_C
		do
 			if check_toggle_b.state then
				!! new_toggle_b_c
 				new_toggle_b_c := new_toggle_b_c.create_context (a_perm_wind_c)
				new_toggle_b_c.set_visual_name (check_field.text)
 				new_toggle_b_c.set_x_y (base_x + 130, base_y)
				new_toggle_b_c.set_font_named ("MS Sans Serif,13,400,,default,dontcare,ansi,0,0,5,draft,stroke,string")
				new_toggle_b_c.set_size (130, new_toggle_b_c.height)
 				display_new_context (new_toggle_b_c)
 				check_box_name := new_toggle_b_c.entity_name
				minimum_height := 30
 			elseif radio_toggle_b.state then
 				!! new_radio_box_c
 				!! true_toggle_b_c
				!! false_toggle_b_c
 				new_radio_box_c := new_radio_box_c.old_create_context (a_perm_wind_c)
 				true_toggle_b_c := true_toggle_b_c.create_context (new_radio_box_c)
				true_toggle_b_c.set_visual_name (radio_true_field.text)
				true_toggle_b_c.set_font_named ("MS Sans Serif,13,400,,default,dontcare,ansi,0,0,5,draft,stroke,string")
				false_toggle_b_c := false_toggle_b_c.create_context (new_radio_box_c)
				false_toggle_b_c.set_visual_name (radio_false_field.text)
				false_toggle_b_c.set_font_named ("MS Sans Serif,13,400,,default,dontcare,ansi,0,0,5,draft,stroke,string")
 				new_radio_box_c.set_x_y (base_x + 130, base_y)
 				display_new_context (new_radio_box_c)
 				radio_box_name := new_radio_box_c.entity_name
 				true_toggle_b_name := true_toggle_b_c.entity_name
				false_toggle_b_name := false_toggle_b_c.entity_name
				minimum_height := 60
 			elseif menu_toggle_b.state then
 			!! new_label_c
				new_label_c := new_label_c.create_context (a_perm_wind_c)
				new_label_c.set_visual_name (query.query_name)
				new_label_c.set_x_y (base_x, base_y)
				new_label_c.set_size (130, new_label_c.height)
 				!! new_opt_pull_c
 				new_opt_pull_c := new_opt_pull_c.create_context (a_perm_wind_c)
 				new_opt_pull_c.set_x_y (base_x + 130, base_y)
 				new_opt_pull_c.set_size (130, new_opt_pull_c.height)
 				add_to_menu (menu_true_field.text, new_opt_pull_c)
				add_to_menu (menu_false_field.text, new_opt_pull_c)
 				display_new_context (new_opt_pull_c)
 				opt_pull_name := new_opt_pull_c.entity_name
				minimum_height := 25
 			end
		end

	add_to_menu (an_option: STRING; an_opt_pull_c: OPT_PULL_C) is
			-- Fill menus for `an_opt_pull_c'.
		local
			new_push_b_c: PUSH_B_C
		do
 			!! new_push_b_c
			new_push_b_c := new_push_b_c.create_context (an_opt_pull_c)
			new_push_b_c.set_visual_name (an_option)
		end

feature -- Interface generation

	minimum_height: INTEGER
			-- Height needed to fit the generated elements
			-- on the permanent window.

	minimum_width: INTEGER is 150
			-- Width for needed to fit the generated elements
			-- on the permanent window.

feature -- Command generation

	arguments: EB_LINKED_LIST [ARG] is
		   -- Generated widgets holding the value to set `query'.
		local
			arg: ARG
		do
			!! Result.make
			if new_toggle_b_c /= Void then
				!! arg.session_init (new_toggle_b_c.type)
				Result.extend (arg)
			elseif true_toggle_b_c /= Void then
				!! arg.session_init (true_toggle_b_c.type)
				Result.extend (arg)
			else
				!! arg.session_init (new_opt_pull_c.type)
				Result.extend (arg)
			end	
		end

	argument_instances: EB_LINKED_LIST [ARG_INSTANCE] is
		   -- Generated widgets holding the value to set `query'.
		local
			arg: ARG_INSTANCE
		do
			!! Result.make
			if new_toggle_b_c /= Void then
				!! arg.storage_init (new_toggle_b_c.type, new_toggle_b_c)
				Result.extend (arg)
			elseif true_toggle_b_c /= Void then
				!! arg.storage_init (true_toggle_b_c.type, true_toggle_b_c)
				Result.extend (arg)
			else
				!! arg.storage_init (new_opt_pull_c.type, new_opt_pull_c)
				Result.extend (arg)
			end	
		end

	generate_eiffel_text (counter: INT_GENERATOR): STRING is
			-- Generate Eiffel text corresponding to the setting
			-- of the query correpsonding to `query'.
		local
			actual_argument: STRING
		do
 			!! Result.make (0)
 			Result.append ("%T%T%T")
			Result.append ("if argument")
			Result.append_integer (counter.value)
			if new_opt_pull_c /= Void then
				Result.append (".selected_button = argument")
				Result.append_integer (counter.value)
				Result.append (".children.first")
 			else
 				Result.append (extension_to_add)
			end
			Result.append (" then%N%T%T%T%T")
			Result.append (eiffel_setting ("True"))
			if test_toggle_b.state and not procedure.precondition_list.empty then
				Result.append ("%N%T%T%Telse%N%T%T%T%Tdisplay_error_message (%"")
				Result.append (test_text_field.text)
				Result.append ("%", argument")
				Result.append_integer (counter.value)
				Result.append (".parent)%N%T%T%Tend%N")
			end	
			Result.append ("%N%T%T%Telse%N%T%T%T%T")
			Result.append (eiffel_setting ("False"))
			if test_toggle_b.state and not procedure.precondition_list.empty then
 				Result.append ("%N%T%T%Telse%N%T%T%T%Tdisplay_error_message (%"")
 				Result.append (test_text_field.text)
				Result.append ("%", argument")
				Result.append_integer (counter.value)
				Result.append (".parent)%N%T%T%Tend%N")
			end
			Result.append ("%N%T%T%Tend%N")
		end

	eiffel_setting (actual_argument: STRING): STRING is
			-- Generate the setting of the query using `argument'.
		local
			preconditions: LINKED_LIST [APPLICATION_PRECONDITION]
		do
 			!! Result.make (0)
 			if test_toggle_b.state and not procedure.precondition_list.empty then 
 				Result.append ("precondition := True%N")
 
 				preconditions := procedure.precondition_list
 				from
 					preconditions.start
 				until
 					preconditions.after
 				loop
 					Result.append ("%T%T%T%Tprecondition := precondition and then ")
 					Result.append (preconditions.item.generated_text_for_command (procedure.argument_name, actual_argument))
 					Result.append ("%N")
 					preconditions.forth
 				end		
 				Result.append ("%N%T%T%T%Tif precondition then%N%T%T%T%T")
 			end
 			Result.append ("target.")
			if one_procedure_toggle_b.state then
				Result.append (procedure.command_name)
				Result.append (" (")
				Result.append (actual_argument)
				Result.append (")")
			else
				if actual_argument.is_equal ("True") then
					Result.append (procedure_true.routine_name)
				elseif actual_argument.is_equal ("False") then
					Result.append (procedure_false.routine_name)
				end
			end
		end

	procedure: APPLICATION_COMMAND is
			-- Procedure chosen to set `query'
		require
			item_selected: procedure_opt_pull.selected_button /= Void
		local
			application_method_button: APPLICATION_METHOD_PUSH_B
		do
			application_method_button ?= procedure_opt_pull.selected_button
			Result ?= application_method_button.application_method
		end

	procedure_true: APPLICATION_ROUTINE is
			-- Procedure chosen to set true `query'
		require
			item_selected: true_opt_pull.selected_button /= Void
		local
			application_method_button: APPLICATION_METHOD_PUSH_B
		do
			application_method_button ?= true_opt_pull.selected_button
			Result ?= application_method_button.application_method
		end

	procedure_false: APPLICATION_ROUTINE is
			-- Procedure chosen to set false `query'
		require
			item_selected: false_opt_pull.selected_button /= Void
		local
			application_method_button: APPLICATION_METHOD_PUSH_B
		do
			application_method_button ?= false_opt_pull.selected_button
			Result ?= application_method_button.application_method
		end

	check_box_name, 
			-- Internal name of the check box holding the value
			-- used to set `query'.

	radio_box_name,
			-- Internal name of radio box holding the value used
			-- to set `query'
	
	true_toggle_b_name,
			-- Internal name of `toggle_b' holding the value used
			-- to set `query'

	false_toggle_b_name,
			-- Internal name of `toggle_b' holding the value used
			-- to set `query'

	opt_pull_name: STRING 
			-- Internal name of the option pull holding the value
			-- used to set `query'.

end -- class BOOLEAN_QUERY_EDITOR_FORM
